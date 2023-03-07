#!/usr/bin/env pwsh

Write-Output "0-10`n"

for ($i = 0; $i -le 10; $i++) {
    Write-Output $i
}

Write-Output "`n0-10 suda cisla`n"

for ($i = 0; $i -le 10; $i += 2) {
    Write-Output $i
}

Write-Output "`n0-10 licha cisla`n"

for ($i = 1; $i -le 10; $i += 2) {
    Write-Output $i
}
