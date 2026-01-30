@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

REM ========================================
REM   _env_menu.bat
REM   Environment Setup Menu
REM   Version: 4.2.0
REM ========================================

set "ENV_DIR=%~dp0"
set "ROOT_DIR=%ENV_DIR%..\..\..\"
set "LOGS_DIR=%ROOT_DIR%logs\"
set "LOG_FILE=%LOGS_DIR%operations.log"

:ENV_MENU
cls
call :DRAW_ENV_HEADER
call :SHOW_ENV_OPTIONS
call :HANDLE_ENV_INPUT
goto :ENV_MENU

:DRAW_ENV_HEADER
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🟢 ENVIRONMENT SETUP - LANGUAGE RUNTIMES             ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
goto :EOF

:SHOW_ENV_OPTIONS
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  PYTHON:                                                       │
echo  │  [1] 🐍 Python 3.12 (Latest)    [2] 🐍 Python 3.11 (Stable)   │
echo  │  [3] 🐍 Multiple Python Versions [4] 🏝️  Python Virtual Envs │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  NODE.JS:                                                      │
echo  │  [5] 🟢 Node.js LTS (Latest)    [6] 🟢 Node.js Current        │
echo  │  [7] 📦 NVM (Node Manager)      [8] 🧶 Yarn Package Manager   │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  JAVA:                                                         │
echo  │  [9] ☕ Java JDK 21             [10] ☕ Java JDK 17            │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  .NET:                                                         │
echo  │  [11] 🌐 .NET 8 SDK            [12] 🌐 .NET 6 SDK             │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  OTHER LANGUAGES:                                              │
echo  │  [13] 🐹 Go Language           [14] 🦀 Rust + Cargo           │
echo  │  [15] 💎 Ruby + DevKit         [16] 🐘 PHP 8.3 + Composer     │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  UTILITIES:                                                    │
echo  │  [17] 🛣️  Manage PATH          [18] 🔍 Check All Installed    │
echo  │  [19] 💾 Export Configuration  [20] 🔄 Update All             │
echo  │  [0] Back to Developer Menu                                    │
echo  └────────────────────────────────────────────────────────────────┘
echo.
goto :EOF

:HANDLE_ENV_INPUT
set /p env_choice="  ┌─ Select Tool [0-20]: "

if "%env_choice%"=="1" (
    echo [%date% %time%] ENV: Installing Python 3.12 >> "%LOG_FILE%"
    call "%ENV_DIR%python_312.bat"
)
if "%env_choice%"=="2" (
    echo [%date% %time%] ENV: Installing Python 3.11 >> "%LOG_FILE%"
    call "%ENV_DIR%python_311.bat"
)
if "%env_choice%"=="3" (
    echo [%date% %time%] ENV: Multiple Python Versions >> "%LOG_FILE%"
    call "%ENV_DIR%python_multi.bat"
)
if "%env_choice%"=="4" (
    echo [%date% %time%] ENV: Python Virtual Environments >> "%LOG_FILE%"
    call "%ENV_DIR%python_venv.bat"
)
if "%env_choice%"=="5" (
    echo [%date% %time%] ENV: Installing Node.js LTS >> "%LOG_FILE%"
    call "%ENV_DIR%nodejs_lts.bat"
)
if "%env_choice%"=="6" (
    echo [%date% %time%] ENV: Installing Node.js Current >> "%LOG_FILE%"
    call "%ENV_DIR%nodejs_current.bat"
)
if "%env_choice%"=="7" (
    echo [%date% %time%] ENV: Installing NVM >> "%LOG_FILE%"
    call "%ENV_DIR%nvm.bat"
)
if "%env_choice%"=="8" (
    echo [%date% %time%] ENV: Installing Yarn >> "%LOG_FILE%"
    call "%ENV_DIR%yarn.bat"
)
if "%env_choice%"=="9" (
    echo [%date% %time%] ENV: Installing Java 21 >> "%LOG_FILE%"
    call "%ENV_DIR%java_21.bat"
)
if "%env_choice%"=="10" (
    echo [%date% %time%] ENV: Installing Java 17 >> "%LOG_FILE%"
    call "%ENV_DIR%java_17.bat"
)
if "%env_choice%"=="11" (
    echo [%date% %time%] ENV: Installing .NET 8 >> "%LOG_FILE%"
    call "%ENV_DIR%dotnet_8.bat"
)
if "%env_choice%"=="12" (
    echo [%date% %time%] ENV: Installing .NET 6 >> "%LOG_FILE%"
    call "%ENV_DIR%dotnet_6.bat"
)
if "%env_choice%"=="13" (
    echo [%date% %time%] ENV: Installing Go >> "%LOG_FILE%"
    call "%ENV_DIR%golang.bat"
)
if "%env_choice%"=="14" (
    echo [%date% %time%] ENV: Installing Rust >> "%LOG_FILE%"
    call "%ENV_DIR%rust.bat"
)
if "%env_choice%"=="15" (
    echo [%date% %time%] ENV: Installing Ruby >> "%LOG_FILE%"
    call "%ENV_DIR%ruby.bat"
)
if "%env_choice%"=="16" (
    echo [%date% %time%] ENV: Installing PHP >> "%LOG_FILE%"
    call "%ENV_DIR%php.bat"
)
if "%env_choice%"=="17" (
    echo [%date% %time%] ENV: Managing PATH >> "%LOG_FILE%"
    call "%ENV_DIR%path_manager.bat"
)
if "%env_choice%"=="18" goto :CHECK_ALL_INSTALLED
if "%env_choice%"=="19" goto :EXPORT_CONFIG
if "%env_choice%"=="20" goto :UPDATE_ALL
if "%env_choice%"=="0" exit /b

