#!/usr/bin/env pwsh

Write-Output "Tvym ukolem je uhodnout nahodne cislo od 0 do 9"

$random = Get-Random -Minimum 0 -Maximum 9
$user_input = Read-Host -Prompt "Zadej cislo"

if ($random -eq $user_input) {
    Write-Output "Vyborne, uhodl jsi cislo"
} else {
    Write-Output "Neuhodl jsi, spravne cislo je $random"
}
