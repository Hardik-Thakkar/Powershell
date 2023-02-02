$CopyFromUser = Get-ADUser "UserName -prop MemberOf
$CopyToUser = Get-ADUser "NewUserName" -prop MemberOf
$CopyFromUser.MemberOf | Where{$CopyToUser.MemberOf -notcontains $_} |  Add-ADGroupMember -Member $CopyToUser