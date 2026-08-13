/**
 * Created by Peter Yeung on 2026-08-11.
 * Copyright © 2026 Salesforce. All rights reserved.
 *
 * Container backing the FSRAccountListCLT custom Lightning Type. Holds the list
 * of accounts the fsrAccountList LWC renders in an Agentforce response.
 * Must be global with @AuraEnabled fields and JSON-accessible so the Lightning
 * Type schema (@apexClassType/c__FSRAccountListData) can bind to it.
 *
 * NOTE: the class name is intentionally DISTINCT from the Lightning Type name
 * (FSRAccountListCLT). A Lightning Type and its backing Apex class must not share
 * a name, or the platform cannot disambiguate the @apexClassType reference and
 * the renderer silently fails to bind.
 */
@JsonAccess(serializable='always' deserializable='always')
global with sharing class FSRAccountListData {
    @AuraEnabled global String heading;
    @AuraEnabled global Integer accountCount;
    // Rows are carried as a serialized JSON string of List<FSRAccountRow> so the
    // Lightning Type contract stays 100% flat primitives, matching the shape the
    // Agentforce CLT renderer is proven to render. A nested List<FSRAccountRow>
    // field caused the renderer to silently fall back to text. The LWC parses
    // this back into rows for display.
    @AuraEnabled global String accountsJson;
}
