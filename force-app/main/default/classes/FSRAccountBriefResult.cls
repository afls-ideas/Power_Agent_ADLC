/**
 * Output wrapper for the FSR Account Brief agent action.
 *
 * The `brief` output parameter is mapped to the custom Lightning type
 * `fsrAccountBrief` (c__fsrAccountBrief) in the agent action's output. Must be
 * a top-level `global` `@JsonAccess` class with a `global` `@InvocableVariable`.
 */
@JsonAccess(serializable='always' deserializable='always')
global class FSRAccountBriefResult {
    @InvocableVariable(label='Account Brief' description='The structured account summary card')
    global FSRAccountBrief brief;
}
