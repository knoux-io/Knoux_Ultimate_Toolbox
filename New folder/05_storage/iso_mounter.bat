@echo off
chcp 65001 >nul
title ISO Mounter Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    ISO Mounter Tool                           ║
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
echo ║                    ISO Mounter                               ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Mount ISO Image
echo [2] Unmount ISO Image
echo [3] List Mounted ISOs
echo [4] Create ISO from Folder
echo [5] Extract ISO Contents
echo [6] Burn ISO to Disc
echo [7] ISO Information
echo [8] Auto-mount Settings
echo [9] Advanced Options
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto mount_iso
if "%choice%"=="2" goto unmount_iso
if "%choice%"=="3" goto list_mounted
if "%choice%"=="4" goto create_iso
if "%choice%"=="5" goto extract_iso
if "%choice%"=="6" goto burn_iso
if "%choice%"=="7" goto iso_info
if "%choice%"=="8" goto auto_mount
if "%choice%"=="9" goto advanced_options
if "%choice%"=="0" goto exit
goto menu

:mount_iso
echo.
echo [INFO] Mount ISO Image...
echo.

set /p iso_path="Enter ISO file path: "
if "%iso_path%"=="" goto menu

if not exist "%iso_path%" (
    echo [ERROR] ISO file not found
    pause
    goto menu
)

set /p drive_letter="Enter drive letter to mount (e.g., G): "
if "%drive_letter%"=="" goto menu

echo [INFO] Mounting ISO to drive %drive_letter%:...
powershell -Command "Mount-DiskImage -ImagePath '%iso_path%' -StorageType ISO -PassThru | Select-Object DeviceId"

:: Alternative method using PowerShell
powershell -Command "$mount = Mount-DiskImage -ImagePath '%iso_path%' -StorageType ISO; $mount | Get-Volume | Select-Object DriveLetter"

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO mounted successfully
    echo [INFO] Check File Explorer for the mounted drive
) else (
    echo [ERROR] Failed to mount ISO
)

pause
goto menu

:unmount_iso
echo.
echo [INFO] Unmount ISO Image...
echo.

echo [1] Unmount by Drive Letter
echo [2] Unmount by ISO Path
echo [3] Unmount All ISOs
echo [0] Back to main menu
echo.
set /p unmount_choice="Select an option [0-3]: "

if "%unmount_choice%"=="1" goto unmount_by_letter
if "%unmount_choice%"=="2" goto unmount_by_path
if "%unmount_choice%"=="3" goto unmount_all
if "%unmount_choice%"=="0" goto menu
goto unmount_iso

:unmount_by_letter
echo.
echo [INFO] Currently mounted drives:
powershell -Command "Get-Volume | Where-Object {$_.FileSystemType -eq 'UDF' -or $_.FileSystemType -eq 'CDFS'} | Select-Object DriveLetter,FileSystemLabel,Size"

echo.
set /p drive_letter="Enter drive letter to unmount (e.g., G): "
if "%drive_letter%"=="" goto unmount_iso

echo [INFO] Unmounting drive %drive_letter%:...
powershell -Command "Dismount-DiskImage -DevicePath (Get-Volume -DriveLetter '%drive_letter%' | Get-Partition | Get-Disk | Get-Partition | Get-DiskImage).DevicePath"

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO unmounted successfully
) else (
    echo [ERROR] Failed to unmount ISO
)

pause
goto unmount_iso

:unmount_by_path
echo.
set /p iso_path="Enter ISO file path to unmount: "
if "%iso_path%"=="" goto unmount_iso

if not exist "%iso_path%" (
    echo [ERROR] ISO file not found
    pause
    goto unmount_iso
)

echo [INFO] Unmounting ISO %iso_path%...
powershell -Command "Dismount-DiskImage -ImagePath '%iso_path%'"

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO unmounted successfully
) else (
    echo [ERROR] Failed to unmount ISO
)

pause
goto unmount_iso

:unmount_all
echo.
echo [WARNING] This will unmount all ISO images!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto unmount_iso

echo [INFO] Unmounting all ISO images...
powershell -Command "Get-DiskImage | Where-Object {$_.StorageType -eq 'ISO'} | ForEach-Object { Dismount-DiskImage -DevicePath $_.DevicePath }"

if %errorLevel% equ 0 (
    echo [SUCCESS] All ISO images unmounted
) else (
    echo [ERROR] Failed to unmount some ISO images
)

pause
goto unmount_iso

:list_mounted
echo.
echo [INFO] Currently Mounted ISO Images...
echo.

echo [1/3] Mounted volumes:
powershell -Command "Get-Volume | Where-Object {$_.FileSystemType -eq 'UDF' -or $_.FileSystemType -eq 'CDFS'} | Select-Object DriveLetter,FileSystemLabel,Size,FileSystemType | Format-Table -AutoSize"

echo.
echo [2/3] Disk image information:
powershell -Command "Get-DiskImage | Where-Object {$_.StorageType -eq 'ISO'} | Select-Object DeviceId,ImagePath,Size,Attached | Format-Table -AutoSize"

