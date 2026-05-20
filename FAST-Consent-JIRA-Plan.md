# FAST Consent Management IG — JIRA Issue Implementation Plan (Revised 2026-05-20)

**Original total:** 83 issues  
**Committed as of 2026-05-20:** 57 issues  
**Remaining open:** 26 issues  
**Source root:** `input/`

---

## Status Summary

### ✅ Already Committed (57 issues)

| JIRA | Summary | Commit |
|------|---------|--------|
| FHIR-53780 | identifier 1..* | pre-existing |
| FHIR-53813 | Remove delete from SubscriptionTopic | pre-existing |
| FHIR-53758 | SubscriptionTopic filter changes | pre-existing |
| FHIR-53754 | Change subscription filter scope → category | pre-existing |
| FHIR-53753 | provision.actor Must Have → Must Support | pre-existing |
| FHIR-54663 | Enable shownav | dc8ce73 |
| FHIR-54665 | Add US Core and IHE-BALP to Dependencies | b074c4e |
| FHIR-54669 | Update "Reading this IG" link text | e2b317e |
| FHIR-54688 | Remove artifacts.html link | 703f8ff |
| FHIR-54658 | Add Privacy Consent definition | bd4badf |
| FHIR-54659 | Add Consent Ceremony definition | d28511f |
| FHIR-54655 | Fix hardcoded FHIR R4 URLs | 479e17b |
| FHIR-54656 | NOTE text resolved by Scope section | 04f6b43 |
| FHIR-54686 | Rename background page; add spec subsections | fb920ab |
| FHIR-54685 | Separate conformance verb definitions | ba190b3 |
| FHIR-54691 | Clarify OP10 wording | da78a92 |
| FHIR-54690 | Add Testing Guide governance note | e3a6a55 |
| FHIR-54675 | LOINC 57016-8 display name in DocRef intro | 0ed7857 |
| FHIR-54678 | Make manager extension normative (§NR1/§NR2) | c0481b4 |
| FHIR-54679 | Consent Network clarity; push/pull labels | 060de8b |
| FHIR-54648 | Remove RecordDisclosure OperationDefinition | c7f6676 |
| FHIR-53779 | Remove RecordDisclosure downstream refs | b51f494 |
| FHIR-54692 | Replace $record-disclosure in technical.md | 97ad3e8 |
| FHIR-55374 | Add IHE-BALP/ITI-81 guidance to AuditEvent | c038294 |
| FHIR-54647 | Document identifier 1..* in intro-notes | 4b93f32 |
| FHIR-54676 | Remove FASTConsentStatuses required binding | 28b92cc |
| FHIR-54132 | Consent.policy 1..* | c4341dc |
| FHIR-54061 | Relax grantee to 0..* MS | a178738 |
| FHIR-53778 | Remove fast-consent-organizationId SP | 4b2c513 |
| FHIR-53777 | Remove fast-consent-patientId SP | 2882080 |
| FHIR-53703 | Document SubscriptionTopic delete removal | ea9e4d5 |
| FHIR-54361 | Update SubscriptionTopic canFilterBy | 7680fda |
| FHIR-55364 | Add §NR3/§NR4 to sharing.md | 4618256 |
| FHIR-54653 | Remove fast-auditevent-consent SP | — |
| FHIR-54652 | Nonsense sentence in SP description | — |
| FHIR-53781 | AuditEvent consent SP removal | — |
| FHIR-54131 | Constraint vs. Exception terminology | — |
| FHIR-54127 | Must Have vs Must Support clarification | — |
| FHIR-54056 | Rationale for fixed Consent.scope | — |
| FHIR-53756 | Must Have list updates for FASTConsentAuditEvent | — |
| FHIR-53757 | Meaning of Success in AuditEvent.outcome | — |
| FHIR-53776 | Why controller/manager search params required | — |
| FHIR-54874 | Update Consent guidance (no in-place PUT/PATCH) | — |
| FHIR-54875 | Dependency on Current Consent State section | — |
| FHIR-54683 | RESTful FHIR vs Operations section | — |
| FHIR-54702 | Consent.patient required; jurisdictional rules OOS | — |
| FHIR-54101 | Authorization to Subscribe section | 2e2383f |
| FHIR-54120 | Consent Access Management section | 1641490 |
| FHIR-54660 | Authorization scope statement | — |
| FHIR-54662 | Authentication as required precondition | — |
| FHIR-53750 | Opt-in / Opt-out; Permit and Deny section | — |
| FHIR-54681 | IHE-PCF relationship expanded section | 77183f8 |
| FHIR-56088 | CDA Privacy Consent Directives section | 911838d |
| FHIR-54650 | Distinguish Authorization Decision vs Disclosure Events | 82ac153 |

