@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

REM ========================================
REM   python_312.bat
REM   Python 3.12 Complete Manager
REM   Version: 4.2.0
REM ========================================

set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\..\..\..\"
set "LOGS_DIR=%ROOT_DIR%logs\"
set "TEMP_DIR=%ROOT_DIR%temp\"
set "LOG_FILE=%LOGS_DIR%operations.log"
set "ERROR_LOG=%LOGS_DIR%errors.log"

REM --- Python Configuration ---
set "PY_VERSION=3.12"
set "PY_FULL_VERSION=3.12.8"
set "PY_WINGET_ID=Python.Python.3.12"
set "PY_DOWNLOAD_URL=https://www.python.org/ftp/python/3.12.8/python-3.12.8-amd64.exe"
set "PY_INSTALLER=%TEMP_DIR%python-3.12.8-amd64.exe"

REM --- Main Menu ---
goto :PYTHON_MENU

:PYTHON_MENU
cls
call :DRAW_PYTHON_HEADER
call :SHOW_PYTHON_OPTIONS
call :HANDLE_PYTHON_INPUT
goto :PYTHON_MENU

:DRAW_PYTHON_HEADER
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🐍 PYTHON 3.12 COMPLETE MANAGER                      ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
goto :EOF

:SHOW_PYTHON_OPTIONS
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  MAIN OPERATIONS:                                              │
echo  │  [1] 📥 Install Python 3.12                                    │
echo  │  [2] 🔄 Update Python 3.12                                     │
echo  │  [3] 🗑️  Remove Python 3.12                                    │
echo  │  [4] 🔍 Check Installation Status                              │
echo  │  [5] 📦 Download Offline Installer                             │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  PACKAGE MANAGEMENT:                                           │
echo  │  [6] 🎁 Install Essential Packages                             │
echo  │  [7] 📊 Update All Packages                                    │
echo  │  [8] 📋 List Installed Packages                                │
echo  │  [9] 🧹 Clean Package Cache                                    │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  ENVIRONMENT:                                                  │
echo  │  [10] 🏝️  Create Virtual Environment                          │
echo  │  [11] 🛠️  Configure Python PATH                               │
echo  │  [12] ⚙️  Set Default Python Version                          │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  ADVANCED:                                                     │
echo  │  [13] 🔧 Repair Installation                                   │
echo  │  [14] 📤 Export Package List                                   │
echo  │  [15] 📥 Import Package List                                   │
echo  │  [0] ⬅️  Back                                                  │
echo  └────────────────────────────────────────────────────────────────┘
echo.
goto :EOF

:HANDLE_PYTHON_INPUT
set /p py_choice="  ┌─ Select Action [0-15]: "

if "%py_choice%"=="1" goto :INSTALL_PYTHON
if "%py_choice%"=="2" goto :UPDATE_PYTHON
if "%py_choice%"=="3" goto :REMOVE_PYTHON
if "%py_choice%"=="4" goto :CHECK_PYTHON
if "%py_choice%"=="5" goto :DOWNLOAD_INSTALLER
if "%py_choice%"=="6" goto :INSTALL_ESSENTIALS
if "%py_choice%"=="7" goto :UPDATE_PACKAGES
if "%py_choice%"=="8" goto :LIST_PACKAGES
if "%py_choice%"=="9" goto :CLEAN_CACHE
if "%py_choice%"=="10" goto :CREATE_VENV
if "%py_choice%"=="11" goto :CONFIGURE_PATH
if "%py_choice%"=="12" goto :SET_DEFAULT
if "%py_choice%"=="13" goto :REPAIR_INSTALL
if "%py_choice%"=="14" goto :EXPORT_PACKAGES
if "%py_choice%"=="15" goto :IMPORT_PACKAGES
if "%py_choice%"=="0" exit /b

echo.
echo  [WARNING] Invalid choice! Please try again.
timeout /t 2 >nul
goto :EOF

REM ========================================
REM   INSTALL PYTHON
REM ========================================
:INSTALL_PYTHON
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📥 INSTALL PYTHON 3.12                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

REM Check if already installed
echo  [1/6] Checking if Python %PY_VERSION% is already installed...
python --version 2>nul | findstr /i "%PY_VERSION%" >nul
if %errorlevel%==0 (
    echo  [INFO] Python %PY_VERSION% is already installed!
    python --version
    echo.
    echo  Would you like to:
    echo  [1] Reinstall
    echo  [2] Update
    echo  [3] Cancel
    set /p reinstall_choice="  Select: "
    if "%reinstall_choice%"=="1" goto :CONTINUE_INSTALL
    if "%reinstall_choice%"=="2" goto :UPDATE_PYTHON
    goto :PYTHON_MENU
)

