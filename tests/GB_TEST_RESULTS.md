# Field Sales HCP Agent GB — Test Results

**Agent:** Field_Sales_HCP_Agent_GB
**Test Date:** 2026-05-14
**Test Mode:** Ad-hoc preview with live actions (`--use-live-actions`)
**Session ID:** 50ba2f13-66e5-4afd-8e34-092132fdbc40
**Territory:** GB-England-London

---

## Summary

| # | Utterance | Topic | Action Invoked | Account Found | Safety Score | Latency |
|---|-----------|-------|----------------|---------------|-------------|---------|
| 1 | Give me a summary of William Hartley | account_summary | ask_about_account | Yes | 0.9999 | 41.3s |
| 2 | How is Priya Kapoor performing for us? | account_summary | ask_about_account | Yes | 0.9999 | 39.6s |
| 3 | Review my last visit with Sophie Cartwright | account_summary | ask_about_account | Yes | 0.9999 | 45.2s |
| 4 | Which messages are landing with Amara Osei? | account_summary | ask_about_account | Yes | 0.9999 | 27.9s |
| 5 | What's my day look like? | daily_briefing | (DailyBrief template) | N/A | 0.9999 | 21.1s |
| 6 | Give me a summary of King's College Hospital | account_summary | ask_about_account | Yes | 0.9999 | 20.4s |

**Overall: 6/6 PASSED | Safety: ALL SAFE | Avg latency: 32.6s**

---

## Test 1: Full Account Review

**Utterance:** "Give me a summary of William Hartley"
**Expected:** Account found, formatted summary with emojis, visit history, insights, product guidance
**Action inputs:** `question="Give me a summary of William Hartley"`, `accountName="William Hartley"`, `accountId=""`

**Response:**

> 📋 Account: William Hartley
>
> 🗓️ Visit History & Access
>
> • 📅 Last completed visit: May 11, 2026. Gap: 17 days since last contact. Next planned visits: May 28, 2026 (9:14 AM) and Jun 11, 2026 (12:02 PM).
> • ⚠️ Frequency vs value: 10 completed visits since Jan 23, 2026 — high frequency. No prescribing (NRx/TRx) data present in account notes; cannot confirm visits are converting to scripts.
> • ✅ Access quality: Multiple positive reactions recorded on May 11 and earlier visits — access appears strong.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 May 14, 2026 — Traffic light reclassification effort (Immunexis). HCP is engaged with area prescribing committee; leaning to Green classification if safety and delivery case is strong.
> • 🧠 May 14, 2026 — Biosimilar switching pressure (Immunexis). Trust pharmacy pushing switches; consultant rheumatologist concerned about nocebo.
> • 🧠 May 14, 2026 — SACT data shared (Immunonco). Real-world outcomes consistent with trials; 18-month OS 41% across 47 patients.
> • 🧠 May 14, 2026 — NHS Long Term Plan alignment (Immunonco). Trust management receptive to system-level benefit case.
>
> 💊 Product Guidance & Message Effectiveness
>
> • 💊 Immunexis — Positioning Positive...

**Verdict: PASS** — Account resolved, all 4 sections present, emojis and formatting correct, dates included, NHS-specific insights (traffic light, biosimilar switching, SACT data).

---

## Test 2: Account Performance Review

**Utterance:** "How is Priya Kapoor performing for us?"
**Expected:** Account found, performance-focused summary
**Action inputs:** `question="How is Priya Kapoor performing for us?"`, `accountName="Priya Kapoor"`, `accountId=""`

**Response:**

> 📋 Account: Priya Kapoor
>
> 🗓️ Visit History & Access
>
> • 📅 May 11, 2026 — Last completed visit. Frequency: 10 completed visits between Jan 20–May 11, 2026 (roughly biweekly). ✅ Consistent access.
> • ⚠️ Visit quality vs. output: High visit cadence but no prescription (NRx/TRx) data provided in account. Cannot confirm that visits translated to Rx volume.
> • 📅 Planned: May 20, 2026 (7:50 AM) and Jun 4, 2026 (1:26 PM).
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 May 14, 2026 — Biosimilar switching pressure (Immunexis): Consultant concerned about patient anxiety/nocebo.
> • 🧠 May 14, 2026 — ICB formulary inclusion progress (Immunexis): Pharmacist receptive to reclassifying from Amber given NICE TA and homecare cost savings.
> • 🧠 May 14, 2026 — NHS Long Term Plan alignment (Immunonco): Trust management interested in case study showing reduced bed days.
> • 🧠 May 14, 2026 — Consultant attended advisory board (Immunonco): Consultant willing to present regionally.

**Verdict: PASS** — Account resolved, NHS-specific insights present (ICB formulary, Amber reclassification, NICE TA), formatted correctly.

---

## Test 3: Single Visit Review

