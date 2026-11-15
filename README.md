# Authorized Security Lab — Engagement Dossier

**Status:** Prepared for owner review; authorization is not effective until the approval fields in [Rules of Engagement](docs/rules-of-engagement.md) are completed and signed.

This repository documents a deliberately isolated training engagement. Testing is limited to the two assets enumerated in [the asset inventory](inventory/authorized-lab-assets.csv). The inventory is the source of truth: if an address, service, identity, or dependency is not explicitly listed and approved, it is out of scope.

## Dossier contents

- [Asset inventory](inventory/authorized-lab-assets.csv) — approved targets, owners, network context, exclusions, and evidence classification.
- [Lab architecture and data-flow](docs/architecture-data-flow.md) — trust boundaries, identities, data classes, and permitted flows.
- [STRIDE threat register](docs/stride-threat-register.md) — abuse cases, likelihood/impact ranking, and mitigations.
- [Rules of Engagement](docs/rules-of-engagement.md) — authorization, permitted methods, timing, evidence handling, escalation, and stop conditions.
- [Lab setup and validation](lab/README.md) — safe local environment guidance and checks before any test.
- [Authorization status](docs/authorization-status.md) — outstanding approval gate.

## Scope at a glance

| ID | Approved asset | Address | Boundary |
|---|---|---|---|
| LAB-01 | Local training web app | `http://127.0.0.1:8080` | Localhost only |
| LAB-02 | Deliberately vulnerable VM | `192.168.56.20` | Private host-only network only |

**Explicitly out of scope:** public IPs, third-party systems, cloud accounts, campus/university networks, home/office networks, unrelated VMs, host operating system and hypervisor except where needed to manage the lab, and any target not listed in the inventory.

## Approval gate

Do not start security testing until the lab owner and assessor have completed and signed the written authorization; named contacts and test window are recorded; the VM is confirmed host-only with no bridged/NAT route to external networks; snapshots/backups exist; and all out-of-scope exclusions are acknowledged.

## Safety principles

- No denial of service, destructive payloads, persistence, credential reuse, uncontrolled data extraction, or outbound traffic.
- Use synthetic accounts and synthetic data only.
- Keep test traffic within the approved lab.
- Capture the minimum evidence required; redact secrets and personal data.
- Stop immediately on scope uncertainty, unexpected access to non-lab systems/data, instability, or a request from the owner.

## Document control

- Prepared: 2026-11-15
- Owner / author: **To be confirmed by repository owner**
- Approval date and signatures: **Pending**
- Review before each engagement and after any inventory or architecture change.
