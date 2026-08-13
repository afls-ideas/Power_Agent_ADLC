import { LightningElement, api } from 'lwc';

/**
 * Renders the FSRAccountBrief custom Lightning type as a structured summary
 * card in an Agentforce response: a headline, one or more sections (each a
 * heading with its own bullet list), and a highlighted next step.
 *
 * The typed action output arrives on the CLT-standard `value` property.
 */
export default class FsrAccountBriefCard extends LightningElement {
    @api value;

    get _brief() {
        if (!this.value) {
            return null;
        }
        if (typeof this.value === 'string') {
            try {
                return JSON.parse(this.value);
            } catch (e) {
                return null;
            }
        }
        return this.value;
    }

    get hasBrief() {
        const b = this._brief;
        return !!(b && (b.accountName || b.headline || (b.sections && b.sections.length)));
    }

    get accountName() {
        return this._brief?.accountName || 'Account';
    }

    get subtitle() {
        return this._brief?.subtitle;
    }

    get headline() {
        return this._brief?.headline;
    }

    get hasHeadline() {
        return !!this._brief?.headline;
    }

    // Give each section and bullet a stable key for iteration.
    get sections() {
        const secs = this._brief?.sections || [];
        return secs.map((s, i) => ({
            key: `sec-${i}`,
            heading: s.heading,
            bullets: (s.bullets || []).map((text, j) => ({
                key: `sec-${i}-b-${j}`,
                text
            }))
        }));
    }

    get hasSections() {
        return this.sections.length > 0;
    }

    get nextStep() {
        return this._brief?.nextStep;
    }

    get hasNextStep() {
        return !!this._brief?.nextStep;
    }
}
