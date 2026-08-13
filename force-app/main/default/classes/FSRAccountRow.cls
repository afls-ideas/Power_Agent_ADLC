/**
 * Created by Peter Yeung on 2026-08-11.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * One account row rendered by the fsrAccountList LWC in an Agentforce
 * response. Backs the FSRAccountList custom Lightning Type, so it must be
 * global, @AuraEnabled on every exposed field, and JSON-accessible.
 *
 * Two URLs are carried per row so the desktop and mobile renderers can each
 * pick the right one:
 *   - recordUrl : /lightning/r/Account/{id}/view      (desktop panel)
 *   - mobileUrl : lsc://deeplink/lightning/r/Account/{id}/view  (LSC mobile app)
 */
@JsonAccess(serializable='always' deserializable='always')
global with sharing class FSRAccountRow {
    @AuraEnabled global String accountId;
    @AuraEnabled global String name;
    @AuraEnabled global String subtitle;
    @AuraEnabled global String recordUrl;
    @AuraEnabled global String mobileUrl;
}
