@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

net session >nul 2>&1 || (
    echo %RED%⚠️  صلاحيات مسؤول مطلوبة%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🐍 Python 3.11 - للتوافق مع المشاريع القديمة%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

python --version 2>&1 | findstr "3.11" >nul && (
    echo %GREEN%✓ Python 3.11 مثبت مسبقًا%WHITE%
    python --version
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%تنزيل Python 3.11.9...%WHITE%
set "INSTALLER=%TEMP%\python-3.11.9-amd64.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe' -OutFile '!INSTALLER!'" >nul 2>&1

start /wait "" "!INSTALLER!" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 >nul 2>&1
del "!INSTALLER!" >nul 2>&1

python --version 2>&1 | findstr "3.11" >nul || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
pip install --upgrade pip >nul 2>&1

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Python 3.11.9 for legacy compatibility >> "!LOG_FILE!"

echo.
echo %GRAY%ملاحظة: تم تثبيت الإصدار جنبًا إلى جنب مع باقي الإصدارات%WHITE%
echo %GRAY%استخدم 'py -3.11' للتشغيل بهذا الإصدار تحديدًا%WHITE%
timeout /t 4 >nul
