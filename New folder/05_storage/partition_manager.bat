@echo off
chcp 65001 >nul
title Partition Manager Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Partition Manager Tool                         ║
echo ║              Knoux Ultimate Toolbox                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Partition Manager                            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] List Disk Partitions
echo [2] Create Partition
echo [3] Delete Partition
echo [4] Format Partition
echo [5] Resize Partition
echo [6] Change Drive Letter
echo [7] Mark Partition Active
echo [8] Convert Partition
echo [9] Advanced Partition Operations
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto list_partitions
if "%choice%"=="2" goto create_partition
if "%choice%"=="3" goto delete_partition
if "%choice%"=="4" goto format_partition
if "%choice%"=="5" goto resize_partition
if "%choice%"=="6" goto change_letter
if "%choice%"=="7" goto mark_active
if "%choice%"=="8" goto convert_partition
if "%choice%"=="9" goto advanced_operations
if "%choice%"=="0" goto exit
goto menu

:list_partitions
echo.
echo [INFO] Listing disk partitions...
echo.

:: List all disks and partitions
echo [1/3] Disk information:
wmic diskdrive get DeviceID,Model,Size,InterfaceType /format:list

echo.
echo [2/3] Partition information:
wmic partition get DeviceID,Size,Type,BootPartition /format:list

echo.
echo [3/3] Volume information:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType,FileSystem /format:list

pause
goto menu

:create_partition
echo.
echo [INFO] Creating partition...
echo.

echo [WARNING] This will use diskpart to create partitions
echo [WARNING] Make sure you have backups before proceeding
echo.

set /p disk_number="Enter disk number (e.g., 0): "
if "%disk_number%"=="" goto menu

set /p partition_size="Enter partition size in MB (leave empty for maximum): "
set /p partition_type="Enter partition type (PRIMARY/EXTENDED): "

if "%partition_type%"=="" set partition_type=PRIMARY

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\create_partition.txt"
echo create partition %partition_type% >> "%TEMP%\create_partition.txt"

if not "%partition_size%"=="" (
    echo size=%partition_size% >> "%TEMP%\create_partition.txt"
)

echo assign letter= >> "%TEMP%\create_partition.txt"
echo format fs=ntfs quick >> "%TEMP%\create_partition.txt"

echo [INFO] Creating partition...
diskpart /s "%TEMP%\create_partition.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition created successfully
) else (
    echo [ERROR] Failed to create partition
)

del "%TEMP%\create_partition.txt" 2>nul
pause
goto menu

:delete_partition
echo.
echo [WARNING] This will delete a partition and all data on it!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Available partitions:
wmic partition get DeviceID,Size,Type /format:list

echo.
set /p partition_number="Enter partition number to delete: "
if "%partition_number%"=="" goto menu

:: Create diskpart script
echo select partition %partition_number% > "%TEMP%\delete_partition.txt"
echo delete partition override >> "%TEMP%\delete_partition.txt"

echo [INFO] Deleting partition...
diskpart /s "%TEMP%\delete_partition.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition deleted successfully
) else (
    echo [ERROR] Failed to delete partition
)

del "%TEMP%\delete_partition.txt" 2>nul
pause
goto menu

:format_partition
echo.
echo [INFO] Formatting partition...
echo.

echo [WARNING] This will format a partition and delete all data!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Available partitions:
wmic logicaldisk get DeviceID,VolumeName,Size,FileSystem /format:list

echo.
set /p drive_letter="Enter drive letter to format (e.g., D): "
if "%drive_letter%"=="" goto menu

set /p file_system="Enter file system (NTFS/FAT32/exFAT): "
if "%file_system%"=="" set file_system=NTFS

set /p volume_label="Enter volume label (optional): "
set /p quick_format="Quick format? [Y/N]: "
if /i "%quick_format%"=="Y" set quick_option=quick

:: Create diskpart script
echo select volume %drive_letter% > "%TEMP%\format_partition.txt"
echo format fs=%file_system% %quick_option% >> "%TEMP%\format_partition.txt"

if not "%volume_label%"=="" (
    echo label=%volume_label% >> "%TEMP%\format_partition.txt"
)

echo [INFO] Formatting partition...
diskpart /s "%TEMP%\format_partition.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition formatted successfully
) else (
    echo [ERROR] Failed to format partition
)

del "%TEMP%\format_partition.txt" 2>nul
pause
goto menu

:resize_partition
echo.
echo [INFO] Resizing partition...
echo.

echo [WARNING] Resizing partitions can cause data loss!
set /p confirm="Do you have backups? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [1] Shrink Partition
echo [2] Extend Partition
echo [0] Back to main menu
echo.
set /p resize_choice="Select an option [0-2]: "

if "%resize_choice%"=="1" goto shrink_partition
if "%resize_choice%"=="2" goto extend_partition
if "%resize_choice%"=="0" goto menu
goto resize_partition

