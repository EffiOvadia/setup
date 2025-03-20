
# Set the dimensions of the console window
if ([System.Environment]::GetEnvironmentVariable('VI_DIMENSIONS') -eq $null) 
  {
    if ($Admin) 
      {[System.Environment]::SetEnvironmentVariable('VI_DIMENSIONS', "205,34", [System.EnvironmentVariableTarget]::Machine)} else 
        {[System.Environment]::SetEnvironmentVariable('VI_DIMENSIONS', "205,34", [System.EnvironmentVariableTarget]::User)}
  }

# Display the stored value of the variable
[System.Environment]::GetEnvironmentVariable('VI_DIMENSIONS')
