@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول لتثبيت Chocolatey%WHITE%
    echo %YELLOW%الحل:%WHITE% انقر بزر الماوس الأيمن واختر "تشغيل كمسؤول"
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %BROWN%===================================================%WHITE%
echo %BROWN%  🍫 Chocolatey - مدير حزم Windows القوي%WHITE%
echo %BROWN%===================================================%WHITE%
echo.

:CHECK_EXISTING
choco -v >nul 2>&1 && (
    echo %GREEN%✓ Chocolatey مثبت مسبقًا%WHITE%
    for /f "tokens=*" %%a in ('choco -v') do set "VER=%%a"
    echo الإصدار الحالي: %CYAN%!VER!%WHITE%
    goto :POST_INSTALL
)

:INSTALL
echo %YELLOW%[1/3] جارٍ تنزيل وتثبيت Chocolatey...%WHITE%
echo %GRAY%(قد يستغرق 1-2 دقيقة حسب سرعة الإنترنت)%WHITE%

:: تثبيت رسمي عبر PowerShell (الطريقة الموصى بها)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1 '))" >nul 2>&1

timeout /t 3 >nul
choco -v >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحلول البديلة:%WHITE%
    echo   1. تأكد من تفعيل PowerShell Scripts (Set-ExecutionPolicy RemoteSigned)
    echo   2. جرب التثبيت اليدوي من: https://chocolatey.org/install 
    timeout /t 6 >nul
    exit /b 1
)

:POST_INSTALL
echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
choco -v

echo.
echo %CYAN%[2/3] جارٍ تحسين الإعدادات...%WHITE%
choco feature enable -n=allowGlobalConfirmation >nul 2>&1
choco feature enable -n=useRememberedArgumentsForUpgrades >nul 2>&1
choco config set cacheLocation "%TEMP%\choco-cache" >nul 2>&1

echo %GREEN%✓ تم تحسين الأداء والتجربة%WHITE%

echo.
echo %CYAN%[3/3] تثبيت الحزم الأساسية للمطورين...%WHITE%
set /p "INSTALL_BASE=هل تريد تثبيت حزمة التطوير الأساسية؟ (VS Code, Git, Node.js, Python) (y/n): "

if /i "!INSTALL_BASE!"=="y" (
    call :LOADING_ANIMATION 5
    choco install -y vscode git nodejs-lts python3 7zip >nul 2>&1
    echo %GREEN%✓ تم تثبيت الحزمة الأساسية%WHITE%
)

echo.
echo %GREEN%===================================================%WHITE%
echo %CYAN%أوامر شائعة:%WHITE%
echo   choco install packageName   ← تثبيت حزمة
echo   choco upgrade all -y       ← تحديث كل الحزم
echo   choco list --local-only    ← عرض الحزم المثبتة
echo   choco search keyword       ← البحث عن حزمة
echo %GREEN%===================================================%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Chocolatey !VER! with dev packages >> "!LOG_FILE!"

timeout /t 6 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    echo !BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!    <nul
)
echo.
exit /b
