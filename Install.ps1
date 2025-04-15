# Register .\MicrophoneLevelGuard.ps1 at Task Scheduler when user logs in once
# This script registers a scheduled task to run the MicrophoneLevelGuard script at user logon every time the user logs in.
# It ensures that the task is created only once and updates it if it already exists.
# The task is set to run with the highest privileges and is configured to start 2 minutes after logon.

# [
# Before starting make sure that the script has admin privileges and if not restart the script with admin privileges in the same directory.
$isAdmin = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
if (-not $isAdmin.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrative privileges. Restarting with elevated privileges..."
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit 1
}
# ]

$taskName = "MicrophoneLevelReset"
$taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$PSScriptRoot\MicrophoneLevelGuard.ps1`""
$taskDescription = "MicrophoneLevel script to maintain microphone volume level."
$taskTrigger = New-ScheduledTaskTrigger -AtLogOn 
$taskTrigger.Enabled = $true
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -DontStopOnIdleEnd
$taskSettings.ExecutionTimeLimit = "PT1H" # 1 hour
$taskSettings.DisallowStartIfOnBatteries = $false
$taskSettings.StartWhenAvailable = $true
$taskSettings.AllowHardTerminate = $true
$taskSettings.DisallowStartIfOnBatteries = $false
$taskSettings.StartWhenAvailable = $true

# Check if the task already exists
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host "Scheduled task '$taskName' already exists. Updating..."
    Set-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings
}
else {
    Write-Host "Creating scheduled task '$taskName'..."
    Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings -Description $taskDescription
}

Write-Host "Scheduled task '$taskName' has been successfully registered."

# Pause to see the output
Read-Host -Prompt "Press Enter to exit"
# End of script