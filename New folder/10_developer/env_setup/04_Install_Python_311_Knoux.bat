@echo off
:: =================================================================
:: KNOUX PYTHON 3.11 INSTALLER
:: تثبيت Python 3.11 مع مدير التوافق
:: =================================================================
title Knoux - Python 3.11 Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX PYTHON 3.11 + COMPATIBILITY MANAGER
echo   تثبيت Python 3.11 مع مدير التوافق
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Python 3.11...
winget install Python.Python.3.11 --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe' -OutFile '$env:TEMP\python311.exe'"
    start /wait "" "$env:TEMP\python311.exe" /quiet InstallAllUsers=1 PrependPath=1
)

echo [✓] تم تثبيت Python 3.11!
python --version
pip --version

echo [→] جاري إنشاء مدير التوافق...
(
    echo @echo off
    echo title Knoux Python Compatibility Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX PYTHON COMPATIBILITY MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] فحص توافق الحزم
    echo echo [2] تحديث الحزم المتوافقة
    echo echo [3] إنشاء متطلبات التوافق
    echo echo [4] فحص الإصدارات المتاحة
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" pip check
    echo if "%%choice%%"=="2" pip install --upgrade pip setuptools wheel
    echo if "%%choice%%"=="3" pip freeze > requirements.txt
    echo if "%%choice%%"=="4" pip list --outdated
    echo pause
) > "%USERPROFILE%\knoux_python_compat.bat"

echo [✓] تم إنشاء مدير التوافق!
pause