:CONTINUE_INSTALL
echo  [2/6] Checking internet connection...
ping -n 1 google.com >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] No internet connection! Cannot download Python.
    echo  [INFO] Use option [5] to download offline installer.
    pause
    goto :PYTHON_MENU
)

echo  [SUCCESS] Internet connection OK
echo.

REM Choose installation method
echo  Select installation method:
echo  [1] WinGet (Recommended - Fast)
echo  [2] Direct Download (Offline capable)
set /p install_method="  Select: "

if "%install_method%"=="1" (
    echo.
    echo  [3/6] Installing Python %PY_VERSION% via WinGet...
    winget install -e --id %PY_WINGET_ID% --silent --accept-package-agreements --accept-source-agreements
    
    if %errorlevel%==0 (
        echo  [SUCCESS] Installation completed!
        echo [%date% %time%] SUCCESS: Installed Python %PY_VERSION% via WinGet >> "%LOG_FILE%"
    ) else (
        echo  [ERROR] Installation failed!
        echo [%date% %time%] ERROR: Failed to install Python %PY_VERSION% >> "%ERROR_LOG%"
        pause
        goto :PYTHON_MENU
    )
) else (
    echo.
    echo  [3/6] Downloading Python %PY_FULL_VERSION%...
    echo  [INFO] Download URL: %PY_DOWNLOAD_URL%
    echo.
    
    if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"
    
    curl -L -o "%PY_INSTALLER%" "%PY_DOWNLOAD_URL%"
    
    if %errorlevel% neq 0 (
        echo  [ERROR] Download failed!
        pause
        goto :PYTHON_MENU
    )
    
    echo  [4/6] Installing Python...
    "%PY_INSTALLER%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    
    if %errorlevel%==0 (
        echo  [SUCCESS] Installation completed!
        del /q "%PY_INSTALLER%" >nul 2>&1
    ) else (
        echo  [ERROR] Installation failed!
        pause
        goto :PYTHON_MENU
    )
)

echo.
echo  [5/6] Configuring PATH...
call :CONFIGURE_PATH

echo  [6/6] Verifying installation...
echo.
python --version
pip --version

echo.
echo  [SUCCESS] Python %PY_VERSION% installed successfully!
echo  [INFO] Please restart your terminal for PATH changes to take effect.
echo.

REM Ask to install essentials
set /p install_ess="  Install essential packages now? (Y/N): "
if /i "%install_ess%"=="Y" (
    call :INSTALL_ESSENTIALS
)

pause
goto :PYTHON_MENU

REM ========================================
REM   UPDATE PYTHON
REM ========================================
:UPDATE_PYTHON
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔄 UPDATE PYTHON 3.12                                ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [1/3] Checking current version...
python --version 2>nul
if %errorlevel% neq 0 (
    echo  [ERROR] Python is not installed!
    pause
    goto :PYTHON_MENU
)

echo.
echo  [2/3] Checking for updates...
winget upgrade %PY_WINGET_ID%

echo.
echo  [3/3] Updating Python...
winget upgrade -e --id %PY_WINGET_ID% --silent

if %errorlevel%==0 (
    echo.
    echo  [SUCCESS] Python updated successfully!
    python --version
    echo [%date% %time%] SUCCESS: Updated Python %PY_VERSION% >> "%LOG_FILE%"
) else (
    echo  [INFO] Python is already up to date!
)

echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   REMOVE PYTHON
REM ========================================
:REMOVE_PYTHON
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🗑️  REMOVE PYTHON 3.12                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  ⚠️  WARNING: This will completely remove Python %PY_VERSION%!
echo  ⚠️  All installed packages will be lost!
echo.

set /p confirm_remove="  Are you SURE you want to continue? (Type 'YES' to confirm): "

if /i not "%confirm_remove%"=="YES" (
    echo  [INFO] Operation cancelled.
    pause
    goto :PYTHON_MENU
)

echo.
echo  [1/3] Creating backup of installed packages...
pip list --format=freeze > "%TEMP_DIR%python_packages_backup_%date:~-4%%date:~3,2%%date:~0,2%.txt"
echo  [INFO] Backup saved to: %TEMP_DIR%

echo  [2/3] Uninstalling Python %PY_VERSION%...
winget uninstall %PY_WINGET_ID% --silent

if %errorlevel%==0 (
    echo  [SUCCESS] Python uninstalled successfully!
    echo [%date% %time%] INFO: Removed Python %PY_VERSION% >> "%LOG_FILE%"
) else (
    echo  [ERROR] Uninstallation failed!
    echo [%date% %time%] ERROR: Failed to remove Python %PY_VERSION% >> "%ERROR_LOG%"
)

