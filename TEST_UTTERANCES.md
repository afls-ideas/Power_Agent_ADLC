# FSR Agent Test Utterances by Country

Test utterances for each country's AcctSummary and DailyBrief prompt templates. Each section covers the key capabilities the prompt should handle.

**Two testing modes:**
1. **On a record page** — Navigate to an Account record page first. The agent picks up `record_id` from `@record.Id` automatically, so you don't need to say the account name. Use the "On record page" utterances below.
2. **Not on a record page** — Say the account name explicitly in your utterance. Use the "By name" utterances below.

---

## US (us.rep)

**AcctSummary — Full account review**
- "Give me a summary of Dr. Martinez"
- "How is Dr. Chen performing for us?"

**AcctSummary — NRx/TRx analysis (US only)**
- "What are Dr. Martinez's prescription trends?"
- "Is Dr. Chen growing or declining on Immunexis?"

**AcctSummary — Single visit review**
- "Review my last visit with Dr. Martinez"
- "How did the June 3rd visit with Dr. Chen go?"

**AcctSummary — Message effectiveness**
- "Which messages are working with Dr. Martinez?"
- "What should I lead with on my next detail with Dr. Chen?"

**AcctSummary — Medical insights**
- "What do we know about Dr. Martinez's treatment preferences?"
- "What are Dr. Chen's concerns about our products?"

**AcctSummary — Next visit planning**
- "Help me prepare for my next visit with Dr. Martinez"
- "What should I do differently with Dr. Chen?"

**DailyBrief**
- "What's my day look like?"
- "Brief me on today's visits"

---

## GB (gb.rep) — Territory: GB-England-London

HCPs: William Hartley (15 visits), Amara Osei (14), Sophie Cartwright (14), Priya Kapoor (14), Oliver Pemberton (14), James Okafor (14), Charlotte Ainsworth (14), Edward Thornton-Hall (14), Eleanor Blackwood (14), Henry Whitmore (14), Fatima Al-Hassan (13), Richard Ellsworth (13), Mei Liang (13), George Fitzwilliam (13), Aisha Mohammed (13)

Accounts: Barts Health NHS Trust, Bloomsbury Surgery, BUPA, Great Ormond Street Hospital, Guy's and St Thomas' NHS Foundation Trust, Harley Street Clinic, King's College Hospital, NHS England, NHS North East London ICB, NHS South East London ICB, Royal London Hospital, St Thomas' Hospital, The Bermondsey and Lansdowne Medical Mission, University College London Hospital, Whitechapel Health Centre

### On record page (navigate to account first, no name needed)

**Full account review**
- "Give me a summary of this account"
- "How is this HCP performing for us?"
- "Tell me about this doctor"

**NHS access & formulary**
- "What's the formulary status for this account?"
- "Is there a shared care protocol in place for Immunexis?"
- "What's the traffic light status for our products here?"

**Single visit review**
- "Review my last visit"
- "How did my most recent visit go?"
- "Walk me through the last detail"

**Message effectiveness**
- "Which messages are landing?"
- "Should I lead with NICE guidance or efficacy data?"
- "What's working and what's not?"

**Medical insights**
- "What does this doctor think about Immunexis?"
- "What are the barriers to prescribing?"
- "What insights do we have?"

**Next visit planning**
- "Help me prepare for my next visit"
- "What should I focus on next time?"
- "What's my game plan?"

**QOF alignment**
- "Does Immunexis help hit any QOF targets?"

**Broad / open-ended**
- "What should I know before my next visit?"
- "What's the one thing I should do differently?"
- "Anything I'm missing?"

### By name (not on a record page)

**Full account review**
- "Give me a summary of William Hartley"
- "How is Priya Kapoor performing for us?"

**NHS access & formulary**
- "What's the formulary status for William Hartley's Trust?"
- "Is there a shared care protocol in place for Immunexis at Priya Kapoor's ICB?"

**Traffic light & shared care**
- "What's blocking prescribing for William Hartley?"
- "Is Amara Osei's hospital green-lighted for our products?"

**Single visit review**
- "Review my last visit with William Hartley"
- "How did my last visit with Sophie Cartwright go?"

**Message effectiveness**
- "Which messages are landing with William Hartley?"
- "Should I lead with NICE guidance or efficacy data for Priya Kapoor?"

**Medical insights**
- "What does William Hartley think about Immunexis?"
- "What are Priya Kapoor's barriers to prescribing?"

**Next visit planning**
- "Help me prepare for my next visit with William Hartley"
- "What should I focus on with Sophie Cartwright?"

**QOF alignment**
- "Does Immunexis help Priya Kapoor hit any QOF targets?"

**Institutional accounts**
- "Give me a summary of King's College Hospital"
- "How is Barts Health NHS Trust performing for us?"

**DailyBrief**
- "What's my day look like?"
- "Brief me on today's visits"

---

## FR (fr.rep)

