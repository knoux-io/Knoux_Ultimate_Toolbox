@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: تحميل المكتبات الأساسية
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %RED%⚠️  هذا السكربت يتطلب صلاحيات مسؤول!%WHITE%
    echo %YELLOW%الحل:%WHITE% انقر بزر الماوس الأيمن واختر "تشغيل كمسؤول"
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %CYAN%===================================================%WHITE%
echo %GREEN%  🟢 Node.js LTS Installer - الإصدار المستقر%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:CHECK_EXISTING
echo %YELLOW%[1/4] جارٍ فحص التثبيت الحالي...%WHITE%
node -v >nul 2>&1 && (
    for /f "tokens=*" %%a in ('node -v') do set "CURRENT_VER=%%a"
    echo %GREEN%✓ Node.js مثبت مسبقًا:%WHITE% !CURRENT_VER!
    set /p "REINSTALL=هل تريد إعادة التثبيت؟ (y/n): "
    if /i "!REINSTALL!"=="n" goto :SUMMARY
)

:INSTALL_CHOICE
echo.
echo %CYAN%اختر طريقة التثبيت:%WHITE%
echo   %GRAY%[1]%WHITE% Winget (موصى به - سريع وآمن)
echo   %GRAY%[2]%WHITE% MSI مباشر من الموقع الرسمي
echo   %GRAY%[3]%WHITE% NVM (لإدارة إصدارات متعددة)
echo.
set /p "METHOD=رقم الطريقة: "

if "!METHOD!"=="1" goto :INSTALL_WINGET
if "!METHOD!"=="2" goto :INSTALL_MSI
if "!METHOD!"=="3" goto :INSTALL_NVM
goto :INSTALL_CHOICE

:INSTALL_WINGET
echo %YELLOW%[2/4] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 4
winget install -e --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements >nul 2>&1
if !errorlevel! equ 0 goto :VERIFY_INSTALL
echo %RED%✗ فشل التثبيت عبر Winget%WHITE%
goto :INSTALL_MSI

:INSTALL_MSI
echo %YELLOW%[2/4] جارٍ التنزيل من الموقع الرسمي...%WHITE%
set "TEMP_MSI=%TEMP%\node-lts.msi"
powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.15.0/node-v20.15.0-x64.msi' -OutFile '!TEMP_MSI!'" >nul 2>&1
if not exist "!TEMP_MSI!" (
    echo %RED%✗ فشل التنزيل - تحقق من اتصال الإنترنت%WHITE%
    exit /b 1
)
echo %YELLOW%[3/4] جارٍ التثبيت الصامت...%WHITE%
start /wait msiexec /i "!TEMP_MSI!" /quiet /norestart ADDLOCAL="NodeRuntime,NodeNpm" >nul 2>&1
del "!TEMP_MSI!" >nul 2>&1

:VERIFY_INSTALL
echo %YELLOW%[4/4] جارٍ التحقق من التثبيت...%WHITE%
timeout /t 2 >nul
node -v >nul 2>&1 && npm -v >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت - لم يتم العثور على Node.js أو NPM%WHITE%
    exit /b 1
)
for /f "tokens=*" %%a in ('node -v') do set "NODE_VER=%%a"
for /f "tokens=*" %%a in ('npm -v') do set "NPM_VER=%%a"

:SUMMARY
echo.
echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت بنجاح!%WHITE%
echo %CYAN%الإصدارات:%WHITE%
echo   Node.js : %GREEN%!NODE_VER!%WHITE%
echo   NPM     : %GREEN%!NPM_VER!%WHITE%
echo %CYAN%المسار:%WHITE% %GRAY%!USERPROFILE!\AppData\Roaming\npm%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الأوامر السريعة:%WHITE%
echo   npm init        - إنشاء مشروع جديد
echo   npm install     - تثبيت التبعيات
echo   npx create-react-app my-app - إنشاء تطبيق React
echo.

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Node.js LTS !NODE_VER! >> "!LOG_FILE!"

:: اقتراح تحسينات أداء NPM
set /p "OPTIMIZE=هل تريد تحسين أداء NPM؟ (تثبيت pnpm + إعدادات مسح مؤقت) (y/n): "
if /i "!OPTIMIZE!"=="y" (
    echo %CYAN%جارٍ تثبيت pnpm وتحسين الإعدادات...%WHITE%
    npm install -g pnpm corepack >nul 2>&1
    npm config set cache "%TEMP%\npm-cache" >nul 2>&1
    npm config set registry "https://registry.npmjs.org/" >nul 2>&1
    echo %GREEN%✓ تم تحسين أداء NPM!%WHITE%
)

timeout /t 6 >nul
exit /b 0

:LOADING_ANIMATION
set "DURATION=%1"
for /l %%i in (1,1,!DURATION!) do (
    echo %YELLOW%!RANDOM:~-1!!RANDOM:~-1!!RANDOM:~-1! جارٍ المعالجة...%WHITE%!RANDOM:~-1!!RANDOM:~-1!!RANDOM:~-1!    <nul
    timeout /t 1 >nul
    echo !BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!!BACKSPACE!    <nul
)
echo.
exit /b
