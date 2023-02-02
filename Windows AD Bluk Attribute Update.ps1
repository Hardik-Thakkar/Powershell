Import-Csv -Path "C:\Util\AD_CSPOrganizationalChart.csv" | 
    ForEach-Object {
        # properties from the csv
        $acct = $samaccountname     # needed for error message
        $props = @{
            title        = $_.JobTitle
            Department   = $_.Department
            manager      = $_.ManagerUPN
	Office       = $_.Location
        }
        Try {
            Get-ADUser -Identity $_.SamAccountName -Properties * -ErrorAction STOP| 
                Set-ADUser @props -ErrorAction STOP
            }
            Catch {
                Write-Host "User '$acct' not found or failed to update: "
                Write-Host $_
            }
        }
