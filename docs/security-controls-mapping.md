# Security Controls and Mitigation Mapping

## 1. Project Information

Project: Authorized Security Lab  
Application: OWASP Juice Shop v20.3.0  
Reverse Proxy: Nginx  
Environment: Local Docker Lab  
Assessment Type: Configuration and Control Review

A control is marked verified only when a runtime output or other evidence supports that status. Configuration text alone is not proof of runtime enforcement.

## 2. Status Definitions

| Status | Meaning |
|---|---|
| Verified | Runtime/configuration evidence was inspected |
| Configured; not yet verified | Declared in Compose but runtime evidence is pending |
| Not Verified | No sufficient evidence |
| Not Implemented | Known not to be configured |
| Not Applicable | Does not apply to this environment |

## 3. Network Security Controls

### NS-01: Localhost-Only Proxy Binding

Related threats: S-02, I-01  
Configuration: `127.0.0.1:8080:8080`  
Status: Verified

Evidence supplied on 2026-11-15:
`docker port authorized-lab-proxy` returned `8080/tcp -> 127.0.0.1:8080`.

### NS-02: Internal Application Network

Related threats: S-02, E-02  
Configuration: `authorized-lab-internal`, `internal: true`  
Status: Verified

Evidence supplied on 2026-11-15: Docker network inspection returned `"Internal": true`.

### NS-03: No Direct Juice Shop Host Port

Related threats: S-02, I-01  
Status: Verified

Evidence supplied on 2026-11-15:
`docker inspect authorized-lab-juice-shop --format '{{json .NetworkSettings.Ports}}'`
returned `{"3000/tcp":null}`.

### NS-04: Network Separation

Related threats: S-02, E-02  
Status: Verified

Evidence supplied on 2026-11-15: the internal network contained Juice Shop and Nginx; the proxy access network contained Nginx only.

## 4. Container Security Controls

### CS-01: Linux Capability Restrictions

Related threat: E-02

- Juice Shop: `cap_drop: [ALL]` — Verified from runtime inspection.
- Nginx: `cap_drop: [ALL]` — Configured in the repository Compose file; runtime output still required.

Nginx additionally requires the explicitly added `CHOWN`, `SETGID` and `SETUID` capabilities for the current read-only Nginx startup configuration. These additions must be checked against the runtime configuration.

### CS-02: No New Privileges

Related threat: E-02

- Juice Shop: `no-new-privileges:true` — Verified from runtime inspection.
- Nginx: Configured in Compose; runtime output still required.

### CS-03: Resource Limits

Related threats: D-01, D-02

- Juice Shop memory: 768 MiB — Verified (805306368 bytes).
- Nginx memory: 128 MiB — Configured; runtime output still required.
- CPU limits: Juice Shop 1.0 CPU and Nginx 0.5 CPU — Configured; runtime verification still required.

### CS-04: Read-Only Proxy Filesystem

Related threats: T-02, E-02

- Nginx `read_only: true` — Verified from runtime inspection.
- Nginx temporary writable paths are provided through tmpfs.

## 5. Application Security Controls

| Control | Related threats | Status |
|---|---|---|
| Authentication and session management | S-01 | Not Verified |
| Server-side authorization | E-01, T-01 | Not Verified |
| Input validation | T-01 | Not Verified |
| Sensitive data protection | I-01, I-02 | Not Verified |

These controls require a separately approved application assessment. This repository review did not test them.

## 6. Logging and Monitoring

| Control | Related threats | Status |
|---|---|---|
| Juice Shop application logging | R-01 | Not Verified |
| Nginx access/error log availability and retention | R-02 | Not Verified |
| Evidence storage and access restriction | R-01, R-02 | Policy documented; operational verification pending |

## 7. Backup and Recovery

| Control | Related threats | Status |
|---|---|---|
| Container/lab recovery procedure | T-01, D-01 | Procedure documented; recovery drill not verified |
| Application data backup | T-01 | Not Verified; confirm whether persistent data is in use |

## 8. Mitigation Priorities

| Priority | Control Area | Action |
|---|---|---|
| P1 | Container security | Complete Nginx runtime verification |
| P1 | Application security | Assess authentication and authorization only after approval |
| P1 | Information protection | Review sensitive data handling only after approval |
| P2 | Network security | Preserve loopback binding and network separation |
| P2 | Logging | Verify log availability and retention |
| P2 | Resource management | Verify CPU and memory runtime limits |
| P3 | Backup and recovery | Document and approve a recovery procedure |
| P3 | Evidence handling | Implement restricted local evidence storage |

## 9. Overall Assessment

- Network topology: Verified from user-provided Docker inspection outputs.
- Juice Shop selected hardening settings: Verified.
- Nginx read-only filesystem: Verified.
- Nginx capabilities, no-new-privileges and memory limit: Runtime verification pending.
- CPU limits: Runtime verification pending.
- Application security, logging and backup controls: Not verified.
- Authorization: Pending; security testing is NOT AUTHORIZED.

## 10. Approval

Prepared by: __________________________  
Reviewed by: __________________________  
Authorized approver: __________________  
Date: __________________________________  
Approval status: Pending
