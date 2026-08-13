/**
 * Employee Agent action: FSR Account Brief.
 *
 * Returns a rich, structured account summary card (FSRAccountBrief) that the
 * custom Lightning type `fsrAccountBrief` renders in the agent UI — replacing
 * inconsistent free-text markdown with clean headings and bullet lists.
 *
 * Reuses the proven sales-context gathering and LLM generation in
 * FSRAskAboutAccountAction, then parses that well-formatted output into
 * structured sections so the LWC (not the LLM's markdown) controls layout.
 *
 * Follows the CLT conventions proven by the Account_Insights reference: the
 * action class and all request/result/type classes are top-level `global` with
 * `@JsonAccess`, which is what lets the `@apexClassType` CLT binding resolve.
 */
@JsonAccess(serializable='always' deserializable='always')
global class FSRAccountBriefAction {

    @InvocableMethod(
        label='FSR Account Brief'
        description='Returns a rich, structured account summary CARD (not text) for an HCP or account. Call this when the user asks for a summary, overview, or briefing of an account or HCP and you want it displayed as a formatted card.'
    )
    global static List<FSRAccountBriefResult> getBrief(List<FSRAccountBriefRequest> requests) {
        List<FSRAccountBriefResult> results = new List<FSRAccountBriefResult>();

        for (FSRAccountBriefRequest req : requests) {
            FSRAccountBriefResult result = new FSRAccountBriefResult();
            try {
                String raw = FSRAskAboutAccountAction.getFormattedSummary(
                    req.question, req.accountId, req.accountName
                );
                result.brief = parseBrief(raw, req.accountName);
            } catch (Exception e) {
                FSRAccountBrief errorBrief = new FSRAccountBrief();
                errorBrief.accountName = String.isNotBlank(req.accountName) ? req.accountName : 'Account';
                errorBrief.headline = 'Could not build the summary.';
                FSRAccountBriefSection s = new FSRAccountBriefSection();
                s.heading = '⚠️ Error';
                s.bullets = new List<String>{ e.getMessage() };
                errorBrief.sections = new List<FSRAccountBriefSection>{ s };
                result.brief = errorBrief;
            }
            results.add(result);
        }

        return results;
    }

    /**
     * Parse the formatted summary text into a structured brief.
     *
     * Expected shape (from FSR_AcctSummary_* prompt templates):
     *   📋 Account: Dr. Jane Smith
     *   <emoji> Section Header
     *   • bullet
     *   • bullet
     *   ...
     * Sections are separated by blank lines; the closing line is a single
     * actionable next step. Anything before the first recognized section
     * header becomes the headline.
     */
    @TestVisible
    private static FSRAccountBrief parseBrief(String raw, String fallbackName) {
        FSRAccountBrief brief = new FSRAccountBrief();
        brief.sections = new List<FSRAccountBriefSection>();

        if (String.isBlank(raw)) {
            brief.accountName = String.isNotBlank(fallbackName) ? fallbackName : 'Account';
            brief.headline = 'No summary available.';
            return brief;
        }

        // Strip any trailing "=== VISIT LINKS ===" block appended by the source action.
        Integer linksIdx = raw.indexOf('=== VISIT LINKS ===');
        if (linksIdx >= 0) {
            raw = raw.substring(0, linksIdx);
        }

        List<String> lines = raw.split('\n');
        FSRAccountBriefSection current;
        List<String> headlineParts = new List<String>();

        for (String rawLine : lines) {
            String line = rawLine == null ? '' : rawLine.trim();
            if (String.isBlank(line)) {
                continue;
            }

            // Account title line, e.g. "📋 Account: Dr. Jane Smith".
            if (brief.accountName == null && line.startsWith('📋')) {
                String name = line.replaceFirst('^📋\\s*', '');
                name = name.replaceFirst('(?i)^Account:\\s*', '');
                brief.accountName = name.trim();
                continue;
            }

            if (isBullet(line)) {
                if (current == null) {
                    // Bullet before any header — start a general section.
                    current = new FSRAccountBriefSection();
                    current.heading = '📌 Summary';
                    current.bullets = new List<String>();
                    brief.sections.add(current);
                }
                current.bullets.add(stripBulletMarker(line));
            } else if (isSectionHeader(line)) {
                current = new FSRAccountBriefSection();
                current.heading = stripBold(line);
                current.bullets = new List<String>();
                brief.sections.add(current);
            } else {
                // Non-bullet, non-header prose. If we haven't hit a section yet,
                // it's part of the headline; otherwise treat it as a bullet.
                if (current == null) {
                    headlineParts.add(stripBold(line));
                } else {
                    current.bullets.add(stripBold(line));
                }
            }
        }

        if (brief.accountName == null) {
            brief.accountName = String.isNotBlank(fallbackName) ? fallbackName : 'Account';
        }
        if (!headlineParts.isEmpty()) {
            brief.headline = String.join(headlineParts, ' ');
        }

        // Promote a trailing single-bullet section that reads like a next step.
        if (!brief.sections.isEmpty()) {
            FSRAccountBriefSection last = brief.sections[brief.sections.size() - 1];
            if (last.bullets != null && last.bullets.size() == 1 && isNextStepHeading(last.heading)) {
                brief.nextStep = last.bullets[0];
                brief.sections.remove(brief.sections.size() - 1);
            }
        }

        return brief;
    }

    private static Boolean isBullet(String line) {
        return line.startsWith('•') || line.startsWith('-') || line.startsWith('*')
            || line.startsWith('◦') || line.startsWith('·');
    }

    private static String stripBulletMarker(String line) {
        return line.replaceFirst('^[•\\-\\*◦·]\\s*', '').trim();
    }

    private static String stripBold(String line) {
        return line.replaceAll('\\*\\*', '').trim();
    }

    // A section header starts with a non-alphanumeric glyph (emoji) and is not a bullet.
    private static Boolean isSectionHeader(String line) {
        if (isBullet(line)) {
            return false;
        }
        String noBold = stripBold(line);
        if (String.isBlank(noBold)) {
            return false;
        }
        String first = noBold.substring(0, 1);
        // Header if it leads with an emoji/symbol (not a letter, digit, or quote).
        return !first.isAlphaNumeric() && first != '"' && first != '\'';
    }

    private static Boolean isNextStepHeading(String heading) {
        if (String.isBlank(heading)) {
            return false;
        }
        String h = heading.toLowerCase();
        return h.contains('next step') || h.contains('next visit') || h.contains('action')
            || h.contains('🎯') || h.contains('recommend');
    }
}
