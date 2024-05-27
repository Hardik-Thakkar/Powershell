##Trend Micro Uninstall Script

Write-Host "Beginning TrendMicro Uninstall Script - Setting RegEdits"
#Set up Registry Edits
$getArchitecture = (Get-WmiObject Win32_OperatingSystem).OSArchitecture

try{
if ($getArchitecture -eq "64-bit"){
	Write-Host "64-bit confirmed. Writing to registry as WOW6432Node."
reg add HKLM\Software\WOW6432Node\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v ConfirmUninstall /t REG_DWORD /d 00000001
reg add HKLM\Software\WOW6432Node\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v NoPwdProtect /t REG_DWORD /d 00000001
reg add HKLM\Software\WOW6432Node\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v AllowUninstall /t REG_DWORD /d 00000001
} elseif ($getArchitecture -eq "32-bit") {
Write-Host "32-bit confirmed. Writing to registry."
reg add HKLM\Software\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v ConfirmUninstall /t REG_DWORD /d 00000001
reg add HKLM\Software\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v NoPwdProtect /t REG_DWORD /d 00000001
reg add HKLM\Software\TrendMicro\PC-cillinNTCorp\CurrentVersion\Misc /v AllowUninstall /t REG_DWORD /d 00000001
} else {
	Write-Host "Unable to determine architecture. Check errors"
}} catch {
    Write-Output "Ran into an issue: $PSItem"
    Write-Output $PSItem.ScriptStackTrace
}

## Uninstall TrendMicro
Start-Process "\\dc1\ofcscan\AutoPcc.exe" -ArgumentList '/S', '/v', '/qn' 


