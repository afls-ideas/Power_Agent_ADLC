/**
 * Created by Peter Yeung on 2026-08-11.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * Container backing the FSRAccountList custom Lightning Type. Holds the list
 * of accounts the fsrAccountList LWC renders in an Agentforce response.
 * Must be global with @AuraEnabled fields and JSON-accessible so the Lightning
 * Type schema (@apexClassType/FSRAccountList) can bind to it.
 */
@JsonAccess(serializable='always' deserializable='always')
global with sharing class FSRAccountList {
    @AuraEnabled global String heading;
    @AuraEnabled global Integer accountCount;
    @AuraEnabled global List<FSRAccountRow> accounts;
}
