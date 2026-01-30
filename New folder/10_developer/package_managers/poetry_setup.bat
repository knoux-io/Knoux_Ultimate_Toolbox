@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  📜 Poetry - مدير حزم حديث لـ Python%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

poetry --version >nul 2>&1 && (
    echo %GREEN%✓ Poetry مثبت مسبقًا%WHITE%
    poetry --version
    goto :SHOW_FEATURES
)

echo %YELLOW%جارٍ التثبيت عبر المثبت الرسمي...%WHITE%
powershell -Command "(Invoke-WebRequest -Uri https://install.python-poetry.org  -UseBasicParsing).Content | python -" >nul 2>&1

:: إضافة إلى PATH
set "POETRY_HOME=%APPDATA%\Python\Scripts"
if not exist "!POETRY_HOME!" set "POETRY_HOME=%LOCALAPPDATA%\pypoetry"
setx PATH "%PATH%;!POETRY_HOME!\bin" >nul

timeout /t 3 >nul
poetry --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:SHOW_FEATURES
echo %GREEN%✓ تم التثبيت بنجاح%WHITE%
poetry --version

echo.
echo %CYAN%لماذا Poetry؟%WHITE%
echo   ✓ إدارة التبعيات + البيئات في أداة واحدة
echo   ✓ دعم كامل لـ PEP 517/518
echo   ✓ إنشاء وتوزيع حزم بايثون بسهولة
echo   ✓ قفل الإصدارات بدقة (poetry.lock)
echo.
echo %CYAN%البدء السريع:%WHITE%
echo   poetry new myproject     ← مشروع جديد
echo   cd myproject
echo   poetry add requests      ← إضافة حزمة
echo   poetry install           ← تثبيت كل التبعيات

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Poetry (modern Python packaging) >> "!LOG_FILE!"

timeout /t 6 >nul
