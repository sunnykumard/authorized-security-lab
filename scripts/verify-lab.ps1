# Run after starting the lab, from the repository root in Windows PowerShell.
# Verifies Docker runtime configuration and the local HTTP endpoint only.
# It does not perform vulnerability testing.

$ErrorActionPreference = "Stop"

$juice = "authorized-lab-juice-shop"
$proxy = "authorized-lab-proxy"
$internalNetwork = "authorized-lab-internal"
$proxyNetwork = "authorized-lab-proxy-access"

function Get-DockerValue([string]$Container, [string]$Format) {
    $value = docker inspect $Container --format $Format
    if ($LASTEXITCODE -ne 0) { throw "Could not inspect container: $Container" }
    return $value
}

Write-Host "== Runtime verification =="

$running = docker compose ps --status running --services
if ($LASTEXITCODE -ne 0) { throw "Could not read Compose service status." }
if (@($running) -notcontains "juice-shop" -or @($running) -notcontains "lab-proxy") {
    throw "Both juice-shop and lab-proxy services must be running. Start with: docker compose up -d"
}

$juicePublished = docker port $juice 3000/tcp
if ($LASTEXITCODE -ne 0) { throw "Could not inspect Juice Shop port mapping." }
if ($juicePublished) { throw "STOP: Juice Shop port 3000 is published to the host: $juicePublished" }

$proxyPublished = docker port $proxy 8080/tcp
if ($LASTEXITCODE -ne 0) { throw "Could not inspect Nginx port mapping." }
if ($proxyPublished -notmatch '^127\.0\.0\.1:8080$') {
    throw "STOP: unexpected Nginx host binding: $proxyPublished"
}

$internal = docker network inspect $internalNetwork --format '{{.Internal}}'
if ($LASTEXITCODE -ne 0 -or $internal -ne "true") {
    throw "STOP: expected internal Docker network is missing or not internal."
}
$proxyInternal = docker network inspect $proxyNetwork --format '{{.Internal}}'
if ($LASTEXITCODE -ne 0 -or $proxyInternal -ne "false") {
    throw "Expected proxy access network is missing or has an unexpected setting."
}

$juiceNetworks = (Get-DockerValue $juice '{{json .NetworkSettings.Networks}}') | ConvertFrom-Json
$proxyNetworks = (Get-DockerValue $proxy '{{json .NetworkSettings.Networks}}') | ConvertFrom-Json
if (-not $juiceNetworks.PSObject.Properties.Name.Contains($internalNetwork) -or
    $juiceNetworks.PSObject.Properties.Name.Contains($proxyNetwork)) {
    throw "STOP: Juice Shop network membership is not restricted to the internal network."
}
if (-not $proxyNetworks.PSObject.Properties.Name.Contains($internalNetwork) -or
    -not $proxyNetworks.PSObject.Properties.Name.Contains($proxyNetwork)) {
    throw "Nginx must be attached to both expected networks."
}

# Verify Juice Shop hardening settings.
$juiceSecurity = Get-DockerValue $juice '{{json .HostConfig.SecurityOpt}}'
$juiceCaps = Get-DockerValue $juice '{{json .HostConfig.CapDrop}}'
$juiceMemory = [int64](Get-DockerValue $juice '{{.HostConfig.Memory}}')
if ($juiceSecurity -notmatch 'no-new-privileges:true') { throw "Juice Shop no-new-privileges is not enabled." }
if ($juiceCaps -notmatch '"ALL"') { throw "Juice Shop does not drop all Linux capabilities." }
if ($juiceMemory -ne 805306368) { throw "Unexpected Juice Shop memory limit: $juiceMemory" }

# Verify Nginx hardening settings.
$proxySecurity = Get-DockerValue $proxy '{{json .HostConfig.SecurityOpt}}'
$proxyCaps = Get-DockerValue $proxy '{{json .HostConfig.CapDrop}}'
$proxyCapAdd = Get-DockerValue $proxy '{{json .HostConfig.CapAdd}}'
$proxyMemory = [int64](Get-DockerValue $proxy '{{.HostConfig.Memory}}')
$proxyReadOnly = Get-DockerValue $proxy '{{.HostConfig.ReadonlyRootfs}}'
if ($proxySecurity -notmatch 'no-new-privileges:true') { throw "Nginx no-new-privileges is not enabled." }
if ($proxyCaps -notmatch '"ALL"') { throw "Nginx does not drop all Linux capabilities." }
foreach ($capability in @("CHOWN", "SETGID", "SETUID")) {
    if ($proxyCapAdd -notmatch $capability) { throw "Nginx is missing required capability: $capability" }
}
if ($proxyMemory -ne 134217728) { throw "Unexpected Nginx memory limit: $proxyMemory" }
if ($proxyReadOnly -ne "true") { throw "Nginx root filesystem is not read-only." }

$listener = Get-NetTCPConnection -State Listen -LocalPort 8080 -ErrorAction SilentlyContinue
if (-not $listener) { throw "No host listener found on port 8080." }
$unexpectedListener = $listener | Where-Object { $_.LocalAddress -ne "127.0.0.1" -and $_.LocalAddress -ne "::1" }
if ($unexpectedListener) { throw "STOP: port 8080 is listening on a non-loopback address." }

$statusCode = curl.exe -sS -o NUL -w "%{http_code}" --max-time 10 http://127.0.0.1:8080/
if ($LASTEXITCODE -ne 0 -or $statusCode -ne "200") {
    throw "Nginx did not return HTTP 200 from the local Juice Shop endpoint. Received: $statusCode"
}

Write-Host "PASS: both containers are running."
Write-Host "PASS: Juice Shop has no published host port and uses only the internal network."
Write-Host "PASS: Nginx is bound to 127.0.0.1:8080 and attached to both expected networks."
Write-Host "PASS: Juice Shop and Nginx hardening settings match the expected configuration."
Write-Host "PASS: local application returned HTTP 200."
Write-Host "LAB-02 VM isolation is not checked by this script and remains a separate manual review."
Write-Host "These checks validate configuration only; they do not authorize security testing."