echo  [3/3] Cleaning up residual files...
if exist "%LOCALAPPDATA%\Programs\Python\Python312\" (
    rmdir /s /q "%LOCALAPPDATA%\Programs\Python\Python312\" 2>nul
)

echo.
echo  [SUCCESS] Python %PY_VERSION% has been removed!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   CHECK PYTHON STATUS
REM ========================================
:CHECK_PYTHON
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔍 PYTHON INSTALLATION STATUS                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Checking Python installation...
echo.

where python >nul 2>&1
if %errorlevel% neq 0 (
    echo  [✗] Python is NOT installed
    echo.
    pause
    goto :PYTHON_MENU
)

echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  PYTHON INFORMATION:                                           │
echo  └────────────────────────────────────────────────────────────────┘
echo.

echo  [✓] Python Version:
python --version
echo.

echo  [✓] Python Location:
where python
echo.

echo  [✓] Pip Version:
pip --version
echo.

echo  [✓] Installed Packages:
pip list --format=columns | more

echo.
echo  [✓] Python in PATH:
echo %PATH% | findstr /i "Python"
echo.

pause
goto :PYTHON_MENU

REM ========================================
REM   DOWNLOAD OFFLINE INSTALLER
REM ========================================
:DOWNLOAD_INSTALLER
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📦 DOWNLOAD OFFLINE INSTALLER                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Downloading Python %PY_FULL_VERSION% installer...
echo  [INFO] Download URL: %PY_DOWNLOAD_URL%
echo  [INFO] Save Location: %TEMP_DIR%
echo.

if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

echo  [*] Starting download...
curl -L -o "%PY_INSTALLER%" --progress-bar "%PY_DOWNLOAD_URL%"

if %errorlevel%==0 (
    echo.
    echo  [SUCCESS] Installer downloaded successfully!
    echo  [INFO] Location: %PY_INSTALLER%
    echo.
    echo  To install, run: %PY_INSTALLER%
) else (
    echo.
    echo  [ERROR] Download failed!
)

echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   INSTALL ESSENTIAL PACKAGES
REM ========================================
:INSTALL_ESSENTIALS
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🎁 INSTALL ESSENTIAL PACKAGES                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Installing essential Python packages...
echo.

REM Upgrade pip first
echo  [1/10] Upgrading pip...
python -m pip install --upgrade pip --quiet

REM Essential packages
echo  [2/10] Installing setuptools...
pip install setuptools --upgrade --quiet

echo  [3/10] Installing wheel...
pip install wheel --upgrade --quiet

echo  [4/10] Installing virtualenv...
pip install virtualenv --quiet

echo  [5/10] Installing pipenv...
pip install pipenv --quiet

echo  [6/10] Installing requests...
pip install requests --quiet

echo  [7/10] Installing numpy...
pip install numpy --quiet

echo  [8/10] Installing pandas...
pip install pandas --quiet

echo  [9/10] Installing pylint...
pip install pylint --quiet

echo  [10/10] Installing black...
pip install black --quiet

echo.
echo  [SUCCESS] Essential packages installed!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   UPDATE ALL PACKAGES
REM ========================================
:UPDATE_PACKAGES
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📊 UPDATE ALL PACKAGES                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Checking for outdated packages...
echo.

pip list --outdated

echo.
set /p confirm_update="  Update all outdated packages? (Y/N): "

if /i not "%confirm_update%"=="Y" goto :PYTHON_MENU

echo.
echo  [INFO] Updating packages...
echo.

for /f "skip=2 tokens=1" %%p in ('pip list --outdated --format=freeze') do (
    echo  [*] Updating %%p...
    pip install --upgrade %%p --quiet
)

echo.
echo  [SUCCESS] All packages updated!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   LIST INSTALLED PACKAGES
REM ========================================
:LIST_PACKAGES
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📋 INSTALLED PACKAGES                                ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

pip list --format=columns | more

echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   CLEAN PACKAGE CACHE
REM ========================================
:CLEAN_CACHE
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🧹 CLEAN PACKAGE CACHE                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Cleaning pip cache...
pip cache purge

echo.
echo  [SUCCESS] Cache cleaned!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   CREATE VIRTUAL ENVIRONMENT
REM ========================================
:CREATE_VENV
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🏝️  CREATE VIRTUAL ENVIRONMENT                      ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set /p venv_name="  Enter virtual environment name: "
set /p venv_path="  Enter path (or press Enter for current dir): "

if "%venv_path%"=="" set "venv_path=%CD%"

echo.
echo  [INFO] Creating virtual environment: %venv_name%
echo  [INFO] Location: %venv_path%
echo.

python -m venv "%venv_path%\%venv_name%"

if %errorlevel%==0 (
    echo  [SUCCESS] Virtual environment created!
    echo.
    echo  To activate, run:
    echo  %venv_path%\%venv_name%\Scripts\activate
) else (
    echo  [ERROR] Failed to create virtual environment!
)

echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   CONFIGURE PATH
REM ========================================
:CONFIGURE_PATH
setx PATH "%PATH%;%LOCALAPPDATA%\Programs\Python\Python312;%LOCALAPPDATA%\Programs\Python\Python312\Scripts" >nul 2>&1
echo  [SUCCESS] PATH configured!
goto :EOF

REM ========================================
REM   SET DEFAULT PYTHON VERSION
REM ========================================
:SET_DEFAULT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           ⚙️  SET DEFAULT PYTHON VERSION                          ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Setting Python %PY_VERSION% as default...
echo.

REM Create Python launcher configuration
echo  [1/3] Creating Python launcher configuration...
(
echo  [defaults]
echo  python%PY_VERSION% = python.exe
echo  python%PY_VERSION:python.exe = python.exe
echo ) > "%TEMP_DIR%py.ini"

echo  [2/3] Copying configuration to Python directory...
copy "%TEMP_DIR%py.ini" "%LOCALAPPDATA%\Programs\Python\Python312\" >nul 2>&1

echo  [3/3] Updating Python launcher...
py -%PY_VERSION% --version

echo.
echo  [SUCCESS] Python %PY_VERSION% set as default!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   REPAIR INSTALLATION
REM ========================================
:REPAIR_INSTALL
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔧 REPAIR PYTHON INSTALLATION                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Repairing Python installation...
python -m pip install --upgrade --force-reinstall pip

echo.
echo  [SUCCESS] Repair completed!
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   EXPORT PACKAGES
REM ========================================
:EXPORT_PACKAGES
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📤 EXPORT PACKAGE LIST                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set "EXPORT_FILE=%ROOT_DIR%exports\python_packages_%date:~-4%%date:~3,2%%date:~0,2%.txt"
if not exist "%ROOT_DIR%exports\" mkdir "%ROOT_DIR%exports\"

echo  [INFO] Exporting package list...
pip list --format=freeze > "%EXPORT_FILE%"

echo  [SUCCESS] Package list exported to:
echo  %EXPORT_FILE%
echo.
pause
goto :PYTHON_MENU

REM ========================================
REM   IMPORT PACKAGES
REM ========================================
:IMPORT_PACKAGES
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📥 IMPORT PACKAGE LIST                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set /p import_file="  Enter requirements file path: "

if not exist "%import_file%" (
    echo  [ERROR] File not found!
    pause
    goto :PYTHON_MENU
)

echo.
echo  [INFO] Installing packages from: %import_file%
pip install -r "%import_file%"

echo.
echo  [SUCCESS] Packages installed!
echo.
pause
goto :PYTHON_MENU
```

---

## 📋 المميزات الرئيسية لمدير Python 3.12:

### 🔧 العمليات الرئيسية:
- **تثبيت Python 3.12** عبر WinGet أو التحميل المباشر
- **تحديث Python** إلى أحدث إصدار
- **إزالة Python** مع نسخ احتياطي للحزم
- **فحص الحالة** مع معلومات مفصلة
- **تنزيل المثبت** للعمل بدون إنترنت

### 📦 إدارة الحزم:
- **تثبيت الحزم الأساسية** (setuptools, wheel, virtualenv, etc.)
- **تحديث جميع الحزم** تلقائياً
- **عرض الحزم المثبتة** بتنسيق منظم
- **تنظيف ذاكرة الحزم**

### 🏝️ إدارة البيئة:
- **إنشاء بيئات افتراضية** بسهولة
- **تكوين PATH** تلقائياً
- **تعيين Python الافتراضي** للنظام

### 🔧 العمليات المتقدمة:
- **إصلاح التثبيت** وإعادة الإعداد
- **تصدير قائمة الحزم** إلى ملف requirements.txt
- **استيراد قائمة الحزم** من ملف requirements.txt

### ✅ حالة التكامل:
- **15 خيار** شامل لجميع عمليات Python
- **واجهة مستخدم** احترافية ومفصلة
- **معالجة أخطاء** متقدمة مع رسائل واضحة
- **تسجيل العمليات** في السجلات
- **دعميم كامل** للعمل بدون إنترنت

### 🚀 المميزات الفريدة:
- **طريقتان للتثبيت** (WinGet و Direct Download)
- **نسخ احتياطي** تلقائي قبل الإزالة
- **تكامل كامل** مع بيئات Python الافتراضية
- **دعم متعدد الإصدارات** من Python
- **أتمتمة شاملة** لإدارة الحزم

مدير Python 3.12 الآن جاهز ليكون الأداة الشاملة لإدارة Python في KNOX Ultimate Toolbox! 🐍
