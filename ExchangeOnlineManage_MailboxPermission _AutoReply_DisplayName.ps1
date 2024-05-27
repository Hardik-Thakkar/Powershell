Connect-ExchangeOnline

$Mailboxes = Get-Content "C:\Scripts\contoso.csv"

foreach ($mailbox in $Mailboxes) 
{

	Write-Host "Modifying the details for - '$mailbox'"

## Removing the mailbox access permissions 

	Remove-MailboxPermission -Identity $mailbox -ResetDefault -Confirm:$false

## Removing the mailbox's send as  permissions 

	Get-RecipientPermission -Identity $mailbox | `  where {($_.Trustee -notlike "NT AUTHORITY\SELF") -and ($_.Trustee -notlike "NTAUTHORITY\SYSTEM")} `	| foreach {Remove-RecipientPermission -Identity $_.Identity -AccessRights SendAs -Trustee $_.Trustee -Confirm:$false}

## Setting up Autoreply on the mailbox 

	Set-MailboxAutoReplyConfiguration –Identity $mailbox -AutoReplyState Enabled –InternalMessage “Hello, this mailbox is no longer being monitored. If you need assistance please call 1-888-305-7140.” -ExternalMessage “Hello, this mailbox is no longer being monitored. If you need assistance please call 1-888-305-7140.”

## Changing the DisplayName of mailbox 

$DName = Get-Mailbox -identity $mailbox  | Select DisplayName 
$Prefix = "[ARCHIVED] - "
$NewDisplayName =  $Prefix + $DName.DisplayName
Set-Mailbox -identity $mailbox -DisplayName $NewDisplayName

## Convert mailbox to shared

Set-Mailbox $mailbox -Type Shared

## Hide Mailbox from GAL (Global Address List)

Set-Mailbox -Identity $Mailbox -HiddenFromAddressListsEnabled $true

}