---

## Remaining 26 Issues — Revised Phases

---

## Phase 3 — AuditEvent Section Revision (2 issues)

**Autonomous. Depends on Phase 1 SP removal and Phase 2 FHIR-54650 — both complete.**

These two are tightly coupled. FHIR-54649's inconsistency was largely resolved by the Record Disclosure removal, but a cleanup pass on the AuditEvent section is still needed. FHIR-53755 calls for a broader revision of the AuditEvent section narrative: explaining the use of FASTConsentAuditEvent, how patients can query for consent consultation events, and adding a use case narrative.

| JIRA | Summary | File(s) | Resolution |
|------|---------|---------|------------|
| FHIR-53755 | Revise ConsentAuditEvent usage section | `technical.md`, `StructureDefinition-FASTConsentAuditEvent-intro.md` | Revise AuditEvent section: clarify that FASTConsentAuditEvent is for authorization decision events only (not disclosure); add narrative explaining how patients can query for consent consultation events; add use case context. |
| FHIR-54649 | AuditEvent profiling inconsistency | `technical.md`, `StructureDefinition-FASTConsentAuditEvent-intro.md` | Cleanup: verify case 1/2/3 are now consistently handled. Case 3 (the removed operation) is gone. Confirm case 1 uses FASTConsentAuditEvent; case 2 references IHE-BALP disclosure pattern. Remove any stale references to the old operation. |

---

## Phase 4 — Actor Definitions & Terminology Consistency (9 issues)

**Largely autonomous.** The canonical actor names are confirmed by the FHIR-53751 resolution: **Consent Client System** (shortened: "Consent Client") and **Consent Server System** (shortened: "Consent Server" or "consent administration service"). CapabilityStatement names should be updated to `ConsentClient` and `ConsentServer`.

**Scope of work:**
1. Add an actor definitions table/section to `usecases.md` (or `conformance.md`) naming and defining both actors
2. Rename CapabilityStatement titles/names in `Capabilities.fsh`
3. Propagate canonical names through `technical.md`, `conformance.md`, `sharing.md`
4. Fix the `technical.md` Systems section (FHIR-54687) to match conformance.md
5. Align actor terminology in `usecases.md` (eliminate "ConsentSystem", "Administrator", etc. where they conflict)

| JIRA | Summary | Primary File(s) | Resolution |
|------|---------|----------------|------------|
| FHIR-53751 | System/Role terminology | `usecases.md`, `Capabilities.fsh`, `conformance.md` | Define "Consent Client System" and "Consent Server System" as canonical; add to use case diagrams; rename CapabilityStatements to ConsentClient/ConsentServer |
| FHIR-53775 | "systems" in conformance statements | `technical.md`, `conformance.md` | Clarify §OP10/§OP11 "systems" — applies to both Consent Client and Consent Server |
| FHIR-54925 | Capability resource name consistency | `Capabilities.fsh` | Rename CapabilityStatement resources to use consistent canonical actor names |
| FHIR-54922 | Inconsistent/unclear definitions and actors | `usecases.md`, multiple pages | Add actor definitions section; propagate "Consent Client / Consent Server" throughout |
| FHIR-54687 | Actor inconsistency in technical.md | `technical.md` | Update Systems section to match the canonical actor definitions from conformance.md |
| FHIR-54684 | Inconsistent actor names and use | Multiple pages | Propagate canonical names; remove "Data Sources" / "Data Consumers" language from Must Support statements; ensure all §-conformance statements use canonical names |
| FHIR-54670 | Use of "Actor" is confusing | `usecases.md` | Distinguish human roles (Consenter, Administrator) from technical actors (Consent Client System, Consent Server System); add explanatory note |
| FHIR-54567 | Actor definitions don't match | `conformance.md`, `technical.md` | Align System definitions on both pages to use identical canonical language |
| FHIR-53887 | Harmonize actor names | Multiple pages | Final consistency pass: ensure patient, manager, grantee, controller, user, authorizer, client, administrator, consenter are all defined and used consistently |

