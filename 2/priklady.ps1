#!/usr/bin/env pwsh

# Read `priklady.txt`
$lines = Get-Content -Path priklady.txt

foreach ($line in $lines) {
    # Skip empty lines
    if ($line -eq '') {
        continue
    }

    # Split line by space
    $words = $line -split ' '

    # Check if line has 3 words
    if ($words.Count -ne 3) {
        Write-Error "Invalid line: $line"
        break
    }

    # Get first number
    $first = $words[0]

    # Check if first word is a number
    if ($first -notmatch '[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)') {
        Write-Error "Invalid line: $line"
        break
    }

    # Get operator
    $operator = $words[1]

    # Check if operator is valid
    if ($operator -notmatch '^\+|-|\*|/$') {
        Write-Error "Invalid line: $line"
        break
    }

    # Get second number
    $second = $words[2]

    # Check if second word is a number
    if ($second -notmatch '[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)') {
        Write-Error "Invalid line: $line"
        break
    }

    # Calculate result
    switch ($operator) {
        '+' { $result = [float]$first + [float]$second }
        '-' { $result = [float]$first - [float]$second }
        '*' { $result = [float]$first * [float]$second }
        '/' { $result = [float]$first / [float]$second }
    }

    # Write result to `priklady-reseni.txt`
    "$first $operator $second = $result" | Out-File -FilePath priklady-reseni.txt -Append
}
