
# Security Controls and Mitigation Mapping

## 1. Project Information

Project: Authorized Security Lab
Application: OWASP Juice Shop v20.3.0
Reverse Proxy: Nginx
Environment: Local Docker Lab
Assessment Type: Security Control Assessment

Purpose:
Document implemented, partially implemented, missing and
unverified security controls associated with the identified threats.

Important:
A control is not considered verified merely because it is
documented as a recommendation.

---

## 2. Control Status Definitions

| Status | Meaning |
|---|---|
| Implemented | Configuration or control has been verified |
| Partially Implemented | Some protection exists, but gaps remain |
| Not Implemented | Control is not currently configured |
| Not Verified | Evidence is insufficient to confirm implementation |
| Not Applicable | Control does not apply to this environment |

---

## 3. Network Security Controls

### NS-01: Localhost-Only Proxy Binding

Related Threats: S-02, I-01

Control:
Publish the Nginx proxy only on 127.0.0.1:8080.

Current Configuration:
127.0.0.1:8080:8080

Status: Implemented

Evidence:
Docker port inspection confirms:
8080/tcp -> 127.0.0.1:8080

---

### NS-02: Internal Application Network

Related Threats: S-02, E-02

Control:
Place Juice Shop on an internal Docker network.

Current Configuration:
Network: authorized-lab-internal
Internal: true

Status: Implemented

Evidence:
Docker network inspection confirms Internal=true.

---

### NS-03: Application Port Exposure

Related Threats: S-02, I-01

Control:
Prevent direct host publication of Juice Shop port 3000.

Status: Implemented

Evidence:
Docker inspection returned:
{"3000/tcp":null}

---

### NS-04: Proxy Network Separation

Related Threats: S-02, E-02

Control:
Connect Nginx to both networks while keeping Juice Shop
on the internal application network only.

Status: Implemented

Evidence:
- Nginx belongs to both Docker networks.
- Juice Shop belongs only to authorized-lab-internal.
- Juice Shop is absent from authorized-lab-proxy-access.

---

## 4. Container Security Controls

### CS-01: Linux Capability Restrictions

Related Threats: E-02

Control:
Drop unnecessary Linux capabilities from containers.

Configuration:
cap_drop:
  - ALL

Status: Configured; runtime verification pending.

Evidence Required:
Inspect container security configuration.

---

### CS-02: No New Privileges

Related Threats: E-02

Control:
Prevent processes from gaining additional privileges.

Configuration:
no-new-privileges:true

Status: Configured; runtime verification pending.

---

### CS-03: Resource Limits

Related Threats: D-01, D-02

Control:
Limit container CPU and memory consumption.

Juice Shop:
Memory: 768 MB
CPU: 1.0

Nginx:
Memory: 128 MB
CPU: 0.5

Status: Configured; runtime verification pending.

---

### CS-04: Read-Only Proxy Filesystem

Related Threats: T-02, E-02

Control:
Run the Nginx container with a read-only root filesystem.

Configuration:
read_only: true

Status: Configured; runtime verification pending.

Note:
Nginx temporary directories are provided through tmpfs.

---

## 5. Application Security Controls

### AS-01: Authentication

Related Threats: S-01

Control:
Verify that application authentication is enforced.

Status: Not Verified

Recommended Action:
Review authentication and session-management behaviour
during an approved assessment.

### AS-02: Authorization

Related Threats: E-01, T-01

Control:
Verify server-side authorization for protected operations.

Status: Not Verified

Recommended Action:
Review access-control requirements and application roles.

### AS-03: Input Validation

Related Threats: T-01

Control:
Validate application input on the server side.

Status: Not Verified

Recommended Action:
Review validation requirements and error handling.

### AS-04: Sensitive Data Protection

Related Threats: I-01, I-02

Control:
Prevent accidental disclosure of sensitive information.

Status: Not Verified

Recommended Action:
Review data handling, logs and configuration files.

---

## 6. Logging and Monitoring Controls

### LM-01: Application Logging

Related Threats: R-01

Control:
Maintain useful application activity logs.

Status: Not Verified

Recommended Action:
Review available application logs and timestamps.

### LM-02: Nginx Logging

Related Threats: R-02

Control:
Maintain proxy access and error logs.

Status: Not Verified

Recommended Action:
Verify log availability and retention.

### LM-03: Evidence Protection

Related Threats: R-01, R-02

Control:
Store assessment evidence securely and redact sensitive values.

Status: Policy Documented; Implementation Pending

Recommended Action:
Establish a local evidence directory with restricted access.

---

## 7. Backup and Recovery Controls

### BR-01: Recovery Procedure

Related Threats: T-01, D-01

Control:
Maintain a recovery procedure for the training environment.

Status: Not Verified

Recommended Action:
Document container restart and lab recovery procedures.

### BR-02: Application Data Backup

Related Threats: T-01

Control:
Maintain recoverable application data where required.

Status: Not Verified

Recommended Action:
Confirm whether persistent application data exists
and document the appropriate backup procedure.

---

## 8. Mitigation Priority

| Priority | Control Area | Action |
|---|---|---|
| P1 | Container Security | Verify capabilities and privileges |
| P1 | Application Security | Review authentication and authorization |
| P1 | Information Protection | Review sensitive data handling |
| P2 | Network Security | Maintain network separation |
| P2 | Logging | Verify application and proxy logs |
| P2 | Resource Management | Verify resource limits |
| P3 | Backup and Recovery | Document recovery procedures |
| P3 | Evidence Handling | Implement evidence storage procedures |

---

## 9. Overall Control Assessment

Network controls:
Implemented and supported by Docker inspection evidence.

Container controls:
Configuration documented; runtime verification pending.

Application controls:
Not yet verified.

Logging controls:
Not yet verified.

Backup and recovery:
Not yet verified.

Evidence handling:
Policy documented; implementation pending.

---

## 10. Authorization Status

No security testing is authorized by this document.

Testing requires:
1. Written authorization.
2. Signed Rules of Engagement.
3. Confirmed asset ownership and scope.
4. Approved testing window.
5. Emergency contact details.
6. Recovery and stopping procedures.

---

## 11. Approval

Prepared By: __________________________

Reviewed By: __________________________

Authorized Approver: __________________

Date: _________________________________

Approval Status: Pending
