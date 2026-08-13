/**
 * Created by Peter Yeung on 2026-08-11.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * Agentforce invocable action that returns the current rep's accounts as a
 * typed FSRAccountListData so the fsrAccountList LWC renders them inline (rather
 * than as text). Same "my accounts" scoping as FSRMyScheduleAction: accounts
 * the rep owns, narrowed by active territory when one resolves.
 *
 * Each row carries BOTH a desktop URL (/lightning/r/...) and a mobile
 * lsc://deeplink URL; the desktop and mobile Lightning Type renderers each use
 * the one that works on their surface.
 */
public with sharing class FSRMyAccountsRichAction {

    // Life Sciences Cloud mobile app deep-link scheme. Kept in one place.
    private static final String LSC_SCHEME = 'lsc://deeplink';

    @InvocableMethod(label='FSR My Accounts (Rich)' description='Returns the accounts owned by the current rep (narrowed by active territory) as a rich, tappable list rendered by a custom component with Life Sciences mobile deep links. Call this when the user asks to see, show, or list their accounts or HCPs.')
    public static List<ActionResponse> getMyAccounts(List<ActionRequest> requests) {
        List<ActionResponse> responses = new List<ActionResponse>();

        for (ActionRequest req : requests) {
            ActionResponse resp = new ActionResponse();
            try {
                resp.result = buildAccounts(req);
            } catch (Exception e) {
                FSRAccountListData errorList = new FSRAccountListData();
                errorList.heading = 'Error: ' + e.getMessage();
                errorList.accountCount = 0;
                errorList.accountsJson = '[]';
                resp.result = errorList;
            }
            responses.add(resp);
        }

        return responses;
    }

    private static FSRAccountListData buildAccounts(ActionRequest req) {
        FSRAccountListData result = new FSRAccountListData();
        Id userId = UserInfo.getUserId();

        List<Account> accounts = queryOwnedAccounts(userId, req == null ? null : req.nameFilter);

        Set<Id> territoryAccountIds = getTerritoryAccountIds(userId);
        List<FSRAccountRow> rows = new List<FSRAccountRow>();
        for (Account a : accounts) {
            if (!territoryAccountIds.isEmpty() && !territoryAccountIds.contains(a.Id)) {
                continue;
            }
            FSRAccountRow row = new FSRAccountRow();
            row.accountId = a.Id;
            row.name = a.Name;
            row.subtitle = buildSubtitle(a);
            row.recordUrl = '/lightning/r/Account/' + a.Id + '/view';
            row.mobileUrl = LSC_SCHEME + '/lightning/r/Account/' + a.Id + '/view';
            rows.add(row);
        }

        result.accountsJson = JSON.serialize(rows);
        result.accountCount = rows.size();
        result.heading = 'Your accounts';
        return result;
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
        @InvocableVariable(label='Accounts' description='The rep\'s accounts, rendered by the FSRAccountListData Lightning Type.')
        public FSRAccountListData result;
    }
}