---

## Phase 5 — Use Cases Page & Diagrams (15 issues)

**Depends on Phase 4.** Once canonical actor names and definitions are in place, these use case edits can proceed.

Some of these share the same resolution (add technical operation links, use case → operation table). They can be batched into ~10–12 commits by combining issues that modify the same diagram file.

| JIRA | Summary | File(s) | Resolution |
|------|---------|---------|------------|
| FHIR-55370 | Map use cases → technical operations | `usecases.md` | Add table: use case → FHIR operation; add operation link/reference to each use case section |
| FHIR-55028 | Confirmation step in use cases | `usecases.md` + diagrams | Add confirmation step (consent successfully filed/delegated/revoked) to all relevant use case diagrams |
| FHIR-54888 | Caregiver-Guardian as Consenter | `usecases.md` | Clarify Consenter = patient or caregiver/guardian; note that explicit notification of guardian is out of scope |
| FHIR-54884 | Add patient to consent tree visual | `usecases.md` | Add note under §4.2.1.1: patient notification on network sharing is out of scope; Consenter role covers this |
| FHIR-54880 | Inform patient of consent change/revocation | `usecases.md` | Clarify §7.2.3: explicit informing of patient is out of scope; consenter is already part of the process |
| FHIR-54789 + FHIR-54359 | Loop fix + alternate flow in Review Consent diagram | `review-consent-sequence.plantuml` | Add loop exit condition; add alternate flow (same commit — both target the same diagram) |
| FHIR-54677 | Consent Request artifact in use cases | `usecases.md` | Clarify that Consent Request (consent form) is a pre-condition artifact; add links to normative FHIR artifacts (Consent, DocumentReference) per use case |
| FHIR-54672 | Actor diagram incomplete for Request Consent | `usecases.md` + actor diagram | Add ConsentSystem to Request Consent use case diagram and Actor list |
| FHIR-54539 | Remove "Actor: Consenter" from Propagate Consent Events | `usecases.md` | Remove "Actor: Consenter" line from Propagate Consent Events section |
| FHIR-54358 | Missing Pre-Condition in §3.4 | `usecases.md` | Add pre-condition to File/Sign Consent section |
| FHIR-54357 | Missing Post-Condition in §3.8 | `usecases.md` | Add post-condition: lifecycle events returned to Consenter |
| FHIR-54047 | Clarify normative vs. illustrative workflow descriptions | `usecases.md` | Label each use case narrative section as "Informative" or "Normative"; link to relevant technical operations |
| FHIR-53773 | Use case page improvements | `usecases.md` | Add descriptions for Administrator and Consenter actors; revise ConsentSystem actor links; harmonize use case titles to verb form |
| FHIR-53752 | Link use cases to conformance | `usecases.md` | Add informative cross-reference: business use case → technical operation; consistent use of canonical actor names |

---

## Recommended Sequencing

```
Phase 3 (AuditEvent revision)    ──────────────────► ~3 commits, fully autonomous, can start now
Phase 4 (actor/terminology)      ──────────────────► ~10 commits, largely autonomous (canonical names confirmed)
Phase 5 (use cases)              ──► depends on Phase 4 ──► ~12 commits
```

**Confirmed canonical actor names (from FHIR-53751 resolution):**
- **Consent Client System** (short form: "Consent Client") — the EHR or system responsible for gathering and filing consents
- **Consent Server System** (short form: "Consent Server" or "consent administration service") — stores consents and handles consent requests
- CapabilityStatement FSH names: `ConsentClient` and `ConsentServer`

**Note on Phase 4 autonomy:** The resolutions across FHIR-53751, 53775, 54925, 54922, 54687, 54684, 54670, 54567, 53887 all converge on the same action: define canonical actors and propagate consistently. Jean's approval is recommended before committing Phase 4 to ensure the actor definitions and CapabilityStatement renames match expectations.

---

*Last updated: 2026-05-20*
