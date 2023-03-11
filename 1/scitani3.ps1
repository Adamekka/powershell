#!/usr/bin/env pwsh

$global:spravne = 0
$global:spatne = 0

function scitani {
    Write-Output "Scitani cisel"

    # Read stdin
    $num0 = Read-Host -Prompt "Zadej prvni cislo"
    $num1 = Read-Host -Prompt "Zadej druhe cislo"
    $sum = Read-Host -Prompt "Zadej soucet"

    # Check if user knows math
    $correct_sum = [int]$num0 + [int]$num1

    if ($sum -eq $correct_sum) {
        Write-Output "Spravne"
        $spravne += 1
    }
    else {
        Write-Output "Spatne"
        Write-Output "Spravny soucet je $correct_sum"
        $spatne += 1
    }

    $continue = Read-Host -Prompt "Chces pokracovat? [y/n]"

    if ($continue -eq 'y') {
        scitani
    }

    Write-Output "Spravne: $spravne"
    Write-Output "Spatne: $spatne"

    Exit
}

scitani
