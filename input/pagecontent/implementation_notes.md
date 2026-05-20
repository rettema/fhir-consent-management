This section offers supplementary notes to support the understanding and implementation of this Implementation Guide and the use cases in its scope. It includes both normative conformance requirements and informative guidance to help implementers interpret the guide correctly, align with best practices, and make technical design decisions.

### Authorization to Subscribe

When a system receives a copy of a Consent resource — whether via push from an originating system or via pull through a search — the authorization that permitted that exchange implies the system is also authorized to subscribe for updates to that consent. This is a key principle of the Consent Network Relationship: a system that legitimately holds a copy of a Consent must be able to maintain that copy's accuracy, and subscribing for updates is the primary mechanism for doing so.

In practice, the access control framework governing subscription registration should align with the framework governing Consent access. A consent administration service receiving a `POST Subscription` request **SHOULD** verify that the subscribing system is authorized to access the consents it is requesting to be notified about. A system that is not authorized to read a Consent resource should not be authorized to subscribe for notifications when that Consent changes.

Patient authorization is an upstream component of this trust model. When a patient's consent is shared between organizations — for example, because the patient has authorized a data sharing arrangement — the consent management systems involved may enter into subscription relationships as a direct consequence of that patient authorization. The specific mechanisms by which organizational trust relationships and subscription authorization are established are outside the scope of this guide; implementers should consult their applicable authorization infrastructure, including SMART App Launch for OAuth-based access control patterns.

### Dependency on Current Consent State

A critical challenge in consent-driven access control is that authorization decisions depend on the *current* state of a patient's consent — and consent state can change at any time, most importantly through revocation. A system that caches a copy of a consent and uses it for access decisions without checking for updates risks making incorrect authorization decisions based on stale data.

This is why this guide mandates the use of FHIR Subscriptions rather than relying on periodic polling or on-demand fetching at the time of each authorization decision. The subscription model ensures that systems holding copies of consent records are proactively notified when the consent changes, so that their copies remain current and authorization decisions remain accurate. The latency between a consent revocation and its propagation to all subscriber systems represents a window of risk; subscriptions minimize this window compared to polling-based approaches.

Implementers should design their systems with this dependency in mind: a system that cannot maintain a subscription to the consent management source **SHOULD** fetch a fresh copy of the consent at the time of each authorization decision rather than rely on a cached copy.

### Enforcing Consent
Consent is a key policy component that must be enforced within the broader access control framework. Whether a transaction or data exchange is subject to patient consent depends on overarching policies, which define when consent is required and when data may flow without it. For example, jurisdictional regulations may stipulate that data exchanged for treatment purposes does not require patient consent, while the exchange of sensitive information does. When overarching policies indicate that a transaction depends on consent, the system must identify the patients whose consents are relevant, retrieve the applicable consents, and apply them within the transaction's context.

### Exchanging Consent
The consent resource contains policy fragments that capture the consenter's preferences regarding the use of their information. These policy fragments may change during the life cycle of the consent, particularly when a consent is revoked. To ensure that the consenters' wishes are respected, it is essential to ensure that at the time of enforcement the consent resource used as the basis of authorization decisions is current and up to date.

If the consent is freshly retrieved from the consent management source (which maintains direct relationship with the patient), the enforcing system can be confident that it is current and up to date. However, this is not always practical since in many scenarios a copy of the consent may be exchanged between systems. For example, a copy of the consent may be included as part of the patient's longitudinal record in single member or bulk exchange.

When a copy of consent travels to a different system, before making decisions based on the consent, the enforcing system needs to ensure it is up to date. The enforcing system can use one or more of the following mechanisms to ensure the freshness of the consent before enforcement:

- Establishing a FHIR subscription with the source of the exchange to receive updates if and when the consent changes, for example upon revocation. 
- Establishing a FHIR subscription with the original collector of the consent (e.g., [the `manager` extension](StructureDefinition-FASTConsent-definitions.html#key_Consent.extension:manager)){{site.data.StructureDefinition-FASTConsent.description.key_Consent.extension:manager}} to receive updates if and when the consent changes, for example upon revocation.
- Using consent URL to retrieve the latest version of the consent from the source of the exchange, either periodically, or at the time of the enforcement.
- Using consent metadata (e.g., [the `manager` extension](StructureDefinition-FASTConsent-definitions.html#key_Consent.extension:manager)) to fetch the latest version of the consent from the original collector of the consent.

A consent enforcer may choose to rely on one or more of these methods to engineer a solution for ensuring that its copy of the consent is up to date and reliable. Note that depending on the circumstances and the relationships between systems and how they may change over time, not all of these methods are always feasible. For example, if the enforcing system does not have a relationship with the manager of the consent it may not be able to establish a subscription or retrieve a fresh copy. 

#### Consent Network Relationship

As these cross-organization exchanges occur, a relationship chain or network of systems may be created. When any System creates and subsequently exchanges a Consent resource with another System, the originating system must convey its identity within the Consent resource itself. The means by which consents are shared can be a push (the originating system proactively sends the Consent to another system) or a pull (another system fetches the Consent from the originating system). The following figure depicts such an exchange, showing how consent records are shared between systems:

<div>{%include consent-network-activity.svg%}</div>


Each subsequent sharing of the same consent will retain its origin, establishing a relationship between the system retaining the Consent resource and the system that created it irrespective of the intermediaries through which the Consent was sent.

§NR1:When the Consent record is created on System A, System A's system identifier **SHALL** be recorded in the `manager` extension of the Consent instance.§ This originator identifier denotes to all recipients of the shared Consent what system originated it. §NR2:Systems that ingest a Consent from another system **SHALL** preserve the `manager` extension value unchanged.§ Thus, when the Consent resource is shared with another system or systems, a relationship between the originating system and the recipient system(s) is established.

Consent resources, when shared from system to system, operationally instantiate a relationship through the creation of a Subscription within the system from which it was received.

This is achieved through the use of standard FHIR Subscription operations

1.  **Example sequence**

> **System A** shares Consent123 with **System B**.
>
> **System B** decides to subscribe to updates to Consent123 in which **System A** performs
>
> **System B** creates a **Subscription** in **System A** targeted to the resource Consent123

##### Consent Network Relationship Tree

The inherent network created by the relationships across systems in which the same Consent resource is shared forms a tree of relationships based on the Consent. The means in which consents are shared can be a push or a pull between systems. Regardless of whether a system received the consent via push or pull, that system is responsible for subscribing to updates from the manager system to ensure its copy remains current.

The figure below represents a three-layered Consent Network illustrating this virtual Network Relationship Tree

<div>{%include consent-network-state.svg%}</div>
