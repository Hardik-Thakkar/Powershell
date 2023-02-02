Connect-ExchangeOnline

$Mailboxes = Get-Content "C:\Scripts\CPTGroup.csv" <File Path>

foreach ($mailbox in $Mailboxes) 
{
        Add-MailboxPermission -Identity $mailbox -User <User/Email> -AccessRights Fullaccess -AutoMapping:$true -InheritanceType All
        Add-RecipientPermission -Identity $mailbox  -AccessRights SendAs –Trustee <User/Email> -Confirm:$False
}
