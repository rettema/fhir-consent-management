Profile: FASTSubscription
Parent: http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription
Description: "A profile for FAST subscriptions."
* criteria = "http://hl7.org/fhir/us/consent-management/SubscriptionTopic/FASTConsentSubscriptionTopic"
* channel.type = #rest-hook

Instance: FASTPatientSubscriptionExample
InstanceOf: FASTSubscription
Description: "An example of a FAST Subscription for a specific patient."
* criteria.extension[http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria].valueString = "patient:identifier=http://example.org/mrn|M1230041"
* status = #active
* channel.endpoint = "http://example.org/send-me-subscription-notifications"
* channel.payload = #application/fhir+json
* channel.payload.extension[http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content].valueCode = #full-resource
* reason = "Receive notifications about consent for patient X."

Instance: FASTOrganizationSubscriptionExample
InstanceOf: FASTSubscription
Description: "An example of a FAST Subscription for a specific organization (controller)."
* criteria.extension[http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria].valueString = "controller:identifier=http://hl7.org/fhir/sid/us-npi|1234567893"
* status = #active
* channel.endpoint = "http://example.org/send-me-subscription-notifications"
* channel.payload = #application/fhir+json
* channel.payload.extension[http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content].valueCode = #full-resource
* reason = "Receive notifications about consent for patient X."

Instance: FASTSubscriptionNotification
InstanceOf: Bundle
Description: "An example of a FAST Subscription Notification"
* type = #history
* timestamp = 2020-05-29T11:44:33.188-05:00
* entry[+].fullUrl = "http://example.org/Parameters/FASTSubscriptionNotificationParameters"
* entry[=].resource = FASTSubscriptionNotificationParameters
* entry[=].request.method = #GET
* entry[=].request.url = "https://example.org/Subscription/FAST/$status"
* entry[=].response.status = "200"
* entry[+].fullUrl = "http://example.org/Consent/ConsentExample"
* entry[=].resource = ConsentExample
* entry[=].request.method = #GET
* entry[=].request.url = "https://example.org/Consent/ConsentExample"
* entry[=].response.status = "200"

Instance: FASTSubscriptionNotificationParameters
InstanceOf: http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4
Description: "An example of the parameters going back for a FAST subscription notification"
* parameter[subscription]
  * valueReference = Reference(FASTPatientSubscriptionExample)
* parameter[topic]
  * valueCanonical = "http://hl7.org/fhir/us/consent-management/SubscriptionTopic/FASTConsentSubscriptionTopic|1.0.0"
* parameter[status]
  * valueCode = #active
* parameter[type]
  * valueCode = #event-notification
* parameter[notificationEvent]
  * part[eventNumber]
    * valueString = "2"
  * part[eventTimestamp]
    * valueInstant = "2020-05-29T11:44:33.188-05:00"
  * part[eventFocus]
    * valueReference.reference = "http://example.org/Bundle/ConsentExample"
