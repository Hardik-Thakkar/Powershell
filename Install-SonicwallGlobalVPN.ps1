$softWarePath = "$env:HOMEDRIVE\Software\Sonicwall\SWGBVPN.exe"
$softWareDir = "$env:HOMEDRIVE\Software\Sonicwall\"
$app = "Global VPN CLient"
$downloadLink ="https://rightclickinc.sharepoint.com/:u:/s/Software/EWrqD23HYI1HrskD0xrojYoBKT7MdZ_B7TX-2rxb6uNzRw?download=1"
<#
    Change the information above to fit your needs. Following this, everything should work.
#>

$installed32 = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})
$installed64 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})

if (($installed32 -eq $true) -or ($installed64 -eq $true)) {
$uninstApp = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq $app}
try{
$uninstApp.Uninstall()
} catch {
Write-Output "Error returned: $PSItem"
Write-Output "$PSItem.ScriptStackTrace"
}
if((Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq "$app"}) -eq $false){
        Write-Output "Successfully uninstalled $app (or it's not installed)"}
        else { Write-Output "Something went wrong here, the app is still installed"}
        }
try{
    if (Test-Path $softWareDir) {
        Write-Output "Directory Exists, proceeding with installer"
        }
    else {
        Write-Output "Creating $softWareDir"
        New-Item -ItemType Directory -Path $softWareDir}
} catch {
    Write-Output "Ran into an issue: $PSItem"
    Write-Output $PSItem.ScriptStackTrace
        }
if (Test-Path $softWarePath){
    Write-Output "File already downloaded... moving to installation."
    } else { 
Write-Output "Beginning $app Download..."

Invoke-WebRequest -Uri $downloadLink -OutFile $softWarePath -UseBasicParsing -ErrorAction Stop
}

Write-Host "Beginning $app Install"
$installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null
If(-Not $installed32 -or $installed64) {
try{
Write-Output "Installing '$app' now."
Start-Process $softWarePath -ArgumentList "/q" -Wait -Verb RunAs -PassThru
##Recheck Installation
$installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null

If(-Not $installed32 -or $installed64) {
Write-Host "'$app' NOT is installed.";
} else {
Write-Host "'$app' is installed."
}}
catch{Write-Output $PSItem.ScriptStackTrace}
} else { Write-Output "'$app' is installed."}