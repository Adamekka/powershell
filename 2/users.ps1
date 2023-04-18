#!/usr/bin/env pwsh

$log_file = "log.txt"
$input_file = "studenti.txt"

# Create log file or clear it if it already exists
if (Test-Path $log_file) {
    Clear-Content $log_file
}
else {
    New-Item -ItemType File -Path $log_file
}

# Function to create user accounts
function create_user_accs($usernames) {
    foreach ($username in $usernames) {
        $first_name = $username.Split(".")[0]
        $last_name = $username.Split(".")[1]
        $password = "$last_name" + "Q12020!"
        $expiration_year = "2024"

        # Create user account with specified settings
        New-LocalUser $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -Description "Student account for $first_name $last_name" -FullName "$first_name $last_name" -UserMayNotChangePassword $false -PasswordNeverExpires $false -PasswordExpired $true -AccountExpires (Get-Date -Year $expiration_year -Month 8 -Day 31)

        # Add user to appropriate groups
        Add-LocalGroupMember -Group "STUDENTS" -Member $username
        Add-LocalGroupMember -Group "ICT" -Member $username
        Add-LocalGroupMember -Group "ELEKTRO" -Member $username
        Add-LocalGroupMember -Group "$($username.Split(".")[2])" -Member $username

        # Write log entry for account creation
        Write-Output "Created user account for $first_name $last_name with username $username and expiration year $expiration_year" | Out-File $log_file -Append
    }
}

# Define function to delete user accounts
function delete_user_accs($usernames) {
    foreach ($username in $usernames) {
        # Delete user account
        Remove-LocalUser -Name $username -ErrorAction SilentlyContinue

        # Remove user from all groups
        Remove-LocalGroupMember -Group "STUDENTS" -Member $username -ErrorAction SilentlyContinue
        Remove-LocalGroupMember -Group "ICT" -Member $username -ErrorAction SilentlyContinue
        Remove-LocalGroupMember -Group "ELEKTRO" -Member $username -ErrorAction SilentlyContinue
        Remove-LocalGroupMember -Group "$($username.Split(".")[2])" -Member $username -ErrorAction SilentlyContinue

        # Write log entry for account deletion
        Write-Output "Deleted user account $username" | Out-File $log_file -Append
    }
}

# Read input file and create or delete user accounts based on command
switch -Wildcard (Get-Content $input_file) {
    "create *" {
        $usernames = (Get-Content $input_file | Select-Object -Skip 1) -replace " ", "." | ForEach-Object { $_.ToLower() }
        create_user_accs($usernames)
    }
    "delete *" {
        $usernames = (Get-Content $input_file | Select-Object -Skip 1) -replace " ", "." | ForEach-Object { $_.ToLower() }
        delete_user_accs($usernames)
    }
    default {
        Write-Error "Invalid command. Please use 'create' or 'delete' followed by a list of usernames in the input file."
    }
}
