# Define the registry path for the Command Processor settings
$RegPath = "HKLM:\Software\Microsoft\Command Processor"
# Define the path for the startup script
$ScriptPath = "$env:ProgramData\WindowsTerminalStartup.cmd"

# Check if the "AutoRun" registry key exists and set it to the script path if it doesn't
if ( !(Get-ItemProperty -Path $RegPath -Name "AutoRun" -ErrorAction SilentlyContinue) ) 
    { Set-ItemProperty -Path $RegPath -Name "AutoRun" -Value "$ScriptPath" }

# Check if the script file exists and create it if it doesn't
if ( !(Test-Path $ScriptPath) ) 
    { New-Item -Path $ScriptPath -ItemType File -Force | Out-Null }

# Check if the script file contains the "@Title CMD" line and add it if it doesn't
if ( !(Select-String -Path $ScriptPath -Pattern "@Title CMD" -ErrorAction SilentlyContinue)) 
    { Add-Content -Path $ScriptPath -Value "@Title CMD" }
