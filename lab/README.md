# Local Lab Setup and Safety Checks

This folder contains setup guidance only. It does not deploy, scan, or exploit any target.

## Required topology

- LAB-01 must bind to `127.0.0.1:8080` only.
- LAB-02 must use a private **host-only** virtual network and the inventory address `192.168.56.20`.
- Do not configure bridged networking, NAT, port forwarding, shared network adapters, or outbound routes.
- Use synthetic training data and disposable accounts only.

## Build sequence

1. Obtain the lab owner's written authorization in `../docs/rules-of-engagement.md`.
2. Obtain the approved training app and VM image from the lab owner. Verify their source and integrity using owner-provided hashes where available.
3. Create an isolated host-only virtual network with no gateway or external route. Do not attach an untrusted or production network.
4. Import the deliberately vulnerable VM and assign the inventory's static host-only address only after confirming no address conflict in the isolated lab.
5. Configure the training web app to listen only on loopback. Confirm that it is not exposed on a LAN interface.
6. Seed synthetic data and create only owner-approved disposable identities.
7. Take a clean VM snapshot and app/data backup. Record the snapshot identifier and rollback operator in the engagement log.
8. Verify the architecture checklist in `../docs/architecture-data-flow.md`.
9. Confirm the exact test window, operator, escalation contact, rate ceiling, and stop conditions with the owner.
10. Perform only the written-permission test cases. Record minimal evidence and stop at the first boundary violation.

## Isolation verification

Before each engagement window, visually inspect the VM network adapter settings and confirm host-only mode. Confirm no NAT, bridged adapter, port forwarding, VPN route, or shared route provides external connectivity. Confirm the app is bound to loopback.

Do not probe external IPs, scan the host machine, scan adjacent VM addresses, or test whether third-party systems are reachable. If isolation cannot be established confidently, do not start.

## Rollback

After testing, stop all test processes. Have the designated owner restore the VM snapshot and app/data backup if state changed. Remove disposable accounts and rotate/delete lab-only secrets as agreed. Verify that no background test process remains, and record the cleanup/deletion date.

## Engagement log template

| Timestamp (IST) | Operator | Asset ID | Approved test case | Action summary | Result / evidence ID | Stop / escalation |
|---|---|---|---|---|---|---|
| | | | | | | |
