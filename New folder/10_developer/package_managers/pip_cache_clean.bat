@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🧹 تنظيف ذاكرة التخزين المؤقت لـ PIP%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

python -c "import sys" >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    exit /b 1
)

:: عرض الحجم الحالي
echo %CYAN%الموقع الحالي للكاش:%WHITE%
pip cache dir

echo %YELLOW%الحجم الحالي:%WHITE%
pip cache info | findstr "Total size"

echo.
set /p "CONFIRM=هل تريد التنظيف الآن؟ (يحرر مساحة كبيرة) (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

pip cache purge >nul 2>&1 && (
    echo %GREEN%✓ تم التنظيف الكامل%WHITE%
) || (
    echo %YELLOW%المحاولة البديلة: حذف مجلد الكاش يدويًا%WHITE%
    rmdir /s /q "%LOCALAPPDATA%\pip\Cache" >nul 2>&1 && echo %GREEN%✓ تم الحذف اليدوي%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: PIP cache cleaned >> "!LOG_FILE!"

timeout /t 3 >nul
