#connecting to the Azure AD
Connect-AzureAD 

#importing the CSV source which has the changes 
$data = Import-Csv D:\Shared\CSP\IMP\AZ_CSPOrganizationalChart.csv

#Iterating through each row in the CSV
foreach ($row in $data)
{
#INFO in the Console
#Write-Host "Updating the user :"  $row.'User Username'    " manager to "  $row.'ManagerUPN'  -ForegroundColor Yellow 

#Updating the Manager 
Set-AzureADUserManager -ObjectId (Get-AzureADUser -ObjectId $row.'User Username').Objectid -RefObjectId (Get-AzureADUser -ObjectId $row.'ManagerUPN').Objectid
#Set-AzureADUser -ObjectId $row.'UserPrincipleName' -Department $row.'Department' -JobTitle $row.'JobTitle' -Office $row.'Location'

#Completion info in the console for the specified row
Write-Host "Updated." -ForegroundColor Green

}