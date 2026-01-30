@echo off
chcp 65001 >nul
title Disk Cleaner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    Disk Cleaner Tool                          ║
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

echo [INFO] Starting disk cleanup process...
echo.

:: Clean temporary files
echo [1/8] Cleaning temporary files...
del /q /s /f "%TEMP%\*.*" 2>nul
del /q /s /f "%WINDIR%\Temp\*.*" 2>nul
del /q /s /f "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
echo [SUCCESS] Temporary files cleaned

:: Clean prefetch
echo [2/8] Cleaning prefetch files...
del /q /s /f "%WINDIR%\Prefetch\*.*" 2>nul
echo [SUCCESS] Prefetch files cleaned

:: Clean recycle bin
echo [3/8] Emptying recycle bin...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo [SUCCESS] Recycle bin emptied

:: Clean browser cache
echo [4/8] Cleaning browser cache...
rmdir /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" 2>nul
rmdir /s /q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*\cache2" 2>nul
rmdir /s /q "%USERPROFILE%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" 2>nul
echo [SUCCESS] Browser cache cleaned

:: Clean Windows Update cache
echo [5/8] Cleaning Windows Update cache...
net stop wuauserv 2>nul
rmdir /s /q "%WINDIR%\SoftwareDistribution\Download" 2>nul
mkdir "%WINDIR%\SoftwareDistribution\Download" 2>nul
net start wuauserv 2>nul
echo [SUCCESS] Windows Update cache cleaned

:: Clean system error reports
echo [6/8] Cleaning system error reports...
rmdir /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportArchive" 2>nul
rmdir /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportQueue" 2>nul
echo [SUCCESS] Error reports cleaned

:: Run Windows Disk Cleanup
echo [7/8] Running Windows Disk Cleanup...
cleanmgr /sagerun:1
echo [SUCCESS] Windows Disk Cleanup completed

:: Clean thumbnail cache
echo [8/8] Cleaning thumbnail cache...
del /q /s /f "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
echo [SUCCESS] Thumbnail cache cleaned

:: Calculate space saved
echo.
echo [INFO] Calculating space saved...
for /f "tokens=3" %%a in ('dir "%TEMP%" /-c ^| find "bytes"') do set temp_size=%%a
for /f "tokens=3" %%a in ('dir "%WINDIR%\Temp" /-c ^| find "bytes"') do set windir_temp_size=%%a

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Disk Cleanup Complete                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [INFO] Disk cleanup completed successfully!
echo [INFO] Temporary files, cache, and unnecessary data have been removed.
echo [INFO] Your system should now have more free disk space.
echo.
pause
