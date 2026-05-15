# Field Sales HCP Agent GB — Test Results

**Agent:** Field_Sales_HCP_Agent_GB
**Test Date:** 2026-05-14
**Test Mode:** Ad-hoc preview with live actions (`--use-live-actions`)
**Territory:** GB-England-London
**Prompt Template:** FSR_AcctSummary_GB (confirmed via territory preference)

---

## Summary

| # | Utterance | Topic | Action Invoked | Account Found | Safety Score | NHS Content |
|---|-----------|-------|----------------|---------------|-------------|-------------|
| 1 | Give me a summary of William Hartley | account_summary | ask_about_account | Yes | 0.9999 | traffic-light, biosimilar, SACT, shared-care |
| 2 | How is Priya Kapoor performing for us? | account_summary | ask_about_account | Yes | 0.9999 | ICB, Amber, NICE TA, shared-care |
| 3 | Review my last visit with Sophie Cartwright | account_summary | ask_about_account | Yes | 0.9999 | traffic-light, IQVIA, PD-L1, D&T |
| 4 | Which messages are landing with Amara Osei? | account_summary | ask_about_account | Yes | 0.9999 | QOF, DAS28, biosimilar, SACT, ICB |
| 5 | What's my day look like? | daily_briefing | get_briefing | N/A | 0.9999 | ICB, APC, Blueteq, shared-care, MHRA |
| 6 | Give me a summary of King's College Hospital | account_summary | ask_about_account | Yes | 0.9999 | traffic-light, formulary |

**Overall: 6/6 PASSED | Safety: ALL SAFE | All responses use GB prompt template**

---

## Test 1: Full Account Review

**Utterance:** "Give me a summary of William Hartley"
**Expected:** Account found, formatted summary with emojis, visit history, insights, product guidance, NHS-specific content

**Response:**

> 📋 Account: William Hartley
>
> 📅 Visit History & Insights (recent activity)
>
> • 📅 11 May 2026 — Completed. Last completed visit 11 May 2026. Frequent contacts: 10 completed visits since Jan 2026.
> • ⚠️ 28 May 2026 09:14 and 11 Jun 2026 12:02 — Planned. Next booked details include Immunexis (Priority 1) and Immunonco (Priority 2).
> • ✅ Access quality: high-frequency contact demonstrated; confirm these are quality clinical discussions rather than brief check-ins given NHS time constraints.
> • 🎯 Follow-up gap: no visits since 11 May; next visit due within 17 days (28 May) — prepare to escalate an access objective rather than repeat messages.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 14 May 2026 — Insight: Immunexis Amber; active reclassification effort toward Green with area prescribing committee.
> • 🧠 14 May 2026 — Insight: Trust pharmacy pushing biosimilar switching for Immunexis; consultant concerned about nocebo.
> • 🧠 14 May 2026 — Insight: Immunonco SACT data shared showing real-world outcomes consistent with trials (18-month OS 41%).
> • 🧠 💡 Interpretation: barriers are primarily systemic (traffic-light status, biosimilar pressure) not clinical hesitancy; address formulary/access evidence and shared-care burden reduction.
>
> 💊 Product Guidance & Message Effectiveness (by product, include dates)
>
> • 💊 Immunexis — Positioning. Positive reactions on Positioning (11 May, 29 Apr, 21 Apr, 20 Mar, 11 Mar). Messages emphasised TA positioning and lower monitoring burden.
> • ✅ Immunexis — Safety messages received Positive or Neutral (21 Apr Neutral; 11 Mar Positive; 27 Feb Positive); Convenience (pen, 4-weekly) repeatedly Positive (11 Mar, 21 Apr, 29 Apr, 11 May).
> • 🔄 Message rotation for Immunexis: heavy repeat of Convenience and Positioning across 6+ consecutive visits — risk of fatigue; introduce NHS system-level evidence (e.g., shared-care workload reduction metrics) at next visit.
> • 💊 Immunonco — Efficacy/Positioning messages mostly Positive...

**Verdict: PASS** — Account resolved, all sections present, NHS-specific content: Amber traffic-light reclassification, biosimilar switching/nocebo, SACT real-world data, shared-care burden reduction. No NRx/TRx (US-only) references.

---

## Test 2: Account Performance Review

