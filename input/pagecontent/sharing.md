Within the Consent sphere, there are three types of information sharing questions that can be asked:

1. Who has my Consent record been shared with?
1. What health information has been shared with who?
1. Who has consulted my Consent record to make a decision on sharing my health information?

For #1 and #2, there are existing mechanisms to convey the answer to those questions.  This guide provides guidance to help answer question #3.

### Who has my Consent record been shared with?
This guide provides both a means for [searching for consents](technical.html#searching-for-consents) and to [subscribe for updates](technical.html#consent-subscriptions) to those consents.  The use of AuditEvents can be used to answer the question of who has received my Consent record.  §SH1?^consent-server:Systems that return a Consent resource in a search result or read interaction **SHOULD** record a standard FHIR AuditEvent following the [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) patterns for FHIR Search and Read events.§  By querying for AuditEvents that have an entity of a consent record, a system can find out when the consent was returned in a search result and to which system it was disclosed.

There is a complexity that this guide introduces in that there may be a network of systems that receive a consent.  See the [Implementation Notes](implementation_notes.html) for more information about how consents may be shared and stored across the network.

When a Consent resource is shared between systems, the following conformance requirements apply to preserve the provenance of the consent and enable downstream systems to track updates:

§NR3?^client,consent-server:When sharing a Consent resource with another system, the originating or forwarding system **SHALL NOT** modify the `manager` extension value.§ The `manager` extension identifies the system that originally created the Consent and must remain unchanged throughout the consent's lifecycle across all sharing relationships.

§NR4?^client,consent-server:A system that receives a shared Consent resource **SHOULD** establish a FHIR Subscription with the system identified in the `manager` extension to receive updates to that Consent (e.g., revocations).§ This ensures that shared copies of the consent remain current.

### What health information has been shared with who?
Similar to the question of where a patient's Consent record has been shared, this question is asking about health information more generally.  What specific health information (i.e. lab tests, procedures, medications) has been shared and with whom?

IHE has a number of guides related to this question so this guide does not offer specific means for answering the question.  A good guide to consult is the [IHE Basic Audit Log Pattern](https://profiles.ihe.net/ITI/BALP/).  Its focus is on enabling Privacy centric AuditEvent logs that hold well-formed indication of the Patient when they are the subject of the activity being recorded in the log.

### Who has consulted my Consent record to make a decision on sharing my health information?
Along with the other two questions is the question around who consulted a patient's Consent record.  There will be times when a Consent record was consulted and a decision made to **NOT** share information.  A patient may want to know that this happened.

To enable this question to be answered, §SH2?^consent-server:systems **SHALL** record a [FAST Consent Audit Event](StructureDefinition-FASTConsentAuditEvent.html) via a RESTful FHIR `POST` to the `AuditEvent` endpoint whenever a Consent record was consulted, no matter whether that led to health information sharing or not.§  See the [Technical Specification](technical.html#sharing-health-information-due-to-consent) for details.
