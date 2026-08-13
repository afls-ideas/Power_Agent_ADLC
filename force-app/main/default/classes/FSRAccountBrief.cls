/**
 * CLT data type backing the `fsrAccountBrief` custom Lightning type.
 *
 * Renders the account summary as a structured card (headline + emoji section
 * headers, each with its own bullet list) instead of inconsistent free-text
 * markdown. This is the first of a family of rich Agentforce output types
 * (tables/related lists, timelines, charts) for the Field Sales HCP agents.
 *
 * CLT requirements (proven by the Account_Insights reference): a top-level
 * `global` class, `@AuraEnabled` on every exposed field, and `@JsonAccess`.
 * Nested `global` `@JsonAccess` types (FSRAccountBriefSection) render fine as
 * long as they follow the same rules — the earlier render failure was caused by
 * inner `public` classes without `@JsonAccess`, not by nesting.
 */
@JsonAccess(serializable='always' deserializable='always')
global class FSRAccountBrief {
    @AuraEnabled global String accountName;
    @AuraEnabled global String subtitle;
    @AuraEnabled global String headline;
    @AuraEnabled global List<FSRAccountBriefSection> sections;
    @AuraEnabled global String nextStep;
}
