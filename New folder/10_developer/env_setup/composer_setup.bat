@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🎵 Composer Package Manager%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

composer -V >nul 2>&1 && (
    echo %CYAN%الإصدار الحالي:%WHITE%
    composer -V
    echo.
    set /p "UPDATE=هل تريد التحديث؟ (y/n): "
    if /i "!UPDATE!"=="y" goto :UPDATE
    exit /b 0
)

:UPDATE
echo %YELLOW%جارٍ التحديث...%WHITE%
composer self-update --quiet >nul 2>&1
if !errorlevel! equ 0 (
    echo %GREEN%✓ تم التحديث بنجاح%WHITE%
    composer -V
) else (
    echo %RED%✗ فشل التحديث%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] INFO: Composer updated to latest version >> "!LOG_FILE!"

timeout /t 3 >nul
