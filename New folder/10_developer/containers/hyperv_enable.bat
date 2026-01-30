@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  💠 تفعيل Hyper-V - افتراضية مايكروسوفت الرسمية%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:: التحقق من دعم الأجهزة
echo %YELLOW%جارٍ التحقق من دعم الأجهزة...%WHITE%
wmic cpu get VirtualizationFirmwareEnabled | findstr "TRUE" >nul || (
    echo %RED%✗ وحدة المعالجة المركزية لا تدعم الافتراضية%WHITE%
    echo %YELLOW%الحل: تحقق من تفعيل "Virtualization Technology" في BIOS/UEFI%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

bcdedit /enum firmware | findstr "hypervisorlaunchtype" | findstr "Auto" >nul && (
    echo %GREEN%✓ Hyper-V مفعل مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%جارٍ تفعيل مكونات Hyper-V...%WHITE%
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart >nul 2>&1
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-Management-PowerShell /all /norestart >nul 2>&1
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-Hypervisor /all /norestart >nul 2>&1

bcdedit /set hypervisorlaunchtype auto >nul 2>&1

echo %GREEN%✓ تم تفعيل Hyper-V بنجاح%WHITE%
echo %RED%⚠️  مطلوب إعادة تشغيل النظام لتفعيل التغييرات%WHITE%
echo.
set /p "REBOOT=هل تريد إعادة التشغيل الآن؟ (y/n): "
if /i "!REBOOT!"=="y" (
    shutdown /r /t 15 /c "إعادة التشغيل لتفعيل Hyper-V - Knoux Toolbox"
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Enabled Hyper-V virtualization platform >> "!LOG_FILE!"

timeout /t 4 >nul
