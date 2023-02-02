softWarePath = "$env:HOMEDRIVE\Software\Kyocera\KXV4_PCL6.exe"
  $softWareDir = "$env:HOMEDRIVE\Software\Kyocera\"
  $app = "Kyocera KXV4 PCL6 Driver"
  $downloadLink = "https://rightclickinc.sharepoint.com/:u:/s/clients/EUJVTEFDwj5Jrh2W6DR7KeIBG020voiGxdcbP3xZaZuyVQ?download=1"
    <#
      Change the information above to fit your needs. Following this, everything should work.
      #This is a driver install script, so the application installation information will be inaccurate - Needs Revision
           ## Add Section to Check Printer Driver instead of app installation
    #>
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
    # Add Driver Check Installation Here
    $kxv4PCL6 = Get-PrinterDriver | Where-Object {$_.Name -like 'KX (PCL6)*'}
    if ($null -ne $kxv4PCL6){
        Write-Output "Reinstalling driver"
        if($answer.ToUpper -eq "y"){
            try {           
            Remove-PrinterDriver -Name "KX (PCL6) v4 Driver for Universal Printing" -Confirm $false
            }catch {
                Write-Output "Ran into an issue: $PSItem"
                Write-Output $PSItem.ScriptStackTrace
            }}}else{
            Write-Host "Moving to driver installation"
            continue}
 
    try {
        Invoke-Command -ScriptBlock {Start-Process $softWarePath -Wait}}
    catch {
        Write-Output "Ran into an issue: $PSItem"
        Write-Output $PSItem.ScriptStackTrace
    }
    #Validate Installation
    try{
    $kxv4PCL6 = Get-PrinterDriver | Where-Object {$_.Name -like 'KX (PCL6)*'}
    if ($null -ne $kxv4PCL6){
        Write-Output "$app installed"
    }else{
        Write-Output "$app not installed or something is wrong"
    }}catch {
        Write-Output "Ran into an issue: $PSItem"
        Write-Output $PSItem.ScriptStackTrace
    }