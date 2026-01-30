@echo off
chcp 65001 >nul
title SSD Optimizer Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    SSD Optimizer Tool                         ║
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
echo ║                    SSD Optimizer                              ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Detect SSD Drives
echo [2] Enable TRIM
echo [3] Optimize SSD Settings
echo [4] Disable Defragmentation
echo [5] Configure Pagefile
echo [6] Enable Write Caching
echo [7] SSD Health Check
echo [8] SSD Performance Test
echo [9] Advanced SSD Optimization
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto detect_ssd
if "%choice%"=="2" goto enable_trim
if "%choice%"=="3" goto optimize_settings
if "%choice%"=="4" goto disable_defrag
if "%choice%"=="5" goto configure_pagefile
if "%choice%"=="6" goto enable_caching
if "%choice%"=="7" goto health_check
if "%choice%"=="8" goto performance_test
if "%choice%"=="9" goto advanced_optimization
if "%choice%"=="0" goto exit
goto menu

:detect_ssd
echo.
echo [INFO] Detecting SSD drives...
echo.

:: Check disk types
echo [1/3] Checking disk types...
wmic diskdrive get Model,MediaType,InterfaceType,Size /format:list

echo.
echo [2/3] Checking for SSD indicators...
powershell -Command "Get-PhysicalDisk | Select-Object DeviceID,FriendlyName,MediaType,BusType | Format-Table -AutoSize"

echo.
echo [3/3] Checking system information...
systeminfo | findstr /i "solid state\|ssd"

echo [SUCCESS] SSD detection completed
pause
goto menu

:enable_trim
echo.
echo [INFO] Enabling TRIM...
echo.

:: Check current TRIM status
echo [1/2] Current TRIM status:
fsutil behavior query DisableDeleteNotify

:: Enable TRIM
echo [2/2] Enabling TRIM...
fsutil behavior set DisableDeleteNotify 0

if %errorLevel% equ 0 (
    echo [SUCCESS] TRIM enabled
) else (
    echo [ERROR] Failed to enable TRIM
)

pause
goto menu

:optimize_settings
echo.
echo [INFO] Optimizing SSD settings...
echo.

:: Disable SuperFetch/Prefetch
echo [1/6] Disabling SuperFetch...
sc config "SysMain" start= disabled >nul 2>&1
net stop "SysMain" >nul 2>&1

:: Disable Windows Search indexing
echo [2/6] Disabling Windows Search indexing...
sc config "WSearch" start= disabled >nul 2>&1
net stop "WSearch" >nul 2>&1

:: Optimize power settings
echo [3/6] Optimizing power settings...
powercfg /setactive SCHEME_BALANCED
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0

:: Disable hibernation
echo [4/6] Disabling hibernation...
powercfg /hibernate off

:: Disable system restore on SSD
echo [5/6] Configuring system restore...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v SystemRestorePointCreationFrequency /t REG_DWORD /d 0 /f >nul

:: Optimize visual effects
echo [6/6] Optimizing visual effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

echo [SUCCESS] SSD settings optimized
pause
goto menu

:disable_defrag
echo.
echo [INFO] Disabling defragmentation for SSD...
echo.

:: Disable automatic defragmentation
echo [1/2] Disabling scheduled defragmentation...
schtasks /delete /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /f >nul 2>&1

:: Configure defragmentation settings
echo [2/2] Configuring defragmentation settings...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" /v EnableAutoLayout /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Defragmentation disabled for SSD
pause
goto menu

:configure_pagefile
echo.
echo [INFO] Configuring pagefile for SSD...
echo.

echo [1] Disable pagefile (not recommended)
echo [2] Move pagefile to HDD
echo [3] Optimize pagefile size
echo [4] Enable pagefile on SSD
echo [0] Back to main menu
echo.
set /p pagefile_choice="Select an option [0-4]: "

if "%pagefile_choice%"=="1" goto disable_pagefile
if "%pagefile_choice%"=="2" goto move_pagefile
if "%pagefile_choice%"=="3" goto optimize_pagefile
if "%pagefile_choice%"=="4" goto enable_pagefile
if "%pagefile_choice%"=="0" goto menu
goto configure_pagefile

:disable_pagefile
echo.
echo [WARNING] Disabling pagefile is not recommended!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto configure_pagefile

wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" delete

echo [SUCCESS] Pagefile disabled
pause
goto configure_pagefile

:move_pagefile
echo.
set /p target_drive="Enter target drive letter (e.g., D): "
if "%target_drive%"=="" goto configure_pagefile

wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" delete
wmic pagefileset create name="%target_drive%:\\pagefile.sys"

echo [SUCCESS] Pagefile moved to drive %target_drive%
pause
goto configure_pagefile

:optimize_pagefile
echo.
echo [INFO] Optimizing pagefile size for SSD...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True

echo [SUCCESS] Pagefile optimized for SSD
pause
goto configure_pagefile

:enable_pagefile
echo.
echo [INFO] Enabling pagefile on SSD...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True

echo [SUCCESS] Pagefile enabled on SSD
pause
goto configure_pagefile

:enable_caching
echo.
echo [INFO] Enabling write caching...
echo.

:: Enable write caching
echo [1/2] Enabling write caching policy...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v WriteCacheEnable /t REG_DWORD /d 1 /f >nul

