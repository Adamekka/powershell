#!/usr/bin/env pwsh

# Read `priklady.txt`
$lines = Get-Content -Path priklady.txt

foreach ($line in $lines) {
    # Get first number
    $first = $line.Split(' ')[0]

    # Get operator
    $operator = $line.Split(' ')[1]

    # Get second number
    $second = $line.Split(' ')[2]

    # Calculate result
    switch ($operator) {
        "+" { $result = $first + $second }
        "-" { $result = $first - $second }
        "*" { $result = $first * $second }
        "/" { $result = $first / $second }
    }

    Write-Output "Výsledek je: $first $operator $second = $result"

    # Write to file
    "$first $operator $second = $result" | Out-File -FilePath "priklady-vysledky.txt" -Append
}