:shrink_partition
echo.
echo [INFO] Available partitions:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace /format:list

echo.
set /p drive_letter="Enter drive letter to shrink (e.g., D): "
if "%drive_letter%"=="" goto resize_partition

set /p shrink_size="Enter amount to shrink in MB: "
if "%shrink_size%"=="" goto resize_partition

:: Create diskpart script
echo select volume %drive_letter% > "%TEMP%\shrink_partition.txt"
echo shrink desired=%shrink_size% minimum=%shrink_size% >> "%TEMP%\shrink_partition.txt"

echo [INFO] Shrinking partition...
diskpart /s "%TEMP%\shrink_partition.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition shrunk successfully
) else (
    echo [ERROR] Failed to shrink partition
)

del "%TEMP%\shrink_partition.txt" 2>nul
pause
goto resize_partition

:extend_partition
echo.
echo [INFO] Available partitions:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace /format:list

echo.
set /p drive_letter="Enter drive letter to extend (e.g., D): "
if "%drive_letter%"=="" goto resize_partition

set /p extend_size="Enter amount to extend in MB (leave empty for maximum): "

:: Create diskpart script
echo select volume %drive_letter% > "%TEMP%\extend_partition.txt"

if not "%extend_size%"=="" (
    echo extend size=%extend_size% >> "%TEMP%\extend_partition.txt"
) else (
    echo extend >> "%TEMP%\extend_partition.txt"
)

echo [INFO] Extending partition...
diskpart /s "%TEMP%\extend_partition.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition extended successfully
) else (
    echo [ERROR] Failed to extend partition
)

del "%TEMP%\extend_partition.txt" 2>nul
pause
goto resize_partition

:change_letter
echo.
echo [INFO] Changing drive letter...
echo.

echo [INFO] Current drive letters:
wmic logicaldisk get DeviceID,VolumeName /format:list

echo.
set /p old_letter="Enter current drive letter: "
if "%old_letter%"=="" goto menu

set /p new_letter="Enter new drive letter: "
if "%new_letter%"=="" goto menu

:: Create diskpart script
echo select volume %old_letter% > "%TEMP%\change_letter.txt"
echo assign letter=%new_letter% >> "%TEMP%\change_letter.txt"

echo [INFO] Changing drive letter...
diskpart /s "%TEMP%\change_letter.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Drive letter changed successfully
) else (
    echo [ERROR] Failed to change drive letter
)

del "%TEMP%\change_letter.txt" 2>nul
pause
goto menu

:mark_active
echo.
echo [INFO] Marking partition as active...
echo.

echo [WARNING] This will mark a partition as active for booting!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Available partitions:
wmic partition get DeviceID,Size,Type,BootPartition /format:list

echo.
set /p partition_number="Enter partition number to mark as active: "
if "%partition_number%"=="" goto menu

:: Create diskpart script
echo select partition %partition_number% > "%TEMP%\mark_active.txt"
echo active >> "%TEMP%\mark_active.txt"

echo [INFO] Marking partition as active...
diskpart /s "%TEMP%\mark_active.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Partition marked as active
) else (
    echo [ERROR] Failed to mark partition as active
)

del "%TEMP%\mark_active.txt" 2>nul
pause
goto menu

:convert_partition
echo.
echo [INFO] Converting partition...
echo.

echo [1] Convert to MBR
echo [2] Convert to GPT
echo [3] Convert to Dynamic
echo [0] Back to main menu
echo.
set /p convert_choice="Select an option [0-3]: "

if "%convert_choice%"=="1" goto convert_mbr
if "%convert_choice%"=="2" goto convert_gpt
if "%convert_choice%"=="3" goto convert_dynamic
if "%convert_choice%"=="0" goto menu
goto convert_partition

:convert_mbr
echo.
echo [WARNING] Converting to MBR will delete all partitions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto convert_partition

set /p disk_number="Enter disk number to convert: "
if "%disk_number%"=="" goto convert_partition

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\convert_mbr.txt"
echo clean >> "%TEMP%\convert_mbr.txt"
echo convert mbr >> "%TEMP%\convert_mbr.txt"

echo [INFO] Converting to MBR...
diskpart /s "%TEMP%\convert_mbr.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Disk converted to MBR
) else (
    echo [ERROR] Failed to convert to MBR
)

del "%TEMP%\convert_mbr.txt" 2>nul
pause
goto convert_partition

:convert_gpt
echo.
echo [WARNING] Converting to GPT will delete all partitions!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto convert_partition

set /p disk_number="Enter disk number to convert: "
if "%disk_number%"=="" goto convert_partition

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\convert_gpt.txt"
echo clean >> "%TEMP%\convert_gpt.txt"
echo convert gpt >> "%TEMP%\convert_gpt.txt"

