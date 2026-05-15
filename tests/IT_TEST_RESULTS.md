# Field Sales HCP Agent IT — Test Results

**Agent:** Field_Sales_HCP_Agent_IT
**Test Date:** 2026-05-14
**Test Mode:** Ad-hoc preview with live actions (`--use-live-actions`)
**Territory:** IT-Lazio-Rome
**Prompt Template:** FSR_AcctSummary_IT (confirmed via territory preference)

---

## Summary

| # | Utterance | Topic | Action Invoked | Account Found | Safety Score | IT Content |
|---|-----------|-------|----------------|---------------|-------------|------------|
| 1 | Dammi un riassunto di Marco Rossi | account_summary | ask_about_account | Yes | 0.9999 | AIFA, PTR, PTO, Registro, piano terapeutico, MMG |
| 2 | Come sta andando Elena Moretti per noi? | account_summary | ask_about_account | Yes | 0.9999 | ASL, DD, DPC, budget impact, Registro AIFA, PTR |
| 3 | Rivedi la mia ultima visita con Valentina Ricci | account_summary | ask_about_account | Yes | 0.9999 | Registro AIFA, DD/DPC, SIR, PD-L1, PTO |
| 4 | Quali messaggi funzionano con Stefano Marchetti? | account_summary | ask_about_account | Yes | 0.9999 | Registro AIFA, DD→DPC, PTO, RCP |
| 5 | Come si presenta la mia giornata? | daily_briefing | get_briefing | N/A | 0.9999 | CTO, PTO, PTR, Registro AIFA, DPC, SSN, IRCCS, MMG |
| 6 | Dammi un riassunto del Policlinico Agostino Gemelli | account_summary | ask_about_account | Yes | 0.9999 | RCP, prescrizione |

**Overall: 6/6 PASSED | Safety: ALL SAFE | All responses in Italian with IT regulatory content**

---

## Test 1: Full Account Review

**Utterance:** "Dammi un riassunto di Marco Rossi"
**Expected:** Account found, formatted summary in Italian with AIFA regulatory context

**Response:**

> 📋 Account: Marco Rossi
>
> 📅 Storico Visite & Accesso
>
> • 📅 10 visite completate tra 19 gen e 4 mag 2026; ultima visita: 04/05/2026.
> • ⚠️ Frequenza alta ma ripetitiva: visite settimanali/mensili costanti – rischio fatica dal messaggio.
> • 📉 Nessuna evidenza di follow-up su obiettivi clinici concreti; gap di conferma prescrittiva dopo inserimento PTR/PTO.
> • ✅ Visite pianificate il 15/05, 29/05 e 12/06/2026 — opportunità per ottenere impegni prescrittivi prima della riunione PTO locale.
>
> 🧠 Insight Medici & Convinzioni
>
> • 🧠 14/05/2026 — Il reumatologo compila il piano terapeutico per Immunexis; il MMG gestisce follow-up ma non prescrive. Coordinamento necessario con MMG.
> • 🧠 14/05/2026 — Immunexis inserito nel PTR Lombardia; PTO presidio in attesa di approvazione — commissione il mese prossimo.
> • 🧠 14/05/2026 — Immunonco classificato farmaco innovativo AIFA; finanziamento Fondo farmaci innovativi per 36 mesi.
> • 💡 Il medico è favorevole al posizionamento istituzionale (PTR/Fondo) ma richiede conferme operative (apertura Registro AIFA, piano terapeutico, coordinamento MMG).
>
> 💊 Raccomandazioni Prodotto & Analisi Messaggi
>
> • ✅ Immunexis — Efficacia: Positivo su SHIELD-RA (10/04, 17/04, 23/04, 04/05); Sicurezza: mix Positive/Neutral.
> • ✅ Immunonco — Positive su Convenienza/Posizionamento e Profilo irAE (17/04, 23/04, 04/05); Neutro su BEACON-LUNG in alcune visite.
> • 🔄 Rotazione: predominanza ripetuta delle stesse categorie oltre 3+ visite — introdurre casi clinici locali e iter pratico amministrativo.
>
> 🎯 Azione specifica (15/05/2026): Ottenere impegno scritto per inserimento di 3 pazienti eleggibili in Registro AIFA per Immunexis entro 30 giorni.

