# Update these variables as needed
$CID = "CID"
$SensorShare = "Setup URL"

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