goto :ENV_MENU

:CHECK_ALL_INSTALLED
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔍 CHECKING INSTALLED RUNTIMES                       ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Scanning system for installed development runtimes...
echo.

call :CHECK_RUNTIME "Python" "python" "--version"
call :CHECK_RUNTIME "Node.js" "node" "--version"
call :CHECK_RUNTIME "NPM" "npm" "--version"
call :CHECK_RUNTIME "Java" "java" "-version"
call :CHECK_RUNTIME "Javac" "javac" "-version"
call :CHECK_RUNTIME ".NET" "dotnet" "--version"
call :CHECK_RUNTIME "Go" "go" "version"
call :CHECK_RUNTIME "Cargo" "cargo" "--version"
call :CHECK_RUNTIME "Ruby" "ruby" "--version"
call :CHECK_RUNTIME "PHP" "php" "--version"
call :CHECK_RUNTIME "Yarn" "yarn" "--version"
call :CHECK_RUNTIME "Pip" "pip" "--version"

echo.
echo  [INFO] Scan completed. Check above for installation status.
echo.
pause
goto :ENV_MENU

:CHECK_RUNTIME
where %~2 >nul 2>&1
if %errorlevel%==0 (
    echo  [✓] %~1:
    for /f "delims=" %%v in ('%~2 %~3 2^>^&1 ^| findstr /i /r "[0-9]\.[0-9]"') do (
        echo      %%v
    )
    echo [%date% %time%] Found: %~1 >> "%LOG_FILE%"
) else (
    echo  [✗] %~1: Not Installed
    echo [%date% %time%] Missing: %~1 >> "%LOG_FILE%"
)
echo.
goto :EOF

:EXPORT_CONFIG
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           💾 EXPORT ENVIRONMENT CONFIGURATION                   ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set "EXPORT_FILE=%ROOT_DIR%exports\env_config_%date:~-4%%date:~3,2%%date:~0,2%.txt"

echo  [INFO] Exporting environment configuration...
echo.

echo ========== ENVIRONMENT CONFIGURATION ========== > "%EXPORT_FILE%"
echo Generated: %date% %time% >> "%EXPORT_FILE%"
echo KNOX Ultimate Toolbox v4.2.0 - Environment Setup >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [1/6] Exporting PATH variables...
echo ========== PATH VARIABLES ========== >> "%EXPORT_FILE%"
echo %PATH% >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [2/6] Exporting environment variables...
echo ========== ENVIRONMENT VARIABLES ========== >> "%EXPORT_FILE%"
set >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [3/6] Exporting installed runtimes...
echo ========== INSTALLED RUNTIMES ========== >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Python" "python" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Node.js" "node" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Java" "java" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS ".NET" "dotnet" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Go" "go" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Ruby" "ruby" >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [4/6] Exporting package managers...
echo ========== PACKAGE MANAGERS ========== >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "NPM" "npm" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Pip" "pip" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Yarn" "yarn" >> "%EXPORT_FILE%"
call :GET_RUNTIME_STATUS "Cargo" "cargo" >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [5/6] Exporting development directories...
echo ========== DEVELOPMENT DIRECTORIES ========== >> "%EXPORT_FILE%"
if exist "%USERPROFILE%\Projects" echo Projects: %USERPROFILE%\Projects >> "%EXPORT_FILE%"
if exist "%USERPROFILE%\Code" echo Code: %USERPROFILE%\Code >> "%EXPORT_FILE%"
if exist "%USERPROFILE%\GitHub" echo GitHub: %USERPROFILE%\GitHub >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [6/6] Exporting system information...
echo ========== SYSTEM INFO ========== >> "%EXPORT_FILE%"
echo OS: %OS% >> "%EXPORT_FILE%"
echo Processor: %PROCESSOR_ARCHITECTURE% >> "%EXPORT_FILE%"
echo Number of Processors: %NUMBER_OF_PROCESSORS% >> "%EXPORT_FILE%"

