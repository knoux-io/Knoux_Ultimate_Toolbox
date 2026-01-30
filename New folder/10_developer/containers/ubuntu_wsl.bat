@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🐧 Ubuntu في WSL2 - بيئة لينكس كاملة%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

wsl -d Ubuntu-22.04 -- bash -c "exit 0" >nul 2>&1 && (
    echo %GREEN%✓ Ubuntu 22.04 مثبت مسبقًا%WHITE%
    wsl -d Ubuntu-22.04 -- cat /etc/os-release | findstr "PRETTY_NAME"
    goto :CUSTOMIZE
)

echo %YELLOW%جارٍ التثبيت من متجر مايكروسوفت...%WHITE%
echo %GRAY%(قد يستغرق 3-10 دقائق حسب سرعة الإنترنت)%WHITE%

wsl --install -d Ubuntu-22.04 >nul 2>&1

:: الانتظار حتى يكتمل التثبيت
:WAIT_INSTALL
timeout /t 5 >nul
wsl -d Ubuntu-22.04 -- bash -c "exit 0" >nul 2>&1 || goto :WAIT_INSTALL

:CUSTOMIZE
echo %YELLOW%جارٍ التخصيص للبيئة العربية...%WHITE%

:: تهيئة اللغة العربية
wsl -d Ubuntu-22.04 -- bash -c "sudo apt update && sudo apt install -y language-pack-ar locales" >nul 2>&1
wsl -d Ubuntu-22.04 -- bash -c "sudo locale-gen ar_SA.UTF-8" >nul 2>&1
wsl -d Ubuntu-22.04 -- bash -c "echo 'export LANG=ar_SA.UTF-8' >> ~/.bashrc" >nul 2>&1
wsl -d Ubuntu-22.04 -- bash -c "echo 'export LANGUAGE=ar_SA:ar' >> ~/.bashrc" >nul 2>&1

:: تثبيت أدوات المطور الأساسية
wsl -d Ubuntu-22.04 -- bash -c "sudo apt install -y git curl wget vim nano zsh tmux htop" >nul 2>&1

:: تهيئة Git للعربية
wsl -d Ubuntu-22.04 -- bash -c "git config --global core.quotepath false" >nul 2>&1
wsl -d Ubuntu-22.04 -- bash -c "git config --global i18n.logoutputencoding utf-8" >nul 2>&1

echo %GREEN%✓ تم التخصيص الكامل للبيئة العربية%WHITE%

echo.
echo %CYAN%الوصول إلى أوبونتو:%WHITE%
echo   • افتح موجه الأوامر واكتب: %CYAN%wsl%WHITE%
echo   • أو ابحث في قائمة ابدأ عن "Ubuntu"
echo.
echo %CYAN%نصائح هامة:%WHITE%
echo   • المجلدات المشتركة: /mnt/c ← قرص C في ويندوز
echo   • لتشغيل أوامر ويندوز من لينكس: %GRAY%cmd.exe /c dir%WHITE%
echo   • لتشغيل أوامر لينكس من ويندوز: %GRAY%wsl ls -la%WHITE%
echo   • لتحرير ملفات لينكس بمحرر ويندوز: %GRAY%code /path/to/file%WHITE% (مع VS Code)

:: اختبار دعم العربية
wsl -d Ubuntu-22.04 -- bash -c "echo 'مرحباً بك في أوبونتو داخل WSL2! 🐧'"

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed and customized Ubuntu 22.04 in WSL2 with Arabic support >> "!LOG_FILE!"

timeout /t 8 >nul
