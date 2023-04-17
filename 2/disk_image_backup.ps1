#!/usr/bin/env pwsh

# User input
$partition = Read-Host "Enter partition number"
$backup_file_path = Read-Host "Enter the path of the location where you want to save the backup"

# Create the backup directory if it does not exist
if (-not (Test-Path $backup_file_path)) {
    New-Item -ItemType Directory -Path $backup_file_path
}

# Create the disk image backup using diskpart
$diskpart_script_create_image = @"
select volume $partition
create vdisk file="$backup_file_path/DiskImage.vhdx" type=expandable maximum=4192
attach vdisk
create partition primary
format fs=ntfs quick label="DiskImageBackup"
assign letter=z
exit
"@

$diskpart_script_create_image | diskpart

# Compress the disk image backup
$compressed_backup = "$backup_file_path/DiskImage.zip"
Compress-Archive -Path "$backup_file_path/DiskImage.vhdx" -DestinationPath $compressed_backup -CompressionLevel Optimal

# Detach the virtual disk and remove the temporary partition
$diskpart_script_detach = @"
select vdisk file="$backup_file_path/DiskImage.vhdx"
detach vdisk
select disk 0
select partition z
delete partition
exit
"@

$diskpart_script_detach | diskpart

Write-Host "Disk image backup complete. The compressed backup is located at $compressed_backup."
