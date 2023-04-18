#!/usr/bin/env pwsh

# Create C:/SCRIPTS/$USERNAME
mkdir -Path "C:/SCRIPTS/$env:USERNAME" -Force

# Set ALL RWX permissions for C:/SCRIPTS
$Acl = Get-Acl "C:/SCRIPTS"
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:USERNAME", "FullControl", "Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "C:/SCRIPTS" $Acl

# Write directory tree structure of C:/
Get-ChildItem -Path "C:/" -Recurse -Force | Select-Object FullName, Name, Directory, LastWriteTime, Length | Format-Table -AutoSize | Out-File -FilePath "C:/SCRIPTS/$env:USERNAME/tree.txt"

# Output normal files of `C:/Windows` including their attributes
$normal_files = Get-ChildItem -Path "C:/Windows" -Recurse -Force -Attributes !Hidden

# Output hidden files of `C:/Windows` including their attributes
$hidden_files = Get-ChildItem -Path "C:/Windows" -Recurse -Force -Attributes Hidden

# Output links of `C:/Windows` including their attributes
$links = Get-ChildItem -Path "C:/Windows" -Recurse -Force -Attributes ReparsePoint

# Write to files
$normal_files | Out-File -FilePath "C:/SCRIPTS/$env:USERNAME/normal_files.txt"
$hidden_files | Out-File -FilePath "C:/SCRIPTS/$env:USERNAME/hidden_files.txt"
$links | Out-File -FilePath "C:/SCRIPTS/$env:USERNAME/links.txt"
