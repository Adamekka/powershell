#!/usr/bin/env pwsh

# Get paths of all tmp files in C: drive and write to file
# Temporary files have tmp in their name

# Create hash table
$paths = @{}

# Get files with tmp in their name
$paths["tmp"] = Get-ChildItem -Path C: -Filter *tmp* -Recurse -File

# Write paths to file
$paths["tmp"] | Out-File -FilePath .\docasne.txt
