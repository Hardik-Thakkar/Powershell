$hfcRMMdownload = "https://contoso.sharepoint.com/:u:/s/clients/EaF_oyjmqsJHiK0q4PEV8xEBOIKgoRTsCpv3HJx3-cGz8Q?download=1"
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
