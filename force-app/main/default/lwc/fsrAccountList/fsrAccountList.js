import { LightningElement, api } from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';

/**
 * Renders the FSRAccountListType Lightning Type (returned by FSRMyAccountsRichAction)
 * as a tappable list of accounts in an Agentforce response.
 *
 * The typed action output arrives on a single @api `value` property. Each row
 * carries a desktop URL (/lightning/r/...) and a mobile lsc:// deep link; the
 * component picks the right one for the current surface.
 */
export default class FsrAccountList extends LightningElement {
    @api value;

    get _wrapper() {
        if (!this.value) return null;
        if (typeof this.value === 'string') {
            try {
                return JSON.parse(this.value);
            } catch (e) {
                return null;
            }
        }
        return this.value;
    }

    get isMobile() {
        return FORM_FACTOR === 'Small';
    }

    // --- temporary diagnostics ---
    get debugType() {
        return typeof this.value + (this.value === null ? ' (null)' : '');
    }

    get debugCount() {
        return this.accountsRaw.length;
    }
    // --- end diagnostics ---

    get accountsRaw() {
        const w = this._wrapper;
        if (!w) return [];
        // Rows arrive as a serialized JSON string (accountsJson) to keep the
        // Lightning Type contract flat. Fall back to a nested `accounts` array
        // for older payload shapes.
        if (typeof w.accountsJson === 'string') {
            try {
                const parsed = JSON.parse(w.accountsJson);
                return Array.isArray(parsed) ? parsed : [];
            } catch (e) {
                return [];
            }
        }
        return Array.isArray(w.accounts) ? w.accounts : [];
    }

    get rows() {
        return this.accountsRaw.map((a) => ({
            ...a,
            href: this.isMobile ? a.mobileUrl : a.recordUrl
        }));
    }

    get hasAccounts() {
        return this.accountsRaw.length > 0;
    }

    get countLabel() {
        const w = this._wrapper;
        const heading = (w && w.heading) ? w.heading : 'Your accounts';
        const n = (w && w.accountCount != null) ? w.accountCount : this.accountsRaw.length;
        return `${heading} (${n})`;
    }

    // On mobile, handing the lsc:// scheme to the app programmatically is more
    // reliable than an anchor href; on desktop the anchor navigates normally.
    handleOpen(event) {
        if (!this.isMobile) {
            return;
        }
        event.preventDefault();
        const url = event.currentTarget.dataset.mobileUrl;
        if (url) {
            window.open(url, '_self');
        }
    }
}
