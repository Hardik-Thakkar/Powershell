#Enable Volume Shadow copy volume on local machine

#Enable Shadows

vssadmin resize shadowstorage /for=C: /on=C: /maxsize=20%
#maxsize=Number of percentage that you want to utilize the space for this task.

#create scheduled tasks

$diskname = "C:\"
$VolumeWmi = Get-CimInstance  Win32_Volume -Namespace root/cimv2 | Where-Object { $_.Name -eq $diskname }
$DeviceID = $VolumeWmi.DeviceID.ToUpper().Replace("\\?\VOLUME", "").Replace("\","")
$TaskName = "ShadowCopyVolume" + $DeviceID
$TaskFor = "\\?\Volume" + $DeviceID + "\"
$Task = "wmic"
$Argument = "shadowcopy call create Volume=C:\"
$WorkingDir = "%systemroot%\system32"

$ScheduledAction = New-ScheduledTaskAction –Execute $Task -WorkingDirectory $WorkingDir -Argument $Argument

$ScheduledTrigger = @()
$ScheduledTrigger += New-ScheduledTaskTrigger -Daily -At 12:00AM
$ScheduledTrigger += New-ScheduledTaskTrigger -Daily -At 10:00AM
$ScheduledTrigger += New-ScheduledTaskTrigger -Daily -At 01:00PM
$ScheduledTrigger += New-ScheduledTaskTrigger -Daily -At 05:00PM
#ScheduledTrigger can be multiple with hourly or weekly option and with the time as per required preferences  


$ScheduledSettings = New-ScheduledTaskSettingsSet -Compatibility V1 -DontStopOnIdleEnd  -ExecutionTimeLimit (New-TimeSpan -Days 3) -Priority 5

$ScheduledTask = New-ScheduledTask -Action $ScheduledAction -Trigger $ScheduledTrigger -Settings $ScheduledSettings

Register-ScheduledTask $TaskName -InputObject $ScheduledTask -User "NT AUTHORITY\SYSTEM"
