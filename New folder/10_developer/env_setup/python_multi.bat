@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %MAGENTA%===================================================%WHITE%
echo %MAGENTA%  🐍 Python Version Manager - إصدارات متعددة%WHITE%
echo %MAGENTA%===================================================%WHITE%
echo.

:: فحص وجود py launcher
py --list >nul 2>&1 || (
    echo %YELLOW%جارٍ تثبيت Python Launcher...%WHITE%
    winget install -e --id Python.Python.3.12 --silent >nul 2>&1
)

echo %CYAN%الإصدارات المثبتة حاليًا:%WHITE%
py --list

echo.
echo %YELLOW%الإصدارات المتاحة للتثبيت:%WHITE%
echo   [1] Python 3.12 (أحدث)
echo   [2] Python 3.11 (مستقر)
echo   [3] Python 3.10 (قديم)
echo   [4] عرض جميع الإصدارات
echo   [0] الخروج
echo.

:MENU
set /p "CHOICE=اختر: "
if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" (
    winget install -e --id Python.Python.3.12 --silent >nul 2>&1
    echo %GREEN%✓ تم تثبيت Python 3.12%WHITE%
)
if "!CHOICE!"=="2" (
    winget install -e --id Python.Python.3.11 --silent >nul 2>&1
    echo %GREEN%✓ تم تثبيت Python 3.11%WHITE%
)
if "!CHOICE!"=="3" (
    winget install -e --id Python.Python.3.10 --silent >nul 2>&1
    echo %GREEN%✓ تم تثبيت Python 3.10%WHITE%
)
if "!CHOICE!"=="4" (
    echo %CYAN%py --list-available%WHITE%
    py --list-available
    pause
)

echo.
echo %CYAN%كيفية الاستخدام:%WHITE%
echo   py -3.12 script.py   ← تشغيل بـ 3.12
echo   py -3.11 script.py   ← تشغيل بـ 3.11
echo   py -0-64             ← أحدث إصدار 64-bit

:: تسجيل العملية
echo [!TIMESTAMP!] INFO: Python multi-version manager accessed >> "!LOG_FILE!"

pause
