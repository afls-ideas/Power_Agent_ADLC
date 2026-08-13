# Custom Lightning Types (Rich Agent Responses)

By default, Agentforce renders action output as free text. Markdown is inconsistent in
the agent panel — indentation, bullets, and headings render unreliably — so summaries
end up as a hard-to-scan wall of text.

**Custom Lightning Types (CLTs)** let an action return a typed object that a Lightning
Web Component renders instead. The LWC — not the LLM's markdown — controls layout, so
responses get clean headings, bullet lists, badges, links, and eventually tables,
timelines, and charts. The goal: make Agentforce responses feel more like Claude.

## Implemented Types

| Type | Renders | Action | Trigger Examples |
|------|---------|--------|------------------|
| **FSR Account Brief** | Structured summary card — account name header, sections (heading + bullets), highlighted next step | `FSRAccountBriefAction` | "overview of Dr. Kim", "brief me on Stanford Health Care", "recap this account", "profile of Dr. Chandra" |

The Account Brief is an **additional** action in the `account_summary` topic — the
original free-text `FSRAskAboutAccountAction` still handles detailed follow-ups, message
lists, and specific data pulls. Summary/overview/brief/briefing/profile/recap requests
route to the card; everything else stays free-text.

## How a CLT Is Wired Together

A CLT needs four pieces, all of which must follow strict conventions or the
`@apexClassType` binding silently fails to resolve (the action fires but nothing mounts):

```
1. Apex type classes ──► 2. Apex invocable action ──► 3. lightningType ──► 4. LWC
   (the data shape)         (returns the typed obj)     (binds type→LWC)    (renders it)
```

### 1. Apex type classes — the data shape

The object the card renders and every nested type must be a **top-level `global` class**
annotated `@JsonAccess(serializable='always' deserializable='always')`, with
`@AuraEnabled global` fields. Inner classes, `public` visibility, or a missing
`@JsonAccess` will break the reflection binding.

- `FSRAccountBrief.cls` — the card: `accountName`, `subtitle`, `headline`, `List<FSRAccountBriefSection> sections`, `nextStep`
- `FSRAccountBriefSection.cls` — one section: `heading`, `List<String> bullets`

### 2. Apex invocable action

- `FSRAccountBriefRequest.cls` — `@InvocableVariable global` inputs (`question`, `accountId`, `accountName`)
- `FSRAccountBriefResult.cls` — `@InvocableVariable global FSRAccountBrief brief`
- `FSRAccountBriefAction.cls` — `@InvocableMethod global static` method. Reuses the proven
  sales-context + prompt-template pipeline (`FSRAskAboutAccountAction.getFormattedSummary`)
  to generate the well-formatted text, then `parseBrief()` splits it into structured
  sections so the LWC controls layout.

### 3. lightningType metadata

`lightningTypes/fsrAccountBrief/`:

- `schema.json` — points the type at the Apex class:
  ```json
  { "title": "FSR Account Brief", "lightning:type": "@apexClassType/c__FSRAccountBrief" }
  ```
- `lightningDesktopGenAi/renderer.json` — binds the type to the LWC:
  ```json
  { "renderer": { "componentOverrides": { "$": { "definition": "c/fsrAccountBriefCard" } } } }
  ```

### 4. Lightning Web Component

`lwc/fsrAccountBriefCard/` — the typed output arrives on the CLT-standard `@api value`
property. `meta.xml` targets `lightning__AgentforceOutput` with
`<sourceType name="c__fsrAccountBrief"/>`.

### 5. Agent Script wiring

In the `account_summary` topic's `account_brief` action, the output block declares the type:

```
outputs:
    brief: object
        complex_data_type_name: "c__fsrAccountBrief"
        is_displayable: True
        filter_from_agent: False
```

The topic reasoning instructs the planner to **always use `show_command`** to display the
returned card.

## Conventions Checklist (why bindings fail)

The root cause of a CLT that "fires but never mounts" is almost always a violated
convention, not the DSL:

- [ ] Action class **and** every request/result/type class is **top-level `global`** (never inner, never `public`)
- [ ] Every type class has `@JsonAccess(serializable='always' deserializable='always')`
- [ ] Data fields are `@AuraEnabled global`; invocable I/O fields are `@InvocableVariable global`
- [ ] `schema.json` uses `@apexClassType/c__<ClassName>` with correct casing
- [ ] `renderer.json` `definition` matches the LWC folder name (`c/<lwcName>`)
- [ ] LWC exposes `@api value` and targets `lightning__AgentforceOutput` with the matching `<sourceType>`
- [ ] DSL output block sets `complex_data_type_name`, `is_displayable: True`, `filter_from_agent: False`
- [ ] Topic reasoning tells the planner to use `show_command`

Verify the binding is healthy via the Connect API:

```
/services/data/v66.0/connect/lightning-types/c__fsrAccountBrief?rendererConfigTarget=lightningDesktopGenAi
```

## Runtime Permission Requirement

The Brief action calls a prompt template under the hood, so the running user needs
`ExecutePromptTemplates`. This **cannot** be granted via a bare `<userPermissions>` entry
on the demo permission set (it's license-gated — the deploy no-ops silently). Assign the
standard **`EinsteinGPTPromptTemplateUser`** permission set to the rep. Symptom when
missing: the agent replies *"Insufficient Privileges: This feature is not currently
enabled for this user."* Permission changes require a session reload to take effect.

## Testing

CLT rendering can be nondeterministic — the same utterance can occasionally return
text instead of the card. Test live as the field rep (not admin),
and if a card doesn't render, resend with slightly different phrasing before assuming a
regression. `sf agent test` caches results by utterance, so always use fresh utterances.

## Roadmap

Additional CLTs planned to further enrich agent responses:

- **Tables / related lists** — e.g. visit history, product detailing records
- **Timeline diagrams** — visit cadence and message delivery over time
- **Charts** — Rx trends, message effectiveness, attainment vs. goal

## File Map

```
force-app/main/default/
├── classes/
│   ├── FSRAccountBrief.cls            # CLT data type (card)
│   ├── FSRAccountBriefSection.cls     # CLT data type (section)
│   ├── FSRAccountBriefRequest.cls     # Invocable inputs
│   ├── FSRAccountBriefResult.cls      # Invocable output wrapper
│   └── FSRAccountBriefAction.cls      # Invocable action + parseBrief()
├── lightningTypes/fsrAccountBrief/
│   ├── schema.json                    # @apexClassType binding
│   └── lightningDesktopGenAi/
│       └── renderer.json              # type → LWC binding
└── lwc/fsrAccountBriefCard/           # renders the card
    ├── fsrAccountBriefCard.js         # @api value
    ├── fsrAccountBriefCard.html
    ├── fsrAccountBriefCard.css
    └── fsrAccountBriefCard.js-meta.xml
```
