@echo off
chcp 65001 >nul
title Prefetch Cleaner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    Prefetch Cleaner Tool                     ║
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

echo [INFO] Starting prefetch cleanup...
echo.

:: Display current prefetch status
echo [1/4] Current prefetch status:
if exist "%WINDIR%\Prefetch\*.pf" (
    dir "%WINDIR%\Prefetch\*.pf" | find "File(s)"
) else (
    echo No prefetch files found
)
echo.

:: Clean prefetch files
echo [2/4] Cleaning prefetch files...
del /q /f "%WINDIR%\Prefetch\*.pf" 2>nul
if %errorLevel% equ 0 (
    echo [SUCCESS] Prefetch files cleaned
) else (
    echo [WARNING] Some prefetch files could not be deleted
)

:: Clean layout files
echo [3/4] Cleaning layout files...
del /q /f "%WINDIR%\Prefetch\*.db" 2>nul
del /q /f "%WINDIR%\Prefetch\*.ini" 2>nul
echo [SUCCESS] Layout files cleaned

:: Optimize prefetch settings
echo [4/4] Optimizing prefetch settings...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul
echo [SUCCESS] Prefetch settings optimized

:: Restart Superfetch service
echo.
echo [INFO] Restarting Superfetch service...
net stop "SysMain" 2>nul
timeout /t 2 >nul
net start "SysMain" 2>nul
echo [SUCCESS] Superfetch service restarted

:: Display cleanup results
echo.
echo [INFO] Cleanup results:
if exist "%WINDIR%\Prefetch\*.pf" (
    dir "%WINDIR%\Prefetch\*.pf" | find "File(s)"
) else (
    echo Prefetch directory is now clean
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Prefetch Cleanup Complete                  ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [INFO] Prefetch cleanup completed successfully!
echo [INFO] Windows will rebuild prefetch files as needed.
echo [INFO] System startup may be slightly slower initially.
echo.
pause
