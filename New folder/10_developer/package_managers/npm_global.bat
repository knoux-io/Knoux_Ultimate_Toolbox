@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  📦 NPM Global Packages Manager%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:: فحص وجود Node.js/NPM
npm -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض الحزم العالمية المثبتة
echo   [2] تثبيت حزمة عالمية
echo   [3] تحديث جميع الحزم العالمية
echo   [4] إصلاح أذونات NPM (مشكلة common)
echo   [5] تغيير مجلد التثبيت العالمي (لتلافي مشاكل الأذونات)
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :LIST_PACKAGES
if "!CHOICE!"=="2" goto :INSTALL_PACKAGE
if "!CHOICE!"=="3" goto :UPDATE_ALL
if "!CHOICE!"=="4" goto :FIX_PERMISSIONS
if "!CHOICE!"=="5" goto :CHANGE_PREFIX
goto :MENU

:LIST_PACKAGES
echo.
echo %CYAN%الحزم العالمية المثبتة:%WHITE%
npm list -g --depth=0
pause
goto :MENU

:INSTALL_PACKAGE
set /p "PKG_NAME=اسم الحزمة (مثل: typescript, vercel): "
echo %YELLOW%جارٍ التثبيت...%WHITE%
npm install -g !PKG_NAME! >nul 2>&1 && (
    echo %GREEN%✓ تم التثبيت: !PKG_NAME!%WHITE%
) || (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل: جرب الخيار [4] لإصلاح الأذونات أولاً%WHITE%
)
goto :MENU

:UPDATE_ALL
echo %YELLOW%جارٍ تحديث جميع الحزم...%WHITE%
npm update -g >nul 2>&1
npm outdated -g --depth=0
echo %GREEN%✓ اكتمل التحديث%WHITE%
pause
goto :MENU

:FIX_PERMISSIONS
echo %YELLOW%إصلاح أذونات مجلد NPM العالمي...%WHITE%
set "NPM_PREFIX=%APPDATA%\npm"
if not exist "!NPM_PREFIX!" mkdir "!NPM_PREFIX!" >nul
setx PATH "%PATH%;!NPM_PREFIX!" >nul

:: إصلاح أذونات المجلد
icacls "!NPM_PREFIX!" /grant "%USERNAME%:(F)" /t >nul 2>&1

echo %GREEN%✓ تم إصلاح الأذونات%WHITE%
echo %GRAY%الآن يمكنك تثبيت الحزم بدون "تشغيل كمسؤول"%WHITE%
pause
goto :MENU

:CHANGE_PREFIX
echo %YELLOW%تغيير مجلد التثبيت العالمي إلى مجلد المستخدم...%WHITE%
set "NEW_PREFIX=%USERPROFILE%\.npm-global"
if not exist "!NEW_PREFIX!" mkdir "!NEW_PREFIX!" >nul
npm config set prefix "!NEW_PREFIX!" >nul 2>&1
setx PATH "%PATH%;!NEW_PREFIX!\bin" >nul

echo %GREEN%✓ تم التغيير بنجاح%WHITE%
echo المسار الجديد: %CYAN%!NEW_PREFIX!\bin%WHITE%
echo %GRAY%(أعد فتح موجه الأوامر لتفعيل التغيير)%WHITE%
pause
goto :MENU
