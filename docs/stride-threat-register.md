
# STRIDE Threat Model and Risk Register

## 1. Project Information

Project: Authorized Security Lab
Application: OWASP Juice Shop v20.3.0
Reverse Proxy: Nginx
Environment: Local Docker-based training environment
Host OS: Windows
Application URL: http://127.0.0.1:8080

Purpose:
Identify potential security threats, assess risks, and document
mitigations before conducting any authorized security assessment.

This document represents a theoretical threat assessment.
It does not confirm that any listed vulnerability exists.

---

## 2. Scope and Assets

| Asset ID | Asset | Description |
|---|---|---|
| LAB-01 | OWASP Juice Shop | Intentionally vulnerable web application |
| LAB-02 | Nginx Proxy | Local application access gateway |
| NET-01 | Internal Docker Network | Isolated application network |
| NET-02 | Proxy Access Network | Network connected to Nginx |
| HOST-01 | Windows Host | Runs Docker Desktop and browser |
| DATA-01 | Application Data | Training application data |
| LOG-01 | Container Logs | Application and proxy activity records |

Out of Scope:
- Public IP addresses and internet-facing systems
- University and campus networks
- Home and office networks
- Third-party applications and services
- Unlisted virtual machines
- Host OS and hypervisor penetration testing

---

## 3. Risk Assessment Methodology

Likelihood:
1 = Rare
2 = Unlikely
3 = Possible
4 = Likely
5 = Almost Certain

Impact:
1 = Negligible
2 = Minor
3 = Moderate
4 = Major
5 = Critical

Risk Score = Likelihood × Impact

Risk Classification:

| Score | Risk Level |
|---|---|
| 1–4 | Low |
| 5–9 | Medium |
| 10–16 | High |
| 17–25 | Critical |

Risk scores are preliminary estimates for planning.
They must be reassessed after controls are verified.

---

## 4. STRIDE Threat Register

### S — Spoofing

Threat ID: S-01

Affected Asset: LAB-01

Threat Scenario:
An unauthorized user attempts to impersonate a legitimate application user.

Potential Impact:
Unauthorized access to user-specific application functionality.

Likelihood: 3
Impact: 4
Risk Score: 12
Risk Level: High

Mitigations:
- Enforce appropriate authentication controls.
- Use secure session management.
- Validate authentication tokens.
- Protect session cookies.
- Avoid storing credentials in plaintext.

---

Threat ID: S-02

Affected Asset: LAB-02

Threat Scenario:
An unauthorized client attempts to access the application through an
untrusted or unintended network path.

Potential Impact:
Unauthorized access to the local training application.

Likelihood: 2
Impact: 4
Risk Score: 8
Risk Level: Medium

Mitigations:
- Bind the published proxy port to 127.0.0.1.
- Avoid publishing the Juice Shop port directly.
- Review Docker port mappings.
- Keep the lab environment restricted to authorized users.

---

### T — Tampering

Threat ID: T-01

Affected Asset: LAB-01, DATA-01

Threat Scenario:
An attacker modifies application data or submits unauthorized changes
through application requests.

Potential Impact:
Data integrity loss and unauthorized modification of application state.

Likelihood: 3
Impact: 4
Risk Score: 12
Risk Level: High

Mitigations:
- Apply server-side input validation.
- Enforce authorization checks.
- Validate business logic.
- Use appropriate database permissions.
- Maintain recoverable application data.

---

Threat ID: T-02

Affected Asset: LAB-02

Threat Scenario:
An unauthorized modification of reverse-proxy configuration changes
request routing or access restrictions.

Potential Impact:
Requests may be forwarded incorrectly or access restrictions weakened.

Likelihood: 2
Impact: 4
Risk Score: 8
Risk Level: Medium

Mitigations:
- Mount Nginx configuration as read-only.
- Restrict access to project configuration files.
- Review configuration changes.
- Maintain backups of known-good configuration.

---

### R — Repudiation

Threat ID: R-01

Affected Asset: LOG-01, LAB-01

Threat Scenario:
A user denies performing an action because application activity
cannot be reliably attributed or reconstructed.

Potential Impact:
Difficulty investigating incidents and establishing accountability.

Likelihood: 3
Impact: 3
Risk Score: 9
Risk Level: Medium

Mitigations:
- Enable appropriate application logging.
- Record relevant timestamps.
- Protect logs from unauthorized modification.
- Maintain a documented evidence-handling process.
- Redact sensitive information from collected evidence.

---

Threat ID: R-02

Affected Asset: LAB-02, LOG-01

Threat Scenario:
Proxy request records are incomplete or unavailable during an incident.

Potential Impact:
Difficulty tracing requests between the browser, proxy and application.

Likelihood: 3
Impact: 3
Risk Score: 9
Risk Level: Medium

Mitigations:
- Maintain appropriate Nginx access and error logs.
- Synchronize system time where practical.
- Record assessment activities.
- Retain evidence according to the approved retention policy.

---

### I — Information Disclosure

