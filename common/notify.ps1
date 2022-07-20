param($type, $message, $expireSeconds = 30)

$ws = New-Object -ComObject WScript.Shell
$ws.popup($message, $expireSeconds, $type, 1 + 64)