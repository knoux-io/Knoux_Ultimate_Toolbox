@echo off
:: =================================================================
:: KNOUX PYTHON 3.12 INSTALLER
:: تثبيت Python 3.12 مع منشئ البيئات الافتراضية
:: =================================================================
title Knoux - Python 3.12 Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX PYTHON 3.12 + VIRTUAL ENV AUTO-CREATOR
echo   تثبيت Python 3.12 مع منشئ البيئات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Python 3.12...
winget install Python.Python.3.12 --silent --accept-package-agreements

if %errorlevel% neq 0 (
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe' -OutFile '$env:TEMP\python312.exe'"
    start /wait "" "$env:TEMP\python312.exe" /quiet InstallAllUsers=1 PrependPath=1
)

echo [✓] تم تثبيت Python 3.12!
python --version
pip --version

:: Create Virtual Environment Creator
echo [→] جاري إنشاء منشئ البيئات الافتراضية...
(
    echo @echo off
    echo title Knoux Python Virtual Environment Creator
    echo.
    echo echo ════════════════════════════════════════
    echo echo   KNOUX PYTHON VENV CREATOR
    echo echo ════════════════════════════════════════
    echo echo.
    echo set /p venv_name=اسم البيئة الافتراضية: 
    echo.
    echo echo [→] جاري إنشاء البيئة: %%venv_name%%
    echo python -m venv %%venv_name%%
    echo.
    echo echo [→] جاري تفعيل البيئة...
    echo call %%venv_name%%\Scripts\activate.bat
    echo.
    echo echo [→] جاري تحديث pip...
    echo python -m pip install --upgrade pip
    echo.
    echo echo [→] هل تريد تثبيت حزم أساسية؟ (Y/N)
    echo set /p install_packages= 
    echo if /i "%%install_packages%%"=="Y" (
    echo     echo [→] جاري تثبيت الحزم الأساسية...
    echo     pip install requests numpy pandas matplotlib flask django
    echo     echo [✓] تم تثبيت الحزم!
    echo )
    echo.
    echo echo [✓] تم إنشاء البيئة بنجاح!
    echo echo [→] لتفعيلها: %%venv_name%%\Scripts\activate
    echo pause
) > "%USERPROFILE%\knoux_python_venv.bat"

echo [✓] تم إنشاء منشئ البيئات!
pause