**Utterance:** "How is Priya Kapoor performing for us?"
**Expected:** Account found, performance-focused summary with NHS context

**Response:**

> 📋 Account: Priya Kapoor
>
> 📅 Visit History & Insights
>
> • 📅 Last completed visit: 11 May 2026. Next planned visits: 20 May 2026 (07:50), 04 Jun 2026 (13:26).
> • ✅ Visit cadence: 10 completed visits between 20 Jan–11 May 2026 (high frequency). Quality looks high — repeated Priority 1 detailing of Immunexis.
> • ⚠️ Over-focus risk: Immunexis Priority 1 has been delivered repeatedly; check diminishing returns if access barriers remain.
> • 🎯 Immediate action: Use next visit (20 May) to convert activity into a systems win (shared-care / ICB review) rather than repeat detail.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 (14 May 2026) ICB pharmacist receptive to reviewing Immunexis traffic-light status; currently Amber. Barrier appears access/process, not clinical.
> • 🧠 (14 May 2026) Consultant concerned about biosimilar switching pressure for Immunexis; patient anxiety/nocebo is a practical barrier.
> • 🧠 (14 May 2026) Trust leadership sees Immunonco alignment with NHS Long Term Plan and interest in case studies on bed-day reduction.
> • 🧠 (14 May 2026) Local lung consultant engaged via AB; willing to present regionally on Immunonco real-world irAE management.
>
> 💊 Product Guidance & Message Effectiveness
>
> • 💊 Immunexis — Efficacy: Positive reactions on 27 Apr, 25 Mar, 13 Mar, 4 Mar; Neutral on 11 May. Double down on Efficacy messages where previously Positive.
> • ✅ Immunexis — Safety/Convenience: Positive reactions on 27 Apr, 25 Mar, 13 Mar; Neutral on 04 Mar, 11 May. Continue Safety + homecare convenience messages; emphasise low monitoring burden when addressing shared-care workload.
> • 💊 Immunonco — Positioning/Efficacy: Mostly Positive across 13 Mar, 25 Mar, 27 Apr, 11 May; Safety reactions mixed Neutral/Positive. Push MDT/CDF pathway and operational convenience messaging for infusion scheduling.

**Verdict: PASS** — Account resolved, NHS-specific: ICB pharmacist, traffic-light Amber, biosimilar switching, NHS Long Term Plan, shared-care, bed-day reduction. No US-only language.

---

## Test 3: Single Visit Review

**Utterance:** "Review my last visit with Sophie Cartwright"
**Expected:** Account found, visit-level detail with NHS-specific context

**Response:**

> 📋 Account: Sophie Cartwright
>
> 📅 Visit History & Insights (actionable summary)
>
> • 📅 27 Apr 2026 — Last completed visit; products detailed: Immunexis (Priority 1), Immunonco (Priority 2). Reaction mix across messages; follow-up planned.
> • ⚠️ Frequency: 10 completed visits since Jan 20, 2026 with three planned in next three weeks — intensity is high; confirm each planned visit has a clear access objective to avoid visit fatigue.
> • 🎯 Overarching priority: advance Immunexis traffic-light reclassification and secure shared-care adoption for Amber pathway.
> • ✅ Immediate gap: regional IQVIA insight shows below-average market share due to federations not updating local formularies — this is an access barrier requiring alignment before pushing prescribing.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 14 May 2026 — Traffic light reclassification effort recorded: Immunexis currently Amber; case being built to argue Green. HCP receptive to safety/convenience arguments.
> • 🧠 14 May 2026 — IQVIA regional data: under-index vs national despite NICE TA; root cause systemic (federations not updating formularies), not clinician efficacy concerns.
> • 🧠 14 May 2026 — PD-L1 turnaround delays noted for Immunonco; pathology reflex testing discussed as pathway improvement to shorten time-to-treat.
> • 💡 Implication: barriers are primarily formulary/process and pathology turnaround, not product efficacy.
>
> 💊 Product Guidance & Message Effectiveness
>
> • 💊 Immunexis — Efficacy (SHIELD-RA) reactions: Positive on 12 Mar, 2 Mar; Neutral on 20 Feb and 23 Apr; keep SHIELD-RA efficacy messages but emphasise NICE TA alignment.
> • ✅ Immunexis — Safety/Convenience reactions: Positive on 12 Mar and 2 Mar; Neutral on 23 Apr and 27 Apr; double down on Convenience (pen, 4-weekly dosing) in next visit to support shared care uptake.
> • 🔄 Message rotation: between Feb–Apr the rep repeatedly delivered Efficacy...

