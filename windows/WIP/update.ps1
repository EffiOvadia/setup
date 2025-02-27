# Automated App Update Script for Windows

# Function to update Windows Store apps
function Update-WindowsStoreApps 
  {
    Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" |
    Invoke-CimMethod -MethodName UpdateScanMethod
  }
  
# Function to update Winget packages
function Update-WingetApps 
  {
    if (Get-Command winget -ErrorAction SilentlyContinue) {winget upgrade --all}
  }
