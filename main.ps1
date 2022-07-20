param($retryTimes = 1, $operation = 'helloWorld', $enableNotification = 'false')

# env start-------------------------------------------
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$env:tmpDir = $env:TEMP # on Windows
$env:errorAction = 'Stop'
$env:ignoreWarning = 'true'
$env:customEnvironmentVariable = "customEnvironmentVariable"
$env:workSpace = Get-Location
# env finish------------------------------------------

$ErrorActionPreference = $env:errorAction

$success = 'false'
$script = $env:workSpace + '/common/timestamp.ps1'
$startTime = & $script
for ($i = 0; $i -lt $retryTimes; $i++) {
    try {
        $script = $env:workSpace + '/' + $operation + '.ps1'
        & $script
        $success = 'true'
    }
    catch {
        Write-Output "an error occurred:"
        Write-Output $_
        Write-Output $_.ScriptStackTrace
    }
    finally {
        Set-Location $env:workSpace
    }
    if ($success -eq 'true') {
        Write-Output "max retry times: " + $retryTimes + ", actual retry times: " + $i
        break
    }
}

$script = $env:workSpace + '/common/timestamp.ps1'
$finishTime = & $script

if ($enableNotification -eq 'true') {
    $script = $env:workSpace + '/common/notify.ps1'
    if ($success -eq 'true') {
        $message = ('final success, resourece cost minutes: ' + ($finishTime - $startTime) / 60);
        & $script -type 'INFO' -message $message
    }
    else {
        $message = "final failed"
        & $script -type 'ERROR' -message $message
    }
    Write-Output $message
}

