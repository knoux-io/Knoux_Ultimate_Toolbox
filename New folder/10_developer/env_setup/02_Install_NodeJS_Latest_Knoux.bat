@echo off
:: =================================================================
:: KNOUX NODE.JS LATEST INSTALLER
:: تثبيت أحدث إصدار من Node.js
:: =================================================================
title Knoux - Node.js Latest Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX NODE.JS LATEST + GLOBAL PACKAGE MANAGER
echo   تثبيت أحدث إصدار Node.js
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري البحث عن أحدث إصدار Node.js...
echo [→] هذا قد يستغرق بضع لحظات...

:: Install latest Node.js
winget install OpenJS.NodeJS --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جرب التثبيت اليدوي...
    start "" "https://nodejs.org/en/download/current/"
    echo [→] يرجى تنزيل وتثبيت أحدث إصدار يدوياً
    pause
    exit /b 1
)

echo [✓] تم تثبيت أحدث إصدار Node.js!
node --version
npm --version

:: Create global package manager
echo [→] جاري إنشاء مدير الحزم العالمي...
(
    echo @echo off
    echo title Knoux Global Package Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX GLOBAL PACKAGE MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] عرض الحزم المثبتة
    echo echo [2] تحديث جميع الحزم
    echo echo [3] البحث عن حزمة
    echo echo [4] تثبيت حزمة
    echo echo [5] إزالة حزمة
    echo echo [6] فحص الثغرات
    echo echo [7] إنشاء ملف حزم
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" npm list -g --depth=0
    echo if "%%choice%%"=="2" npm update -g
    echo if "%%choice%%"=="3" set /p pkg=اسم الحزمة: ^&^& npm search %%pkg%%
    echo if "%%choice%%"=="4" set /p pkg=اسم الحزمة: ^&^& npm install -g %%pkg%%
    echo if "%%choice%%"=="5" set /p pkg=اسم الحزمة: ^&^& npm uninstall -g %%pkg%%
    echo if "%%choice%%"=="6" npm audit
    echo if "%%choice%%"=="7" npm list -g --depth=0 ^> global_packages.txt
    echo pause
) > "%USERPROFILE%\knoux_npm_manager.bat"

echo [✓] تم إنشاء مدير الحزم العالمي!
echo [→] المسار: %USERPROFILE%\knoux_npm_manager.bat
pause
