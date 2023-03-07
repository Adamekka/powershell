#!/usr/bin/env pwsh

function scitani {
    Write-Output "Scitani cisel"

    # Read stdin
    $num0 = Read-Host -Prompt "Zadej prvni cislo"
    $num1 = Read-Host -Prompt "Zadej druhe cislo"

    $soucet = [int]$num0 + [int]$num1

    Write-Output "Soucet  cisel: $soucet"

    $continue = Read-Host -Prompt "Chces pokracovat? [y/n]"

    if ($continue -eq 'y') {
        scitani
    }
}

scitani
