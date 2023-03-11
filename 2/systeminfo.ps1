#!/usr/bin/env pwsh

# Read system info
# date and time, info about logged in user, system info, path info, env variables

# Get date and time
$date_time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Get info about logged in user
$logged_in_user = Get-Process -Id $pid -IncludeUserName | Select-Object -ExpandProperty UserName

# Get system info
$system_info = [ordered]@{}
$system_info["computer_name"] = $env:COMPUTERNAME
$system_info["os"] = $env:OS
$system_info["arch"] = $env:PROCESSOR_ARCHITECTURE
$system_info["system_drive"] = $env:SystemDrive
$system_info["system_directory"] = $env:SystemRoot
$system_info["user"] = $env:USERNAME
$system_info["user_profile"] = $env:USERPROFILE

# Get path info
$path_info = [ordered]@{}
$path_info["path"] = $env:PATH
$path_info["home"] = $env:HOME
$path_info["temp"] = $env:TEMP
$path_info["tmp"] = $env:TMP

# Get env variables
$env_variables = [ordered]@{}
$env_variables["env"] = $env:env

# Delete previout systeminfo.txt if it exists
if (Test-Path "systeminfo.txt") {
    Remove-Item "systeminfo.txt"
}

# Write output to systeminfo.txt
"Date and time:`n" | Out-File -FilePath "systeminfo.txt"
$date_time | Out-File -FilePath "systeminfo.txt" -Append
"`nLogged in user:`n" | Out-File -FilePath "systeminfo.txt" -Append
$logged_in_user | Out-File -FilePath "systeminfo.txt" -Append
"`nSystem info:" | Out-File -FilePath "systeminfo.txt" -Append
$system_info | Out-File -FilePath "systeminfo.txt" -Append
"`nPath info:" | Out-File -FilePath "systeminfo.txt" -Append
$path_info | Out-File -FilePath "systeminfo.txt" -Append
"`nEnv variables:" | Out-File -FilePath "systeminfo.txt" -Append
$env_variables | Out-File -FilePath "systeminfo.txt" -Append
