@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🏝️  Pipenv - إدارة بيئات Python الذكية%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

pipenv --version >nul 2>&1 && (
    echo %GREEN%✓ Pipenv مثبت مسبقًا%WHITE%
    pipenv --version
    goto :USAGE
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
pip install --user pipenv >nul 2>&1

pipenv --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:USAGE
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
pipenv --version

echo.
echo %CYAN%كيفية الاستخدام:%WHITE%
echo   1. اذهب إلى مجلد مشروعك: %GRAY%cd myproject%WHITE%
echo   2. إنشاء بيئة + تثبيت حزم: %GRAY%pipenv install django%WHITE%
echo   3. تفعيل البيئة: %GRAY%pipenv shell%WHITE%
echo   4. تشغيل سكربت داخل البيئة: %GRAY%pipenv run python app.py%WHITE%
echo.
echo %CYAN%مزايا Pipenv:%WHITE%
echo   ✓ يدمج virtualenv + pip + إدارة التبعيات
echo   ✓ ينشئ Pipfile (أفضل من requirements.txt)
echo   ✓ يدعم تبعيات التطوير (dev-packages)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Pipenv for Python environment management >> "!LOG_FILE!"

timeout /t 6 >nul
