# Authorized Security Lab — Rules of Engagement

**Document status:** Draft for written approval. This document is not itself evidence of authorization until completed and signed by the asset owner and assessor.

## 1. Written authorization

| Field | Required value |
|---|---|
| Lab owner organization | RabTech lab (as listed in supplied inventory) |
| Named owner / authorized signatory | **TO BE COMPLETED** |
| Assessor name | **TO BE COMPLETED** |
| Approval date | **TO BE COMPLETED** |
| Engagement start / end | **TO BE COMPLETED — exact dates, times, timezone** |
| Emergency contact (name and phone) | **TO BE COMPLETED** |
| Technical point of contact | **TO BE COMPLETED** |
| Approved assets | LAB-01 and LAB-02 only, as listed in `inventory/authorized-lab-assets.csv` |
| Authorization reference / signature | **TO BE COMPLETED** |

The owner must have authority over each target. No testing may begin until the owner signs this document and confirms the inventory. Never test a system absent from the inventory. Verbal permission, repository ownership, or possession of a VM does not replace written authorization.

## 2. Approved assets and boundaries

- **LAB-01:** Local training web app — `http://127.0.0.1:8080`; localhost only.
- **LAB-02:** Deliberately vulnerable VM — `192.168.56.20`; private host-only network only.

The CSV inventory is authoritative. All other IPs, hostnames, domains, ports, services, identities, cloud resources, devices, and networks are excluded unless the owner approves a written inventory amendment before testing.

### Explicitly out of scope

- Public internet, third-party targets, campus/university, employer, home, office, or shared networks.
- Any cloud service/account, router, access point, DNS server, domain controller, hypervisor, host OS, or unrelated VM.
- Other clients or devices on the same physical or virtual network.
- Any asset discovered during testing that is not already approved.
- Real user accounts, production data, personal data, or credentials not created solely for this lab.

## 3. Permitted techniques

Only during the approved window, and only against the exact approved assets:

- Passive review of supplied lab configuration and documentation.
- Confirming that LAB-01 is reachable on loopback and LAB-02 is reachable through the configured host-only interface.
- Low-volume, targeted service identification against LAB-02 at its exact inventory address, limited to services the owner expects to be enabled.
- Manual application security validation on documented LAB-01 routes using synthetic data and disposable accounts.
- Basic authentication, session, input-validation, access-control, configuration, and security-header checks that do not modify unrelated data or disrupt service.
- Capturing minimal screenshots, request/response snippets, timestamps, and notes for reporting.
- Rechecking a specific finding after remediation, with renewed owner approval if outside the original window.

No broad subnet scanning. Do not scan the host-only subnet or adjacent addresses. Do not enumerate unrelated hosts. Avoid automated scanners unless the owner separately approves the exact tool, target, rate, and test case in writing.

## 4. Prohibited actions

- Denial-of-service, stress testing, load testing, resource exhaustion, or high-volume fuzzing.
- Destructive payloads, data deletion/corruption, destructive file writes, or changes to VM/network configuration during tests.
- Persistence, backdoors, scheduled tasks, startup changes, implants, or maintaining access after a test.
- Credential stuffing, password spraying, brute force, credential reuse, phishing, social engineering, or testing real credentials.
- Malware, ransomware, crypto-mining, exfiltration, uncontrolled data extraction, or access to personal/production data.
- Exploiting hypervisor escapes, host OS vulnerabilities, kernel vulnerabilities, or pivoting to other systems.
- Any outbound traffic from LAB-02 or any test traffic to external networks.
- Any action not explicitly permitted in Section 3.

## 5. Test window, rate limits, and operating controls

- Start: **TO BE COMPLETED**
- End: **TO BE COMPLETED**
- Timezone: **Asia/Kolkata (IST, UTC+05:30), confirm with owner**
- Emergency contact and stop authority: **TO BE COMPLETED**
- Maximum request rate: **one request per second for manual HTTP checks; no concurrency**.
- Run short, single-purpose test cases. Pause between cases and verify the app/VM remains healthy.
- Do not run unattended scans or leave testing processes active.
- Keep a live log of start/end times, target, activity, operator, and result.
- Before the window, confirm snapshots/backups and the rollback contact.

If the owner has not approved an exact rate or testing window, do not test. The conservative limit above is a proposed ceiling, not permission to use a scanner.

## 6. Evidence handling

- Use synthetic data only. Collect the minimum evidence needed to substantiate each finding.
- Store evidence in a local, access-restricted engagement folder; do not publish raw evidence to a public repository.
- Redact passwords, tokens, cookies, private keys, personal data, and sensitive VM details from screenshots and reports.
- Do not download or copy data unrelated to a specific approved test case.
- Record evidence ID, asset ID, timestamp, test description, and operator.
- Share findings only with the named owner and authorized assessor.
- Proposed retention: delete raw evidence within **30 days after owner acceptance of the final report**, unless the owner specifies a shorter period in writing. Record the actual deletion date.
- If real or sensitive data is unexpectedly encountered, stop immediately; do not inspect further, copy, or include it in evidence. Notify the owner securely.

## 7. Escalation and stop conditions

**Stop testing immediately** when any of the following occurs:

1. A target does not exactly match the approved asset inventory.
2. A request is routed outside localhost or the host-only VM, or external connectivity is detected.
3. Any unrelated host, third-party service, production system, or real user data is encountered.
4. The app/VM becomes unstable, unresponsive, unexpectedly changes state, or shows resource pressure.
5. A test may cause data loss, service interruption, account lockout, or irreversible change.
6. Evidence suggests access beyond the authorized role or intended lab boundary.
7. The owner, assessor lead, or emergency contact orders a stop.
8. The approved time window expires or the emergency contact is unavailable when required.

On stop: cease traffic; do not attempt further diagnosis; preserve only minimal safe metadata; do not make additional changes; notify the named owner through the agreed channel; and wait for written direction. Resume only after the owner confirms the cause is understood, the environment is restored if needed, and written approval is renewed.

## 8. Rollback and incident response

- VM owner confirms and maintains a known-good snapshot before testing.
- App owner confirms a backup or reset mechanism for synthetic data.
- Only the owner or designated operator performs rollback.
- If a suspected security incident affects anything outside the lab, disconnect the lab from all networks without interacting with the external system, preserve minimal logs, and notify the owner immediately.
- Record the event, time, observed impact, actions taken, and authorization for any restart.

## 9. Reporting requirements

Each finding must include:

- Finding ID and title.
- Affected asset ID and exact in-scope endpoint/service.
- Severity and documented rationale (likelihood, impact, and assumptions).
- Preconditions and synthetic identity/role used.
- Minimal, repeatable reproduction steps.
- Observed result versus expected secure result.
- Impact limited to the lab context.
- Redacted evidence references and timestamps.
- Recommended remediation and owner.
- Retest result and closure date, when applicable.

Do not include exploit chains or details that enable use against out-of-scope systems. Clearly label unverified hypotheses as hypotheses.

## 10. Approval and signatures

By signing, the parties confirm that they understand and accept the scope, exclusions, schedule, safeguards, evidence handling, and stop conditions in this document.

**Lab owner / authorized signatory**

Name: __________________________________

Title: ___________________________________

Signature: _______________________________

Date and time (IST): ______________________

**Assessor**

Name: __________________________________

Signature: _______________________________

Date and time (IST): ______________________

**Emergency contact confirmed:** Yes / No

**Asset inventory reviewed and approved:** Yes / No

**Host-only isolation verified:** Yes / No

**Snapshots/backups confirmed:** Yes / No

Testing is prohibited until all required approval and pre-test fields are completed.
