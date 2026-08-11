/**
 * Created by Peter Yeung on 2026-07-31.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * Agentforce invocable action for the "Field Sales HCP Agent US" agent.
 * Returns the most-recently-modified Visit for an account. Resolves the
 * account from an explicit accountId (page context, when the agent is
 * launched from an Account record page) or, failing that, from an account
 * name mentioned in the user's message — mirroring FSRAskAboutAccountAction.
 */
public with sharing class FSRLatestVisitAction {

    @InvocableMethod(label='FSR Latest Visit For Account' description='Returns the most recently modified Visit for an account. Pass accountId when known (from the record page), otherwise pass the account or HCP name mentioned by the user.')
    public static List<ActionResponse> getLatestVisit(List<ActionRequest> requests) {
        List<ActionResponse> responses = new List<ActionResponse>();

        for (ActionRequest req : requests) {
            ActionResponse resp = new ActionResponse();
            try {
                resp = buildResponse(req);
            } catch (Exception e) {
                resp.output = 'Error: ' + e.getMessage();
            }
            responses.add(resp);
        }

        return responses;
    }

    private static ActionResponse buildResponse(ActionRequest req) {
        ActionResponse resp = new ActionResponse();

        Id acctId = resolveAccountId(req.accountId, req.accountName);
        if (acctId == null && String.isNotBlank(req.question)) {
            acctId = searchAccountFromQuestion(req.question);
        }
        if (acctId == null) {
            resp.output = 'Could not determine which account to look up. Please provide the account or HCP name.';
            return resp;
        }

        List<Account> accts = [
            SELECT Id, Name FROM Account WHERE Id = :acctId LIMIT 1
        ];
        if (accts.isEmpty()) {
            resp.output = 'Account not found or you do not have access.';
            return resp;
        }
        Account acct = accts[0];

        List<Visit> visits = [
            SELECT Id, Name, Status, PlannedVisitStartTime, ActualVisitStartTime,
                   LastModifiedDate, Owner.Name
            FROM Visit
            WHERE AccountId = :acctId
            ORDER BY LastModifiedDate DESC
            LIMIT 1
        ];

        if (visits.isEmpty()) {
            resp.output = '📅 ' + acct.Name + '\n\nNo visits found for this account.';
            resp.accountName = acct.Name;
            return resp;
        }

        Visit v = visits[0];

        String modifiedStr = v.LastModifiedDate != null
            ? v.LastModifiedDate.format('MMM d, yyyy h:mm a') : 'Unknown';
        String startStr = v.ActualVisitStartTime != null
            ? v.ActualVisitStartTime.format('MMM d, yyyy h:mm a')
            : (v.PlannedVisitStartTime != null
                ? v.PlannedVisitStartTime.format('MMM d, yyyy h:mm a') + ' (planned)'
                : 'Not started');

        List<String> lines = new List<String>();
        lines.add('📅 Latest visit for ' + acct.Name);
        lines.add('');
        lines.add('Visit: ' + (v.Name != null ? v.Name : v.Id));
        lines.add('Status: ' + (v.Status != null ? v.Status : 'Unknown'));
        lines.add('Start: ' + startStr);
        lines.add('Owner: ' + (v.Owner != null ? v.Owner.Name : 'Unknown'));
        lines.add('Last modified: ' + modifiedStr);

        resp.output = String.join(lines, '\n');
        resp.accountName = acct.Name;
        resp.visitId = v.Id;
        return resp;
    }

    private static Id resolveAccountId(String accountId, String accountName) {
        if (String.isNotBlank(accountId)) {
            try {
                Id parsed = Id.valueOf(accountId);
                if (parsed.getSObjectType() == Account.SObjectType) {
                    return parsed;
                }
                // A Visit Id (or other) can arrive from page context — traverse to its Account.
                if (parsed.getSObjectType() == Visit.SObjectType) {
                    List<Visit> vs = [SELECT AccountId FROM Visit WHERE Id = :parsed LIMIT 1];
                    if (!vs.isEmpty() && vs[0].AccountId != null) {
                        return vs[0].AccountId;
                    }
                }
            } catch (Exception e) { /* fall through to name resolution */ }
        }

        if (String.isNotBlank(accountName)) {
            String name = accountName.trim();

            List<List<SObject>> soslResults = [
                FIND :String.escapeSingleQuotes(name) IN NAME FIELDS
                RETURNING Account(Id)
                LIMIT 1
            ];
            if (!soslResults.isEmpty() && !soslResults[0].isEmpty()) {
                return soslResults[0][0].Id;
            }

            String term = '%' + String.escapeSingleQuotes(name) + '%';
            List<Account> matches = [SELECT Id FROM Account WHERE Name LIKE :term LIMIT 1];
            if (!matches.isEmpty()) return matches[0].Id;

            List<String> tokens = name.split('\\s+');
            if (tokens.size() > 1) {
                String lastToken = tokens[tokens.size() - 1];
                if (lastToken.length() >= 3) {
                    String surnameTerm = '%' + String.escapeSingleQuotes(lastToken) + '%';
                    List<Account> surnameMatches = [
                        SELECT Id FROM Account WHERE Name LIKE :surnameTerm LIMIT 5
                    ];
                    if (surnameMatches.size() == 1) return surnameMatches[0].Id;
                }
            }
        }

        return null;
    }

    private static Id searchAccountFromQuestion(String question) {
        String cleaned = question.replaceAll('(?i)(show|me|latest|last|recent|visit|visits|for|this|hcp|account|tell|about|what|are|was|the|from|dr\\.?|doctor|give|get|please|can|you|provide)\\s*', ' ').trim();
        cleaned = cleaned.replaceAll('\\s+', ' ').trim();
        if (String.isBlank(cleaned) || cleaned.length() < 3) return null;

        List<List<SObject>> searchResults = [
            FIND :String.escapeSingleQuotes(cleaned) IN NAME FIELDS
            RETURNING Account(Id)
            LIMIT 1
        ];
        if (!searchResults.isEmpty() && !searchResults[0].isEmpty()) {
            return searchResults[0][0].Id;
        }

        String term = '%' + String.escapeSingleQuotes(cleaned) + '%';
        List<Account> matches = [SELECT Id FROM Account WHERE Name LIKE :term LIMIT 1];
        if (!matches.isEmpty()) return matches[0].Id;

        return null;
    }

    public class ActionRequest {
        @InvocableVariable(label='Question' description='The user message. Used to extract an account or HCP name if no Id is provided.')
        public String question;

        @InvocableVariable(label='Account Id' description='Optional. The Account Id (or Visit Id) from the current page context. Leave blank to auto-detect from the question.')
        public String accountId;

        @InvocableVariable(label='Account Name' description='Optional. The account or HCP name mentioned by the user.')
        public String accountName;
    }

    public class ActionResponse {
        @InvocableVariable(label='output' description='Formatted summary of the latest visit for the account')
        public String output;

        @InvocableVariable(label='Account Name' description='The resolved account name')
        public String accountName;

        @InvocableVariable(label='Visit Id' description='The Id of the most recently modified visit')
        public String visitId;
    }
}