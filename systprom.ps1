#!/usr/bin/env pwsh

# Read system info
# name of computer, OS, arch, system drive, system directory, user, user profile

# Create empty hash table
$system_info = [ordered]@{}

# Get system info
$system_info["computer_name"] = $env:COMPUTERNAME
$system_info["os"] = $env:OS
$system_info["arch"] = $env:PROCESSOR_ARCHITECTURE
$system_info["system_drive"] = $env:SystemDrive
$system_info["system_directory"] = $env:SystemRoot
$system_info["user"] = $env:USERNAME
$system_info["user_profile"] = $env:USERPROFILE

Write-Output "`nSystem info:"
$system_info | Format-Table -AutoSize
