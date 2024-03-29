function Enable-ShadowCopies {
    param (
    [String]$ComputerName = $Env:ComputerName,
    [Parameter(Mandatory=$true)]
    [String]$Drive
    )
$volumeWMI = Get-WmiObject -ComputerName $ComputerName -Class Win32_Volume -Filter "DriveLetter = '$Drive'";
$volumeID = ($volumeWMI.DeviceID.SubString(10)).SubString(0,($volumeWMI.DeviceID.SubString(10)).Length-1);
$scheduler = New-Object -ComObject Schedule.Service
$scheduler.Connect($ComputerName)
$tskDef = $scheduler.NewTask(0);
$tskRegInfo = $tskDef.RegistrationInfo;
$tskSettings = $tskDef.Settings;
$tskTriggers = $tskDef.Triggers;
$tskActions = $tskDef.Actions;
$tskPrincipals = $tskDef.Principal;

# Registration Info
$tskRegInfo.Author = "SC_PS_Script";

# Settings
$tskSettings.DisallowStartIfOnBatteries = $false;
$tskSettings.StopIfGoingOnBatteries = $false
$tskSettings.AllowHardTerminate = $false;
$tskSettings.IdleSettings.IdleDuration = "PT600S";
$tskSettings.IdleSettings.WaitTimeout = "PT3600S";
$tskSettings.IdleSettings.StopOnIdleEnd = $false;
$tskSettings.IdleSettings.RestartOnIdle = $false;
$tskSettings.Enabled = $true;
$tskSettings.Hidden = $false;
$tskSettings.RunOnlyIfIdle = $false;
$tskSettings.WakeToRun = $false;
$tskSettings.ExecutionTimeLimit = "PT259200S";
$tskSettings.Priority = "5";
$tskSettings.StartWhenAvailable = $false;
$tskSettings.RunOnlyIfNetworkAvailable = $false;

# Triggers
$tskTrigger1 = $tskTriggers.Create(3);
$tskTrigger2 = $tskTriggers.Create(3);
#$tskTrigger3 = $tskTriggers.Create(4);

## Trigger 1
$tskTrigger1.Id = "Trigger1"
$tskTrigger1.StartBoundary = (Get-Date -format "yyyy-MM-dd")+"T12:00:00";
$tskTrigger1.DaysOfWeek = 0x3E; # Monday - Friday - http://msdn.microsoft.com/en-us/library/windows/desktop/aa384024(v=vs.85).aspx
$tskTrigger1.Enabled = $true;

## Trigger 2
$tskTrigger2.Id = "Trigger2";
$tskTrigger2.StartBoundary = (Get-Date -format "yyyy-MM-dd")+"T16:32:00";
$tskTrigger2.DaysOfWeek = 0x3E; # Monday - Friday - http://msdn.microsoft.com/en-us/library/windows/desktop/aa384024(v=vs.85).aspx
$tskTrigger2.Enabled = $true;

## Trigger 3
#$tskTrigger3.Id = "Trigger3";
#$tskTrigger3.StartBoundary = (Get-Date -format "yyyy-MM-dd")+"T24:00:00";
#$tskTrigger3.DaysOfWeek = 0x3E; # Monday - Friday - http://msdn.microsoft.com/en-us/library/windows/desktop/aa384024(v=vs.85).aspx
#$tskTrigger3.Enabled = $true;

# Principals (RunAs User)
$tskPrincipals.Id = "Author";
$tskPrincipals.UserID = "SYSTEM";
$tskPrincipals.RunLevel = 1;

# Actions
$tskActions.Context = "Author"
$tskAction1 = $tskActions.Create(0);

# Action 1
$tskAction1.Path = "C:\Windows\system32\vssadmin.exe";
$tskAction1.Arguments = "Create Shadow /AutoRetry=15 /For="+$volumeWMI.DeviceID;
$tskAction1.WorkingDirectory = "%systemroot%\system32";

# Configure VSS, Add scheduled task
vssadmin Add ShadowStorage /For=$Drive /On=$Drive /MaxSize=10%;
$tskFolder = $scheduler.GetFolder("\")
$tskFolder.RegisterTaskDefinition("ShadowCopyVolume$volumeID", $tskDef, 6, "SYSTEM", $null,5);
}