This section of the implementation guide defines the specific conformance requirements for systems wishing to conform to this FAST Consent implementation guide.

### Context

#### Pre-reading
Before reading this formal specification, implementers should first familiarize themselves with two other key portions of the specification:

* The [Use Cases & Overview](usecases.html) page provides context for what this formal specification is trying to accomplish and will give a sense of both the business context and general process flow enabled by the formal specification below.

* The [Underlying Specifications](background.html) page describes the specifications this guide builds on and indicates what portions of them should be read and understood to have the necessary foundation to understand the constraints and usage guidance described here.


#### Systems

This implementation guide sets expectations for two types of systems:

* **Client** systems are systems that are responsible for gathering and filing consents
* **Server** systems are consent administration services that store consents and handle requests for consents.


#### Profiles
This specification makes significant use of [FHIR profiles]({{site.data.fhir.path}}profiling.html) and terminology artifacts to describe the content to be shared as part of prior authorization requests and responses.

The full set of profiles defined in this implementation guide can be found by following the links on the [Artifacts](artifact_overview.html) page.

#### Integration with other Implementation Guides

This implementation guide also builds on the [US Core]({{site.data.fhir.uscore}}) Implementation Guide and implementers need to familiarize themselves with the profiles in that IG.

This implementation guide uses Subscriptions that are based on the [Subscriptions R5 Backport framework]({{site.data.fhir.subscriptions}}).

