#!/usr/bin/env pwsh

# Read `priklady.txt`
$lines = Get-Content -Path priklady.txt

foreach ($line in $lines) {
    # Split line by space
    $words = $line -split ' '

    # Get first number
    $first = $words[0]

    # Get operator
    $operator = $words[1]

    # Get second number
    $second = $words[2]

    # Calculate result
    switch ($operator) {
        '+' { $result = $first + $second }
        '-' { $result = $first - $second }
        '*' { $result = $first * $second }
        '/' { $result = $first / $second }
    }

    # Write result to `priklady-reseni.txt`
    "$first $operator $second = $result" | Out-File -FilePath priklady-reseni.txt -Append
}
