#!/usr/bin/env pwsh

# User input
$partition = Read-Host "Enter partition number"
$backupLocation = Read-Host "Enter the full path of the location where you want to save the backup (e.g. C:\Backup\)"

# Create the disk image backup using diskpart
$diskpartScript = @"
select volume $partition
create vdisk file="$backupLocation\DiskImage.vhdx" type=expandable maximum=4192
attach vdisk
create partition primary
format fs=ntfs quick label="DiskImageBackup"
assign letter=z
exit
"@
Invoke-Expression "echo $diskpartScript | diskpart"

# Compress the disk image backup
$compressedBackup = "$backupLocation\DiskImage.zip"
Compress-Archive -Path "$backupLocation\DiskImage.vhdx" -DestinationPath $compressedBackup -CompressionLevel Optimal

# Detach the virtual disk and remove the temporary partition
$diskpartScript = @"
select vdisk file="$backupLocation\DiskImage.vhdx"
detach vdisk
select disk 0
select partition z
delete partition
exit
"@
Invoke-Expression "echo $diskpartScript | diskpart"

Write-Host "Disk image backup complete. The compressed backup is located at $compressedBackup."
