#!/usr/bin/env pwsh

Write-Output "Aritemeticky prumer"

# Aritmeticky prumer zadanych cisel
# Vstupni data jsou oddelena mezerou
# Vystupem je prumer

# Read stdin
$user_input = Read-Host -Prompt "Zadej cisla oddelena mezerou"

# Split string to array
$numbers = $user_input -split ' '

# Calculate average
$sum = 0
foreach ($number in $numbers) {
    $sum += [int]$number
}

$average = $sum / $numbers.Length

Write-Output "Aritmeticky prumer: $average"
