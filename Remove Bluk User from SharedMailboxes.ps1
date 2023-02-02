$Cred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Cred -Authentication Basic -AllowRedirection
Import-PSSession $Session

# Run any commands you want here

$users =  get-content c:\list.csv ( CSV File Path )
$sharedmbxs=get-mailbox | where {_.type -eq "Shared"}

foreach ($user in $users)
{
   foreach ($mbx in $sharedmbxs)
   {
      remove-mailboxpermission $mbx -user $user -accessrights fullaccess -confirm:$false
   }
}

Remove-PSSession $Session  