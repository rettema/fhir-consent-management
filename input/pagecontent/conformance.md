### Systems
The FAST Consent implementation guide defines the responsibilities of the two types of systems involved in a Consent solution:

[**Client systems**](CapabilityStatement-ConsentClientCapabilities.html) are typically Electronic Medical Record (EHR) systems but could theoretically be any system responsible for gathering consent records. 

[**Server systems**](CapabilityStatement-ConsentAdministrativeServerCapabilities.html) (or servers) are consent administration systems.

### Conformance Verbs

The conformance verbs — **SHALL**, **SHOULD**, **MAY** — used in this guide are defined in [FHIR Conformance Rules]({{site.data.fhir.path}}conformance-rules.html#conflang).

### MustSupport

Profiles in this implementation guide make use of the [mustSupport]({{site.data.fhir.path}}profiling.html#mustsupport) element. Base expectations for mustSupport are set in the [FHIR core specification]({{site.data.fhir.path}}conformance-rules.html#conflang). Also see the mustSupport rules for [US Core]({{site.data.fhir.ver.uscore}}/must-support.html), which apply to content adhering to data elements profiled in those guides.

The following rule defines the meaning of mustSupport in this guide:

* §MS-1:Consent Client systems **SHALL** be capable of populating a mustSupport element when sharing resources compliant with the profile. I.e., the system must be able to demonstrate the population and sharing of the element, but it is acceptable to omit the element if the system doesn’t have values in a particular instance. A system that is incapable of ever sharing the element would be non-conformant.§

### General Conformance Rules

The following rules apply to all elements in profiles defined in this guide, not only mustSupport elements:

* §MS-2:Consent Server systems **SHALL** be capable of processing resource instances containing data elements without generating an error or causing the application to fail.§
* §MS-3:If the minimum cardinality of an element is greater than 0 — i.e., the element is required — then the element **SHALL** be present in the instance and **SHALL** have a value.§
* §MS-4:Consent Server systems **SHALL** interpret missing data elements within resource instances as data not being present in the sending system or not being shareable for privacy or other business reasons.§
* §MS-5:Consent Server systems **SHALL** be able to process resource instances containing data elements that have extensions in place of a value where such extensions are declared as part of the profile.§

### Conformance Statements in this Guide

§§§