echo [INFO] Converting to GPT...
diskpart /s "%TEMP%\convert_gpt.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Disk converted to GPT
) else (
    echo [ERROR] Failed to convert to GPT
)

del "%TEMP%\convert_gpt.txt" 2>nul
pause
goto convert_partition

:convert_dynamic
echo.
echo [INFO] Converting to dynamic disk...
echo.

set /p disk_number="Enter disk number to convert: "
if "%disk_number%"=="" goto convert_partition

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\convert_dynamic.txt"
echo convert dynamic >> "%TEMP%\convert_dynamic.txt"

echo [INFO] Converting to dynamic disk...
diskpart /s "%TEMP%\convert_dynamic.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Disk converted to dynamic
) else (
    echo [ERROR] Failed to convert to dynamic
)

del "%TEMP%\convert_dynamic.txt" 2>nul
pause
goto convert_partition

:advanced_operations
echo.
echo [INFO] Advanced Partition Operations...
echo.

echo [1] Clean Disk
echo [2] Create EFI System Partition
echo [3] Create Recovery Partition
echo [4] Check Disk Integrity
echo [5] Repair Partition
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto clean_disk
if "%adv_choice%"=="2" goto create_efi
if "%adv_choice%"=="3" goto create_recovery
if "%adv_choice%"=="4" goto check_integrity
if "%adv_choice%"=="5" goto repair_partition
if "%adv_choice%"=="0" goto menu
goto advanced_operations

:clean_disk
echo.
echo [WARNING] This will completely wipe the disk!
set /p confirm="Are you absolutely sure? [Y/N]: "
if /i not "%confirm%"=="Y" goto advanced_operations

set /p disk_number="Enter disk number to clean: "
if "%disk_number%"=="" goto advanced_operations

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\clean_disk.txt"
echo clean >> "%TEMP%\clean_disk.txt"

echo [INFO] Cleaning disk...
diskpart /s "%TEMP%\clean_disk.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Disk cleaned
) else (
    echo [ERROR] Failed to clean disk
)

del "%TEMP%\clean_disk.txt" 2>nul
pause
goto advanced_operations

:create_efi
echo.
echo [INFO] Creating EFI System Partition...
echo.

set /p disk_number="Enter disk number: "
if "%disk_number%"=="" goto advanced_operations

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\create_efi.txt"
echo create partition efi size=100 >> "%TEMP%\create_efi.txt"
echo format fs=fat32 quick >> "%TEMP%\create_efi.txt"
echo assign letter=S >> "%TEMP%\create_efi.txt"

echo [INFO] Creating EFI System Partition...
diskpart /s "%TEMP%\create_efi.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] EFI System Partition created
) else (
    echo [ERROR] Failed to create EFI System Partition
)

del "%TEMP%\create_efi.txt" 2>nul
pause
goto advanced_operations

:create_recovery
echo.
echo [INFO] Creating Recovery Partition...
echo.

set /p disk_number="Enter disk number: "
if "%disk_number%"=="" goto advanced_operations

set /p recovery_size="Enter recovery partition size in MB: "
if "%recovery_size%"=="" set recovery_size=300

:: Create diskpart script
echo select disk %disk_number% > "%TEMP%\create_recovery.txt"
echo create partition primary size=%recovery_size% >> "%TEMP%\create_recovery.txt"
echo format fs=ntfs quick >> "%TEMP%\create_recovery.txt"
echo assign letter=R >> "%TEMP%\create_recovery.txt"
echo set id=27 >> "%TEMP%\create_recovery.txt"

echo [INFO] Creating Recovery Partition...
diskpart /s "%TEMP%\create_recovery.txt"

if %errorLevel% equ 0 (
    echo [SUCCESS] Recovery Partition created
) else (
    echo [ERROR] Failed to create Recovery Partition
)

del "%TEMP%\create_recovery.txt" 2>nul
pause
goto advanced_operations

:check_integrity
echo.
echo [INFO] Checking disk integrity...
echo.

set /p drive_letter="Enter drive letter to check (e.g., C): "
if "%drive_letter%"=="" goto advanced_operations

echo [INFO] Checking disk integrity for drive %drive_letter%:...
chkdsk %drive_letter%: /f /r

echo [SUCCESS] Disk integrity check completed
pause
goto advanced_operations

:repair_partition
echo.
echo [INFO] Repairing partition...
echo.

set /p drive_letter="Enter drive letter to repair (e.g., C): "
if "%drive_letter%"=="" goto advanced_operations

echo [INFO] Repairing partition on drive %drive_letter%:...
chkdsk %drive_letter%: /f

echo [SUCCESS] Partition repair completed
pause
goto advanced_operations

:exit
echo.
echo [INFO] Partition Manager Tool closed
exit /b 0
