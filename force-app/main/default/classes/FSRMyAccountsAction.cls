/**
 * Created by Peter Yeung on 2026-08-11.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * Agentforce invocable action for the "Field Sales HCP Agent" agents.
 * Returns the list of accounts the current rep owns, narrowed by the rep's
 * active territory when one is set (mirrors FSRMyScheduleAction scoping).
 *
 * Each account is rendered as a markdown link so the Agentforce panel shows a
 * tappable list. The link uses the relative Lightning URL
 * (/lightning/r/Account/{id}/view), which works on BOTH surfaces: the desktop
 * panel navigates to it directly, and the Life Sciences Cloud mobile app
 * intercepts the same path. A bare "lsc://" deep link is deliberately NOT used
 * because the desktop browser has no handler for that scheme and silently
 * falls back to the home page.
 */
public with sharing class FSRMyAccountsAction {

    private static final Map<String, Map<String, String>> LABELS = new Map<String, Map<String, String>>{
        'en_US' => new Map<String, String>{
            'heading' => 'Your accounts', 'account' => 'account', 'accounts' => 'accounts',
            'none' => 'No accounts found in your territory.',
            'open' => 'Open', 'open_app' => 'Open in app'
        },
        'fr' => new Map<String, String>{
            'heading' => 'Vos comptes', 'account' => 'compte', 'accounts' => 'comptes',
            'none' => 'Aucun compte trouvé dans votre secteur.',
            'open' => 'Ouvrir', 'open_app' => 'Ouvrir dans l\'app'
        },
        'de' => new Map<String, String>{
            'heading' => 'Ihre Accounts', 'account' => 'Account', 'accounts' => 'Accounts',
            'none' => 'Keine Accounts in Ihrem Gebiet gefunden.',
            'open' => 'Öffnen', 'open_app' => 'In App öffnen'
        },
        'it' => new Map<String, String>{
            'heading' => 'I tuoi account', 'account' => 'account', 'accounts' => 'account',
            'none' => 'Nessun account trovato nel tuo territorio.',
            'open' => 'Apri', 'open_app' => 'Apri nell\'app'
        },
        'es' => new Map<String, String>{
            'heading' => 'Sus cuentas', 'account' => 'cuenta', 'accounts' => 'cuentas',
            'none' => 'No se encontraron cuentas en su territorio.',
            'open' => 'Abrir', 'open_app' => 'Abrir en la app'
        },
        'ja' => new Map<String, String>{
            'heading' => '担当アカウント', 'account' => '件のアカウント', 'accounts' => '件のアカウント',
            'none' => 'テリトリーにアカウントが見つかりません。',
            'open' => '開く', 'open_app' => 'アプリで開く'
        },
        'ko' => new Map<String, String>{
            'heading' => '내 거래처', 'account' => '개 거래처', 'accounts' => '개 거래처',
            'none' => '담당 지역에 거래처가 없습니다.',
            'open' => '열기', 'open_app' => '앱에서 열기'
        }
    };

    private static Map<String, String> getLabels() {
        String lang = UserInfo.getLanguage();
        if (LABELS.containsKey(lang)) return LABELS.get(lang);
        return LABELS.get('en_US');
    }

    @InvocableMethod(label='FSR My Accounts' description='Returns the accounts owned by the current rep (narrowed by active territory) as a tappable list with desktop and Life Sciences mobile deep links. Call this when the user asks to see, show, or list their accounts or HCPs.')
    public static List<ActionResponse> getMyAccounts(List<ActionRequest> requests) {
        List<ActionResponse> responses = new List<ActionResponse>();

        for (ActionRequest req : requests) {
            ActionResponse resp = new ActionResponse();
            try {
                resp = buildAccounts(req);
            } catch (Exception e) {
                resp.output = 'Error: ' + e.getMessage();
                resp.accountCount = 0;
            }
            responses.add(resp);
        }

        return responses;
    }

    private static ActionResponse buildAccounts(ActionRequest req) {
        ActionResponse resp = new ActionResponse();
        Map<String, String> l = getLabels();
        Id userId = UserInfo.getUserId();

        List<Account> accounts = queryOwnedAccounts(userId, req.nameFilter);

        // Narrow to the rep's active territory when one resolves (empty => no narrowing).
        Set<Id> territoryAccountIds = getTerritoryAccountIds(userId);
        List<Account> filtered = new List<Account>();
        if (territoryAccountIds.isEmpty()) {
            filtered = accounts;
        } else {
            for (Account a : accounts) {
                if (territoryAccountIds.contains(a.Id)) {
                    filtered.add(a);
                }
            }
        }

        resp.accountCount = filtered.size();
        resp.output = buildMarkdown(filtered, l);
        return resp;
    }

    private static List<Account> queryOwnedAccounts(Id userId, String nameFilter) {
        if (String.isNotBlank(nameFilter)) {
            String term = '%' + nameFilter.trim() + '%';
            return [
                SELECT Id, Name, PersonTitle, BillingCity, BillingState
                FROM Account
                WHERE OwnerId = :userId AND Name LIKE :term
                ORDER BY Name ASC
                LIMIT 100
            ];
        }
        return [
            SELECT Id, Name, PersonTitle, BillingCity, BillingState
            FROM Account
            WHERE OwnerId = :userId
            ORDER BY Name ASC
            LIMIT 100
        ];
    }

    private static String buildMarkdown(List<Account> accounts, Map<String, String> l) {
        String countWord = (accounts.size() != 1) ? l.get('accounts') : l.get('account');
        String md = '**' + l.get('heading') + '** (' + accounts.size() + ' ' + countWord + ')';

        if (accounts.isEmpty()) {
            md += '\n\n' + l.get('none');
            return md;
        }

        md += '\n';
        Integer i = 1;
        for (Account a : accounts) {
            String subtitle = buildSubtitle(a);
            // The account name links to the relative Lightning URL: the desktop
            // panel resolves it directly and the LSC mobile app intercepts the
            // same path — one link that works on both surfaces.
            md += '\n' + i + '. [' + escapeMd(a.Name) + '](' + recordUrl(a.Id) + ')';
            if (String.isNotBlank(subtitle)) {
                md += ' — ' + subtitle;
            }
            i++;
        }
        return md;
    }

    private static String buildSubtitle(Account a) {
        List<String> parts = new List<String>();
        if (String.isNotBlank(a.PersonTitle)) parts.add(a.PersonTitle);
        String location;
        if (String.isNotBlank(a.BillingCity) && String.isNotBlank(a.BillingState)) {
            location = a.BillingCity + ', ' + a.BillingState;
        } else if (String.isNotBlank(a.BillingCity)) {
            location = a.BillingCity;
        } else if (String.isNotBlank(a.BillingState)) {
            location = a.BillingState;
        }
        if (String.isNotBlank(location)) parts.add(location);
        return String.join(parts, ' · ');
    }

    // Relative Lightning URL for an Account record. Works on both surfaces:
    // the desktop Agentforce panel navigates to it directly, and the Life
    // Sciences Cloud mobile app intercepts the same /lightning/r/... path.
    // A bare "lsc://" URL is NOT used here because the desktop browser has no
    // handler for that scheme and silently falls back to the home page.
    private static String recordUrl(Id recordId) {
        return '/lightning/r/Account/' + recordId + '/view';
    }

    // Escape markdown link-syntax characters in account names so they don't
    // break the [text](url) anchor.
    private static String escapeMd(String value) {
        if (String.isBlank(value)) return '';
        return value.replace('[', '\\[').replace(']', '\\]');
    }

    private static Set<Id> getTerritoryAccountIds(Id userId) {
        Id activeTerritoryId = getActiveTerritoryId(userId);
        if (activeTerritoryId == null) {
            return new Set<Id>();
        }
        List<ObjectTerritory2Association> acctTerrs = [
            SELECT ObjectId FROM ObjectTerritory2Association
            WHERE Territory2Id = :activeTerritoryId AND SobjectType = 'Account'
        ];
        Set<Id> acctIds = new Set<Id>();
        for (ObjectTerritory2Association ota : acctTerrs) {
            acctIds.add(ota.ObjectId);
        }
        return acctIds;
    }

    private static Id getActiveTerritoryId(Id userId) {
        String pref = TerritoryPreferenceReader.getPreference(userId);
        if (String.isBlank(pref)) return null;
        Integer idx = pref.indexOf('"activeTerritoryId":"');
        if (idx < 0) return null;

        Integer start = idx + 21;
        Integer endIdx = pref.indexOf('"', start);
        if (endIdx < 0) return null;

        String terrIdStr = pref.substring(start, endIdx);
        if (String.isBlank(terrIdStr) || terrIdStr == 'null') return null;

        try {
            return Id.valueOf(terrIdStr);
        } catch (Exception e) {
            return null;
        }
    }

    public class ActionRequest {
        @InvocableVariable(label='Name Filter' description='Optional. Only return accounts whose name contains this text.')
        public String nameFilter;
    }

    public class ActionResponse {
        @InvocableVariable(label='output' description='Markdown list of accounts, each with desktop and mobile deep links')
        public String output;

        @InvocableVariable(label='accountCount' description='Number of accounts returned')
        public Integer accountCount;
    }
}