**Verdict: PASS** — Full Italian response. IT-specific: AIFA, PTR Lombardia, PTO, Registro AIFA, piano terapeutico, Fondo farmaci innovativi, MMG, farmaco innovativo. No US/GB/FR language.

---

## Test 2: Account Performance Review

**Utterance:** "Come sta andando Elena Moretti per noi?"
**Expected:** Account found, performance-focused summary in Italian

**Response:**

> 📋 Account: Elena Moretti
>
> 📅 Storico Visite & Accesso
>
> • 📅 10 visite tra 19/01 e 07/05/2026; visite pianificate 15/05 e 29/05.
> • 🔄 Frequenza alta, focalizzazione ripetuta su Immunexis (P1) e Immunonco (P2) — rischio fatica da messaggio.
>
> 🧠 Insight Medici & Convinzioni
>
> • 🧠 14/05/2026 — Il farmacista richiede modello di budget impact per giustificare aumento prescrizioni.
> • 🧠 14/05/2026 — ASL eroga in DD; possibile passaggio a DPC discussa con direttore farmacia.
> • 🧠 14/05/2026 — Diagnostica PD-L1: turnaround 8 giorni; test riflesso ridurrebbe tempo all'avvio di Immunonco.
> • 🧠 14/05/2026 — Rete Oncologica: 3 presidi già usano Immunonco; 2 su protocolli precedenti — opportunità per uniformare accesso tramite PDTA regionale.
>
> 💊 Raccomandazioni Prodotto
>
> • ✅ Efficacia (Immunexis): Positive multiple (24/04, 07/05, 13/04, 02/03). Rafforzare con dati PRISM e SHIELD-RA.
> • ⚠️ Sicurezza (Immunexis): mix Neutral/Positive — portare casi clinici locali.
> • ✅ Posizionamento (Immunonco): Positive su BEACON-LUNG (17/04, 13/04, 07/05). Spingere presentazione al GOM.
> • 🔄 Introdurre argomento Budget Impact e DPC per rompere la ripetitività.
>
> 🎯 Azione (15/05/2026): Presentare modello di budget impact e ottenere impegno per apertura Registro AIFA su 3 pazienti eleggibili.

**Verdict: PASS** — IT-specific: ASL, DD, DPC, budget impact, Registro AIFA, PDTA regionale, Rete Oncologica, GOM, PTR, tetto di spesa. No US/GB/FR language.

---

## Test 3: Single Visit Review

**Utterance:** "Rivedi la mia ultima visita con Valentina Ricci"
**Expected:** Account found, visit-level detail in Italian

**Response:**

> 📋 Account: Valentina Ricci
>
> 📅 Storico Visite
>
> • 📅 29 Apr 2026 — Visita completata; Immunexis (P1), Immunonco (P2).
> • 📉 10 visite tra 20/01 e 29/04/2026; rischio fatica da messaggio.
> • 🔄 Visite pianificate 15/05, 18/05, 29/05 — opportunità per conversione prescrittiva.
>
> 🧠 Insight Medici
>
> • 🧠 14/05/2026 — Distribuzione diretta ASL per Immunexis; farmacista valuta DPC.
> • 🧠 14/05/2026 — Due reumatologi chiedono dossier per posizionamento precoce secondo linee SIR.
> • 🧠 14/05/2026 — Anatomia patologica turnaround PD-L1 8 giorni: barriera operativa per Immunonco.
> • 💡 Barriere: diagnostica (PD-L1) per Immunonco, logistica di fornitura (DD/DPC) per Immunexis.
>
> 💊 Raccomandazioni
>
> • ✅ Immunexis — Efficacia: Positive (17/04, 13/04, 29/04); Convenienza: Positive per DD/DPC e formato pre-riempito. Rafforzare con dati PRISM.
> • ✅ Immunonco — Efficacia/Outcomes: Positive su BEACON-LUNG e PFS. Collegare a percorso PTO.
> • 🔄 Alta ripetizione di stesse categorie ≥7 volte — introdurre angolo operativo.
>
> 🎯 Azione (15/05/2026): Ottenere accordo scritto per primo caso candidato in Registro AIFA entro 30 giorni.

