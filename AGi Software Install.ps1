$Download = "https://www.lightinganalysts.com/catalog/index.php?dln=AGI32-20.4_Setup.exe"

If(-not(Test-Path C:\Util))
{
mkdir C:\Util\
}
else { Write-Host "path exits..Proceeding for the Download..."}

Invoke-WebRequest -Uri $Download -OutFile C:\Util\AGI32_Setup.exe -ErrorAction Stop 

# Start-Process -Wait -FilePath "C:\Util\AGI32_Setup.exe" -ArgumentList "/S" -PassThru

C:\Util\AGI32_Setup.exe /silent