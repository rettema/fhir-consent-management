This profile is based on the [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) profile for when an Authorization decision is made based on a Consent record. The differences are that the relevant participant references use US Core profiles where needed.

### Mandatory and Must Support Data Elements

The following data elements must always be present or must be supported if the data is present in the sending system [Must Support]({{site.data.fhir.path}}conformance-rules.html#mustSupport). They are presented below in a simple human-readable explanation. Profile specific guidance and examples are provided as well. The [Formal Views](#profile) below provides the formal summary, definitions, and terminology requirements.

**Each Audit Event Must Have:**

1. a type from the IHE BALP audit event type code system
1. a subtype of `AuthZ-Consent` (from the IHE BALP `AuthZsubType` code system) indicating this is a consent-based authorization event
1. an action fixed to `E` ("Execute")
1. an outcome code indicating whether the authorization succeeded or failed (see [Meaning of Outcome](#meaning-of-outcome) below)
1. a recorded instant (`.recorded`) capturing when the audit event was created
1. a source identifying the system that generated the audit event
1. agents representing the:
    1. client application
    1. user
    1. user organization
    1. authorizer
1. entities representing the:
    1. patient whose consent was consulted
    1. the Consent resource that was consulted

### Referencing External Participants

Since a FHIR reference can contain a RESTful id to a patient, organization, practitioner, or related person, and those RESTful ids may not be useful once an Audit Event instance has propogated to other consent servers, this guide requires that an external identifier for those participants SHALL be populated.  The RESTful id can also be sent but it is not necessary since the mandatory identifier conveys the identity of the participant.  The FHIR additionalIdentifier extension is also included in the Reference to allow for multiple identifiers for participants to be conveyed.
