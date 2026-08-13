/**
 * Input wrapper for the FSR Account Brief agent action.
 *
 * Mirrors the inputs of the existing free-text FSRAskAboutAccountAction so the
 * same account-resolution logic can be reused.
 */
@JsonAccess(serializable='always' deserializable='always')
global class FSRAccountBriefRequest {
    @InvocableVariable(label='Question' description='The user question about this account or HCP')
    global String question;

    @InvocableVariable(label='Account Id' description='Optional. The Account record ID from page context. Leave blank to auto-detect.')
    global String accountId;

    @InvocableVariable(label='Account Name' description='Optional. The account or HCP name mentioned by the user.')
    global String accountName;
}
