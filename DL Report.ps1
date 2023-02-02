Write-host "
Distribution Group Member Report
----------------------------
1. Display in Exchange Management Shell
2. Export to CSV File
3. Enter the Distribution Group name with Wild Card (Export)
4. Enter the Distribution Group name with Wild Card (Display)
Dynamic Distribution Group Member Report
----------------------------
5. Display in Exchange Management Shell
6. Export to CSV File
7. Enter the Dynamic Distribution Group name with Wild Card (Export)
8. Enter the Dynamic Group name with Wild Card (Display)
Unified Group Member Report (Connect-ExchangeOnline)
----------------------------
9.  Display in Exchange Management Shell
10. Export to CSV File"-ForeGround "Cyan"

#----------------
# Script
#----------------

Write-Host "               "

$number = Read-Host "Choose The Task"
$output = @()
switch ($number) 
{

1 {

$AllDG = Get-DistributionGroup -resultsize unlimited
Foreach($dg in $allDg)
 {
$Members = Get-DistributionGroupMember $Dg.name -resultsize unlimited


if($members.count -eq 0)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }
else
{
Foreach($Member in $members)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $member.Alias
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }

}

  }

;Break}

2 {

$i = 0 

$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\DG.csv)" 

$AllDG = Get-DistributionGroup -resultsize unlimited

Foreach($dg in $allDg)
{
$Members = Get-DistributionGroupMember $Dg.name -resultsize unlimited

if($members.count -eq 0)
{
$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.GroupType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

}
else
{
Foreach($Member in $members)
 {

$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $Member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $Member.Alias
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value $Member.RecipientType
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value $Member.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $Member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.GroupType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

 }
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Groups . . ." -status "Scanned: $i of $($allDg.Count)" -percentComplete (($i / $allDg.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}

;Break}

3 {

$i = 0 

$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\DG.csv)" 

$Dgname = Read-Host "Enter the DG name or Range (Eg. DGname , DG*,*DG)"

$AllDG = Get-DistributionGroup $Dgname -resultsize unlimited

Foreach($dg in $allDg)

{

$Members = Get-DistributionGroupMember $Dg.name -resultsize unlimited

if($members.count -eq 0)
{
$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.GroupType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

}
else
{
Foreach($Member in $members)
 {

$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $Member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $Member.Alias
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value $Member.RecipientType
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value $Member.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $Member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.GroupType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

 }
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Groups . . ." -status "Scanned: $i of $($allDg.Count)" -percentComplete (($i / $allDg.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}

;Break}

4 {

$Dgname = Read-Host "Enter the DG name or Range (Eg. DGname , DG*,*DG)"

$AllDG = Get-DistributionGroup $Dgname -resultsize unlimited

Foreach($dg in $allDg)

 {

$Members = Get-DistributionGroupMember $Dg.name -resultsize unlimited

if($members.count -eq 0)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }
else
{
Foreach($Member in $members)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $member.Alias
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }

}

  }

;Break}

5 {

$AllDG = Get-DynamicDistributionGroup -resultsize unlimited

Foreach($dg in $allDg)

{

$Members = Get-Recipient -RecipientPreviewFilter $dg.RecipientFilter -resultsize unlimited

if($members.count -eq 0)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }
else
{
Foreach($Member in $members)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $member.Alias
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }

}

  }

;Break}

6 {
$i = 0 

$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\DYDG.csv)" 

$AllDG = Get-DynamicDistributionGroup -resultsize unlimited

Foreach($dg in $allDg)

