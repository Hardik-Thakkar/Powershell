    $softWarePath = "$env:HOMEDRIVE\Software\Microsoft\LAPS\LAPSx64.msi"
    $softWareDir = "$env:HOMEDRIVE\Software\Microsoft\LAPS"
    $app = "Local Administrator Password Solution"
    $downloadLink = "https://contoso.sharepoint.com/:u:/s/Software/EepcNXYCws5DsCC2KAAhUBoBBIUnJ7UfduRiJ78xn-kSKg?download=1"
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
#Check Installs
$installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null
If(-Not $installed32 -or $installed64) {
try{
Write-Output "Installing '$app' now."
     #EDITED FOR MSI
    msiexec /i C:\Software\Microsoft\LAPS\LAPSx64.msi /q
 #EDITED FOR MSI
 Start-Sleep -s 10
#Recheck Installs
$installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null
If($installed32 -or $installed64) {
Write-Host "'$app' is installed.";
} else {
Write-Host "'$app' is NOT installed."
}}
catch{Write-Output $PSItem.ScriptStackTrace}
} else { Write-Output "'$app' is installed. No errors"}
