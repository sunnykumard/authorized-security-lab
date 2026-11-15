# Local Lab Setup and Safety Checks

This lab uses OWASP Juice Shop as the intentionally vulnerable **LAB-01** web application. The official project documents its Docker image and local usage; this repository pins the deployment to image tag `v20.3.0` for repeatability. See the [official running guide](https://pwning-juice-shop.github.io/companion-guide/latest/part1/running.html).

This folder contains configuration and preflight scripts. The GitHub repository cannot start Docker or create a VM on your personal computer. Run the commands below locally.

## Components and scope

| ID | Component | Address | Status |
|---|---|---|---|
| LAB-01 | OWASP Juice Shop container | `http://127.0.0.1:8080` | Compose configuration supplied; local startup pending |
| LAB-02 | Deliberately vulnerable VM | `192.168.56.20` | Manual VM setup pending; use only an owner-approved training image |

The Compose network is marked `internal: true`, and the host port is explicitly bound to `127.0.0.1`. This restricts access to the local host and prevents the container network from routing externally. Do not change the binding to `0.0.0.0`, publish additional ports, or attach the container to another network.

## Requirements

- Windows 10/11 with Docker Desktop and the Docker Compose plugin, or a compatible Docker Engine/Compose installation.
- Hardware virtualization enabled if you will also run LAB-02 in VirtualBox.
- A clean snapshot/backup plan.
- Completed written authorization in `../docs/rules-of-engagement.md` before security testing.

## Start LAB-01 (Windows PowerShell)

From the repository root:

```powershell
# Validate Docker and the Compose configuration
.\scripts\preflight.ps1

# Start the intentionally vulnerable app
docker compose up -d

# View startup logs
docker compose logs --tail 50 juice-shop

# Verify loopback binding and internal Docker network
.\scripts\verify-lab.ps1
```

Then open `http://127.0.0.1:8080`. Use only synthetic accounts and data. The app is deliberately vulnerable; do not expose it to a LAN, the internet, or a public tunnel.

To stop it:

```powershell
docker compose down
```

To remove the local container and network, use `docker compose down`. Do not use volume deletion flags unless you understand the data-loss effect.

## LAB-02 VM setup (manual)

No VM image was supplied, so this repository does not download or boot an unverified image. Obtain an intentionally vulnerable training VM from its official publisher and verify its integrity before import. Configure it as follows:

1. Create a **host-only** virtual network in your hypervisor.
2. Attach the VM to that host-only network only. Do not use bridged networking, NAT, port forwarding, or a second adapter.
3. Assign `192.168.56.20` only after confirming that this address belongs to the isolated host-only subnet and is not already in use.
4. Do not configure a default gateway or DNS server for the VM.
5. Keep the VM powered off until its image source, network settings, owner approval, and rollback snapshot are confirmed.
6. Take a clean snapshot and record its identifier and the rollback operator.
7. Do not test the hypervisor, host OS, host-only gateway, or any adjacent address.

If you cannot establish host-only isolation confidently, do not boot the VM for testing. LAB-02 is not considered validated merely because its IP address is configured.

## Pre-test validation

- [ ] Signed Rules of Engagement and exact test window are complete.
- [ ] LAB-01 is bound only to `127.0.0.1:8080`.
- [ ] Docker network reports `Internal: true`.
- [ ] LAB-01 uses only synthetic data and disposable identities.
- [ ] LAB-02 uses one host-only adapter only, with no gateway, NAT, bridged mode, or port forwarding.
- [ ] LAB-02 address matches the approved inventory.
- [ ] Snapshots/backups and rollback operator are recorded.
- [ ] Emergency contact and stop authority are available.

The PowerShell verification script validates LAB-01 only. LAB-02's hypervisor network mode must be inspected manually. Do not run penetration tests until every approval and isolation check is complete.

## Rollback

After an exercise, stop test processes and run `docker compose down`. Have the designated owner restore the VM snapshot and app/data backup if state changed. Remove disposable accounts and rotate/delete lab-only secrets as agreed. Record cleanup and evidence deletion dates.

## Engagement log template

| Timestamp (IST) | Operator | Asset ID | Approved test case | Action summary | Result / evidence ID | Stop / escalation |
|---|---|---|---|---|---|---|
| | | | | | | |