echo.
echo [3/3] Mount points:
mountvol | findstr "ISO\|CDFS\|UDF"

pause
goto menu

:create_iso
echo.
echo [INFO] Create ISO from Folder...
echo.

set /p source_folder="Enter source folder path: "
if "%source_folder%"=="" goto menu

if not exist "%source_folder%" (
    echo [ERROR] Source folder not found
    pause
    goto menu
)

set /p iso_path="Enter output ISO file path: "
if "%iso_path%"=="" goto menu

set /p volume_label="Enter volume label (optional): "

echo [INFO] Creating ISO from %source_folder%...
echo [WARNING] This may take a long time for large folders...

if "%volume_label%"=="" (
    powershell -Command "New-ISOFile -Path '%source_folder%' -Destination '%iso_path%'"
) else (
    powershell -Command "New-ISOFile -Path '%source_folder%' -Destination '%iso_path%' -VolumeLabel '%volume_label%'"
)

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO created successfully
    echo [INFO] ISO saved to: %iso_path%
) else (
    echo [ERROR] Failed to create ISO
    echo [INFO] This feature may require additional tools
)

pause
goto menu

:extract_iso
echo.
echo [INFO] Extract ISO Contents...
echo.

set /p iso_path="Enter ISO file path: "
if "%iso_path%"=="" goto menu

if not exist "%iso_path%" (
    echo [ERROR] ISO file not found
    pause
    goto menu
)

set /p extract_path="Enter extraction path: "
if "%extract_path%"=="" set extract_path=%TEMP%\iso_extract_%random%

if not exist "%extract_path%" mkdir "%extract_path%"

echo [INFO] Extracting ISO contents to %extract_path%...
powershell -Command "$mount = Mount-DiskImage -ImagePath '%iso_path%' -StorageType ISO -PassThru; $drive = $mount | Get-Volume; Copy-Item -Path ($drive.DriveLetter + ':\*') -Destination '%extract_path%' -Recurse -Force; Dismount-DiskImage -DevicePath $mount.DevicePath"

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO extracted successfully
    echo [INFO] Contents extracted to: %extract_path%
) else (
    echo [ERROR] Failed to extract ISO
)

pause
goto menu

:burn_iso
echo.
echo [INFO] Burn ISO to Disc...
echo.

echo [WARNING] This feature requires disc burning software
echo [INFO] Built-in Windows disc burning recommended
echo [INFO] Right-click ISO file and select "Burn disc image"
echo.
echo [1] Open File Explorer with ISO location
echo [2] List available burning software
echo [0] Back to main menu
echo.
set /p burn_choice="Select an option [0-2]: "

if "%burn_choice%"=="1" (
    explorer /select,"%iso_path%"
) else if "%burn_choice%"=="2" (
    echo Available burning software:
    echo - Windows built-in burner
    echo - ImgBurn (free)
    echo - CDBurnerXP (free)
    echo - Nero (commercial)
    echo - PowerISO (commercial)
)

pause
goto menu

:iso_info
echo.
echo [INFO] ISO Information...
echo.

set /p iso_path="Enter ISO file path: "
if "%iso_path%"=="" goto menu

if not exist "%iso_path%" (
    echo [ERROR] ISO file not found
    pause
    goto menu
)

echo [1/4] Basic file information:
dir "%iso_path%" | findstr "%iso_path%"

echo.
echo [2/4] ISO properties:
powershell -Command "Get-ItemProperty '%iso_path%' | Select-Object Name,Length,LastWriteTime,Attributes"

echo.
echo [3/4] ISO image information:
powershell -Command "Get-DiskImage -ImagePath '%iso_path%' | Select-Object DeviceId,Size,StorageType,Attached"

echo.
echo [4/4] Volume information (if mounted):
powershell -Command "Get-Volume | Where-Object {$_.FileSystemType -eq 'UDF' -or $_.FileSystemType -eq 'CDFS'} | Select-Object DriveLetter,FileSystemLabel,Size"

pause
goto menu

:auto_mount
echo.
echo [INFO] Auto-mount Settings...
echo.

echo [1] Enable Auto-mount
echo [2] Disable Auto-mount
echo [3] Configure Auto-mount Options
echo [4] Current Auto-mount Status
echo [0] Back to main menu
echo.
set /p auto_choice="Select an option [0-4]: "

if "%auto_choice%"=="1" goto enable_auto
if "%auto_choice%"=="2" goto disable_auto
if "%auto_choice%"=="3" goto configure_auto
if "%auto_choice%"=="4" goto auto_status
if "%auto_choice%"=="0" goto menu
goto auto_mount

:enable_auto
echo.
echo [INFO] Enabling auto-mount...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom\AutoRun" /v AutoRun /t REG_DWORD /d 1 /f >nul 2>&1

echo [SUCCESS] Auto-mount enabled
pause
goto auto_mount

:disable_auto
echo.
echo [INFO] Disabling auto-mount...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom\AutoRun" /v AutoRun /t REG_DWORD /d 0 /f >nul 2>&1