**AcctSummary — Bilan complet du compte**
- "Donne-moi un résumé du Dr. Dupont"
- "Comment se passe le Dr. Martin pour nous ?"

**AcctSummary — Revue d'une visite**
- "Revois ma dernière visite avec le Dr. Dupont"
- "Comment s'est passée la visite du 3 juin avec le Dr. Martin ?"

**AcctSummary — Efficacité des messages**
- "Quels messages fonctionnent avec le Dr. Dupont ?"
- "Avec quoi devrais-je commencer mon prochain entretien avec le Dr. Martin ?"

**AcctSummary — Insights médicaux**
- "Que sait-on des préférences de traitement du Dr. Dupont ?"
- "Quels sont les freins du Dr. Martin à prescrire ?"

**AcctSummary — Préparation prochaine visite**
- "Aide-moi à préparer ma prochaine visite avec le Dr. Dupont"
- "Que devrais-je faire différemment avec le Dr. Martin ?"

**DailyBrief**
- "Comment se présente ma journée ?"
- "Fais-moi le brief de la journée"

---

## DE (de.rep)

**AcctSummary — Vollständige Kontobewertung**
- "Gib mir eine Zusammenfassung von Dr. Müller"
- "Wie läuft es mit Dr. Schmidt für uns?"

**AcctSummary — Einzelne Besuchsbewertung**
- "Überprüfe meinen letzten Besuch bei Dr. Müller"
- "Wie lief der Besuch am 3. Juni bei Dr. Schmidt?"

**AcctSummary — Nachrichteneffektivität**
- "Welche Botschaften funktionieren bei Dr. Müller?"
- "Womit sollte ich beim nächsten Detail mit Dr. Schmidt beginnen?"

**AcctSummary — Medizinische Insights**
- "Was wissen wir über die Behandlungspräferenzen von Dr. Müller?"
- "Was sind die Bedenken von Dr. Schmidt bezüglich unserer Produkte?"

**AcctSummary — Nächster Besuch Vorbereitung**
- "Hilf mir, meinen nächsten Besuch bei Dr. Müller vorzubereiten"
- "Was sollte ich bei Dr. Schmidt anders machen?"

**DailyBrief**
- "Wie sieht mein Tag aus?"
- "Gib mir das Briefing für heute"

---

## IT (it.rep)

**AcctSummary — Riepilogo completo del conto**
- "Dammi un riepilogo del Dr. Rossi"
- "Come sta andando il Dr. Bianchi per noi?"

**AcctSummary — Revisione singola visita**
- "Rivedi la mia ultima visita con il Dr. Rossi"
- "Com'è andata la visita del 3 giugno con il Dr. Bianchi?"

**AcctSummary — Efficacia dei messaggi**
- "Quali messaggi funzionano con il Dr. Rossi?"
- "Con cosa dovrei iniziare il prossimo dettaglio con il Dr. Bianchi?"

**AcctSummary — Insights medici**
- "Cosa sappiamo sulle preferenze di trattamento del Dr. Rossi?"
- "Quali sono le barriere del Dr. Bianchi alla prescrizione?"

**AcctSummary — Preparazione prossima visita**
- "Aiutami a preparare la mia prossima visita con il Dr. Rossi"
- "Cosa dovrei fare diversamente con il Dr. Bianchi?"

**DailyBrief**
- "Com'è la mia giornata?"
- "Fammi il briefing di oggi"

---

## ES (es.rep)

**AcctSummary — Resumen completo de la cuenta**
- "Dame un resumen del Dr. García"
- "¿Cómo va el Dr. López para nosotros?"

**AcctSummary — Revisión de una visita**
- "Revisa mi última visita con el Dr. García"
- "¿Cómo fue la visita del 3 de junio con el Dr. López?"

**AcctSummary — Efectividad de mensajes**
- "¿Qué mensajes están funcionando con el Dr. García?"
- "¿Con qué debería empezar en mi próximo detalle con el Dr. López?"

**AcctSummary — Insights médicos**
- "¿Qué sabemos sobre las preferencias de tratamiento del Dr. García?"
- "¿Cuáles son las barreras del Dr. López para prescribir?"

**AcctSummary — Preparación próxima visita**
- "Ayúdame a preparar mi próxima visita con el Dr. García"
- "¿Qué debería hacer diferente con el Dr. López?"

**DailyBrief**
- "¿Cómo se ve mi día?"
- "Dame el briefing de hoy"

---

## JP (jp.rep)

**AcctSummary — アカウント全体レビュー**
- "田中先生のまとめを教えてください"
- "佐藤先生の状況はどうですか？"

**AcctSummary — 個別訪問レビュー**
- "田中先生との最後の訪問をレビューしてください"
- "6月3日の佐藤先生との訪問はどうでしたか？"

**AcctSummary — メッセージ効果**
- "田中先生にはどのメッセージが効いていますか？"
- "佐藤先生への次のディテーリングで何をリードすべきですか？"