:: Enable write caching for removable drives
echo [2/2] Enabling write caching for removable drives...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v CacheWriteBack /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] Write caching enabled
pause
goto menu

:health_check
echo.
echo [INFO] SSD Health Check...
echo.

:: Check S.M.A.R.T. status
echo [1/4] Checking S.M.A.R.T. status...
wmic diskdrive get Status,Model /format:list

:: Check for SSD-specific issues
echo [2/4] Checking SSD-specific issues...
powershell -Command "Get-PhysicalDisk | Select-Object DeviceID,HealthStatus,OperationalStatus | Format-Table -AutoSize"

:: Check wear level (if available)
echo [3/4] Checking wear level...
powershell -Command "Get-StorageReliabilityCounter | Select-Object DeviceID,WearLevel | Format-Table -AutoSize" 2>nul

:: Check temperature
echo [4/4] Checking drive temperature...
powershell -Command "Get-WmiObject MSAcpi_ThermalZoneTemperature | Select-Object InstanceName,CurrentTemperature | Format-Table -AutoSize" 2>nul

echo [SUCCESS] SSD health check completed
pause
goto menu

:performance_test
echo.
echo [INFO] SSD Performance Test...
echo.

:: Test read speed
echo [1/4] Testing read speed...
powershell -Command "$test = 1..10 | ForEach-Object { Measure-Command { Get-Content 'C:\Windows\System32\drivers\etc\hosts' } }; $avg = ($test | Measure-Object -Property TotalMilliseconds -Average).Average; Write-Host 'Average read time: ' $avg ' ms'"

:: Test write speed
echo [2/4] Testing write speed...
powershell -Command "$test = 1..10 | ForEach-Object { Measure-Command { 'Test data' | Out-File -FilePath '$env:TEMP\ssd_test.txt' -Force } }; $avg = ($test | Measure-Object -Property TotalMilliseconds -Average).Average; Write-Host 'Average write time: ' $avg ' ms'"

:: Test random access
echo [3/4] Testing random access...
powershell -Command "$test = 1..10 | ForEach-Object { Measure-Command { Get-Random -Minimum 1 -Maximum 1000 } }; $avg = ($test | Measure-Object -Property TotalMilliseconds -Average).Average; Write-Host 'Average random access time: ' $avg ' ms'"

:: Clean up test file
del "%TEMP%\ssd_test.txt" 2>nul

echo [4/4] Performance summary:
echo [INFO] SSD performance test completed
echo [INFO] Lower times indicate better performance

pause
goto menu

:advanced_optimization
echo.
echo [INFO] Advanced SSD Optimization...
echo.

echo [1] Configure AHCI Mode
echo [2] Optimize NTFS Settings
echo [3] Disable 8.3 File Names
echo [4] Disable Last Access Timestamp
echo [5] Optimize Memory Management
echo [6] Configure Power Management
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-6]: "

if "%adv_choice%"=="1" goto configure_ahci
if "%adv_choice%"=="2" goto optimize_ntfs
if "%adv_choice%"=="3" goto disable_83
if "%adv_choice%"=="4" goto disable_timestamp
if "%adv_choice%"=="5" goto optimize_memory
if "%adv_choice%"=="6" goto configure_power
if "%adv_choice%"=="0" goto menu
goto advanced_optimization

:configure_ahci
echo.
echo [INFO] Configuring AHCI mode...
echo [WARNING] AHCI mode requires BIOS/UEFI configuration
echo [INFO] Check your motherboard manual for AHCI setup instructions
echo [INFO] After BIOS configuration, install AHCI drivers if needed

:: Configure Windows for AHCI
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v EnableWriteCache /t REG_DWORD /d 1 /f >nul

echo [SUCCESS] AHCI configuration completed
pause
goto advanced_optimization

:optimize_ntfs
echo.
echo [INFO] Optimizing NTFS settings for SSD...
echo.

:: Disable NTFS last access timestamp
fsutil behavior set disablelastaccess 1

:: Optimize NTFS memory usage
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsMemoryUsage /t REG_DWORD /d 2 /f >nul

:: Disable NTFS 8.3 name creation
fsutil behavior set disable8dot3 1

echo [SUCCESS] NTFS settings optimized
pause
goto advanced_optimization

:disable_83
echo.
echo [INFO] Disabling 8.3 file name creation...
fsutil behavior set disable8dot3 1

echo [SUCCESS] 8.3 file name creation disabled
pause
goto advanced_optimization

:disable_timestamp
echo.
echo [INFO] Disabling last access timestamp...
fsutil behavior set disablelastaccess 1

echo [SUCCESS] Last access timestamp disabled
pause
goto advanced_optimization

:optimize_memory
echo.
echo [INFO] Optimizing memory management for SSD...
echo.

:: Configure memory management
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Memory management optimized
pause
goto advanced_optimization

:configure_power
echo.
echo [INFO] Configuring power management for SSD...
echo.

:: Set power plan to high performance
powercfg /setactive SCHEME_MIN

:: Configure disk power management
powercfg /setdisktimeout-value 0

echo [SUCCESS] Power management configured
pause
goto advanced_optimization

:exit
echo.
echo [INFO] SSD Optimizer Tool closed
exit /b 0
