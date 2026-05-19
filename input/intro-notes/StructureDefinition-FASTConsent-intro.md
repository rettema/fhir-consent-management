
### Mandatory and Must Support Data Elements

The following data elements must always be present or must be supported if the data is present in the sending system [Must Support]({{site.data.fhir.path}}conformance-rules.html#mustSupport). They are presented below in a simple human-readable explanation. Profile specific guidance and examples are provided as well. The [Formal Views](#profile) below provides the formal summary, definitions, and terminology requirements.

**Must Have** elements have a minimum cardinality of 1 or greater in this profile — they are always required to be present in a conformant instance.  **Must Support** elements have a minimum cardinality of 0 but systems claiming conformance must be capable of populating them when the data is available, and receiving systems must be capable of processing them without error.

**Each Consent Must Have:**

1. a status (any value from the FHIR [consent-state-codes]({{site.data.fhir.path}}valueset-consent-state-codes.html) value set is permitted; `active` is used for consents that are in force and `inactive` is used for revoked consents; other status values such as `draft`, `entered-in-error`, and `rejected` may be used as appropriate)
1. a scope (fixed to the code 'patient-privacy')
1. a category
1. one or more identifiers (at least one identifier is required to support cross-system identification of the Consent)
1. a patient (where the reference SHALL contain an identifier for the patient)
1. a dateTime
1. one or more performers (where each reference SHALL contain an identifier for the organization, patient, related person, or practitioner)
1. a source[x] that is either a DocumentReference with an attachment or a QuestionnaireResponse
1. one or more policies, each with a URI identifying the base policy governing this consent
1. a provision, that must include the following:
    1. a type

**Each Consent Must Support:**

1. all Must Have elements
1. a provision purpose
1. a Consent grantee extension (backported from the R5 Consent resource; 0..* to accommodate implicit or program-based grantees where the explicit identity of the grantee is determined by the policy rather than named in the Consent itself)
1. a Consent manager extension (backported from the R5 Consent resource)
1. a Consent controller extension (backported from the R5 Consent resource)
1. a provision, that must support the following:
    1. an actor (where role is fixed to IRCP)
    1. a purpose
    1. a nested provision

**Each Consent MUST NOT provide:**

1. an organization - this is contained in the extensions
1. more than two levels of provision

### Why Consent.scope Is Fixed

`Consent.scope` is fixed to the code `patient-privacy` from the FHIR consent-scope code system. This constraint is intentional and aligned with the [IHE Privacy Consent on FHIR (PCF)]({{site.data.fhir.ver.iheconsent}}) Basic Consent profile, which applies the same fixed value.

The rationale is that this implementation guide is explicitly scoped to *privacy consents* — authorizations by a patient (or their representative) governing how health information may be collected, used, or disclosed. Other consent types defined in the FHIR base specification (such as research consents or advance directives) are out of scope for this guide. Fixing the scope code makes it unambiguous that a FAST Consent instance is a privacy consent, simplifies server-side filtering and subscription topic filtering, and ensures interoperability with systems implementing IHE-PCF.

A Consent resource that validates against this profile will also satisfy the IHE-PCF Basic Consent scope constraint, enabling implementers to simultaneously conform to both guides.

### Constraints and Exceptions

In the base FHIR R4 Consent resource, the terms "constraint" and "exception" are used interchangeably to describe rules that refine the overall consent decision. For example, a Consent may permit access to all health information (a "permit" provision) with a constraint that excludes mental health records (a nested provision of type "deny"). In R4 the `provision.type` code `deny` is sometimes labelled an "exception" in documentation. This guide uses the terms interchangeably and does not distinguish between them.

### Referencing External Participants

Since a FHIR reference can contain a RESTful id to a patient, organization, practitioner, or related person, and those RESTful ids may not be useful once a Consent instance has propogated to other consent servers, this guide requires that an external identifier for those participants SHALL be populated.  The RESTful id can also be sent but it is not necessary since the mandatory identifier conveys the identity of the participant.  The FHIR additionalIdentifier extension is also included in the Reference to allow for multiple identifiers for participants to be conveyed.
