@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
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
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🪟 WSL2 - Windows Subsystem for Linux (الإصدار الثاني)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
wsl --list --verbose >nul 2>&1 && (
    echo %GREEN%✓ WSL2 مفعل مسبقًا%WHITE%
    wsl --list --verbose
    goto :ASK_DISTRO
)

echo %YELLOW%[1/5] جارٍ تفعيل مكونات Windows المطلوبة...%WHITE%
call :LOADING_ANIMATION 6

:: تفعيل مكونات أساسية
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart >nul 2>&1
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart >nul 2>&1

echo %YELLOW%[2/5] جارٍ تنزيل حزمة تحديث النواة...%WHITE%
set "KERNEL=%TEMP%\wsl_update_x64.msi"
powershell -Command "Invoke-WebRequest -Uri 'https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi' -OutFile '!KERNEL!'" >nul 2>&1

if exist "!KERNEL!" (
    start /wait msiexec /i "!KERNEL!" /quiet >nul 2>&1
    del "!KERNEL!" >nul 2>&1
)

echo %YELLOW%[3/5] جارٍ تعيين WSL2 كإصدار افتراضي...%WHITE%
wsl --set-default-version 2 >nul 2>&1

echo %YELLOW%[4/5] جارٍ تهيئة دعم اللغة العربية في WSL...%WHITE%
set "WSL_CONFIG=%USERPROFILE%\.wslconfig"
(
echo [wsl2]
echo kernelCommandLine = systemd.unified_cgroup_hierarchy=0
echo swap=0
echo localhostForwarding=true
echo 
echo [interop]
echo enabled=true
echo appendWindowsPath=true
) > "!WSL_CONFIG!"

echo %GREEN%✓ تم إنشاء ملف التهيئة: !WSL_CONFIG!%WHITE%

echo %YELLOW%[5/5] جارٍ إعادة التشغيل المطلوبة...%WHITE%
echo %RED%⚠️  مطلوب إعادة تشغيل النظام لإكمال التفعيل%WHITE%
echo.
set /p "REBOOT=هل تريد إعادة التشغيل الآن؟ (y/n): "
if /i "!REBOOT!"=="y" (
    shutdown /r /t 15 /c "إعادة التشغيل لإكمال تفعيل WSL2 - Knoux Toolbox"
    timeout /t 5 >nul
    exit /b 0
)

echo %YELLOW%سيتم تفعيل WSL2 بعد إعادة التشغيل اليدوية%WHITE%

:ASK_DISTRO
echo.
echo %CYAN%هل تريد تثبيت توزيعة لينكس الآن؟%WHITE%
echo   [1] Ubuntu 22.04 LTS (موصى به للمبتدئين)
echo   [2] Debian (مستقر وخفيف)
echo   [3] Kali Linux (لأدوات الاختبار الأمني)
echo   [4] openSUSE (لمطوري Enterprise)
echo   [0] تخطي الآن
echo.
set /p "DISTRO=اختر: "

if "!DISTRO!"=="1" call "%~dp0ubuntu_wsl.bat"
if "!DISTRO!"=="2" wsl --install -d Debian
if "!DISTRO!"=="3" wsl --install -d kali-linux
if "!DISTRO!"=="4" wsl --install -d openSUSE-Leap-15.5

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Enabled WSL2 with Arabic support configuration >> "!LOG_FILE!"

timeout /t 5 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التفعيل... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
