Import-Module ActiveDirectory
$UserName = “eyoung“
$ReportPath = “C:\Util\eyoungUserGroups.txt“
(Get-ADUser $UserName –Properties MemberOf | Select MemberOf).MemberOf |Out-File -FilePath $reportpath