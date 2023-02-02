# This will not work on Windows Version 20H2 or 2004 

$SWPath = "C:\Util\kb5001567.msu"
$SWDir = "C:\Util"
$UD = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2021/03/windows10.0-kb5001567-x64_e3c7e1cb6fa3857b5b0c8cf487e7e16213b1ea83.msu"
$update = "KB5001567"
$installed = Get-Hotfix -Id 5000802 $update

try{
    if (Test-Path $SWDir) 
    {
        Write-Output "Directory Exists, proceeding with KB5001566 Update"
    }  
    else 
    {
        Write-Output "Creating $SWDir"
        New-Item -ItemType Directory -Path $SWDir
    }
   } 
    catch 
    {
     Write-Output "Ran into an issue: $PSItem"
     Write-Output $PSItem.ScriptStackTrace
    }
    if (Test-Path $SWPath)
        { 
        Write-Output "Windows Update file already downloaded... moving to installation." 
        } 
        else 
        {
            Write-Output "Downloading KB5001567 update..."
            Invoke-WebRequest -uri $UD -OutFile "$SWDir\$update.msu"
        }
        
    If(-Not $installed) 
    {
        Write-Output "Installing '$update' now."
    
        try{
    
            Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Util\kb5001567.msu /quiet /norestart" -Wait
            
            If ( $installed) 
              { Write-Output " Windows Update'$update' installed"}
            else 
              { Write-Output "Something went wrong."}}
    
            catch
            { Write-Output $PSItem.ScriptStackTrace }
        }
else { Write-Output "Windows Update'$update' is installed"}

