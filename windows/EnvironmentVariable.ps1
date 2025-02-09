
## Set the variable "SSH_AUTH_SOCK" for current session
$env:SSH_AUTH_SOCK = "\\.\pipe\openssh-ssh-agent"

if ($Admin) 
  {
    ## Set the variable "SSH_AUTH_SOCK" for all users permanently
    [System.Environment]::SetEnvironmentVariable('SSH_AUTH_SOCK', $env:SSH_AUTH_SOCK, [System.EnvironmentVariableTarget]::Machine)
  } else {
    ## Set the variable "SSH_AUTH_SOCK" for the current user permanently
    [System.Environment]::SetEnvironmentVariable('SSH_AUTH_SOCK', $env:SSH_AUTH_SOCK, [System.EnvironmentVariableTarget]::User)
  }

## Display the stored value of "SSH_AUTH_SOCK"
[System.Environment]::GetEnvironmentVariable('SSH_AUTH_SOCK')
