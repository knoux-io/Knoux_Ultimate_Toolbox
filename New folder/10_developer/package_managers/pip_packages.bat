@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🐍 Python Packages Manager (PIP)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

python -c "import sys; print(sys.version)" >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\python_312.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض جميع الحزم المثبتة
echo   [2] تثبيت حزمة جديدة
echo   [3] تثبيت من ملف requirements.txt
echo   [4] تصدير الحزم الحالية إلى requirements.txt
echo   [5] إنشاء بيئة افتراضية + تثبيت الحزم
echo   [6] البحث عن حزمة
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :LIST_PACKAGES
if "!CHOICE!"=="2" goto :INSTALL_PACKAGE
if "!CHOICE!"=="3" goto :INSTALL_FROM_REQ
if "!CHOICE!"=="4" goto :EXPORT_REQ
if "!CHOICE!"=="5" goto :VENV_SETUP
if "!CHOICE!"=="6" goto :SEARCH_PACKAGE
goto :MENU

:LIST_PACKAGES
echo.
echo %CYAN%الحزم المثبتة:%WHITE%
pip list --format=columns
pause
goto :MENU

:INSTALL_PACKAGE
set /p "PKG=اسم الحزمة (مثل: django, pandas, requests): "
set /p "VERSION=الإصدار (اترك فارغًا لأحدث): "
if "!VERSION!"=="" (
    pip install !PKG! --no-cache-dir
) else (
    pip install !PKG!==!VERSION! --no-cache-dir
)
if !errorlevel! equ 0 (
    echo %GREEN%✓ تم التثبيت%WHITE%
) else (
    echo %RED%✗ فشل التثبيت%WHITE%
)
goto :MENU

:INSTALL_FROM_REQ
set /p "REQ_FILE=مسار ملف requirements.txt: "
if not exist "!REQ_FILE!" (
    echo %RED%✗ الملف غير موجود%WHITE%
    goto :MENU
)
echo %YELLOW%جارٍ التثبيت...%WHITE%
pip install -r "!REQ_FILE!" --no-cache-dir
goto :MENU

:EXPORT_REQ
set "OUTPUT=requirements_!DATE:~10,4!!DATE:~4,2!!DATE:~7,2!.txt"
pip freeze > "!OUTPUT!"
echo %GREEN%✓ تم التصدير إلى: !OUTPUT!%WHITE%
goto :MENU

:VENV_SETUP
set /p "VENV_NAME=اسم البيئة الافتراضية: "
python -m venv "!VENV_NAME!" && (
    echo %GREEN%✓ تم إنشاء البيئة%WHITE%
    echo %YELLOW%للتفعيل:%WHITE% !VENV_NAME!\Scripts\activate.bat
) || (
    echo %RED%✗ فشل الإنشاء%WHITE%
)
goto :MENU

:SEARCH_PACKAGE
set /p "QUERY=ابحث عن: "
pip search !QUERY! 2>nul || (
    echo %YELLOW%ملاحظة: 'pip search' معطل مؤقتًا من PyPI%WHITE%
    echo استخدم: %CYAN%https://pypi.org/search/?q= !QUERY!%WHITE%
)
goto :MENU
