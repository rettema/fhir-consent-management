



Instance: fast-consent-controller
InstanceOf: SearchParameter
Description: "The Consent controller reference which is defined by the Consent extension controller."
Usage: #definition

* id = "fast-consent-controller"
* url = "http://hl7.org/fhir/us/consent-management/SearchParameter/fast-consent-controller"
* version = "0.1.0"
* name = "FASTConsentController"
* status = #active
* experimental = false
* description = "The Consent controller reference which is defined by the Consent extension controller."
* jurisdiction = urn:iso:std:iso:3166#US
* code = #controller
* base = #Consent
* type = #reference
* expression = "Consent.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.controller').extension.value.reference"
* xpath = "f:Consent/f:extension[@url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.controller']/f:extension/f:valueReference/f:reference"
* xpathUsage = #normal
* comparator[0] = #eq


Instance: fast-consent-grantee
InstanceOf: SearchParameter
Description: "The Consent grantee reference which is defined by the Consent extension grantee."
Usage: #definition

* id = "fast-consent-grantee"
* url = "http://hl7.org/fhir/us/consent-management/SearchParameter/fast-consent-grantee"
* version = "0.1.0"
* name = "FASTConsentGrantee"
* status = #active
* experimental = false
* description = "The Consent grantee reference which is defined by the Consent extension grantee."
* jurisdiction = urn:iso:std:iso:3166#US
* code = #grantee
* base = #Consent
* type = #reference
* expression = "Consent.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.grantee').extension.value.reference"
* xpath = "f:Consent/f:extension[@url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.grantee']/f:extension/f:valueReference/f:reference"
* xpathUsage = #normal
* comparator[0] = #eq


Instance: fast-consent-manager
InstanceOf: SearchParameter
Description: "The Consent manager reference which is defined by the Consent extension manager."
Usage: #definition

* id = "fast-consent-manager"
* url = "http://hl7.org/fhir/us/consent-management/SearchParameter/fast-consent-manager"
* version = "0.1.0"
* name = "FASTConsentManager"
* status = #active
* experimental = false
* description = "The Consent manager reference which is defined by the Consent extension manager."
* jurisdiction = urn:iso:std:iso:3166#US
* code = #manager
* base = #Consent
* type = #reference
* expression = "Consent.extension('http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.manager').extension.value.reference"
* xpath = "f:Consent/f:extension[@url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Consent.manager']/f:extension/f:valueReference/f:reference"
* xpathUsage = #normal
* comparator[0] = #eq


