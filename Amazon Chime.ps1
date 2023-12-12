$SWPath = "$env:HOMEDRIVE\Software\Amazon\Chime.exe"
$SWDir = "$env:HOMEDRIVE\Software\Amazon\"
$app = "Amazon Chime"
$Download = "Setup URL"
<#
  Change the information above to fit your needs. Following this, everything should work.
  To Install the latest Version change the $Download to ('https://clients.chime.aws/win/latest') 
#>

$installed = ( Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $app } )
try {
  if (Test-Path $SWDir) {
    Write-Output "Directory Exists, proceeding with installer"
  }
    
  else {
    Write-Output "Creating $SWDir"
    New-Item -ItemType Directory -Path $SWDir
  }
} 
catch {
  Write-Output "Ran into an issue: $PSItem"
  Write-Output $PSItem.ScriptStackTrace
}
if (Test-Path $SWPath) { 
  Write-Output "File already downloaded... moving to installation." 
} 
else {
  Write-Output "Beginning $app Download..."
  Invoke-WebRequest -Uri $Download -OutFile $SWPath -UseBasicParsing -ErrorAction Stop 
}
If (-Not $installed) {
  Write-Output "Installing '$app' now."
    
  try {
    
    Invoke-Command -ScriptBlock { Start-Process $SWPath -ArgumentList "/verysilent /nas" -Wait } 
            
    If ( $installed) 
    { Write-Output "'$app' installed" }
    else 
    { Write-Output "App not installed. Something went wrong." }
  }
    
  catch
  { Write-Output $PSItem.ScriptStackTrace }
}
else { Write-Output "'$app' is installed." }
