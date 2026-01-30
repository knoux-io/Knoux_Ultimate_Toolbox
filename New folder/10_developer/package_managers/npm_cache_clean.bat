@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🧹 تنظيف ذاكرة التخزين المؤقت لـ NPM%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

npm -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    exit /b 1
)

:: عرض حجم الكاش الحالي
for /f "tokens=*" %%a in ('npm config get cache 2^>nul') do set "CACHE_DIR=%%a"
if exist "!CACHE_DIR!" (
    echo %CYAN%مجلد الكاش الحالي:%WHITE% !CACHE_DIR!
    dir /a /s "!CACHE_DIR!" 2>nul | findstr "File(s)"
)

echo.
echo %YELLOW%الخيارات:%WHITE%
echo   [1] تنظيف كامل (موصى به)
echo   [2] إصلاح الكاش التالف
echo   [3] تغيير مسار الكاش إلى مجلد مؤقت
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="1" (
    echo %YELLOW%جارٍ التنظيف...%WHITE%
    npm cache clean --force >nul 2>&1
    echo %GREEN%✓ تم التنظيف%WHITE%
)

if "!CHOICE!"=="2" (
    echo %YELLOW%جارٍ الإصلاح...%WHITE%
    npm cache verify >nul 2>&1
    echo %GREEN%✓ تم التحقق والإصلاح%WHITE%
)

if "!CHOICE!"=="3" (
    set "NEW_CACHE=%TEMP%\npm-cache"
    npm config set cache "!NEW_CACHE!" >nul 2>&1
    echo %GREEN%✓ تم تغيير مسار الكاش إلى: !NEW_CACHE!%WHITE%
    echo %GRAY%(سيتم مسحه تلقائيًا عند إعادة التشغيل)%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] INFO: NPM cache cleaned/optimized >> "!LOG_FILE!"

timeout /t 4 >nul
