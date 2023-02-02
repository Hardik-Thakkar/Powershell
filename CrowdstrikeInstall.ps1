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
