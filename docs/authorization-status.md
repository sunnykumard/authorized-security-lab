# Authorization and Readiness Status

## 1. Project Details

Project: Authorized Security Lab  
Environment: Local Docker Training Lab  
Application: OWASP Juice Shop v20.3.0  
Reverse Proxy: Nginx  
Last user-supplied local validation date: 2026-11-15

## 2. Lab Deployment Status

| Component | Status |
|---|---|
| Docker Desktop | Installed; started manually for lab use |
| Juice Shop | Deployed; running at last reported validation |
| Nginx Proxy | Deployed; running at last reported validation |
| Internal Docker Network | Verified: Internal=true |
| Proxy Access Network | Verified: standard bridge, Internal=false |
| Localhost Port Binding | Verified: 127.0.0.1:8080 |
| Direct Juice Shop Host Port | Verified: no host binding |
| Application HTTP Response | Verified: HTTP 200 at last reported check |
| Separate VM-01 | Not deployed or validated |

Runtime status can change after containers are stopped or recreated. Re-run the verification script when starting the lab.

## 3. Security Configuration Status

| Control | Status |
|---|---|
| Juice Shop no-new-privileges | Verified |
| Juice Shop cap_drop ALL | Verified |
| Juice Shop memory limit 768 MiB | Verified |
| Nginx read-only filesystem | Verified |
| Nginx cap_drop ALL | Configured; runtime verification pending |
| Nginx added capabilities CHOWN, SETGID, SETUID | Configured; runtime verification pending |
| Nginx no-new-privileges | Configured; runtime verification pending |
| Nginx memory limit 128 MiB | Configured; runtime verification pending |
| CPU limits | Configured; runtime verification pending |
| Network separation | Verified |

## 4. Documentation Status

| Document | Status |
|---|---|
| Asset Inventory | Prepared; owner confirmation pending |
| Architecture and Data Flow | Prepared |
| STRIDE Threat Register | Prepared; theoretical risks only |
| Abuse Case Analysis | Prepared; hypothetical scenarios only |
| Security Controls Mapping | Prepared |
| Rules of Engagement | Draft; not signed |
| Evidence Handling Plan | Prepared |
| Evidence Register | Template only |
| Authorization Status | Current status documented |

## 5. Authorization Requirements

| Requirement | Status |
|---|---|
| Asset owner identity and ownership confirmation | Pending |
| Named authorized approver | Pending |
| Written authorization | Pending |
| Signed Rules of Engagement | Pending |
| Confirmed testing dates and time window | Pending |
| Timezone confirmation | Pending |
| Emergency and owner contacts | Pending |
| Recovery procedure approval | Pending |
| VM-01 deployment and isolation validation | Not applicable to current Docker-only setup; pending if VM is later proposed |

## 6. Current Authorization Decision

**NOT AUTHORIZED FOR SECURITY TESTING**

Reason: written approval and signed Rules of Engagement have not been obtained. Local deployment, configuration checks and repository documentation do not grant permission to perform security testing.

## 7. Conditions for Readiness

Before any security assessment:

1. Confirm the asset owner and exact assets in scope.
2. Obtain written authorization from an authorized approver.
3. Complete and sign the Rules of Engagement.
4. Confirm the test dates, times, timezone and authorized personnel.
5. Confirm emergency contacts and stop authority.
6. Approve recovery and evidence-retention procedures.
7. Re-run local configuration checks and preserve non-sensitive evidence.
8. Exclude VM-01 unless it is separately deployed, isolated and approved.

Prepared by: __________________________  
Reviewed by: __________________________  
Authorized approver: __________________  
Date: __________________________________
