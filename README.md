# Field Sales HCP Power Agent

An Agentforce employee agent for pharmaceutical field sales reps built on the Atlas Reasoning Engine using Agent Script. The agent provides account intelligence, visit schedules, and daily briefings — accessible from both the Agentforce desktop panel and mobile SDK.

Ten country-specific agent variants deliver localized content with country-appropriate regulatory framing.

## What It Does

| Topic | Trigger Examples | Backing Action |
|-------|-----------------|----------------|
| **Account Summary** | "Summarize Dr. Sullivan", "Tell me about this HCP", "What are the product guidances?" | `FSRAskAboutAccountAction` |
| **Visit Schedule** | "Show my schedule", "My visits this week" | `FSRMyScheduleAction` |
| **Daily Briefing** | "Give me my daily briefing", "Morning update" | `FSRDailyBriefAction` |

## Account Intelligence Data

The account summary action gathers and passes the following context to the LLM:

- Account profile (name, title, email, phone, location, owner)
- Contacts (via AccountContactRelation)
- Previous and planned visits (with visit IDs for navigation)
- Product detailing records (priority, off-label flag, notes, next visit objectives)
- Product messages delivered with HCP reactions (Positive/Neutral/Negative)
- Medical insights with related products (HCP beliefs, clinical preferences, treatment philosophy)
- Recent events and meetings
- Open and completed tasks
- Activity plan progress (plan name, time period, goal vs actual vs scheduled, attainment %)
- Open cases

The prompt template (`FSR_AcctSummary_{countryCode}`) instructs the LLM to analyze this data like a top-performing sales rep — focusing on actionable insights, message effectiveness, visit cadence, HCP beliefs from medical insights, and strategy recommendations.

## Multi-Country Agents

| Country | Agent | Language | Regulatory Framework | Territory Example |
|---------|-------|----------|---------------------|-------------------|
| US | `Field_Sales_HCP_Agent_US` | English | FDA, PDMA, formulary/payer | US-W-San Francisco |
| GB | `Field_Sales_HCP_Agent_GB` | English | MHRA, NICE, NHS, ABPI Code | GB-England-London |
| FR | `Field_Sales_HCP_Agent_FR` | French | ANSM, HAS, CEPS, AMM, Charte visite médicale | FR-Ile-de-France-Paris |
| DE | `Field_Sales_HCP_Agent_DE` | German | BfArM, G-BA, IQWiG, AMNOG | DE-Bayern-Munich |
| IT | `Field_Sales_HCP_Agent_IT` | Italian | AIFA, Farmindustria Code, Registro AIFA | IT-Lazio-Rome |
| ES | `Field_Sales_HCP_Agent_ES` | Spanish | AEMPS, SNS, Farmaindustria Code | ES-Madrid-Madrid |
| JP | `Field_Sales_HCP_Agent_JP` | Japanese | PMDA, MHLW, NHI, JPMA Code | JP-Kanto-Tokyo |
| KR | `Field_Sales_HCP_Agent_KR` | Korean | MFDS, HIRA, NHIS, KRPIA Code, Kim Young-ran Act | KR-Seoul-Seoul |
| BR | `Field_Sales_HCP_Agent_BR` | Portuguese | ANVISA, SUS, Interfarma Code | BR-Sudeste-São Paulo |
| MX | `Field_Sales_HCP_Agent_MX` | Spanish | COFEPRIS, IMSS, CANIFARMA Code | MX-CDMX-Mexico City |

The country code is resolved at runtime from the user's active territory name via `TerritoryPreferenceReader`. Each agent has country-specific system instructions with the applicable regulatory framework.

The schedule action (`FSRMyScheduleAction`) supports localized labels for en_US, fr, de, it, es, ja, and ko.

## Test Results

