This profile is based on the [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) profile for when an Authorization decision is made based on a Consent record. The differences are that the relevant participant references use US Core profiles where needed.

### When to Create This Event

§AE1?^admin-service:A FAST Consent Audit Event **SHALL** be created by the system that evaluates a Consent resource to determine whether a request to access patient information should be permitted or denied.§ This system is acting as a Policy Decision Point (PDP) in the access control framework.

§AE2?^admin-service:The event **SHALL** be created regardless of whether the authorization decision was a permit or a deny.§ Both outcomes represent a completed consent evaluation and must be recorded to give patients a complete picture of how their consent has been used. The event is persisted by POSTing it to the `AuditEvent` endpoint of the consent administration service or another ATNA-compliant audit repository.

This profile applies exclusively to **authorization decision events** — cases where a Consent resource was consulted to make an access control decision. It does not apply to disclosure events (cases where health information was actually shared following a permit decision). For disclosure events, use [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) patterns directly, without this profile.

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

### Meaning of Outcome

The `AuditEvent.outcome` element records whether the *audited system operation* completed successfully, not whether data was ultimately shared with the requesting party. Specifically:

- **`0` (Success)** — the authorization evaluation completed without error. This does NOT mean that data was shared; a successful outcome may reflect either a permit decision (data sharing allowed) or a deny decision (data sharing refused). Both outcomes are valid results of a successful consent evaluation.
- **`4` (Minor failure)** or **`8` (Serious failure)** — the authorization evaluation itself encountered an error and could not be completed (for example, the Consent resource was unreachable or malformed).

To determine whether a consent permit or deny decision was made, examine the `AuditEvent.purposeOfEvent` and the content of the `entity` elements rather than relying on `outcome` alone.

### Referencing External Participants

Since a FHIR reference can contain a RESTful id to a patient, organization, practitioner, or related person, and those RESTful ids may not be useful once an Audit Event instance has propogated to other consent servers, this guide requires that §AE3?^admin-service:an external identifier for those participants **SHALL** be populated.§  The RESTful id can also be sent but it is not necessary since the mandatory identifier conveys the identity of the participant.  The FHIR additionalIdentifier extension is also included in the Reference to allow for multiple identifiers for participants to be conveyed.
