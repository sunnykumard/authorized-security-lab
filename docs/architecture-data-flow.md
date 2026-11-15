
# Architecture and Data-Flow Documentation

## 1. Project Overview

Project: Authorized Security Lab  
Environment: Local Docker-based training environment  
Application: OWASP Juice Shop v20.3.0  
Reverse Proxy: Nginx  
Host Operating System: Windows  
Access URL: http://127.0.0.1:8080

## 2. Architecture Components

| Component | Identifier | Purpose |
|---|---|---|
| Windows Host | Local machine | Runs Docker Desktop and accesses the lab |
| Nginx Proxy | authorized-lab-proxy | Provides localhost-only application access |
| Juice Shop | authorized-lab-juice-shop | Intentionally vulnerable training application |
| Internal Network | authorized-lab-internal | Isolated application network |
| Proxy Network | authorized-lab-proxy-access | Connects the proxy to the host-published service |

## 3. Network Configuration

### Internal Network

- Name: authorized-lab-internal
- Driver: bridge
- Subnet: 172.19.0.0/16
- Gateway: 172.19.0.1
- Internal: true
- Connected containers:
  - authorized-lab-juice-shop
  - authorized-lab-proxy

### Proxy Access Network

- Name: authorized-lab-proxy-access
- Driver: bridge
- Subnet: 172.18.0.0/16
- Gateway: 172.18.0.1
- Internal: false
- Connected containers:
  - authorized-lab-proxy

## 4. Data Flow

1. The user accesses http://127.0.0.1:8080 from the Windows host.
2. Docker forwards the request to the Nginx proxy.
3. Nginx receives the request on port 8080.
4. Nginx forwards the request to http://juice-shop:3000.
5. Juice Shop processes the request.
6. The response returns through Nginx to the user's browser.

## 5. Security Boundaries

- Juice Shop has no published host port.
- Juice Shop is connected only to the internal Docker network.
- Nginx is the only container connected to both Docker networks.
- The host-published proxy port is bound to 127.0.0.1.
- The proxy-access network is not marked internal.
- No external or third-party targets are included in this lab scope.

## 6. Observed Validation Results

- Juice Shop container: Running
- Nginx container: Running
- Juice Shop port 3000: No host binding
- Nginx port 8080: Bound to 127.0.0.1
- HTTP response: 200 OK
- Internal Docker network: Internal=true
- Proxy access network: Internal=false
- Juice Shop membership in proxy access network: Not present

## 7. Limitations

- Docker network isolation does not independently prove host firewall isolation.
- Container IP addresses may change after recreation.
- The separate vulnerable VM at 192.168.56.20 has not yet been deployed or validated.
- This document records lab configuration, not authorization to conduct security testing.

## 8. Authorization Status

Security testing remains pending written authorization, signed Rules of Engagement, confirmed testing dates, and completed scope approval.
