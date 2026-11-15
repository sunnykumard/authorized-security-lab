# Run from the repository root in Windows PowerShell.
# Validates the local Docker/Compose configuration only.
# Does not run vulnerability tests or contact external targets.

$ErrorActionPreference = "Stop"

Write-Host "== Authorized Security Lab preflight =="

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker CLI not found. Install Docker Desktop and make it available in PATH."
}

docker version
if ($LASTEXITCODE -ne 0) { throw "Docker daemon is not available. Start Docker Desktop manually." }

docker compose version
if ($LASTEXITCODE -ne 0) { throw "Docker Compose plugin is unavailable." }

docker compose config --quiet
if ($LASTEXITCODE -ne 0) { throw "docker-compose.yml validation failed." }

$configJson = docker compose config --format json
if ($LASTEXITCODE -ne 0) { throw "Could not render Compose configuration as JSON." }

try {
    $config = $configJson | ConvertFrom-Json
} catch {
    throw "Could not parse rendered Compose configuration: $($_.Exception.Message)"
}

$juice = $config.services.'juice-shop'
$proxy = $config.services.'lab-proxy'
if (-not $juice) { throw "Missing juice-shop service." }
if (-not $proxy) { throw "Missing lab-proxy service. Expected the Nginx reverse-proxy architecture." }

if ($juice.ports -and @($juice.ports).Count -gt 0) {
    throw "STOP: Juice Shop must not publish a host port directly."
}
if (@($juice.expose) -notcontains "3000") {
    throw "Juice Shop must expose container port 3000 to its Docker network."
}

$proxyPort = @($proxy.ports | Where-Object {
    $_.host_ip -eq "127.0.0.1" -and
    [string]$_.published -eq "8080" -and
    [int]$_.target -eq 8080
})
if ($proxyPort.Count -ne 1) {
    throw "STOP: Nginx must publish container port 8080 only on 127.0.0.1:8080."
}

$juiceNetworks = @($juice.networks.PSObject.Properties.Name)
$proxyNetworks = @($proxy.networks.PSObject.Properties.Name)
if ($juiceNetworks -notcontains "isolated_lab" -or $juiceNetworks.Count -ne 1) {
    throw "Juice Shop must be connected only to isolated_lab."
}
if ($proxyNetworks -notcontains "isolated_lab" -or $proxyNetworks -notcontains "proxy_access") {
    throw "Nginx must connect to isolated_lab and proxy_access."
}
if ($config.networks.isolated_lab.internal -ne $true) {
    throw "STOP: isolated_lab must have internal: true."
}

Write-Host "PASS: Compose configuration is valid."
Write-Host "PASS: Juice Shop has no published host port."
Write-Host "PASS: Nginx is published only on 127.0.0.1:8080."
Write-Host "PASS: Juice Shop uses only the internal application network."
Write-Host ""
Write-Host "To start the local training application: docker compose up -d"
Write-Host "To verify the running lab: .\scripts\verify-lab.ps1"
Write-Host "This preflight validates configuration only; it does not authorize security testing."