echo.
echo  [SUCCESS] Configuration exported to: %EXPORT_FILE%
echo  [%date% %time%] Environment configuration exported >> "%LOG_FILE%"
echo.
notepad "%EXPORT_FILE%"
pause
goto :ENV_MENU

:GET_RUNTIME_STATUS
where %~2 >nul 2>&1
if %errorlevel%==0 (
    echo  [✓] %~1: Installed
    %~2 %~3 2>nul | findstr /i "[0-9]" | set /p= │ Version: 
) else (
    echo  [✗] %~1: Not installed
)
goto :EOF

:UPDATE_ALL
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔄 UPDATE ALL DEVELOPMENT RUNTIMES                 ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  This will update all installed development runtimes to their latest versions.
echo.
set /p confirm="  Do you want to continue? (Y/N): "

if /i not "%confirm%"=="Y" goto :ENV_MENU

echo.
echo  [INFO] Updating all development runtimes...
echo.

echo  [*] Updating WinGet packages...
winget upgrade --all --silent

echo  [*] Updating NPM packages...
npm update -g

echo  [*] Updating PIP packages...
pip list --outdated --format=freeze | findstr /V "^\-e" | findstr /R ".*" > %TEMP%\pip_outdated.txt
for /f "tokens=1 delims==" %%i in (%TEMP%\pip_outdated.txt) do pip install --upgrade %%i

echo  [*] Updating Yarn packages...
yarn global upgrade

echo  [*] Updating Cargo packages...
cargo install-update -a

echo.
echo  [SUCCESS] All runtimes updated!
echo  [%date% %time%] All development runtimes updated >> "%LOG_FILE%"
echo.
pause
goto :ENV_MENU
```

---

## 📋 المميزات الرئيسية لقائمة إعدادات البيئة:

### 🔧 الفئات المتاحة:

**1. Python:**
- Python 3.12 (الأحدث)
- Python 3.11 (مستقر)
- إصدارات Python متعددة
- البيئات الافتراضية Python

**2. Node.js:**
- Node.js LTS (الأحدث)
- Node.js Current
- NVM (مدير Node)
- Yarn Package Manager

**3. Java:**
- Java JDK 21
- Java JDK 17

**4. .NET:**
- .NET 8 SDK
- .NET 6 SDK

**5. لغات أخرى:**
- Go Language
- Rust + Cargo
- Ruby + DevKit
- PHP 8.3 + Composer

**6. الأدوات المساعدة:**
- إدارة PATH
- فحص جميع المثبتات
- تصدير الإعدادات
- تحديث الكل

### 🚀 المميزات التقنية:

**فحص شامل:**
- التحقق من وجود كل runtime
- عرض الإصدارات الحالية
- تسجيل الحالة في السجلات

**تصدير الإعدادات:**
- متغيرات PATH
- متغيرات البيئة
- قائمة الـ runtimes المثبتة
- مديري الحزم
- أدلة التطوير
- معلومات النظام

**تحديث شامل:**
- تحديث حزم WinGet
- تحديث حزم NPM
- تحديث حزم PIP
- تحديث حزم Yarn
- تحديث حزم Cargo

### ✅ حالة التكامل:
- **القائمة الرئيسية** مكتملة بالكامل
- **20 خيار** لجميع لغات البرمجة
- **فحص شامل** لجميع المثبتات
- **تصدير إعدادات** متكامل
- **تحديث تلقائي** لجميع الأدوات
- **تسجيل العمليات** في السجلات

قائمة إعدادات البيئة الآن جاهزة لتكون المركز الرئيسي لإدارة جميع لغات البرمجة وأدوات التطوير! 🟢
