# Run from the repository root in PowerShell.
# This script validates Docker/Compose availability and the compose configuration.
# It does NOT start security tests or contact any target.

$ErrorActionPreference = "Stop"

Write-Host "== Authorized Lab preflight =="

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker CLI not found. Install/start Docker Desktop, then rerun."
}

docker version
if ($LASTEXITCODE -ne 0) { throw "Docker daemon is not available." }

docker compose version
if ($LASTEXITCODE -ne 0) { throw "Docker Compose plugin is unavailable." }

docker compose config --quiet
if ($LASTEXITCODE -ne 0) { throw "docker-compose.yml validation failed." }

Write-Host "Compose configuration is valid."
Write-Host "Expected published binding: 127.0.0.1:8080 -> container:3000"
Write-Host "Expected Docker network: internal=true (no external routing from this container network)."
Write-Host ""
Write-Host "Before starting, confirm written authorization and complete docs/rules-of-engagement.md."
Write-Host "Then start only the local training app with: docker compose up -d"
