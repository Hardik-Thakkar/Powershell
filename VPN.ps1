Function RemoveVpn
{
$vpnconnection = Get-VpnConnection -AllUserConnection
#$Bvpnconnection = Get-VpnConnection

	foreach ($vpn in $vpnconnection)
	{
		If ($vpn.ConnectionStatus -eq "Connected")
		{	
			 rasdial $vpn.name /disconnect; Remove-VpnConnection -Name $vpn.name -force -AllUserConnection
		}
		else   
		{
			Remove-VpnConnection -Name $vpn.name -force -AllUserConnection
		}
	}
}

Function AddVPN
{
$vpnconnection = Get-VpnConnection -AllUserConnection
$SFVPN = Add-VpnConnection -Name "SF VPN" -ServerAddress "VPN HOST" -TunnelType SSTP -EncryptionLevel Optional -SplitTunneling -AuthenticationMethod MSChapv2 -AllUserConnection -RememberCredential -PassThru -UseWinlogonCredential
$NBVPN = Add-VpnConnection -Name "NB VPN" -ServerAddress "VPN HOST - X.CONTOSO.COM" -TunnelType SSTP -EncryptionLevel Optional -SplitTunneling -AuthenticationMethod MSChapv2 -AllUserConnection -RememberCredential -PassThru -UseWinlogonCredential

	foreach ($vpn in $vpnconnection)
	{
		If ($vpn.name -ne $vpnconnection)
			{	 
				$SFVPN
				$NBVPN
			}
		else
			{
				Write-Host "SF & NB VPN Exists"
			}
		
	}
}

function main
{
	RemoveVpn
	AddVPN
}	

Main
