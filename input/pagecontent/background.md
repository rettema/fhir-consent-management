
### Background
The need for this guide emerged from an initial FAST discovery project to evaluate and identify gaps in the existing consent-related specifications and guidelines, as outlined in the [Consent at Scale](https://confluence.hl7.org/download/attachments/204279212/FAST-consent-at-scale-2023-08-20-final-version.pdf) Report. This report defines the impetus and scope of the current implementation guide.

### Underlying Specifications
This guide is built on several underlying specifications. Implementers should be familiar with the key aspects of each before reading this guide.

#### FHIR R4
This implementation guide is based on the [HL7 FHIR R4]({{site.data.fhir.path}}index.html) standard.  Implementers need to understand the basics of FHIR, including terminology, notations, and design principles.  Readers who are unfamiliar with FHIR are encouraged to read (or at least skim) the following prior to reading the rest of this implementation guide.

* [FHIR Overview]({{site.data.fhir.path}}overview.html)
* [Developer's Introduction]({{site.data.fhir.path}}overview-dev.html) (or [Clinical Introduction]({{site.data.fhir.path}}overview-clinical.html))
* [FHIR Data Types]({{site.data.fhir.path}}datatypes.html)
* [Using Codes]({{site.data.fhir.path}}terminologies.html)
* [References between Resources]({{site.data.fhir.path}}references.html)
* [How to Read Resource & Profile Definitions]({{site.data.fhir.path}}formats.html) and additional [IG reading guidance](https://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html)
* [Base Resource]({{site.data.fhir.path}}resource.html)

#### US Core
This implementation guide builds on the [US Core]({{site.data.fhir.ver.uscore}}) Implementation Guide. Implementers need to be familiar with the US Core profiles for Patient, Practitioner, Organization, RelatedPerson, PractitionerRole, and QuestionnaireResponse, as these are referenced directly by the FAST Consent profile.

#### Subscriptions R5 Backport
This implementation guide uses subscriptions to notify systems of consent changes. Subscriptions are based on the [Subscriptions R5 Backport framework]({{site.data.fhir.ver.subscriptions}}). Implementers should understand how to register a subscription, how topic-based subscriptions work, and how to receive and process subscription notifications.

#### IHE Privacy Consent on FHIR (PCF)
This guide aligns with the [IHE Privacy Consent on FHIR (PCF)]({{site.data.fhir.ver.iheconsent}}) guide. The FAST Consent profiles are designed to be a US-Core-flavoured subset of IHE-PCF — a Consent instance that is valid against the FAST Consent profile will generally also satisfy IHE-PCF constraints. Implementers should consult IHE-PCF for additional context on consent actors, transactions, and enforcement patterns. IHE-PCF also includes Appendix P, which provides foundational background on the concepts underlying privacy consent management.

##### Actor Mapping

IHE-PCF defines four actors: **Consent Recorder**, **Consent Registry**, **Consent Authorization Server**, and **Consent Enforcement Point**. This guide defines two system roles — **Consent Client System** and **Consent Server System** — that correspond to a subset of these actors:

- The **Consent Client System** corresponds most closely to the IHE-PCF **Consent Recorder**: it is responsible for gathering consent from patients and filing it with a consent administration service.
- The **Consent Server System** (consent administration service) corresponds to the IHE-PCF **Consent Registry**: it stores consents and services queries for consent records.
- The **Consent Authorization Server** and **Consent Enforcement Point** actors from IHE-PCF are outside the scope of this guide. This guide standardizes the representation and exchange of consent data; the application of that data to make and enforce access decisions is handled by external authorization infrastructure.

##### Operations vs. IHE-PCF Transactions

IHE-PCF defines transactions using IHE's ITI transaction model. This guide uses custom FHIR operations and RESTful FHIR interactions rather than IHE-style transactions. The functional correspondence is:

- The `$fileConsent` operation (this guide) corresponds to IHE-PCF's **[ITI-108] Access Consent** (create).
- The `$revokeConsent` operation (this guide) corresponds to IHE-PCF's **[ITI-109] Revoke Consent**.
- Consent search (this guide) corresponds to IHE-PCF's **[ITI-108] Access Consent** (search/read).
- FHIR Subscriptions (this guide) extend beyond IHE-PCF by adding proactive change notification; IHE-PCF does not define a subscription or notification transaction.

Implementers conforming to this guide do not need to implement IHE-PCF transactions, but systems that already implement IHE-PCF transactions may find that their implementations are largely compatible with the operations defined here.

##### Authorization and SMART App Launch

IHE-PCF relies on IHE's own authorization model (IUA — Internet User Authorization). This guide recommends [SMART App Launch](https://hl7.org/fhir/smart-app-launch/) as the OAuth-based authorization mechanism for securing the operations and interactions defined here. Systems that have already implemented IHE IUA for IHE-PCF compliance may adapt their existing authorization infrastructure to satisfy the SMART-based access control expectations of this guide; the underlying OAuth 2.0 token model is compatible. See the [Privacy, Safety, and Security]({{site.data.fhir.path}}security.html#SecPrivConsiderations) section for additional guidance.

#### IHE Basic Audit Log Patterns (BALP)
This guide relies on [IHE Basic Audit Log Patterns (BALP)](https://profiles.ihe.net/ITI/BALP/) for representing audit events related to consent access and health information disclosure. Implementers should be familiar with the BALP Consent Authorized Decision Audit Message and the Privacy Disclosure Audit Message profiles.

#### CDA Privacy Consent Directives

Prior to the widespread adoption of FHIR, patient consent decisions were commonly represented using HL7 Clinical Document Architecture (CDA) documents, including the [HL7 CDA R2 Implementation Guide: Privacy Consent Directives](https://www.hl7.org/implement/standards/product_brief.cfm?product_id=280). These CDA-based consent directives capture the same fundamental patient decisions — authorizing or restricting the use and disclosure of health information — that this guide represents as FHIR Consent resources.

This guide does not define a migration path or transformation profile for converting CDA Privacy Consent Directives to FHIR Consent resources. Organizations operating in environments where consent is currently captured in CDA format will need to develop their own transformation processes to produce FHIR Consent instances conformant with the [FAST Consent profile](StructureDefinition-FASTConsent.html) defined here. The IHE-PCF guide includes guidance on representing consent in FHIR that may be useful as a reference for such transformations.

Note that the IHE-PCF guide itself references and aligns with both the CDA Privacy Consent Directive tradition and the FHIR Consent resource model. Because the FAST Consent profile is a US-Core-flavoured subset of IHE-PCF, implementers familiar with IHE-PCF's handling of CDA-to-FHIR consent representations will find that guidance applicable here as well.

Implementers should also familiarize themselves with the FHIR resources used within the guide:

| Resource | Relevance |
|-----------|------------|
| [CapabilityStatement]({{site.data.fhir.path}}capabilitystatement.html) | Used to define conformance expectations for this guide |
| [Consent]({{site.data.fhir.path}}consent.html) | The main resource that contains the information |
| [CodeSystem]({{site.data.fhir.path}}codesystem.html) | Used to define custom codes specific to this guide |
| [OperationDefinition]({{site.data.fhir.path}}operationdefinition.html) | Used to define the operations used in this IG |
| [Organization]({{site.data.fhir.path}}organization.html) | Used when identifying providers in Consents |
| [Parameters]({{site.data.fhir.path}}parameters.html) | Used to provide the information for the operations |
| [Patient]({{site.data.fhir.path}}patient.html) | Demographic information relevant to all requests |
| [Practitioner]({{site.data.fhir.path}}practitioner.html) | Used when identifying providers in Consents |
| [PractitionerRole]({{site.data.fhir.path}}practitionerrole.html) | Used when identifying providers in Consents |
| [StructureDefinition]({{site.data.fhir.path}}structuredefinition.html) | Used when profiling resources and defining extensions |
| [Subscription]({{site.data.fhir.path}}subscription.html) | Used when subscribing for authorization decisions for an organization |
| [ValueSet]({{site.data.fhir.path}}valueset.html) | Used to define collections of codes used in FAST Consent profiles |