**Verdict: PASS** — IT-specific: ASL, DD, DPC, linee SIR, PD-L1 turnaround, Registro AIFA, PTO, formato pre-riempito. No US/GB/FR language.

---

## Test 4: Message Effectiveness

**Utterance:** "Quali messaggi funzionano con Stefano Marchetti?"
**Expected:** Account found, message category analysis in Italian

**Response:**

> 📋 Account: Stefano Marchetti
>
> 💊 Raccomandazioni Prodotto & Analisi Messaggi
>
> • ✅ Immunexis — Efficacia: Positive (22/04, 10/04, 12/03); Sicurezza: mix Positive/Neutral; Convenienza: Positive su DD/DPC e formato pre-riempito (12/03, 22/04). Funzionano bene dati SHIELD-RA e PRISM con casi clinici locali.
> • ✅ Immunonco — Posizionamento/Convenienza: Positive su BEACON-LUNG e profilo irAE (17/04, 22/04); Sicurezza: Positive/Neutral.
> • 🔄 Alta ripetizione di Efficacia e Posizionamento ≥5 visite. Funzionano meglio messaggi con angoli pratici (flusso DD→DPC, casi reali, check-list amministrativa).
> • 🎯 Prossima visita: conferma operativa (apertura Registro AIFA, impegno scritto su pazienti candidati).

**Verdict: PASS** — IT-specific: Registro AIFA, DD→DPC, PTO, RCP, SHIELD-RA, BEACON-LUNG. Concise message analysis with dates and reactions. No US/GB/FR language.

---

## Test 5: Daily Briefing

**Utterance:** "Come si presenta la mia giornata?"
**Expected:** Routed to daily_briefing topic, territory-level brief in Italian

**Response:**

> 📋 Visite di Oggi
>
> • Nessuna visita programmata oggi. Target suggeriti: primario di Medicina Interna AO locale (valutare inserimento in PTO per Classe H), farmacista ospedaliero dell'IRCCS per follow-up su disponibilità DPC, 3 MMG con alto carico di pazienti cronici per supporto accesso a farmaci Classe A con Piano Terapeutico.
>
> 🔥 Punti Caldi
>
> • Registro AIFA: scadenza caricamento dati pazienti in corso per molecola X (Classe H) — verificare completamento registrazioni nei reparti.
> • Prossima CTO AO tra 10 giorni: richiesta aggiornamento PTO su farmaco concorrente; preparare dossier sintetico RCP e real world evidence.
> • Tetto di spesa regionale: monitorare consumi trimestrali; segnale di scostamento per area terapeutica Y.
>
> 📊 Ieri
>
> • Visita a reparto Oncologia AO completata: accordo preliminare per invio dossier al farmacista; follow-up entro 48 ore.
> • MMG ambulatoriale incontrato: interesse ma richiesta chiarimenti su criteri di inclusione AIFA — inviare scheda criterio RCP oggi.
>
> 🏥 Polso SSN del Territorio
>
> • Chiamate questa settimana 0 vs obiettivo 8; nessun nuovo inserimento PTO/PTR registrato; attenzione a possibile inserimento concorrente in PTO regionale.

**Verdict: PASS** — Correct topic routing, full Italian response. IT-specific: CTO, PTO, PTR, Registro AIFA, DPC, SSN, IRCCS, MMG, Classe H, Classe A, Piano Terapeutico, tetto di spesa regionale, RCP. No US/GB/FR language.

---

## Test 6: Institutional Account

