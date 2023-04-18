#!/usr/bin/env pwsh

# Check for internet connection
$ping = Test-Connection -ComputerName "1.1.1.1" -Count 1 -Quiet
if ($ping) {
    Write-Host "Internet connection is available"
}
else {
    Write-Host "Internet connection is not available"
}

# Prompt the user to enter a domain name or IP address of a server
$server = Read-Host "Enter a domain name or IP address of a server"

# Output the packet path to the specified server address
Test-NetConnection -ComputerName $Server | Out-File "internet.txt" -Append

# Output information about the specified domain using the whois command
$who_is_result = whois $server
$who_is_result | Out-File "internet.txt" -Append

# Output DNS records of the specified domain using the nslookup command
$dns_result = nslookup $server
$dns_result | Out-File "internet.txt" -Append
