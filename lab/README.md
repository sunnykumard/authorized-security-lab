# Local Lab Setup and Safety Checks

This lab uses OWASP Juice Shop as the intentionally vulnerable **LAB-01** web application behind an Nginx reverse proxy. The deployment pins Juice Shop to `v20.3.0`. See the [official Juice Shop running guide](https://pwning-juice-shop.github.io/companion-guide/latest/part1/running.html).

The GitHub repository supplies configuration and checks; it cannot start Docker or create a VM on your computer. Run the commands locally.

## Components and scope

| ID | Component | Address | Status |
|---|---|---|---|
| LAB-01 | OWASP Juice Shop | Container port 3000; reached via `http://127.0.0.1:8080` | Deployed locally |
| LAB-02 | Nginx reverse proxy | `127.0.0.1:8080` | Deployed locally |
| NET-01 | Internal Docker network | `authorized-lab-internal` | Configured |
| NET-02 | Proxy access bridge | `authorized-lab-proxy-access` | Configured |
| VM-01 | Separate vulnerable training VM | Proposed `192.168.56.20` | Not deployed or validated |

## Network architecture

- Juice Shop is attached only to `authorized-lab-internal`, configured with `internal: true`.
- Juice Shop port 3000 is exposed to the Docker network but is not published to the Windows host.
- Nginx is attached to both `authorized-lab-internal` and `authorized-lab-proxy-access`.
- Nginx publishes container port 8080 only on `127.0.0.1:8080`.
- `authorized-lab-proxy-access` is a standard bridge network, not an internal network. Do not attach Juice Shop to it.
- Do not change the host binding to `0.0.0.0`, publish additional ports, or add networks to Juice Shop.

## Requirements

- Windows 10/11 with Docker Desktop and Docker Compose.
- PowerShell 5.1 or later.
- Hardware virtualization only if you later deploy VM-01.
- An approved snapshot/backup and rollback plan before any authorized assessment.

## Start LAB-01 (Windows PowerShell)

From the repository root, start Docker Desktop manually and run:

```powershell
.\scripts\preflight.ps1
docker compose up -d
docker compose ps
docker compose logs --tail 50 juice-shop
docker compose logs --tail 50 lab-proxy
.\scripts\verify-lab.ps1
```

Open `http://127.0.0.1:8080`. Use synthetic accounts and data only. The application is deliberately vulnerable; do not expose it to a LAN, the internet or a public tunnel.

The preflight script validates the rendered Compose configuration. The runtime verification script checks the containers, network membership, port mappings, selected hardening settings and local HTTP response. Neither script performs vulnerability testing.

## Stop LAB-01

```powershell
docker compose down
```

Quit Docker Desktop when you are finished if you do not want it running. Do not use volume deletion flags unless you understand the data-loss effect.

## VM-01 setup (manual and currently out of scope)

No VM image is supplied by this repository. Do not download or boot an unverified image. Before any future use:

1. Obtain an intentionally vulnerable training image from its official publisher and verify its integrity.
2. Create a host-only virtual network in the hypervisor.
3. Attach the VM to that host-only network only. Do not use bridged networking, NAT, port forwarding or a second adapter.
4. Assign `192.168.56.20` only after confirming that the address belongs to the isolated host-only subnet and is unused.
5. Do not configure a default gateway or DNS server for the VM.
6. Take a clean snapshot and record its identifier and rollback operator.
7. Obtain written approval that explicitly adds VM-01 to the scope.

If host-only isolation cannot be established confidently, do not boot the VM for testing. The PowerShell scripts in this repository do not validate hypervisor network mode.

## Pre-assessment checklist

- [ ] Asset ownership and scope confirmed in writing.
- [ ] Signed Rules of Engagement and exact test window completed.
- [ ] LAB-01 proxy binding is only `127.0.0.1:8080`.
- [ ] Juice Shop has no published host port.
- [ ] Docker network reports `Internal: true` for `authorized-lab-internal`.
- [ ] Juice Shop is attached only to the internal network.
- [ ] Synthetic data and disposable identities are used.
- [ ] If VM-01 is separately approved: host-only mode, no gateway, no NAT, no bridged mode, no port forwarding, and approved snapshot are verified.
- [ ] Emergency contact and stop authority are available.

Do not conduct penetration tests until every approval and isolation condition is complete.

## Rollback

Stop the lab with `docker compose down`. Have the designated owner restore the approved VM snapshot and application/data backup if required. Remove disposable accounts and lab-only secrets as agreed. Record cleanup and evidence deletion dates.

## Engagement log template

| Timestamp (timezone) | Operator | Asset ID | Approved test case | Action summary | Result / evidence ID | Stop / escalation |
|---|---|---|---|---|---|---|
| | | | | | | |