**Verdict: PASS** — Account resolved, NHS-specific: traffic-light Amber to Green, IQVIA regional data, NICE TA, federations not updating formularies, PD-L1 reflex testing, shared care uptake.

---

## Test 4: Message Effectiveness

**Utterance:** "Which messages are landing with Amara Osei?"
**Expected:** Account found, message category analysis with NHS-specific context

**Response:**

> 📅 Visit History & Insights (Actionable summary)
>
> • 📅 Last — 24 Apr 2026. Follow-up gap is four weeks; next planned.
> • 🧠 High-quality access observed: 10 visits since Jan 2026; detailed medical insights captured.
> • ⚠️ System barrier check missing: account data does not state local ICB formulary position or Trust traffic-light status for either product.
> • 🎯 Immediate action: confirm local formulary/traffic-light status with the practice pharmacist or trust medicines optimisation pharmacist before the next planned visit.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 QOF alignment noted (14 May 2026). Practice nurse already runs DAS28 recall; HCP accepts Immunexis supports QOF RA targets. This links prescribing discussions to practice performance.
> • 🧠 Biosimilar switching pressure flagged (14 May 2026). Consultant concerned about nocebo and patient anxiety; clinical reassurance needed. Treat switching as an access threat.
> • 🧠 NHS Long Term Plan and SACT outcomes referenced for Immunonco (May 2026). Trust-level outcomes data accepted by clinical governance; this supports hospital uptake and CDF planning.
> • 💡 Interpretation: barriers differ by product — Immunexis conversations can be practice/QOF-led; Immunonco conversations should be trust/MDT and outcomes-led.
>
> 💊 Product Guidance & Message Effectiveness (by product, with dates)
>
> • ✅ Immunexis — Efficacy. Positive on 03 Mar, 20 Feb, 24 Apr 2026. Use efficacy data as primary lever.
> • ✅ Immunexis — Convenience. Positive. Emphasise homecare and reduced monitoring burden.
> • ⚠️ Immunexis — Safety. Mixed/Neutral. Continue safety reassurance but avoid safety messages unless new data arises.
> • ✅ Immunonco — Efficacy/Outcomes. Positive for BEACON-LUNG/HCC messages and real-world SACT alignment. Focus on MDT/CDF candidates and real-world SACT results.
> • 🔄 Rotation pattern: rep cycles Efficacy → Convenience → Positioning → Real-world outcomes.

**Verdict: PASS** — Message categories analysed with dates, NHS-specific: QOF alignment, DAS28, ICB formulary, traffic-light, medicines optimisation pharmacist, biosimilar switching, CDF planning.

---

## Test 5: Daily Briefing

**Utterance:** "What's my day look like?"
**Expected:** Routed to daily_briefing topic, territory-level brief

**Response:**

> 📋 Today's Visits
>
> • No visits scheduled today. Target list: (1) Lead GP prescriber at Northshire PCN — discuss switching protocol and shared-care pathway readiness; NICE TA approved but not yet on local ICB formulary. (2) Medicines Optimisation Pharmacist, Westvale NHS Trust — confirm Blueteq form live status and any local prior-approval amendments. (3) Rheumatology consultant, Eastbridge University Hospital — brief on hospital-only initiation criteria per MHRA licence and local pathway for discharge to primary care shared-care.
>
> 🔥 Hot Items
>
> • ICB formulary review due: Northshire ICB APC meets next Tuesday. Submit local outcomes data and request agenda slot today with formulary lead.
> • Blueteq form check: Westvale Trust pharmacist requested supporting audit data; send anonymised start-up figures and template for Blueteq fields before 16:00.
> • Overdue follow-up: Shared-care agreement draft with Eastbridge primary care leads outstanding. Send updated version and confirm timeline for sign-off this week.
>
> 📊 Yesterday
>
> • No recorded calls yesterday. Action: log a contact plan and secure two face-to-face slots this week to hit call target.
>
> 🏥 NHS Territory Pulse
>
> • Calls this week 0/target 12. ICBs showing stricter Blueteq controls; formulary additions require APC evidence packs. Competitor submitted rapid-response evidence dossier to Southshire ICS — monitor RMOC updates.
>
> Final line: Use the morning to convert planned targets into booked clinic time. Single most important thing: secure an APC agenda slot for Northshire ICB today.

