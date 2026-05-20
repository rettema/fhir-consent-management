### Systems

The FAST Consent implementation guide defines the responsibilities of two types of systems involved in a consent solution. These are the canonical **Consent Client System** and **Consent Server System** actors defined in this guide.

[**Consent Client systems**](CapabilityStatement-ConsentClientCapabilities.html) are systems responsible for gathering patient consent decisions and filing them with a consent administration service. They are typically Electronic Medical Record (EHR) systems or patient portals, but can be any system that invokes the File Consent and Revoke Consent operations on behalf of a patient or authorized representative.

[**Consent Server systems**](CapabilityStatement-ConsentAdministrativeServerCapabilities.html) are consent administration services that store consent records, service search requests, manage subscriptions, and persist audit events for consent access decisions.

### Conformance Verbs

The conformance verbs — **SHALL**, **SHOULD**, **MAY** — used in this guide are defined in [FHIR Conformance Rules]({{site.data.fhir.path}}conformance-rules.html#conflang).

### MustSupport

Profiles in this implementation guide make use of the [mustSupport]({{site.data.fhir.path}}profiling.html#mustsupport) element. Base expectations for mustSupport are set in the [FHIR core specification]({{site.data.fhir.path}}conformance-rules.html#conflang). Also see the mustSupport rules for [US Core]({{site.data.fhir.ver.uscore}}/must-support.html), which apply to content adhering to data elements profiled in those guides.

The following rule defines the meaning of mustSupport in this guide:

* §MS-1?^client:Consent Client systems **SHALL** be capable of populating a mustSupport element when sharing resources compliant with the profile. I.e., the system must be able to demonstrate the population and sharing of the element, but it is acceptable to omit the element if the system doesn’t have values in a particular instance. A system that is incapable of ever sharing the element would be non-conformant.§

### General Conformance Rules

The following rules apply to all elements in profiles defined in this guide, not only mustSupport elements:

* §MS-2?^admin-service:Consent Server systems **SHALL** be capable of processing resource instances containing data elements without generating an error or causing the application to fail.§
* §MS-3?^client,admin-service:If the minimum cardinality of an element is greater than 0 — i.e., the element is required — then the element **SHALL** be present in the instance and **SHALL** have a value.§
* §MS-4?^admin-service:Consent Server systems **SHALL** interpret missing data elements within resource instances as data not being present in the sending system or not being shareable for privacy or other business reasons.§
* §MS-5?^admin-service:Consent Server systems **SHALL** be able to process resource instances containing data elements that have extensions in place of a value where such extensions are declared as part of the profile.§

### Conformance Statements in this Guide

§§§
