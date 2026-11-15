
# Rules of Engagement (ROE)

## 1. Engagement Information

Project: Authorized Security Lab
Engagement Type: Controlled Security Assessment
Environment: Local Docker-Based Training Lab
Application: OWASP Juice Shop v20.3.0
Reverse Proxy: Nginx
Prepared By: __________________________
Asset Owner: RabTech Lab (to be confirmed)
Authorized Approver: __________________
Document Version: 1.0
Status: DRAFT - NOT APPROVED

## 2. Purpose

Define the permitted scope, responsibilities, restrictions,
safety requirements and stopping conditions for a future
authorized security assessment.

No testing is permitted until this document is completed
and signed by the authorized owner and assessor.

## 3. Authorized Scope

Proposed assets:

| Asset ID | Asset | Address | Status |
|---|---|---|---|
| LAB-01 | OWASP Juice Shop | http://127.0.0.1:8080 | Deployed |
| LAB-02 | Nginx Proxy | 127.0.0.1:8080 | Deployed |
| NET-01 | Internal Docker Network | authorized-lab-internal | Deployed |
| NET-02 | Proxy Access Network | authorized-lab-proxy-access | Deployed |
| VM-01 | Training VM | 192.168.56.20 | Not deployed/verified |

Only assets explicitly approved in the signed scope are permitted.

The VM at 192.168.56.20 is excluded until separately deployed,
validated and added to the approved scope.

## 4. Out-of-Scope Assets

The following are strictly excluded:

- Public IP addresses.
- Third-party systems.
- University and campus networks.
- Home and office networks.
- Cloud infrastructure.
- Unlisted virtual machines.
- Windows host operating system testing.
- Hypervisor testing.
- External services and APIs.
- Any asset without explicit written approval.

## 5. Permitted Activities

Only after written approval:

- Application configuration review.
- Manual application security review.
- Authentication and authorization review.
- Input-validation review.
- Safe validation of approved security controls.
- Review of application and proxy logs.
- Documentation of findings and recommendations.

All activities must remain within the approved assets,
methods, dates and time window.

## 6. Prohibited Activities

Unless separately approved in writing, the following are prohibited:

- Denial-of-service testing.
- Stress and load testing.
- Destructive testing.
- Data deletion or corruption.
- Persistence installation.
- Credential stuffing.
- Password spraying.
- Phishing or social engineering.
- Malware deployment.
- Accessing real personal or sensitive information.
- Data exfiltration.
- Host OS or hypervisor attacks.
- Testing external or third-party targets.
- Testing outside the approved time window.

## 7. Testing Conditions

Approved Start Date: __________________

Approved End Date: ____________________

Approved Time Window: _________________

Timezone: _____________________________

Authorized Source Machine: ____________

Authorized Personnel: _________________

Emergency Contact: ____________________

Owner Contact: ________________________

All fields must be completed and approved before testing.

## 8. Safety Limits

Proposed operational limits, subject to owner approval:

- Manual request rate: Maximum 1 request per second.
- Concurrent requests: 1.
- No automated stress testing.
- No destructive requests.
- No persistence.
- No access to real user information.
- Stop immediately if the application becomes unstable.

These limits do not override stricter owner requirements.

## 9. Evidence Handling

- Collect only the minimum evidence required.
- Store evidence locally in the approved evidence directory.
- Redact credentials, tokens and sensitive values.
- Record timestamps and relevant asset identifiers.
- Do not upload evidence to public services.
- Maintain an evidence register.
- Proposed retention: 30 days after owner acceptance,
  subject to the owner's approved retention policy.

## 10. Stop Conditions

Immediately stop the activity if:

1. An out-of-scope asset is encountered.
2. Real personal or sensitive information appears.
3. The application or container becomes unstable.
4. Unexpected system changes occur.
5. The owner or authorized contact requests a stop.
6. The approved testing window expires.
7. Scope or authorization becomes unclear.
8. Evidence indicates potential impact beyond the approved lab.

Stop all activity, preserve relevant minimal evidence safely,
and notify the authorized contact.

## 11. Recovery Procedure

- Stop the relevant testing activity.
- Notify the authorized owner.
- Preserve logs and evidence where safe.
- Restore the approved lab snapshot or backup if required.
- Verify normal lab operation before any further activity.
- Obtain renewed approval before resuming.

## 12. Authorization and Signatures

Asset Owner Name: _____________________

Asset Owner Signature: _________________

Authorized Approver: __________________

Approver Signature: ___________________

Assessor Name: ________________________

Assessor Signature: ___________________

Date of Approval: _____________________

Status: PENDING SIGNATURES

## 13. Final Authorization Statement

No security testing may begin until:

- Asset ownership is confirmed.
- Scope is explicitly approved.
- All testing dates and times are approved.
- Emergency contacts are available.
- Recovery arrangements are confirmed.
- All required signatures are obtained.

Document Status: NOT AUTHORIZED FOR TESTING
