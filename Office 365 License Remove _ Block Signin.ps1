Connect-MsolService

$Mailboxes = Get-Content "C:\Scripts\CPTGroup.csv"

## Remote all the licenses 

foreach ($mailbox in $Mailboxes) 
{

Write-Host "Modifying the details for - '$mailbox'"

$MsolUser = Get-MsolUser -UserPrincipalName $mailbox
$AssignedLicenses = $MsolUser.licenses.AccountSkuId

foreach($License in $AssignedLicenses) {
    Set-MsolUserLicense -UserPrincipalName $mailbox -RemoveLicenses $License
}

## Block Sign-in
Set-MsolUser -UserPrincipalName $mailbox  -BlockCredential $true

}