Threat ID: I-01

Affected Asset: LAB-01, DATA-01

Threat Scenario:
Sensitive application information becomes accessible to an unauthorized user.

Potential Impact:
Exposure of personal, account or application information.

Likelihood: 3
Impact: 5
Risk Score: 15
Risk Level: High

Mitigations:
- Apply access control to sensitive resources.
- Avoid storing unnecessary sensitive information.
- Redact secrets from logs.
- Use secure transport where required.
- Restrict access to application data.

---

Threat ID: I-02

Affected Asset: HOST-01, LAB-01

Threat Scenario:
Sensitive information is unintentionally exposed through container
logs, environment variables or configuration files.

Potential Impact:
Exposure of credentials, tokens or internal configuration details.

Likelihood: 3
Impact: 4
Risk Score: 12
Risk Level: High

Mitigations:
- Do not commit secrets to source control.
- Restrict access to configuration files.
- Review logs before sharing evidence.
- Use environment-specific secret management.
- Remove unnecessary sensitive information.

---

### D — Denial of Service

Threat ID: D-01

Affected Asset: LAB-01

Threat Scenario:
Excessive application requests consume available container resources.

Potential Impact:
Application slowdown or service unavailability.

Likelihood: 3
Impact: 4
Risk Score: 12
Risk Level: High

Mitigations:
- Configure CPU and memory limits.
- Establish request-rate limits.
- Monitor container health.
- Avoid stress testing without separate written approval.
- Maintain a safe shutdown procedure.

---

Threat ID: D-02

Affected Asset: LAB-02

Threat Scenario:
Proxy resource exhaustion prevents users from reaching the application.

Potential Impact:
Loss of access to the local training environment.

Likelihood: 2
Impact: 3
Risk Score: 6
Risk Level: Medium

Mitigations:
- Apply proxy container resource limits.
- Monitor proxy logs.
- Keep unnecessary services disabled.
- Restart the lab only through documented procedures.

---

### E — Elevation of Privilege

Threat ID: E-01

Affected Asset: LAB-01

Threat Scenario:
A user with limited application privileges obtains access to
administrative functionality.

Potential Impact:
Unauthorized access to privileged application operations.

Likelihood: 3
Impact: 5
Risk Score: 15
Risk Level: High

Mitigations:
- Enforce server-side role-based authorization.
- Validate permissions for sensitive operations.
- Apply least-privilege principles.
- Review administrative functionality.
- Monitor privilege-related events.

---

Threat ID: E-02

Affected Asset: LAB-01, LAB-02

Threat Scenario:
A compromised application container attempts to access resources
outside its intended container permissions or network boundary.

Potential Impact:
Unauthorized access to other containers or host resources.

Likelihood: 2
Impact: 5
Risk Score: 10
Risk Level: High

Mitigations:
- Drop unnecessary Linux capabilities.
- Enable no-new-privileges.
- Avoid privileged containers.
- Do not mount sensitive host directories.
- Keep the application on the internal Docker network.
- Review container permissions and network membership.

---

## 5. Prioritized Mitigation Plan

| Priority | Threat IDs | Recommended Action |
|---|---|---|
| 1 | I-01, E-01 | Review access control and authorization |
| 2 | E-02 | Review container isolation and privileges |
| 3 | T-01, I-02 | Protect application data and secrets |
| 4 | D-01, D-02 | Maintain resource limits and monitoring |
| 5 | S-01, S-02 | Review authentication and access boundaries |
| 6 | R-01, R-02 | Improve logging and evidence handling |
| 7 | T-02 | Protect configuration integrity |

---

## 6. Trust Boundaries

Boundary 1: Windows Host to Nginx Proxy
- Access through 127.0.0.1:8080.
- Proxy port is bound to localhost.

Boundary 2: Proxy Access Network
- Docker network: authorized-lab-proxy-access.
- Only Nginx is currently attached.

Boundary 3: Internal Application Network
- Docker network: authorized-lab-internal.
- Internal=true.
- Connects Nginx and Juice Shop.

Boundary 4: Application Data
- Application requests are processed by Juice Shop.
- Application data must remain within the approved lab scope.

---

## 7. Assumptions and Limitations

- Risk scores are preliminary and based on theoretical scenarios.
- No listed threat is confirmed as an exploitable vulnerability.
- No penetration test has been performed.
- The separate VM at 192.168.56.20 is not yet deployed or validated.
- Docker isolation does not independently establish complete host security.
- Threat scores must be updated following authorized validation.

---

## 8. Authorization Status

Security testing is NOT AUTHORIZED until:

1. Written authorization is obtained.
2. Rules of Engagement are signed.
3. Authorized assets are confirmed.
4. Testing dates and time windows are approved.
5. Emergency contacts and stopping conditions are documented.
6. Backups and recovery procedures are confirmed.

---

## 9. Review and Approval

Prepared By: __________________________

Reviewed By: __________________________

Authorized Approver: __________________

Date: _________________________________

Approval Status: Pending