**AcctSummary — メディカルインサイト**
- "田中先生の治療嗜好について何がわかっていますか？"
- "佐藤先生が処方をためらっている理由は？"

**AcctSummary — 次回訪問準備**
- "田中先生への次の訪問の準備を手伝ってください"
- "佐藤先生に対して何を変えるべきですか？"

**DailyBrief**
- "今日の予定はどうなっていますか？"
- "今日のブリーフィングをお願いします"

---

## KR (kr.rep)

**AcctSummary — 전체 계정 리뷰**
- "김 교수님 요약을 알려주세요"
- "박 교수님 상황은 어떻습니까?"

**AcctSummary — 개별 방문 리뷰**
- "김 교수님과의 마지막 방문을 리뷰해 주세요"
- "6월 3일 박 교수님 방문은 어떻게 되었습니까?"

**AcctSummary — 메시지 효과**
- "김 교수님에게 어떤 메시지가 효과적입니까?"
- "박 교수님 다음 디테일링에서 무엇을 리드해야 합니까?"

**AcctSummary — 의학적 인사이트**
- "김 교수님의 처방 선호도에 대해 무엇을 알고 있습니까?"
- "박 교수님이 처방을 주저하는 이유는 무엇입니까?"

**AcctSummary — 다음 방문 준비**
- "김 교수님 다음 방문 준비를 도와주세요"
- "박 교수님에게 무엇을 다르게 해야 합니까?"

**DailyBrief**
- "오늘 일정이 어떻게 됩니까?"
- "오늘 브리핑을 부탁합니다"

---

## BR (br.rep)

**AcctSummary — Resumo completo da conta**
- "Me dê um resumo do Dr. Silva"
- "Como está o Dr. Santos para nós?"

**AcctSummary — Revisão de uma visita**
- "Revise minha última visita com o Dr. Silva"
- "Como foi a visita de 3 de junho com o Dr. Santos?"

**AcctSummary — Efetividade de mensagens**
- "Quais mensagens estão funcionando com o Dr. Silva?"
- "Com o que devo liderar no próximo detalhe com o Dr. Santos?"

**AcctSummary — Insights médicos**
- "O que sabemos sobre as preferências de tratamento do Dr. Silva?"
- "Quais são as barreiras do Dr. Santos para prescrever?"

**AcctSummary — Preparação próxima visita**
- "Me ajude a preparar minha próxima visita com o Dr. Silva"
- "O que devo fazer diferente com o Dr. Santos?"

**DailyBrief**
- "Como está meu dia?"
- "Me dê o briefing de hoje"

---

## MX (mx.rep)

**AcctSummary — Resumen completo de la cuenta**
- "Dame un resumen del Dr. Hernández"
- "¿Cómo va el Dr. Ramírez para nosotros?"

**AcctSummary — Revisión de una visita**
- "Revisa mi última visita con el Dr. Hernández"
- "¿Cómo fue la visita del 3 de junio con el Dr. Ramírez?"

**AcctSummary — Efectividad de mensajes**
- "¿Qué mensajes están funcionando con el Dr. Hernández?"
- "¿Con qué debería empezar en mi próximo detalle con el Dr. Ramírez?"

**AcctSummary — Insights médicos**
- "¿Qué sabemos sobre las preferencias de tratamiento del Dr. Hernández?"
- "¿Cuáles son las barreras del Dr. Ramírez para prescribir?"

**AcctSummary — Preparación próxima visita**
- "Ayúdame a preparar mi próxima visita con el Dr. Hernández"
- "¿Qué debería hacer diferente con el Dr. Ramírez?"

**DailyBrief**
- "¿Cómo se ve mi día?"
- "Dame el briefing de hoy"

---

## What to Check in Every Response

For **every** test utterance, verify:

1. **Formatting** — Emojis present, section headers on own lines, bullet points with •, two blank lines before each section, no HTML, no markdown, no code fences
2. **Account name** — Response starts with 📋 Account/Conta/Cuenta/Compte/Konto/アカウント/계정 header
3. **Dates included** — All message reactions and objectives reference specific visit dates
4. **Message categories** — Uses category labels (Efficacy, Safety, etc.) from message Name field, not raw MessageText
5. **One closing action** — Ends with a single specific next step, not a menu of options
6. **Compliance** — No off-label suggestions, no competitor disparagement, no incentive recommendations
7. **Language** — Response is in the correct language for the country
8. **No Salesforce IDs** — No raw 15/18-character IDs visible

### US-only checks
- NRx/TRx analysis present when prescription data exists
- Prescription trend interpretation (growing, declining, flat)

### GB-only checks
- NHS context: references to formulary, NICE, traffic light status, shared care protocols, ICBs
- QOF alignment mentioned when relevant
- Closing action appropriate to HCP role (consultant initiation vs GP shared care continuation)
- No suggestion to lobby formulary/D&T committees directly
