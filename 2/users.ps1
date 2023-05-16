#!/usr/bin/env pwsh
# Requires -RunAsAdministrator

# Check if studenti.csv already exists else create it
if (!(Test-Path .\studenti.csv)) {
    # Convert `studenti.xlsx` to `studenti.csv` using gocsvs
    .\gocsv.exe xlsx --sheet 1 .\studenti.xlsx > .\studenti.csv
}

# Variables
$log_file = "log.txt"
$log = ""
$input_buffer = Get-Content -Path .\studenti.csv

# Create log file or clear it if it already exists
if (Test-Path $log_file) {
    Clear-Content $log_file
}
else {
    New-Item -ItemType File -Path $log_file
}

foreach ($line in $input_buffer) {
    # If line starts with `,` skip it
    if ($line.StartsWith(',')) {
        continue
    }

    # Split line by `,`
    $words = $line -split ','
    $prijmeni = $words[0]
    $jmeno = $words[1]
    $trida = $words[2]
    $rocknik = $words[3]
    $pohlavi = $words[4]

    foreach ($word in $words) {
        $word.replace('á', 'a')
        $word.replace('č', 'c')
        $word.replace('ď', 'd')
        $word.replace('é', 'e')
        $word.replace('ě', 'e')
        $word.replace('í', 'i')
        $word.replace('ň', 'n')
        $word.replace('ó', 'o')
        $word.replace('ř', 'r')
        $word.replace('š', 's')
        $word.replace('Š', 's')
        $word.replace('ť', 't')
        $word.replace('ú', 'u')
        $word.replace('ů', 'u')
        $word.replace('ý', 'y')
        $word.replace('ž', 'z')
    }
}
