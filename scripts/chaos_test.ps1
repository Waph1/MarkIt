$packageName = "com.waph1.markit"
$eventCount = 500
$logFile = "monkey_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

Write-Host "Starting Chaos Test (Monkey) on $packageName with $eventCount events..."
Write-Host "Logging to $logFile"

# Run monkey and tee output to file
# -p packageName: target package
# -v -v -v: verbose output
# --throttle 100: delay between events in ms
# -s 1234: seed (optional, for reproducibility)
# --ignore-crashes --ignore-timeouts: continue even if app crashes (optional, remove to stop on crash)
$adbPath = "C:\Android\Sdk\platform-tools\adb.exe"

# Check if adb exists
if (-not (Test-Path $adbPath)) {
    Write-Error "ADB not found at $adbPath. Please check your Android SDK installation."
    exit 1
}

& $adbPath shell monkey -p $packageName -v -v -v 500 | Tee-Object -FilePath $logFile

Write-Host "Test complete. Check $logFile for details."
