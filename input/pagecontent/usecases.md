<div>{%include usecases.svg%}</div>

### Systems and Actors

This guide defines two categories of participants in consent workflows: **human roles** (the people involved) and **technical actors** (the systems they use to carry out interactions). Keeping these distinct is important: a human role describes *who* is involved in a use case; a technical actor describes *which system* executes the FHIR interactions.

#### Human Roles

**Consenter** — The individual who makes the consent decision. This is typically the patient, but may also be a caregiver, guardian, or legally authorized representative acting on the patient's behalf. The Consenter is the subject of all use cases on this page. The use cases and operations in this guide support the Consenter as part of the consent process regardless of whether that person is the patient or their authorized representative. Explicit out-of-band notification of caregivers or guardians (e.g., notifying a guardian when the patient files a consent) is outside the scope of this guide.

**Administrator** — A person or organizational role that initiates consent-related workflows on behalf of a healthcare organization. For example, an administrator may request that a patient complete a consent form, or may act as an intermediary between the patient and the Consent Server System. The Administrator is distinct from the Consenter: the Administrator initiates or facilitates the process; the Consenter makes the decision.

#### Technical Actors

**Consent Client System** — The system used by the Consenter (and in some cases the Administrator) to interact with the consent administration service. Consent Client systems gather consent decisions and invoke the `$fileConsent` and `$revokeConsent` operations. In the sequence diagrams on this page, this corresponds to the application or portal the Consenter uses to review and sign consent forms. See the [Consent Client Capabilities](CapabilityStatement-ConsentClientCapabilities.html) for conformance requirements.

**Consent Server System** — The consent administration service that stores consent records, services search and subscription requests, and maintains audit events. In the sequence diagrams on this page, this is labelled "ConsentSystem." See the [Consent Server Capabilities](CapabilityStatement-ConsentAdministrativeServerCapabilities.html) for conformance requirements.

The typical interaction model is: **Consenter** (or Administrator) → **Consent Client System** → **Consent Server System**. The human roles are not directly represented in FHIR interactions; they operate through the technical actor systems.

---

### Request Consent

<div>{%include request-consent-sequence.svg%}</div>

**Actor:** Administrator, Consenter, Consent Server System

**Pre-condition:** 
- If the initiator is an administrator, they are already aware of the identity of the consenter, either by manual selection or implied by the overarching workflow (e.g., a referral).

**Narrative:**
- The administrator specified a consent form. The consent form is either explicitly selected by the administrator or is implied by the workflow.

- The administrator specifies a consenter. The consenter is either explicitly selected by the administrator or is implied by the workflow.

- The administrator initiates a request to collect consent from the consenter based on the form and identity of the consenter.

- The Consent Server System notifies the consenter and tracks the assignment of the form to the consenter.

**Post-condition:**
- The consenter is notified about the request.
- If there is a delegation in place, the substitute decision maker should be notified.

### Review Consent

<div>{%include review-consent-sequence.svg%}</div>

**Actor:** Consenter 

**Pre-condition:**
- A consent request may have been initiated by an administrator or the consenter themselves.

- A consent form is available  and assigned to the consenter. 