{

$Members = Get-Recipient -RecipientPreviewFilter $dg.RecipientFilter -resultsize unlimited

if($members.count -eq 0)
{
$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

}
else
{
Foreach($Member in $members)
 {

$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $Member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $Member.Alias
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value $Member.RecipientType
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value $Member.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $Member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

 }
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Groups . . ." -status "Scanned: $i of $($allDg.Count)" -percentComplete (($i / $allDg.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}

;Break}

7 {
$i = 0 

$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\DYDG.csv)" 

$Dgname = Read-Host "Enter the DG name or Range (Eg. DynmicDGname , Dy*,*Dy)"

$AllDG = Get-DynamicDistributionGroup $Dgname -resultsize unlimited

Foreach($dg in $allDg)

{

$Members = Get-Recipient -RecipientPreviewFilter $dg.RecipientFilter -resultsize unlimited

if($members.count -eq 0)
{
$managers = $Dg | Select @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

}
else
{
Foreach($Member in $members)
 {

$managers = $Dg | Select-Object @{Name='DistributionGroupManagers';Expression={[string]::join(";", ($_.Managedby))}}
$manageremail = Get-Mailbox $managers.DistributionGroupManagers -ErrorAction SilentlyContinue -resultsize unlimited

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $Member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $Member.Alias
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value $Member.RecipientType
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value $Member.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $Member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
$userObj | Add-Member NoteProperty -Name "Distribution Group Primary SMTP address" -Value $DG.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers" -Value $managers.DistributionGroupManagers
$userObj | Add-Member NoteProperty -Name "Distribution Group Managers Primary SMTP address" -Value $manageremail.primarysmtpaddress
$userObj | Add-Member NoteProperty -Name "Distribution Group OU" -Value $DG.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Distribution Group Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Distribution Group Recipient Type" -Value $DG.RecipientType
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $DG.RequireSenderAuthenticationEnabled

$output += $UserObj  

 }
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Groups . . ." -status "Scanned: $i of $($allDg.Count)" -percentComplete (($i / $allDg.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}

;Break}

8 {

$Dgname = Read-Host "Enter the Dynamic DG name or Range (Eg. DynamicDGname , DG*,*DG)"

$AllDG = Get-DynamicDistributionGroup $Dgname -resultsize unlimited

Foreach($dg in $allDg)

{

$Members = Get-Recipient -RecipientPreviewFilter $dg.RecipientFilter -resultsize unlimited

if($members.count -eq 0)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }
else
{
Foreach($Member in $members)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $member.Alias
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Distribution Group" -Value $DG.Name
Write-Output $Userobj
 }

}

  }

;Break}

9 {

$AllUG = Get-UnifiedGroup -resultsize unlimited
Foreach($ug in $allug)
 {
$Members = Get-UnifiedGroupLinks $ug.name -LinkType member -resultsize unlimited


if($members.count -eq 0)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmtpyGroup
$userObj | Add-Member NoteProperty -Name "UnifiedGroup" -Value $ug.Name
Write-Output $Userobj
 }
else
{
Foreach($Member in $members)
 {
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $member.Alias
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "UnifiedGroup" -Value $ug.Name
Write-Output $Userobj
 }

}

  }

;Break}

10 {

$i = 0 

$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\UG.csv)" 

$Allug = Get-UnifiedGroup -resultsize unlimited

Foreach($ug in $allug)
{
$Members = Get-UnifiedGroupLinks $ug.name -LinkType member -resultsize unlimited

if($members.count -eq 0)
{
$managers = $ug.managedby -join ','

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Alias" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value EmptyGroup
$userObj | Add-Member NoteProperty -Name "Unified Group" -Value $ug.Name
$userObj | Add-Member NoteProperty -Name "Unified Group Primary SMTP address" -Value $ug.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Unified Group Managers" -Value $managers
$userObj | Add-Member NoteProperty -Name "Unified Group OU" -Value $ug.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Unified Group Type" -Value $ug.GroupType
$userObj | Add-Member NoteProperty -Name "Unified Group Recipient Type" -Value $ug.RecipientType
$userObj | Add-Member NoteProperty -Name "Unified Group Display Name" -Value $ug.DisplayName
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $ug.RequireSenderAuthenticationEnabled
$userObj | Add-Member NoteProperty -Name "Unified Group Access Type" -Value $ug.AccessType

$output += $UserObj  

}
else
{
Foreach($Member in $members)
 {

$managers = $ug.managedby -join ','

$userObj = New-Object PSObject

$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $Member.Name
$userObj | Add-Member NoteProperty -Name "Alias" -Value $Member.Alias
$userObj | Add-Member NoteProperty -Name "RecipientType" -Value $Member.RecipientType
$userObj | Add-Member NoteProperty -Name "Recipient OU" -Value $Member.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $Member.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Unified Group" -Value $ug.Name
$userObj | Add-Member NoteProperty -Name "Unified Group Primary SMTP address" -Value $ug.PrimarySmtpAddress
$userObj | Add-Member NoteProperty -Name "Unified Group Managers" -Value $managers
$userObj | Add-Member NoteProperty -Name "Unified Group OU" -Value $ug.OrganizationalUnit
$userObj | Add-Member NoteProperty -Name "Unified Group Group Type" -Value $ug.GroupType
$userObj | Add-Member NoteProperty -Name "Unified Group Recipient Type" -Value $ug.RecipientType
$userObj | Add-Member NoteProperty -Name "Unified Group Display Name" -Value $ug.DisplayName
$userObj | Add-Member NoteProperty -Name "Not Allowed from Internet" -Value $ug.RequireSenderAuthenticationEnabled
$userObj | Add-Member NoteProperty -Name "Unified Group Access Type" -Value $ug.AccessType

$output += $UserObj  

 }
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Unified Groups . . ." -status "Scanned: $i of $($allug.Count)" -percentComplete (($i / $allug.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}

;Break}

Default {Write-Host "No matches found , Enter Options 1 or 2" -ForeGround "red"}

}