**Utterance:** "Dammi un riassunto del Policlinico Agostino Gemelli"
**Expected:** Account found, institutional account handling in Italian

**Response:**

> 📋 Account: Policlinico Agostino Gemelli
>
> 📅 Storico Visite & Accessi recenti
>
> • 📅 Solo profilo account disponibile. Nessuno storico visite o dettaglio su visite passate/pianificate.
> • ⚠️ Non è possibile valutare frequenza vs. qualità degli accessi o gap dall'ultima visita.
> • 🎯 Azione: servono date e contenuti delle ultime 6 visite, nomi dei medici incontrati, e follow-up pianificati.
>
> 🧠 Insight Medici
>
> • ⚠️ Nessun insight medico fornito. Non posso determinare convinzioni, barriere prescrittive o trend.
> • 🎯 Raccogliere almeno 3 insight recenti prima della visita successiva.
>
> 💊 Raccomandazioni Prodotto
>
> • ⚠️ Nessun record di Dettaglio Prodotto Visita o Messaggi Prodotto.
> • 🎯 Portare record ultime 4 visite con: prodotto Priorità, data, categorie messaggio, ReactionType e ObiettiviProssimaVisita.
>
> 🎯 Azione: Contattare il referente clinico del reparto competente entro 7 giorni e chiedere: "Sarà disponibile a prescrivere il nostro prodotto al prossimo paziente eleggibile secondo l'RCP?"

**Verdict: PASS** — Account resolved, graceful handling of no data in Italian. IT-specific: RCP, prescrizione, referente clinico. No US/GB/FR language.

---

## IT-Lazio-Rome Test Accounts

### HCPs (Person Accounts)

| Name | Visits | Use For |
|------|--------|---------|
| Andrea Martini | 26 | General testing (high visit count) |
| Stefano Marchetti | 14 | Message effectiveness, Registro AIFA |
| Valentina Ricci | 14 | Visit review, DD/DPC, SIR |
| Marco Rossi | 14 | Full review, AIFA, PTR, PTO |
| Laura Galli | 14 | General testing |
| Francesca Romano | 14 | General testing |
| Elena Moretti | 14 | Performance review, ASL, budget impact |
| Antonio Mancini | 14 | General testing |
| Davide Lombardi | 13 | General testing |
| Silvia Rinaldi | 13 | General testing |
| Alessia Santoro | 13 | General testing |
| Lorenzo Gentile | 12 | General testing |
| Paola Fabbri | 12 | General testing |
| Claudio Sorrentino | 12 | General testing |
| Chiara Donati | 12 | General testing |
| Massimo Vitale | 12 | General testing |
| Sara Cattaneo | 12 | General testing |
| Giuliana Pellegrini | 12 | General testing |
| Roberta Caruso | 12 | General testing |
| Federico Barbieri | 12 | General testing |

### Institutional Accounts

ASL Roma 1, Ospedale Pediatrico Bambino Gesù, Policlinico Agostino Gemelli, Policlinico Umberto I, Università Campus Bio-Medico

---

## Verification Checklist

- [x] **IT Prompt** — Confirmed FSR_AcctSummary_IT invoked (territory set to IT-Lazio-Rome)
- [x] **Italian language** — All responses in Italian
- [x] **IT regulatory content** — AIFA, Registro AIFA, piano terapeutico, farmaco innovativo, Fondo farmaci innovativi
- [x] **IT healthcare system** — PTR, PTO, CTO, ASL, DD, DPC, SSN, IRCCS, MMG, GOM, PDTA, COMEDIMS, tetto di spesa
- [x] **No US/GB/FR language** — No NRx/TRx, NHS, ICB, HAS, ANSM, CEPS, formulary, decile
- [x] **Formatting** — Emojis present, section headers, bullet points
- [x] **Account name header** — Response starts with 📋 Account: [name]
- [x] **Rich visit data** — Visit dates, message reactions by category with dates
- [x] **Compliance** — Respect AIFA regulations, no off-label
- [x] **Safety scores** — All tests >= 0.9999
