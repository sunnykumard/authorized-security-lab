
# Evidence Collection and Handling Plan

## 1. Purpose

Define how evidence will be collected, stored, documented,
protected and retained during an authorized security assessment.

## 2. Evidence Collection Principles

- Collect only evidence necessary for the approved assessment.
- Do not collect real personal or sensitive information.
- Do not collect credentials or session tokens unnecessarily.
- Redact sensitive information before sharing evidence.
- Preserve original evidence where practical.
- Do not modify original evidence files.
- Maintain an evidence register.

## 3. Evidence Types

| Evidence ID | Type | Example |
|---|---|---|
| EV-01 | Configuration | Docker Compose configuration |
| EV-02 | Network | Docker network inspection output |
| EV-03 | Container | Docker security inspection output |
| EV-04 | Application | Relevant application response |
| EV-05 | Logs | Nginx and Juice Shop logs |
| EV-06 | Documentation | Threat model and assessment report |
| EV-07 | Screenshot | Relevant lab configuration screenshot |

## 4. Evidence Directory Structure

evidence/
    README.md
    screenshots/
    logs/
    configurations/
    network/
    reports/
    evidence-register.csv

## 5. Evidence Register

Each evidence item must record:

- Evidence ID
- Filename
- Collection date and time
- Asset ID
- Collection method
- Description
- Collector
- Sensitivity classification
- SHA-256 hash, where appropriate
- Storage location

## 6. Evidence Integrity

Where appropriate, calculate a SHA-256 hash.

Example PowerShell command:

Get-FileHash .\evidence\filename.txt -Algorithm SHA256

Record the resulting hash in the evidence register.

Do not alter original evidence after hashing.
If redaction or annotation is required, save a separate copy.

## 7. Access Control

- Store evidence in the local project directory.
- Restrict access to authorized project personnel.
- Do not commit sensitive evidence to public GitHub repositories.
- Do not upload confidential evidence to public file-sharing services.
- Keep credentials and tokens out of evidence.

## 8. Retention and Disposal

Proposed retention period: 30 days after owner acceptance.

The final retention period must be confirmed by the asset owner.

After the approved retention period:
- Confirm that evidence is no longer required.
- Obtain approval where required.
- Securely delete evidence according to the owner's policy.
- Document the disposal date.

## 9. Incident Handling

If evidence contains unexpected sensitive information:

1. Stop the relevant activity.
2. Avoid further access or copying.
3. Secure the material.
4. Notify the authorized owner.
5. Follow the approved incident-handling process.

## 10. Authorization

Evidence collection for a security assessment must follow
the signed Rules of Engagement.

No unauthorized security testing or evidence collection is permitted.

Prepared By: __________________________

Reviewed By: __________________________

Approval Status: Pending
