# STRIDE Threat Register

## Scope and method

This register assesses the two assets in the approved inventory only: LAB-01 (localhost training web app) and LAB-02 (host-only deliberately vulnerable VM). Ratings are preliminary design assessments, not confirmed vulnerabilities. Reassess after setup and record evidence without expanding scope.

**Scale:** Likelihood (L) and Impact (I): 1 = Low, 2 = Moderate, 3 = High. Priority = L × I. Priority bands: 1–2 Low, 3–4 Medium, 6–9 High. Ratings assume synthetic data and an isolated lab.

| ID | STRIDE | Asset / abuse case | L | I | Score | Ranked mitigations / owner |
|---|---|---|---:|---:|---:|---|
| S-01 | Spoofing | LAB-01: an attacker impersonates a synthetic user by abusing weak authentication or session handling | 2 | 2 | 4 Medium | M1: use disposable lab credentials and strong password handling; M2: secure session cookies and rotate sessions after authentication; M3: rate-limit login attempts. Owner: app maintainer |
| S-02 | Spoofing | LAB-02: an unauthorized lab user obtains an account or reuses credentials outside the exercise | 2 | 3 | 6 High | M1: unique synthetic credentials, never reused; M2: restrict VM console/SSH access to authorized operators; M3: remove test accounts and rotate lab secrets after the exercise. Owner: VM owner |
| T-01 | Tampering | LAB-01: untrusted input changes application state or stored training records without authorization | 2 | 2 | 4 Medium | M1: server-side validation and parameterized data access; M2: enforce authorization on every state-changing operation; M3: keep a snapshot and synthetic data reset procedure. Owner: app maintainer |
| T-02 | Tampering | LAB-02: local user modifies configuration or files beyond intended lab permissions | 2 | 3 | 6 High | M1: least-privilege accounts and file permissions; M2: record baseline configuration and checksums for critical training files; M3: snapshot before exercise and restore after. Owner: VM owner |
| R-01 | Repudiation | Either asset: actions cannot be reliably attributed because events are not logged or timestamps are inconsistent | 2 | 2 | 4 Medium | M1: enable bounded application/VM audit logs; M2: synchronize lab clocks where practical; M3: retain minimal, access-controlled evidence with a finding ID. Owner: lab owner |
| I-01 | Information Disclosure | LAB-01: verbose errors, exposed files, or missing authorization reveal synthetic lab information | 2 | 2 | 4 Medium | M1: generic external errors; M2: authorization checks and deny-by-default access; M3: ensure only synthetic data is loaded and redact evidence. Owner: app maintainer |
| I-02 | Information Disclosure | LAB-02: unintended service exposure or insecure permissions expose VM configuration or test secrets | 2 | 3 | 6 High | M1: minimize listening services and bind to the host-only interface; M2: firewall inbound traffic to required lab sources; M3: protect secrets and avoid shared folders containing host data. Owner: VM owner |
| D-01 | Denial of Service | LAB-01 or LAB-02: excessive requests or resource exhaustion makes the training target unavailable | 2 | 3 | 6 High | M1: DoS and stress testing are prohibited; M2: set conservative request-rate limits and short test batches; M3: monitor health and stop on latency/errors or resource pressure. Owner: assessor and lab owner |
| E-01 | Elevation of Privilege | LAB-01: a lower-privilege synthetic user accesses an administrative function due to a broken authorization check | 2 | 3 | 6 High | M1: server-side role checks on every privileged action; M2: deny by default; M3: test only with owner-approved synthetic roles and stop before host/OS escalation. Owner: app maintainer |
| E-02 | Elevation of Privilege | LAB-02: a normal VM account reaches privileges outside the intended exercise boundary | 2 | 3 | 6 High | M1: isolate and snapshot VM; M2: restrict administrative credentials to owner/operator; M3: no persistence, kernel exploitation, hypervisor escape, or host access. Owner: VM owner |

## Ranked cross-cutting mitigations

1. **P1 — Enforce isolation and scope:** host-only VM networking; localhost-only web app; no NAT, bridged interface, forwarding, or external route. Verify before each window.
2. **P1 — Written authorization and explicit boundaries:** signed owner approval, inventory-controlled targets, named contacts, test schedule, and emergency stop authority.
3. **P1 — Prevent destructive/unbounded tests:** prohibit DoS, stress/fuzzing at scale, persistence, destructive payloads, credential reuse, and uncontrolled extraction.
4. **P2 — Least privilege and synthetic identities:** unique test accounts, least privilege, no real or reused credentials, and owner-approved role fixtures only.
5. **P2 — Backups and rollback:** clean snapshot/backup before testing; documented restoration owner and procedure.
6. **P2 — Evidence minimization:** redact secrets and personal data; store evidence locally with restricted access; set deletion date.
7. **P3 — Logging and remediation:** bounded audit logging, consistent timestamps, documented findings, and retest only after owner approval.

## Abuse-case boundaries

These are review scenarios, not permission to attack systems outside the inventory:

- A user attempts to call an application function without the required synthetic role.
- A user submits malformed or unexpected input to a documented application field using a small, bounded test set.
- A user requests a non-public synthetic record through the application and access is expected to be denied.
- An operator checks which deliberately enabled VM services are reachable from the host-only assessor interface, without scanning beyond the exact VM.
- An assessor checks that a prohibited external route is absent; do not send probes to external destinations.

## Residual risks and assumptions

- The exact web application, VM operating system, enabled services, application roles, storage components, and logging configuration were not provided. Asset-specific findings cannot be asserted until the owner documents these details.
- The inventory names RabTech lab as owner but does not identify an individual approver or emergency contact.
- The student-defined approved window must be converted to exact date/time and timezone before execution.
- Any change to IP, URL, VM network mode, owner, service, or test technique requires a reviewed inventory/ROE update before work resumes.
