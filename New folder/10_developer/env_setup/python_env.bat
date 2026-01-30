@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🏝️  Python Virtual Environment Manager%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:: فحص وجود Python
python -c "import sys; print(sys.version)" >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل python_312.bat أولاً%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] إنشاء بيئة جديدة
echo   [2] تفعيل بيئة موجودة
echo   [3] حذف بيئة
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :CREATE_ENV
if "!CHOICE!"=="2" goto :ACTIVATE_ENV
if "!CHOICE!"=="3" goto :DELETE_ENV
goto :MENU

:CREATE_ENV
set /p "ENV_NAME=اسم البيئة (مثل: myenv): "
set /p "PYTHON_VER=الإصدار (3.12/3.11/تفريغ لأحدث): "

if "!PYTHON_VER!"=="" (
    python -m venv "!ENV_NAME!" >nul 2>&1
) else (
    py -!PYTHON_VER! -m venv "!ENV_NAME!" >nul 2>&1
)

if exist "!ENV_NAME!\Scripts\activate.bat" (
    echo %GREEN%✓ تم إنشاء البيئة: !ENV_NAME!%WHITE%
    echo %YELLOW%للتفعيل: !ENV_NAME!\Scripts\activate%WHITE%
) else (
    echo %RED%✗ فشل الإنشاء%WHITE%
)
goto :MENU

:ACTIVATE_ENV
set /p "ENV_PATH=مسار البيئة: "
if exist "!ENV_PATH!\Scripts\activate.bat" (
    call "!ENV_PATH!\Scripts\activate.bat"
    echo %GREEN%✓ تم التفعيل%WHITE%
    echo %GRAY%(اكتب 'deactivate' للخروج من البيئة)%WHITE%
) else (
    echo %RED%✗ البيئة غير موجودة%WHITE%
)
goto :MENU

:DELETE_ENV
set /p "ENV_PATH=مسار البيئة للحذف: "
if exist "!ENV_PATH!" (
    rmdir /s /q "!ENV_PATH!" >nul 2>&1
    echo %GREEN%✓ تم الحذف%WHITE%
) else (
    echo %RED%✗ المسار غير موجود%WHITE%
)
goto :MENU
