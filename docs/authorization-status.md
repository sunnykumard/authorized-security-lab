# Authorization Status

**Status as of 2026-11-15: NOT AUTHORIZED TO TEST — approval fields are incomplete.**

The supplied inventory lists RabTech lab as the asset owner and identifies two permitted lab assets. The supplied Rules of Engagement template requires the lab owner, assessor, approved assets, approval date, exact permitted activities, test window, emergency contact, evidence handling, and stop conditions.

This repository contains a completed draft engagement dossier, but it does not create legal permission by itself. Before any security testing:

1. The authorized owner must verify ownership/control of LAB-01 and LAB-02.
2. A named owner/signatory and named assessor must complete and sign `rules-of-engagement.md`.
3. The exact start/end times, timezone, rate limits, and emergency contacts must be confirmed.
4. The owner must confirm the two inventory entries and approve any additional service details in writing.
5. The assessor must verify loopback and host-only isolation, synthetic data, and rollback snapshots.

Do not interpret the repository's presence, public visibility, or commit history as authorization. Do not test third-party assets or any target not listed in the approved inventory.