#### Testing Requirements
There is a [FAST Consent Testing Guide](https://wildfhir4.wildfhir.org/ig/fhir-consent-management-tg/index.html) which is a companion guide to this guide and provides testing artifacts used in the verification and validation of implementations declaring conformance to this guide. Note: at the time of publication of this guide, the Testing Guide is a working draft that has not yet been published under HL7 governance. The link above points to the current working version; the link will be updated once the Testing Guide is hosted on an HL7-governed site.

### Detailed Requirements

#### Identifying Patients, Practitioners, Organizations, and Related Persons
One of the most important parts of registering consents across systems is the proper identification of patients, practitioners, organizations, and related persons.  For a self-contained consent adminstration system, the URIs of those entities could be used, but when consents are spread across multiple systems, those URIs may be potentially no longer useful.  §ID1:For that reason, this guide mandates that Client systems **SHALL** query the consent administration service for the identifiers of the involved patients, practitioners, organizations, and related persons§.  How exactly these systems will identify that the proper entities are discovered is out of scope of this guide.  For patient matching and identification, the [FAST Interoperable Digital Identity and Patient Matching guide](https://hl7.org/fhir/us/identity-matching/) can be referenced.  Similar means for matching and identifying practitioners, organizations, and related persons should be used.

#### General Operation Details
Every operation in this guide has an optional OperationOutcome defined as the return of the operation.  This OperationOutcome instance will detail whether the operation was a success or not and, if not, what business rules did not allow the operation to be successful.  The HTTP status code returned by the operation will indicate whether an operation was successful or not.  §OP10:Systems **MAY** return an OperationOutcome with a success when they wish to provide additional structured information alongside a successful operation response.§  §OP11:Systems **SHOULD** return an OperationOutcome with the details if an HTTP status code of 4xx or 5xx is returned.§

#### Consent Management

§OP1:To satisfy the business use cases for consent management, two operations are defined that a consent administration service **SHALL** support: File Consent and Revoke Consent.§

§OP2:Along with these operations, Consent administration service systems **SHALL** support searching for consents§.  §OP3:Finally, a consent administration service **SHALL** support subscriptions to allow other systems to be informed when consents for a patient have changed.§

##### File Consent Operation
The [File Consent Operation](OperationDefinition-file-consent.html) is used to file a consent with a consent administration service.  The details of the consent are contained in the [Consent](StructureDefinition-FASTConsent.html) instance and any documents that were used to generate the Consent are also included in the operation parameters.  §OP4:When filing a consent, the Consent status element **SHALL** be set to 'active'.§

##### Revoke Consent Operation
The [Revoke Consent Operation](OperationDefinition-revoke-consent.html) is used to revoke an existing consent with a consent administration service.  The parameters are a reference to a pre-existing Consent instance along with a reference to the Patient who is the subject of the consent and any supporting documentation for the revocation.  §OP5:After a consent has been revoked, the Consent status element for the revoked consent **SHALL** be set to 'inactive'.§  §OP6:A revoked consent **SHALL NOT** be deleted from the consent management system.§

##### Searching for Consents

§OP7:To support searching for consents, the following search parameters **SHALL** be supported - patient, controller, manager, date, status, and scope.§

* [patient]({{site.data.fhir.path}}consent.html#search)
* [controller](SearchParameter-fast-consent-controller.html)
* [manager](SearchParameter-fast-consent-manager.html)
* [date]({{site.data.fhir.path}}consent.html#search)
* [status]({{site.data.fhir.path}}consent.html#search)
* [scope]({{site.data.fhir.path}}consent.html#search)

The `controller` and `manager` search parameters are required (not merely recommended) because they are fundamental to the federated consent management model that is the core purpose of this IG. Searching by `manager` allows subscriber systems to locate all consents for which they must maintain subscriptions to receive updates from the originating system. Searching by `controller` allows systems to find all consents within their data governance scope. Making these parameters optional would undermine the interoperability goals of federated consent sharing.  For single-organization deployments, the practical utility of these parameters may be limited.

To search for consents by organization identifier, implementers **SHOULD** use the `controller:identifier` chained search parameter (e.g., `GET [base]/Consent?controller:identifier=|1234567890`) rather than a custom organization ID search parameter.  To search for consents by patient identifier, implementers **SHOULD** use the `patient:identifier` chained search parameter (e.g., `GET [base]/Consent?patient:identifier=http://example.org/mrn|M1230041`).


##### Consent Subscriptions
To allow for systems to be informed when a patient's consent has changed but not require polling of systems, this guide mandates that Subscriptions be used.  A [SubscriptionTopic](SubscriptionTopic-FASTConsentSubscriptionTopic.html) has been defined for use by systems to register subscriptions.

To register a subscription, client systems will POST to a consent administration service's Subscription endpoint.  In this request is a link to the FAST Subscription Topic and any criteria to be used to filter subscription responses.  The defined filter criteria for the FAST Subscription Topic are:

* [patient]({{site.data.fhir.path}}consent.html#search) (use `patient:identifier` chained search to filter by patient identifier)
* [controller](SearchParameter-fast-consent-controller.html) (use `controller:identifier` chained search to filter by organization identifier)
* [actor]({{site.data.fhir.path}}consent.html#search)
* [status]({{site.data.fhir.path}}consent.html#search)
* [category]({{site.data.fhir.path}}consent.html#search)

For more details about supporting subscriptions, including how to delete a subscription that is no longer desired, consult the [Subscriptions R5 Backport framework]({{site.data.fhir.subscriptions}}).

#### Updating Consents

This guide does not define an Update Consent operation, and systems conforming to this guide **SHOULD NOT** update an existing Consent resource in place using RESTful `PUT` or `PATCH`. The reasons are:

1. **Traceability and auditability** — Consent changes are significant events in a patient's care record. Updating a Consent in place loses the history of what was previously consented to. Each new patient consent decision should result in a new Consent resource (or a Revoke followed by a new File).
2. **Propagation integrity** — In a federated consent network, other systems may hold copies of a shared Consent. In-place updates would require those systems to detect the change via subscription or polling. Revoking and re-filing makes the change unambiguous and ensures that subscription notifications accurately reflect the transition from one consent state to another.
3. **Status lifecycle** — The primary lifecycle events for a consent are filing (`status = active`) and revocation (`status = inactive`). These are supported by the [File Consent](OperationDefinition-file-consent.html) and [Revoke Consent](OperationDefinition-revoke-consent.html) operations respectively. Administrative corrections (e.g., fixing a data entry error) may be performed via `PUT` but should be clearly distinguished from patient-driven consent changes.

#### Sharing Health Information due to Consent
§OP8:Along with the business use cases of consent management, consent administration services **SHALL** be able to record and retrieve disclosures of when a consent was accessed to determine whether patient information could be accessed.§  To support this requirement, systems record consent disclosures as standard FHIR AuditEvent resources using RESTful FHIR interactions, and are required to support searches for those disclosures.

Disclosures are recorded as FHIR AuditEvent instances that conform to the [FAST Consent Audit Event](StructureDefinition-FASTConsentAuditEvent.html) profile.  These AuditEvents reflect the Consent instance that was consulted as well as the type of health information that was shared.  §OP12:Systems **SHALL** create a FAST Consent Audit Event via a RESTful FHIR `POST AuditEvent` whenever a Consent instance is accessed to determine whether patient information can be accessed.§

Implementers are encouraged to consult the [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) implementation guide, in particular the [ITI-81 Retrieve ATNA Audit Event](https://profiles.ihe.net/ITI/TF/Volume2/ITI-81.html) transaction, for additional guidance on structuring AuditEvent records and supporting privacy-centric audit log queries.

##### Searching for Disclosures
§OP9:To allow systems to document disclosures to requesting authorities (including a patient), systems **SHALL** support the searching for FAST Audit Events§ using the following search parameters:

* [entity]({{site.data.fhir.path}}auditevent.html#search) — use `entity=Consent/[id]` to search for audit events related to a specific Consent instance
* [patient]({{site.data.fhir.path}}auditevent.html#search)

