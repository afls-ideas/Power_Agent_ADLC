# Field Sales HCP Agent US

An Agentforce employee agent for pharmaceutical field sales reps built on the Atlas Reasoning Engine using Agent Script. The agent provides account intelligence, visit schedules, and daily briefings — accessible from both the Agentforce desktop panel and mobile SDK.

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

## Multi-Country Support

Prompt templates exist for 8 country variants: US, GB, FR, DE, IT, ES, JP, KR. The country code is resolved at runtime from the user's active territory name via `TerritoryPreferenceReader`.

The schedule action (`FSRMyScheduleAction`) supports localized labels for en_US, fr, de, it, es, ja, and ko.

## Project Structure

```
force-app/main/default/
├── aiAuthoringBundles/
│   └── Field_Sales_HCP_Agent_US/
│       ├── Field_Sales_HCP_Agent_US.agent        # Agent Script source
│       └── Field_Sales_HCP_Agent_US-bundle-meta.xml
├── classes/
│   ├── FSRAskAboutAccountAction.cls              # Account intelligence (Apex + LLM)
│   ├── FSRDailyBriefAction.cls                   # Daily briefing (Apex + LLM)
│   └── FSRMyScheduleAction.cls                   # Visit schedule (Apex, HTML output)
├── genAiPromptTemplates/
│   ├── FSR_AcctSummary_{US,GB,FR,DE,IT,ES,JP,KR} # Account summary prompts
│   └── FSR_DailyBrief_{US,GB,FR,DE,IT,ES,JP,KR}  # Daily briefing prompts
└── permissionsets/
    ├── Demo_FSR_Power_Agent_US.permissionset-meta.xml
    └── Field_Sales_HCP_Agent_US_Access.permissionset-meta.xml
```

## Deployment

```bash
# Set target org
sf config set target-org <your-org-alias>

# Deploy all metadata
sf project deploy start --source-dir force-app

# Publish and activate the agent
sf agent publish authoring-bundle --api-name Field_Sales_HCP_Agent_US
sf agent activate --api-name Field_Sales_HCP_Agent_US
```

## Permission Setup

Assign one of the included permission sets to users who need agent access:

- **Field_Sales_HCP_Agent_US_Access** — grants access to the agent and all backing Apex classes
- **Demo_FSR_Power_Agent_US** — includes the above plus RunFlow permission

Both permission sets grant access to: `FSRAskAboutAccountAction`, `FSRDailyBriefAction`, `FSRMyScheduleAction`, and `TerritoryPreferenceReader`.

## Dependencies

- Life Sciences Cloud with Visits, Provider Visit Product Detailing, and Activity Plans
- Einstein Generative AI (for prompt template invocation via `ConnectApi.EinsteinLlm`)
- Territory Management (for territory-aware account filtering and country resolution)
- `TerritoryPreferenceReader` Apex class (deployed separately in the org)
