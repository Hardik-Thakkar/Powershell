$Download = "https://contoso.sharepoint.com/:u:/s/Software/ERPrwCORZKhFj2BoUZsd7aIBuIP_9_G6K1wtjeXn0hZeJQ?download=1"
Invoke-WebRequest -Uri $Download -OutFile C:\Utils\AutodeskDWGCompare2016-2019.msi -UseBasicParsing -ErrorAction Stop 

If(-not(Test-Path C:\Util))
{
mkdir C:\Util\
}
else { Write-Host "path exits.."}

Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Utils\AutodeskDWGCompare2016-2019.msi /quiet' 