| Country | Tests | Status | Key Regulatory Content Verified |
|---------|-------|--------|-------------------------------|
| [US](tests/US_TEST_RESULTS.md) | 6/6 | PASSED | NRx/TRx, FDA label, formulary, prior auth, PDMA, samples |
| [GB](tests/GB_TEST_RESULTS.md) | 6/6 | PASSED | NHS, NICE TA, MHRA, traffic-light, ICB, QOF, shared-care, Blueteq, ABPI |
| [FR](tests/FR_TEST_RESULTS.md) | 6/6 | PASSED | HAS, ANSM, CEPS, ASMR, AMM, PMSI, GHT, COMEDIMS, livret thérapeutique |
| [IT](tests/IT_TEST_RESULTS.md) | 6/6 | PASSED | AIFA, Registro AIFA, PTR, PTO, ASL, DD/DPC, SSN, IRCCS, MMG |
| [KR](tests/KR_TEST_RESULTS.md) | 5/6 | 5 PASSED, 1 BLOCKED | MFDS, NHIS, HIRA, KCR, MDT, RSA, biosimilar, 약사위원회 |
| BR | — | Not yet tested | |
| DE | — | Not yet tested | |
| ES | — | Not yet tested | |
| JP | — | Not yet tested | |
| MX | — | Not yet tested | |

Each test suite validates: correct prompt template invocation, native language responses, country-specific regulatory terminology, no cross-country language contamination, account resolution, message effectiveness analysis with dates/reactions, and safety compliance.

## Project Structure

```
force-app/main/default/
├── aiAuthoringBundles/
│   ├── Field_Sales_HCP_Agent_US/
│   ├── Field_Sales_HCP_Agent_GB/
│   ├── Field_Sales_HCP_Agent_FR/
│   ├── Field_Sales_HCP_Agent_DE/
│   ├── Field_Sales_HCP_Agent_IT/
│   ├── Field_Sales_HCP_Agent_ES/
│   ├── Field_Sales_HCP_Agent_JP/
│   ├── Field_Sales_HCP_Agent_KR/
│   ├── Field_Sales_HCP_Agent_BR/
│   └── Field_Sales_HCP_Agent_MX/
├── classes/
│   ├── FSRAskAboutAccountAction.cls       # Account intelligence (Apex + LLM)
│   ├── FSRDailyBriefAction.cls            # Daily briefing (Apex + LLM)
│   └── FSRMyScheduleAction.cls            # Visit schedule (Apex, HTML output)
├── genAiPromptTemplates/
│   ├── FSR_AcctSummary_{US,GB,FR,DE,IT,ES,JP,KR,BR,MX}
│   └── FSR_DailyBrief_{US,GB,FR,DE,IT,ES,JP,KR,BR,MX}
├── permissionsets/
│   ├── Demo_FSR_Power_Agent_{CC}.permissionset-meta.xml
│   └── Field_Sales_HCP_Agent_{CC}_Access.permissionset-meta.xml
└── tests/
    ├── US_TEST_RESULTS.md
    ├── GB_TEST_RESULTS.md
    ├── FR_TEST_RESULTS.md
    ├── IT_TEST_RESULTS.md
    └── KR_TEST_RESULTS.md
```

## Deployment

```bash
# Set target org
sf config set target-org <your-org-alias>

# Deploy all metadata
sf project deploy start --source-dir force-app

# Publish and activate an agent (repeat per country)
sf agent publish authoring-bundle --api-name Field_Sales_HCP_Agent_US
sf agent activate --api-name Field_Sales_HCP_Agent_US
```

## Permission Setup

Each country has its own permission sets. Assign to users who need agent access:

- **Field_Sales_HCP_Agent_{CC}_Access** — grants access to the agent and all backing Apex classes
- **Demo_FSR_Power_Agent_{CC}** — includes the above plus RunFlow permission

Both permission sets grant access to: `FSRAskAboutAccountAction`, `FSRDailyBriefAction`, `FSRMyScheduleAction`, and `TerritoryPreferenceReader`.

## Dependencies

- Life Sciences Cloud with Visits, Provider Visit Product Detailing, and Activity Plans
- Einstein Generative AI (for prompt template invocation via `ConnectApi.EinsteinLlm`)
- Territory Management (for territory-aware account filtering and country resolution)
- `TerritoryPreferenceReader` Apex class (deployed separately in the org)
