# Run after starting the lab, from the repository root in PowerShell.
# Checks only the local Docker container/network and localhost listener.

$ErrorActionPreference = "Stop"

$container = "authorized-lab-juice-shop"
$network = "authorized-lab-internal"

docker inspect $container --format '{{json .NetworkSettings.Ports}}'
if ($LASTEXITCODE -ne 0) { throw "Container not found. Start it with: docker compose up -d" }

docker network inspect $network --format '{{.Name}} internal={{.Internal}}'
if ($LASTEXITCODE -ne 0) { throw "Expected isolated Docker network not found." }

$internal = docker network inspect $network --format '{{.Internal}}'
if ($internal -ne "true") { throw "STOP: Docker network is not marked internal." }

$binding = docker port $container 3000/tcp
if ($binding -notmatch '^127\.0\.0\.1:8080$') {
    throw "STOP: unexpected published binding: $binding"
}

$listener = Get-NetTCPConnection -State Listen -LocalPort 8080 -ErrorAction SilentlyContinue
if (-not $listener) { throw "No localhost listener found on port 8080." }

$bad = $listener | Where-Object { $_.LocalAddress -ne "127.0.0.1" -and $_.LocalAddress -ne "::1" }
if ($bad) { throw "STOP: port 8080 is listening on a non-loopback address." }

Write-Host "PASS: container network is internal and port 8080 is loopback-only."
Write-Host "Open http://127.0.0.1:8080 in your browser."
Write-Host "This verifies only LAB-01. LAB-02 VM isolation remains a separate manual check."