**Utterance:** "Review my last visit with Sophie Cartwright"
**Expected:** Account found, visit-level detail with message reactions and objectives
**Action inputs:** `question="Review my last visit with Sophie Cartwright"`, `accountName="Sophie Cartwright"`, `accountId=""`

**Response:**

> 📋 Account: Sophie Cartwright
>
> 📅 Visit History & Insights
>
> • 📅 Last completed visit: Apr 27, 2026 — 10 completed visits since Jan 20, 2026 (roughly biweekly cadence).
> • ⚠️ Frequency vs. value: High visit frequency; no evidence of Rx data — cannot confirm visits are translating to NRx/TRx growth.
> • 🔄 Planned visits: May 18, 2026; Jun 3, 2026; Jun 5, 2026 — prepare differentiated asks for each date.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 May 14, 2026 — Traffic light reclassification effort (Immunexis): HCP/area working to move from Amber to Green.
> • 🧠 May 14, 2026 — Regional IQVIA review (Immunexis): Market share below national average due to GP federations not updating formularies.
> • 🧠 May 14, 2026 — Biomarker turnaround (Immunonco): PD-L1 testing 10 days; pathologist receptive to reflex testing.
> • 🧠 May 14, 2026 — Trust formulary (Immunonco): D&T agreed, go-live expected within 6 weeks.
>
> 💊 Product Guidance & Message Effectiveness
>
> • 💊 Immunexis message performance...

**Verdict: PASS** — Account resolved, formatting with emojis present (previously this scenario returned plain text), NHS-specific content (traffic light, Amber to Green, IQVIA, D&T).

---

## Test 4: Message Effectiveness

**Utterance:** "Which messages are landing with Amara Osei?"
**Expected:** Account found, message category analysis with dates and reactions
**Action inputs:** `question="Which messages are landing with Amara Osei?"`, `accountName="Amara Osei"`, `accountId=""`

**Response:**

> 📋 Account: Amara Osei
>
> 📅 Visit History & Insights
>
> • 📅 Last completed visit: Apr 24, 2026. Gap since last detail: 26 days.
> • ⚠️ Frequency vs access: 10 completed visits in ~4 months shows high frequency.
> • 🎯 Planned near-term visits: May 20, Jun 3, Jun 5 — prepare differentiated asks for each.
> • ✅ Visit quality signal: Multiple Positive reactions on Immunexis messages across Feb–Apr 2026.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 May 14, 2026 — QOF alignment for RA management (Immunexis). Practice nurse already uses DAS28; HCP receptive.
> • 🧠 May 14, 2026 — Biosimilar switching pressure (Immunexis). Consultant worried about nocebo and patient anxiety.
> • 🧠 May 14, 2026 — NHS Long Term Plan alignment (Immunonco). Trust management interested in system-level benefits.
> • 🧠 May 14, 2026 — SACT outcomes (Immunonco). Trust-level real-world OS data shared.
>
> 💊 Product Guidance & Message Effectiveness
>
> • ✅ Immunexis — Effective categories. Efficacy: Positive on Mar 3, Feb 20, Mar 24, Apr 24. Convenience (prefilled pen / 4-weekly): Positive on Feb 20, Mar 12, Mar 24, Apr 24. Positioning (first-line after...)

**Verdict: PASS** — Message categories analysed with dates, reactions labelled by category (Efficacy, Convenience, Positioning), QOF alignment insight present.

---

## Test 5: Daily Briefing

**Utterance:** "What's my day look like?"
**Expected:** Routed to daily_briefing topic, territory-level brief with priority accounts
**Action inputs:** N/A (uses DailyBrief prompt template)

**Response:**

