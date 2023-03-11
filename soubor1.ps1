#!/usr/bin/env pwsh

# Read input file
$input_file = Get-Content -Path "soubor1-data.txt"

# Example of input file
# Novak Jiri;novak@posta.cz;16000;Kutna Hora
# Polak Vlastimil;vlastink@posta.cz;15000;Kolin
# When line starts with #, it is comment
# Calulate sum of salaries which is in 3rd column
# Create table containing all name, email, salary and city

# Create empty array
$employees = @()

# Loop through all lines in input file
foreach ($line in $input_file) {
    # Skip comment lines
    if ($line -match "^#") {
        continue
    }

    # Split line by ;
    $fields = $line -split ";"

    # Create new hash table
    $employee = [ordered]@{}

    # Add name, email, salary and city to hash table
    $employee["name"] = $fields[0]
    $employee["email"] = $fields[1]
    $employee["salary"] = $fields[2]
    $employee["city"] = $fields[3]
    $employee[""] = ""

    # Add hash table to array
    $employees += $employee
}

# Calculate sum of salaries
$sum = 0
foreach ($employee in $employees) {
    $sum += $employee["salary"]
}

# Create table
$employees | Format-Table -AutoSize

# Print sum of salaries
Write-Host "Sum of salaries: $sum"
