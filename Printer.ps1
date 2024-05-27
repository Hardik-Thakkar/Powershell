Add-Printer -ConnectionName "\\s4\HB BIG TOSHIBA"
Add-Printer -ConnectionName "\\dc1\20-HB-TOSHIBA"
$printer = Get-CimInstance -Class Win32_Printer -Filter "ShareName='HB BIG TOSHIBA'"
Invoke-CimMethod -InputObject $printer -MethodName SetDefaultPrinter