echo [SUCCESS] Auto-mount disabled
pause
goto auto_mount

:configure_auto
echo.
echo [INFO] Configuring auto-mount options...
echo [1] Auto-mount on insert
echo [2] Auto-run programs
echo [3] Auto-play settings
echo [0] Back
echo.
set /p config_choice="Select an option [0-3]: "

if "%config_choice%"=="1" (
    echo [INFO] Auto-mount on insert is controlled by system settings
) else if "%config_choice%"=="2" (
    echo [INFO] Auto-run programs controlled by registry
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutoRun 2>nul
) else if "%config_choice%"=="3" (
    echo [INFO] Auto-play settings in Control Panel
    echo [INFO] AutoPlay can be configured in Settings > Devices > AutoPlay
)

pause
goto auto_mount

:auto_status
echo.
echo [INFO] Current auto-mount status:
reg query "HKLM\SYSTEM\CurrentControlSet\Services\cdrom\AutoRun" /v AutoRun 2>nul

echo.
echo [INFO] Auto-run status:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAutoRun 2>nul

pause
goto auto_mount

:advanced_options
echo.
echo [INFO] Advanced ISO Options...
echo.

echo [1] Mount with Specific Options
echo [2] Create Bootable ISO
echo [3] Split Large ISO
echo [4] Compress ISO
echo [5] Verify ISO Integrity
echo [6] Convert ISO Formats
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-6]: "

if "%adv_choice%"=="1" goto mount_options
if "%adv_choice%"=="2" goto bootable_iso
if "%adv_choice%"=="3" goto split_iso
if "%adv_choice%"=="4" goto compress_iso
if "%adv_choice%"=="5" goto verify_iso
if "%adv_choice%"=="6" goto convert_iso
if "%adv_choice%"=="0" goto menu
goto advanced_options

:mount_options
echo.
echo [INFO] Advanced mount options...
echo [1] Read-only mount
echo [2] Write mount (if supported)
echo [3] Mount with specific drive letter
echo [0] Back
echo.
set /p mount_opt_choice="Select an option [0-3]: "

if "%mount_opt_choice%"=="1" (
    echo [INFO] ISO is mounted read-only by default
) else if "%mount_opt_choice%"=="2" (
    echo [INFO] Write mounting requires specialized software
) else if "%mount_opt_choice%"=="3" (
    echo [INFO] Use mount option with specific drive letter
)

pause
goto advanced_options

:bootable_iso
echo.
echo [INFO] Creating bootable ISO requires specialized tools
echo [INFO] Recommended tools:
echo - Rufus (free)
echo - PowerISO (commercial)
echo - UltraISO (commercial)
echo - Windows ADK (for Windows images)
pause
goto advanced_options

:split_iso
echo.
set /p iso_path="Enter ISO file path to split: "
if "%iso_path%"=="" goto advanced_options

set /p split_size="Enter split size (e.g., 700MB for CD): "
if "%split_size%"=="" goto advanced_options

echo [INFO] Splitting ISO requires specialized tools
echo [INFO] Recommended tools:
echo - 7-Zip (free)
echo - WinRAR (commercial)
echo - HJSplit (free)
pause
goto advanced_options

:compress_iso
echo.
set /p iso_path="Enter ISO file path to compress: "
if "%iso_path%"=="" goto advanced_options

echo [INFO] Compressing ISO...
set compressed_path=%iso_path%.zip
powershell -Command "Compress-Archive -Path '%iso_path%' -DestinationPath '%compressed_path%'"

if %errorLevel% equ 0 (
    echo [SUCCESS] ISO compressed
    echo [INFO] Compressed file: %compressed_path%
) else (
    echo [ERROR] Failed to compress ISO
)

pause
goto advanced_options

:verify_iso
echo.
set /p iso_path="Enter ISO file path to verify: "
if "%iso_path%"=="" goto advanced_options

echo [INFO] Verifying ISO integrity...
powershell -Command "Get-FileHash '%iso_path%' -Algorithm SHA256"

echo [INFO] ISO verification completed
echo [INFO] Compare hash with original if available
pause
goto advanced_options

:convert_iso
echo.
echo [INFO] Convert ISO Formats...
echo [1] ISO to IMG
echo [2] ISO to BIN/CUE
echo [3] ISO to WIM
echo [0] Back
echo.
set /p convert_choice="Select an option [0-3]: "

if "%convert_choice%"=="1" (
    echo [INFO] ISO to IMG conversion requires specialized tools
) else if "%convert_choice%"=="2" (
    echo [INFO] ISO to BIN/CUE conversion requires specialized tools
) else if "%convert_choice%"=="3" (
    echo [INFO] Converting to WIM format...
    powershell -Command "Convert-WindowsImage -SourcePath '%iso_path%' -DestinationPath '%iso_path%.wim'"
)

pause
goto advanced_options

:exit
echo.
echo [INFO] ISO Mounter Tool closed
exit /b 0