- Any information known to the session (such as the consenter's name, date of birth, or timestamp) should be pre-filled by the application to minimize the effort for the consenter. 

- Some of the responses in the form may be pre-populated at the time of assignment. These options may be read-only or simply defaults the consenter can change. 

- The consenter may have reviewed the form in a previous session and may have entered some responses; any such responses are saved and visible to the consenter upon revisiting the form.
  
**Narrative:**

- The consenter views the consent form. 

- The form may be arranged as multiple pages in which case the consenter can navigate back and forth between pages.

- The consenter can review the options available in each page and enter a response, thereby communicating a decision. The response shall be retained as the consenter navigates between pages. 

- The consenter shall be able to see what mandatory fields remain in the form and await response as the consenter navigates the form.

- The consenter shall be able to see whether the form is complete and ready for signing and submission as the consenter navigates the form.

**Post-condition:**
- A completed consent form is available for submission.

**Alternative Flow:**
- The consenter may save the incomplete form and log out of the application. The state of the form including all the information entered shall be retained.



### Sign and File Consent

<div>{%include file-consent-sequence.svg%}</div>

**Actor:** Consenter

**Pre-condition:**
A consent form has been reviewed and completed (see use case [Review Consent](usecases.html#review-consent)).

**Narrative:**
- The consenter expresses their wish to sign and enact the consent. The user experience provide a mechanism to ensure the patient is making this decision in an informed way (and not by accident).

- A proper user experience enables the consenter to sign the consent form.

- The consenter can see the change in the status of the consent to become active.

- The consenter can review the finalized consent and download a human-readable or print-friendly copy.

**Post-condition:**
- A signed consent form is retained for future review.  
- A computable consent resource is extracted based on the finalized consent form and is stored in the consent store FHIR server.


### Delegate Consent

<div>{%include delegate-consent-sequence.svg%}</div>

**Actor:** Consenter

**Pre-condition:**
- The consenter is an authenticated user of the Consent Client System.
- The consenter has authority to delegate: they are either the patient or a currently authorized representative with delegation rights.
- The consent management system supports the delegation workflow.

**Narrative:**
By navigating and signing a delegation form, the consenter assigns a delegate to sign and file a consent on their behalf. 

**Post-condition:**
- Notices to collect consent from the original consenter would be routed to the delegate.
- The consenter receives confirmation that the delegation has been recorded and is active. 

- The delegate may also be able to revoke the consent. This may depend on the conditions of delegation as decided by the consenter, or by overarching policies. 

- The audit must record accurately whether a consent was filed by the consenter or the delegate.

- The delegate may be assigned through other mechanisms such as a court order. These alternatives are outside the scope of this IG although the effect is the same.

**Notes:**
- Conditions and limitations on the scope of the power of a delegate may apply based on overarching policies.

### Revoke Consent

<div>{%include revoke-consent-sequence.svg%}</div>

**Actor:** Consenter

**Pre-condition:**
A consent has been previously signed and filed and is still active (not expired).

**Narrative:**
- The consenter navigates the user interface to find the consent they intend to revoke. This may be in the form of a search (for example by form or by original requester) or by plain navigation of all active consents.

- The consenter interacts with the UI to revoke the consent. 

- Depending on the policy context, the consenter may have to sign a form to confirm their intent to revoke the consent.

**Post-condition:**
- The state of the consent is marked as inactive.
- The consenter receives confirmation that the consent has been successfully revoked.
- The revocation event and pertinent metadata is recorded in the provenance of the consent.
- The record of the consent revocation (if a signed form was required in the legal context) is retained and associated with the consent and the provenance event.

### Disclosure Audit
(implementing this use case is optional)

<div>{%include disclosure-audit-sequence.svg%}</div>

**Actor:** Consenter

**Pre-condition:** 
A consent has been signed and filed.

**Narrative:**
- The consenter can navigate and find a previously filed consent. This may be active or inactive.

- The consenter is able to navigate a record of activities authorized or blocked based on the consent in question. 

### Propagate Consent Events

<div>{%include propagate-consent-events-sequence.svg%}</div>

**Actor:** Consent Server System

**Pre-condition:**
- A subscription has been registered with the consent administration service by an authorized entity specifying the address and the protocol for sending notifications about the events pertaining to consents of interest.

**Narrative:**
A notice of consent event is sent to a partner system. Supported events are:
- The consenter starting to review the consent form (optional).
- The consenter signs and files the consent.
- The consent is revoked.

**Post-condition:**
- The requesting entity will receive event notifications.

**Note:** Explicit notification of the patient (as distinct from the Consenter) when consent records are propagated across systems — for example, notifying the patient whenever a copy of their consent is shared with a new system — is outside the scope of this guide. The Consenter, who may be the patient themselves, is already a participant in the consent process through the filing and revocation use cases. 

### Consent Provenance

<div>{%include consent-provenance-sequence.svg%}</div>

**Actor:** Consenter

**Pre-condition:**
A consent has been signed and filed.

**Narrative:**
The consenter can navigate the timeline of the lifecycle events about the consent, including:

- When and by whom the consent was requested,
- When and by whom the consent was filed/signed.
- If/when and by whom the consent was revoked.
- If/when and to whom the consent has been shared.

**Post-condition:**
- The lifecycle events of the consent are returned to the Consenter for review.
