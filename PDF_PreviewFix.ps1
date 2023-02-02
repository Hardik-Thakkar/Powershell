try {
	if(-NOT (Test-Path -LiteralPath "HKLM:\Software\Microsoft\Windows\CurrentVersion\PreviewHandlers")){ return $false };
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}")){ return $false };
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\Implemented Categories")){ return $false };
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\Implemented Categories\{62C8FE65-4EBB-45E7-B440-6E39B2CDBF29}")){ return $false };
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32")){ return $false };
	if(-NOT (Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32\v0.53.1.0")){ return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\Software\Microsoft\Windows\CurrentVersion\PreviewHandlers' -Name '{07665729-6243-4746-95b7-79579308d1b2}' -ea SilentlyContinue) -eq 'Pdf Preview Handler') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}' -Name 'DisplayName' -ea SilentlyContinue) -eq 'Pdf Preview Handler') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}' -Name '(default)' -ea SilentlyContinue) -eq 'Microsoft.PowerToys.PreviewHandler.Pdf.PdfPreviewHandler') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}' -Name 'AppID' -ea SilentlyContinue) -eq '{6d2b5079-2f0b-48dd-ab7f-97cec514d30b}') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\Implemented Categories\{62C8FE65-4EBB-45E7-B440-6E39B2CDBF29}' -Name '(default)' -ea SilentlyContinue) -eq '') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32' -Name '(default)' -ea SilentlyContinue) -eq 'C:\Program Files\PowerToys\modules\FileExplorerPreview\PowerToys.PdfPreviewHandler.comhost.dll') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32' -Name 'Assembly' -ea SilentlyContinue) -eq 'PowerToys.PdfPreviewHandler, Version=v0.53.1.0, Culture=neutral') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32' -Name 'Class' -ea SilentlyContinue) -eq 'Microsoft.PowerToys.PreviewHandler.Pdf.PdfPreviewHandler') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32' -Name 'ThreadingModel' -ea SilentlyContinue) -eq 'Both') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32\v0.53.1.0' -Name 'Assembly' -ea SilentlyContinue) -eq 'PowerToys.PdfPreviewHandler, Version=v0.53.1.0, Culture=neutral') {  } else { return $false };
	if((Get-ItemPropertyValue -LiteralPath 'HKLM:\SOFTWARE\Classes\WOW6432Node\CLSID\{07665729-6243-4746-95b7-79579308d1b2}\InprocServer32\v0.53.1.0' -Name 'Class' -ea SilentlyContinue) -eq 'Microsoft.PowerToys.PreviewHandler.Pdf.PdfPreviewHandler') {  } else { return $false };
}
catch { return $false }
return $true