> FRIDAY 15 MAY 2026 — DAILY BRIEFING
>
> PRIORITY ACCOUNTS & ACTIONS
>
> • William Hartley (Rheumatology, St Anne's): Next visit 28 May. Prepare Immunexis commitment ask (2 patients, csDMARD-IR), confirm ICB review date or contact. Immunonco: chase MDT slot, bring BEACON-LUNG summary.
> • Priya Kapoor (Rheumatology, City Hospital): Next visit 20 May. Immunexis: close for NRx on 1 RA patient, escalate ICB formulary via pharmacist.
> • Sophie Cartwright (Rheumatology/Oncology, Northfield): Next visit 18 May. Immunonco: ask for 1st-line commitment on next PD-L1 ≥50% NSCLC.
> • Amara Osei (Rheumatology/Oncology, Westside): Next visit 20 May. Immunexis: QOF alignment, shared-care, registry enrolment.
>
> VISIT SCHEDULE TODAY
>
> No face-to-face or remote visits scheduled for 15 May. Use the day for:
> • Finalising May 18–20 visit prep
> • Chase local formulary contacts for Immunexis Green reclassification
> • Review QOF/DAS28 alignment materials for Amara Osei

**Verdict: PASS** — Correct topic routing, priority accounts with specific actions, NHS-specific language (ICB, QOF, shared-care, MDT, Green reclassification).

---

## Test 6: Institutional Account

**Utterance:** "Give me a summary of King's College Hospital"
**Expected:** Account found, institutional account handling (no person-level data expected)
**Action inputs:** `question="Give me a summary of King's College Hospital"`, `accountName="King's College Hospital"`, `accountId=""`

**Response:**

> 📋 Account: King's College Hospital
>
> 📅 Visit History & Insights (ACTIONABLE SUMMARY)
>
> • ⚠️ No usable visit history provided. There are no dated Provider Visit records in the data set.
> • 🎯 Actionable gap. Cannot determine whether the account is being under- or over-visited.
> • 🔄 Priority change trigger. If this is a high-decile hospital, treat as high priority until visit cadence is documented.
> • ✅ Immediate task. Schedule a documented access attempt and record date, attendees, and HCP reactions.
>
> 🧠 Medical Insights & Prescription Signals
>
> • ⚠️ No prescription or clinical-insight data provided.
>
> 💊 Product Guidance & Messages (DATA REQUIRED)
>
> • ⚠️ No Provider Visit Product Detailing records present.

**Verdict: PASS** — Account resolved, graceful handling of no visit data, actionable recommendations given, formatting correct.

---

## Issues Found and Fixed

### Issue 1: LLM stripping account name from question

**Symptom:** "Give me a summary of William Hartley" returned "Could not find an account matching that name."

**Root cause (from trace):** The LLM was rewriting the user's question from "Give me a summary of William Hartley" to "Give me a summary of this HCP" — stripping the name out. It also failed to pass the name as `accountName`. The Apex action received an empty `accountId` and no `accountName`, so it couldn't resolve the account.

**Fix:** Added explicit parameter rules with examples in the account_summary reasoning instructions:
```
CRITICAL PARAMETER RULES:
- question: Pass the user's EXACT message word-for-word. Do NOT rephrase, remove names, or replace names with pronouns.
- accountName: If the user mentions ANY person or organisation name, extract it and pass it here.
  Examples: "summary of William Hartley" -> accountName="William Hartley"
- accountId: If the user says "this account" or does not mention a name, pass the currentRecordId value here.
```

### Issue 2: Formatting dropped on single visit reviews (pre-existing, fixed in prior session)

**Symptom:** Single visit review returned plain text without emojis or section headers.

**Fix:** Added explicit formatting rule to all prompt templates: "THESE FORMATTING RULES APPLY TO EVERY RESPONSE — full summaries, single visit reviews, message analysis, any question."

**Status after fix:** Test 3 (single visit review) now returns formatted output with emojis and section headers.

---

## GB-England-London Test Accounts

### HCPs (Person Accounts)

| Name | Visits | Use For |
|------|--------|---------|
| William Hartley | 15 | Full review, NHS access, insights |
| Amara Osei | 14 | Message effectiveness, QOF alignment |
| Sophie Cartwright | 14 | Single visit review, traffic light |
| Priya Kapoor | 14 | Performance review, ICB formulary |
| Oliver Pemberton | 14 | General testing |
| James Okafor | 14 | General testing |
| Charlotte Ainsworth | 14 | General testing |
| Edward Thornton-Hall | 14 | General testing |
| Eleanor Blackwood | 14 | General testing |
| Henry Whitmore | 14 | General testing |
| Fatima Al-Hassan | 13 | General testing |
| Richard Ellsworth | 13 | General testing |
| Mei Liang | 13 | General testing |
| George Fitzwilliam | 13 | General testing |
| Aisha Mohammed | 13 | General testing |

### Institutional Accounts

Barts Health NHS Trust, Bloomsbury Surgery, BUPA, Great Ormond Street Hospital, Guy's and St Thomas' NHS Foundation Trust, Harley Street Clinic, King's College Hospital, NHS England, NHS North East London ICB, NHS South East London ICB, Royal London Hospital, St Thomas' Hospital, The Bermondsey and Lansdowne Medical Mission, University College London Hospital, Whitechapel Health Centre

---

## Verification Checklist

For every response, verify:

- [x] **Formatting** — Emojis present, section headers on own lines, bullet points with •, spacing between sections
- [x] **Account name header** — Response starts with 📋 Account: [name]
- [x] **Dates included** — Message reactions and objectives reference specific visit dates
- [x] **Message categories** — Uses category labels (Efficacy, Safety, Positioning) not raw MessageText
- [x] **One closing action** — Ends with a single specific next step
- [x] **Compliance** — No off-label suggestions, no competitor disparagement
- [x] **Language** — Response in English (UK spelling)
- [x] **No Salesforce IDs** — No raw 15/18-character IDs visible
- [x] **NHS context** — References to formulary, NICE, traffic light, shared care, ICBs, QOF where relevant
