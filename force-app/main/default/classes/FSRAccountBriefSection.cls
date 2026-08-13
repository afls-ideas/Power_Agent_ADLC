/**
 * One section of an FSRAccountBrief: an emoji/heading line and its bullets.
 *
 * Top-level `global` + `@JsonAccess` with `@AuraEnabled` fields so it nests
 * cleanly inside FSRAccountBrief for the CLT renderer.
 */
@JsonAccess(serializable='always' deserializable='always')
global class FSRAccountBriefSection {
    @AuraEnabled global String heading;
    @AuraEnabled global List<String> bullets;
}