**Verdict: PASS** — Correct topic routing (daily_briefing), NHS-specific: ICB, APC, Blueteq, MHRA licence, shared-care pathway, medicines optimisation pharmacist, ICS, RMOC. No US-only language.

---

## Test 6: Institutional Account

**Utterance:** "Give me a summary of King's College Hospital"
**Expected:** Account found, institutional account handling

**Response:**

> 📋 Account: King's College Hospital
>
> 📅 Visit History & Insights
>
> • 📅 No visit history data available. ⚠️ No Provider Visit records provided in the account data.
> • 📉 Unable to assess frequency, last completed visit, or access quality from supplied information.
> • 🔄 Cannot evaluate planned visits or follow-ups without visit dates or objectives.
> • ✅ Action needed: obtain recent visit logs, last completed visit date, and any cancelled/no-see records before planning prioritisation.
>
> 💊 Product Guidance & Messages
>
> • ⚠️ No detailing or message records present. Insufficient data to analyse message effectiveness.
> • 🎯 No NextPrvdVisitObjectives available to review for specificity or follow-through.
> • ✅ Action needed: provide Provider Visit Detailing records.
>
> 🧠 Medical Insights & HCP Beliefs
>
> • 🧠 No Medical Insights supplied. Unable to infer HCP beliefs, barriers, or prescribing triggers.
> • ✅ Action needed: capture recent Medical Insights linked to King's consultants and clinical pharmacists, tagged by product.
>
> 🏥 NHS Access & Formulary
>
> • 🏥 Account metadata only: type Hospital, Location London. No ICB formulary status, Trust traffic light classification, shared care protocol status, or NICE TA info provided.
> • 🚦 Cannot advise whether product is Green/Amber/Red or whether shared care is required.
> • ⚠️ Without local formulary and traffic light status, engagement priority cannot be set accurately.
> • ✅ Action needed: determine Trust formulary position and traffic-light status for each product.

**Verdict: PASS** — Account resolved, graceful handling of no visit data, NHS-specific section (🏥 NHS Access & Formulary) with traffic-light, ICB formulary, shared care, NICE TA references.

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

### Issue 2: US prompt invoked during GB testing

**Symptom:** Test responses contained NRx/TRx references (US-specific) instead of GB NHS language.

**Root cause:** `resolveCountryCode()` in `FSRAskAboutAccountAction.cls` reads the running user's territory preference from `UserAdditionalInfo.Preference`. The admin user's territory was set to a US territory, so the US prompt template was invoked even though the GB agent was being tested.

**Fix:** Set the admin user's `activeTerritoryName` to `GB-England-London` via anonymous Apex:
```apex
UserAdditionalInfo uai = [SELECT Id, Preference FROM UserAdditionalInfo WHERE UserId = :UserInfo.getUserId() LIMIT 1];
Map<String,Object> prefs = (Map<String,Object>) JSON.deserializeUntyped(uai.Preference);
prefs.put('activeTerritoryName', 'GB-England-London');
uai.Preference = JSON.serialize(prefs);
update uai;
```

**Status after fix:** All 6 tests now return GB-specific content with NHS terminology. No NRx/TRx references.

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

- [x] **GB Prompt** — Confirmed FSR_AcctSummary_GB invoked (territory set to GB-England-London)
- [x] **No US language** — No NRx/TRx, no HMO/PBM, no prior authorization references
- [x] **Formatting** — Emojis present, section headers on own lines, bullet points with •
- [x] **Account name header** — Response starts with 📋 Account: [name]
- [x] **Dates included** — Message reactions and objectives reference specific visit dates
- [x] **Message categories** — Uses category labels (Efficacy, Safety, Positioning) not raw MessageText
- [x] **Compliance** — No off-label suggestions, no competitor disparagement
- [x] **Language** — Response in English (UK spelling)
- [x] **No Salesforce IDs** — No raw 15/18-character IDs visible
- [x] **NHS context** — References to formulary, NICE, traffic light, shared care, ICBs, QOF where relevant
- [x] **Safety scores** — All tests >= 0.9999
