function InstallLaps{  
Write-Host "Installing LAPS"  
    $softWarePath = "$env:HOMEDRIVE\Software\Microsoft\LAPS\LAPSx64.msi"
    $softWareDir = "$env:HOMEDRIVE\Software\Microsoft\LAPS"
    $app = "Local Administrator Password Solution"
    $downloadLink = "https://rightclickinc.sharepoint.com/:u:/s/Software/EepcNXYCws5DsCC2KAAhUBoBBIUnJ7UfduRiJ78xn-kSKg?download=1"
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
If(-Not $installed32 -or -Not $installed64) {
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
}

function InstallCrowdStrike {
Write-Host "Installing Crowdstrike"
   # Update these variables as needed
$CID = "F89D36CF691E4FF4B4F0DE233B9965AA-14"
$SensorShare = "https://rightclickinc-my.sharepoint.com/:u:/g/personal/stephon_rclick_com/EVc0_6R9b9lKnv37fQvZyxYBvNHREBZCo2hoOJNANShpLQ?download=1"

# The sensor is copied to the following directory
$SensorLocal = "C:\Temp\WindowsSensor.MaverickGyr.exe"

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path 'C:\Temp' -ErrorAction SilentlyContinue)) {

    New-Item -ItemType Directory -Path 'C:\Temp' -Force

}
# Now copy the sensor installer if the share is available
if (Test-Path -Path 'C:\Temp') {
    
    Invoke-WebRequest -Uri $SensorShare -OutFile $SensorLocal

}
# Now check to see if the service is already present and if so, don't bother running installer.
if (!(Get-Service -Name 'CSFalconService' -ErrorAction SilentlyContinue)) {

    Invoke-Command -ScriptBlock {& $SensorLocal /install /quiet /norestart CID=$CID}

}
 
}

function InstallSonicwallVPN {
Write-Host "Installing Sonicwall VPN"
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
}

function InstallMERMM {
   $hfcRMMdownload = "https://rightclickinc.sharepoint.com/:u:/s/clients/EaF_oyjmqsJHiK0q4PEV8xEBOIKgoRTsCpv3HJx3-cGz8Q?download=1"
$dtExtPath = "$env:SystemDrive\MERMM\"
$scriptPath = "$env:SystemDrive\MERMM\Irvine\directsetup\setup_auto2.bat"
$zipPath = "$env:SystemDrive\MERMM\Irvine.zip"
$app = "RMM"

#Add Function to Unzip Application
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipPath, [string]$dtExtPath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $dtExtPath)
}

if (Test-Path $zipPath) {
    Write-Host "File Exists, moving to Unzipping stage"
}
else {
    try{
        if (Test-Path $dtExtPath) {
            Write-Host "Directory Exists, beginning download of $app"
            Invoke-WebRequest -Uri $hfcRMMdownload -UseBasicParsing -OutFile $zipPath -ErrorAction Stop
            Write-Output "Download successful, beginning unzipping and installation process"
    
        }else {
            Write-Host "Creating Directory for $app"
            New-Item -ItemType Directory -Path $dtExtPath -ErrorAction Stop
            Invoke-WebRequest -Uri $hfcRMMdownload -UseBasicParsing -OutFile $zipPath -ErrorAction Stop
            Write-Output "Download successful, beginning unzipping and installation process"
    
    }} catch {
       Write-Output "Something went wrong with the download..."
       Write-Output $PSItem.Exception
       Write-Output $PSItem.ScriptStackTrace
    }
}

if (Test-Path $zipPath) {
    try{
        Write-Host "Beginning unzipping proccess"
        Unzip $zipPath $dtExtPath
    }
    catch {
       Write-Output "Something went wrong while unzipping.."
       Write-Output $PSItem.Exception
       Write-Output $PSItem.ScriptStackTrace
    }
} else {
    Write-Output "Unzipped files already exists, proceeding to install"
    continue 
    }

#Begin Installer
try {
$error.clear()
  try{
    & $scriptPath
    Write-Output "RMM Successfully Installed"}
    catch {Write-Host "$PSItem"
           Write-Host "$PSItem.ScriptStackTrace"
           $error=True}
} catch {
   Write-Output "Something went wrong with the install"
   Write-Output $PSItem.Exception
   Write-Output $PSItem.ScriptStackTrace
} 
}

function UninstallTrendMicro {
Write-Host "Uninstalling TrendMirco"
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
Start-Process "\\hfchqrole1\ofcscan\AutoPcc.exe" -ArgumentList '/S', '/v', '/qn' 
}

#Check Installs for Apps
function CheckSWInstall {
    $app = "Global VPN CLient"
    $installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
    $installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null
    If(-Not $installed32 -or $installed64) {
        Write-Host "'$app' NOT is installed.";
        Write-Host "$app Not Found. Beginning installation"
        InstallSonicwallVPN
    } else {
    Write-Host "'$app' is installed."
    return $true
    }}

function CheckCrowdStrike {
$app = "CrowdStrike Windows Sensor"
$installed32 = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})
$installed64 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})

 If ($installed32 -or $installed64) { Write-Output "'$app' installed"}
        else{ Write-Output "$app not installed. Moving to installation process"
              InstallCrowdStrike 
        }
}

function CheckMERMM {
$app = "ManageEngine Desktop Central - Agent"
$installed32 = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})
$installed64 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})

 If ($installed32 -or $installed64) { Write-Output "'$app' installed"}
        else { Write-Output "$app not installed. Moving to installation process."
               InstallMERMM
        }
}

function CheckLAPS {
$app = "Local Administrator Password Solution"
#Recheck Installs
$installed32 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app}) -ne $null
$installed64 = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -match $app}) -ne $null
If($installed32 -or $installed64) {
Write-Host "'$app' is installed.";
} else {
Write-Host "'$app' is NOT installed. Moving to Installation"
InstallLaps
}
}

function CheckTrendMicro {
$app = "Trend Micro OfficeScan Agent"
$installed32 = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})
$installed64 = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -match $app})

 If ($installed32 -or $installed64) { 
 Write-Output "'$app' installed. Moving to uninstallation. Checking if VPN is installed."
 If(CheckSWInstall -eq $true){
    Write-Host "Sonicwall VPN Installed. Please connect to the HFC VPN (vpn.gohfc.com), then press enter once connected."
    Write-Host "Note: If the computer is on-site at HFC Irvine and connected to the corporate network, there is no need for the VPN."
    pause
    UninstallTrendMicro
    }else{
    Write-Host "Sonicwall VPN not installed. Beginning Installation Process"
    InstallSonicwallVPN
    Write-Host "When installation is successful, please connect to the HFC VPN (vpn.gohfc.com), then press enter once connected."
    Write-Host "Note: If the computer is on-site at HFC Irvine and connected to the corporate network, there is no need for the VPN."
    pause
    UninstallTrendMicro
    }}
        else { Write-Output "$app not installed."}

}

function main{
  Start-Transcript -Path "$env:HOMEDRIVE\2021RefreshLog.txt" -ErrorAction SilentlyContinue
  Write-Host "Beginning HFC Desktop Refresh 2021... Performing Checks"
  CheckMERMM
  CheckLAPS 
  CheckCrowdStrike
  CheckTrendMicro
  Write-Host "Almost done. Any uninstallation will continue to run in the background."
  sleep 15
  Write-Host "Technician: Please check installations in Control Panel to ensure applications are installed/removed. Run individual scripts if necessary."
  pause
  Stop-Transcript
}

main