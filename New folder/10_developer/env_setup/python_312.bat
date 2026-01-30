@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

net session >nul 2>&1 || (
    echo %RED%⚠️  صلاحيات مسؤول مطلوبة%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🐍 Python 3.12 Installer - مع أدوات التطوير%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:: فحص التثبيت الحالي
python --version 2>&1 | findstr "3.12" >nul && (
    echo %GREEN%✓ Python 3.12 مثبت مسبقًا%WHITE%
    python --version
    goto :POST_INSTALL
)

:: اختيار المكونات
echo %CYAN%اختر المكونات المطلوبة:%WHITE%
echo   [1] Python أساسي + pip (موصى به)
echo   [2] + أدوات تطوير (venv, test, idle)
echo   [3] + تجميع (py launcher, اختصارات)
set /p "COMPONENTS=اختر (1/2/3): "

if "!COMPONENTS!"=="1" set "OPTS=/quiet InstallAllUsers=1 PrependPath=1"
if "!COMPONENTS!"=="2" set "OPTS=/quiet InstallAllUsers=1 PrependPath=1 Include_test=1 Include_dev=1"
if "!COMPONENTS!"=="3" set "OPTS=/quiet InstallAllUsers=1 PrependPath=1 Include_launcher=1"

:: التنزيل والتثبيت
echo %YELLOW%جارٍ تنزيل Python 3.12.4...%WHITE%
set "INSTALLER=%TEMP%\python-3.12.4-amd64.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.4/python-3.12.4-amd64.exe' -OutFile '!INSTALLER!'" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

echo %YELLOW%جارٍ التثبيت الصامت...%WHITE%
start /wait "" "!INSTALLER!" !OPTS! >nul 2>&1
del "!INSTALLER!" >nul 2>&1

:: التحقق
python --version 2>&1 | findstr "3.12" >nul || (
    echo %RED%✗ فشل التثبيت - جرب إعادة التشغيل%WHITE%
    exit /b 1
)

for /f "tokens=*" %%a in ('python --version 2^>nul') do set "PY_VER=%%a"
echo %GREEN%✓ تم التثبيت: !PY_VER!%WHITE%

:POST_INSTALL
:: تثبيت حزم أساسية
echo.
echo %YELLOW%جارٍ تثبيت الحزم الأساسية...%WHITE%
pip install --upgrade pip setuptools wheel >nul 2>&1
pip install virtualenv pylint black flake8 >nul 2>&1

echo %GREEN%✓ تم إعداد بيئة تطوير Python كاملة!%WHITE%
echo.
echo %CYAN%الأوامر السريعة:%WHITE%
echo   python -m venv myenv    - إنشاء بيئة افتراضية
echo   pip install package    - تثبيت حزمة
echo   python -m http.server  - خادم ويب بسيط على المنفذ 8000

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Python 3.12 with dev tools >> "!LOG_FILE!"

timeout /t 5 >nul
