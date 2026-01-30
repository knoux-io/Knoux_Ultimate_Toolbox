@echo off
:: =================================================================
:: KNOUX CHOCOLATEY PACKAGE MANAGER
:: تثبيت Chocolatey مع مزامن الحزم
:: =================================================================
title Knoux - Chocolatey Package Manager

echo ═══════════════════════════════════════════════════════════
echo   KNOUX CHOCOLATEY + PACKAGE SYNCHRONIZER
echo   تثبيت Chocolatey مع مزامن الحزم
echo ═══════════════════════════════════════════════════════════
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] يلزم صلاحيات المسؤول!
    echo [→] يرجى تشغيل كمسؤول
    pause
    exit /b 1
)

:: Install Chocolatey
echo [→] جاري تثبيت Chocolatey...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo [✓] تم تثبيت Chocolatey!
choco --version

:: Create package synchronizer
echo [→] جاري إنشاء مزامن الحزم...
(
    echo @echo off
    echo title Knoux Chocolatey Package Synchronizer
    echo.
    echo echo [→] جاري تصدير قائمة الحزم المثبتة...
    echo choco list --local-only > chocolatey_packages.txt
    echo.
    echo echo [✓] تم حفظ قائمة الحزم في: chocolatey_packages.txt
    echo echo.
    echo echo [→] لاستعادة الحزم على جهاز آخر:
    echo echo 1. انسخ ملف chocolatey_packages.txt
    echo echo 2. شغل: choco install -y ^<package_list^>
    echo pause
) > "%USERPROFILE%\chocolatey_sync.bat"

echo [✓] تم إنشاء مزامن الحزم!
pause
