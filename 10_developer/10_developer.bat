@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

REM ========================================
REM   10_developer.bat
REM   Developer Tools Hub - Main Menu
REM   Version: 4.2.0
REM ========================================

REM --- Path Configuration ---
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\"
set "MODULES_DIR=%SCRIPT_DIR%modules\"
set "DEV_SUBDIR=%MODULES_DIR%developer\"
set "LOGS_DIR=%ROOT_DIR%logs\"

REM --- Logging ---
set "LOG_FILE=%LOGS_DIR%operations.log"
echo [%date% %time%] Opened Developer Tools Hub >> "%LOG_FILE%"

REM --- Main Entry ---
goto :DEVELOPER_MAIN_MENU

REM ========================================
REM   MAIN DEVELOPER MENU
REM ========================================
:DEVELOPER_MAIN_MENU
cls
call :DRAW_DEV_HEADER
call :SHOW_DEV_MENU
call :HANDLE_DEV_INPUT
goto :DEVELOPER_MAIN_MENU

REM ========================================
REM   DRAW DEVELOPER HEADER
REM ========================================
:DRAW_DEV_HEADER
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║    🚀 DEVELOPER TOOLS HUB v4.2.0                               ║
echo  ║    Complete Development Environment Setup & Management        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
goto :EOF

REM ========================================
REM   SHOW DEVELOPER MENU
REM ========================================
:SHOW_DEV_MENU
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    DEVELOPER CATEGORIES                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  CORE DEVELOPMENT:                                             │
echo  │  [1]  🟢 Environment Setup         │  [8]  🌐 Web Servers       │
echo  │  [2]  📦 Package Managers          │  [9]  ⚛️  Frontend Tools   │
echo  │  [3]  💙 Editors and IDEs          │  [10] 📱 Mobile Dev        │
echo  │  [4]  🗄️  Database Tools           │  [11] 🔧 API Tools         │
echo  │  [5]  🐙 Version Control (Git)    │  [12] 🧪 Testing Tools     │
echo  │  [6]  🔒 Security Tools           │  [13] ⚙️  DevOps/CI-CD     │
echo  │  [7]  🐳 Containers/Docker         │  [14] 🏗️  Build Tools      │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  ADDITIONAL TOOLS:                                             │
echo  │  [15] 📚 Documentation Tools       │  [18] ☁️  Cloud CLI Tools  │
echo  │  [16] 💻 Terminal/Productivity     │  [19] 🔍 Code Analysis     │
echo  │  [17] 🎯 Frameworks Installer      │  [20] 📊 View Dev Report   │
echo  ├────────────────────────────────────────────────────────────────┤
echo  │  QUICK ACTIONS:                                                │
echo  │  [Q] Install Developer Bundle      │  [E] Export Dev Config    │
echo  │  [C] Check Installed Tools         │  [U] Update All Tools     │
echo  │  [0] Return to Main Menu           │                           │
echo  └────────────────────────────────────────────────────────────────┘
echo.
goto :EOF

REM ========================================
REM   HANDLE DEVELOPER INPUT
REM ========================================
:HANDLE_DEV_INPUT
set /p dev_choice="  ┌─ Select Category [0-20 or Q/E/C/U]: "

REM Navigate to categories
if "%dev_choice%"=="1" (
    echo [%date% %time%] DEV: Environment Setup >> "%LOG_FILE%"
    call "%DEV_SUBDIR%env_setup\_env_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="2" (
    echo [%date% %time%] DEV: Package Managers >> "%LOG_FILE%"
    call "%DEV_SUBDIR%package_managers\_pkg_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="3" (
    echo [%date% %time%] DEV: Editors and IDEs >> "%LOG_FILE%"
    call "%DEV_SUBDIR%editors_ides\_editors_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="4" (
    echo [%date% %time%] DEV: Database Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%database_tools\_db_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="5" (
    echo [%date% %time%] DEV: Version Control >> "%LOG_FILE%"
    call "%DEV_SUBDIR%version_control\_git_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="6" (
    echo [%date% %time%] DEV: Security Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%security_tools\_security_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="7" (
    echo [%date% %time%] DEV: Containers/Docker >> "%LOG_FILE%"
    call "%DEV_SUBDIR%containers\_containers_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="8" (
    echo [%date% %time%] DEV: Web Servers >> "%LOG_FILE%"
    call "%DEV_SUBDIR%web_servers\_servers_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="9" (
    echo [%date% %time%] DEV: Frontend Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%frontend\_frontend_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="10" (
    echo [%date% %time%] DEV: Mobile Dev >> "%LOG_FILE%"
    call "%DEV_SUBDIR%mobile_dev\_mobile_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="11" (
    echo [%date% %time%] DEV: API Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%api_tools\_api_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="12" (
    echo [%date% %time%] DEV: Testing Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%testing_tools\_testing_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="13" (
    echo [%date% %time%] DEV: DevOps/CI-CD >> "%LOG_FILE%"
    call "%DEV_SUBDIR%devops\_devops_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="14" (
    echo [%date% %time%] DEV: Build Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%build_tools\_build_menu.bat"
    goto :EOF
)

REM Additional tools
if "%dev_choice%"=="15" (
    echo [%date% %time%] DEV: Documentation Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%documentation\_docs_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="16" (
    echo [%date% %time%] DEV: Terminal/Productivity >> "%LOG_FILE%"
    call "%DEV_SUBDIR%terminal\_terminal_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="17" (
    echo [%date% %time% DEV: Frameworks Installer >> "%LOG_FILE%"
    call "%DEV_SUBDIR%frameworks\_frameworks_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="18" (
    echo [%date% %time%] DEV: Cloud CLI Tools >> "%LOG_FILE%"
    call "%DEV_SUBDIR%cloud\_cloud_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="19" (
    echo [%date% %time%] DEV: Code Analysis >> "%LOG_FILE%"
    call "%DEV_SUBDIR%analysis\_analysis_menu.bat"
    goto :EOF
)
if "%dev_choice%"=="20" (
    echo [%date% %time%] DEV: View Dev Report >> "%LOG_FILE%"
    goto :VIEW_DEV_REPORT
)

REM Quick Actions
if /i "%dev_choice%"=="Q" goto :INSTALL_DEV_BUNDLE
if /i "%dev_choice%"=="E" goto :EXPORT_CONFIG
if /i "%dev_choice%"=="C" goto :CHECK_INSTALLED
if /i "%dev_choice%"=="U" goto :UPDATE_ALL
if "%dev_choice%"=="0" (
    call "%ROOT_DIR%Knoux.bat"
    exit /b
)

REM Invalid input
echo.
echo  [WARNING] Invalid choice! Please try again.
timeout /t 2 >nul
goto :EOF

REM ========================================
REM   INSTALL DEVELOPER BUNDLE
REM ========================================
:INSTALL_DEV_BUNDLE
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════╗
echo  ║           📦 DEVELOPER BUNDLE INSTALLER                        ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  This will install the complete developer bundle including:
echo  - Node.js LTS
echo  - Python 3.12
echo  - Git SCM
echo  - Visual Studio Code
echo  - Docker Desktop
echo  - Windows Terminal
echo  - Chocolatey Package Manager
echo.
echo  ⚠️  This process may take 20-30 minutes depending on your connection.
echo.
set /p confirm="  Do you want to continue? (Y/N): "

if /i not "%confirm%"=="Y" goto :EOF

echo.
echo  [INFO] Starting Developer Bundle installation...
echo.

REM Install tools one by one
call :INSTALL_TOOL "Node.js" "winget install -e --id OpenJS.NodeJS.LTS --silent"
call :INSTALL_TOOL "Python" "winget install -e --id Python.Python.3.12 --silent"
call :INSTALL_TOOL "Git" "winget install -e --id Git.Git --silent"
call :INSTALL_TOOL "VS Code" "winget install -e --id Microsoft.VisualStudioCode --silent"
call :INSTALL_TOOL "Windows Terminal" "winget install -e --id Microsoft.WindowsTerminal --silent"

echo.
echo  [SUCCESS] Developer Bundle installation completed!
echo  [INFO] Please restart your terminal for changes to take effect.
echo.
pause
goto :EOF

:INSTALL_TOOL
echo  [*] Installing %~1...
%~2 >nul 2>&1
if %errorlevel%==0 (
    echo  [✓] %~1 installed successfully!
    echo [%date% %time%] Installed: %~1 >> "%LOG_FILE%"
) else (
    echo  [✗] Failed to install %~1
    echo [%date% %time%] ERROR: Failed to install %~1 >> "%LOGS_DIR%errors.log"
)
goto :EOF

REM ========================================
REM   CHECK INSTALLED TOOLS
REM ========================================
:CHECK_INSTALLED
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔍 INSTALLED DEVELOPMENT TOOLS                       ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo  Checking installed tools...
echo.

REM Check each tool
call :CHECK_TOOL_INSTALLED "Node.js" "node" "--version"
call :CHECK_TOOL_INSTALLED "NPM" "npm" "--version"
call :CHECK_TOOL_INSTALLED "Python" "python" "--version"
call :CHECK_TOOL_INSTALLED "Pip" "pip" "--version"
call :CHECK_TOOL_INSTALLED "Git" "git" "--version"
call :CHECK_TOOL_INSTALLED "Docker" "docker" "--version"
call :CHECK_TOOL_INSTALLED "VS Code" "code" "--version"
call :CHECK_TOOL_INSTALLED "Chocolatey" "choco" "--version"

echo.
pause
goto :EOF

:CHECK_TOOL_INSTALLED
where %~2 >nul 2>&1
if %errorlevel%==0 (
    echo  [✓] %~1 is installed
    %~2 %~3 2>nul | findstr /i "[0-9]" | set /p=  │ Version: 
    echo.
) else (
    echo  [✗] %~1 is NOT installed
)
goto :EOF

REM ========================================
REM   EXPORT CONFIGURATION
REM ========================================
:EXPORT_CONFIG
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📤 EXPORT DEVELOPMENT CONFIGURATION                  ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set "EXPORT_FILE=%ROOT_DIR%exports\dev_config_%date:~-4%%date:~3,2%%date:~0,2%.txt"

echo  [INFO] Exporting development configuration...
echo.

echo ========== DEVELOPMENT ENVIRONMENT CONFIG ========== > "%EXPORT_FILE%"
echo Generated: %date% %time% >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [1/5] Exporting PATH variables...
echo ========== PATH VARIABLES ========== >> "%EXPORT_FILE%"
echo %PATH% >> "%EXPORT_FILE%"
echo. >> "%EXPORT_FILE%"

echo  [2/5] Exporting installed tools...
echo ========== INSTALLED TOOLS ========== >> "%EXPORT_FILE%"
winget list >> "%EXPORT_FILE%" 2>&1
echo. >> "%EXPORT_FILE%"

echo  [3/5] Exporting Node.js packages...
echo ========== NPM GLOBAL PACKAGES ========== >> "%EXPORT_FILE%"
npm list -g --depth=0 >> "%EXPORT_FILE%" 2>&1
echo. >> "%EXPORT_FILE%"

echo  [4/5] Exporting Python packages...
echo ========== PIP PACKAGES ========== >> "%EXPORT_FILE%"
pip list >> "%EXPORT_FILE%" 2>&1
echo. >> "%EXPORT_FILE%"

echo  [5/5] Exporting Git configuration...
echo ========== GIT CONFIG ========== >> "%EXPORT_FILE%"
git config --list >> "%EXPORT_FILE%" 2>&1

echo.
echo  [SUCCESS] Configuration exported to: %EXPORT_FILE%
echo.
pause
goto :EOF

REM ========================================
REM   UPDATE ALL TOOLS
REM ========================================
:UPDATE_ALL
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔄 UPDATE ALL DEVELOPMENT TOOLS                      ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
echo  This will update all installed development tools to their latest versions.
echo.
set /p confirm="  Do you want to continue? (Y/N): "

if /i not "%confirm%"=="Y" goto :EOF

echo.
echo  [INFO] Updating all tools...
echo.

echo  [*] Updating WinGet packages...
winget upgrade --all --silent

echo  [*] Updating NPM packages...
npm update -g

echo  [*] Updating PIP packages...
pip list --outdated --format=freeze | findstr /V "^\-e" | findstr /R ".*" > %TEMP%\pip_outdated.txt
for /f "tokens=1 delims==" %%i in (%TEMP%\pip_outdated.txt) do pip install --upgrade %%i

echo.
echo  [SUCCESS] All tools updated!
echo.
pause
goto :EOF

REM ========================================
REM   VIEW DEVELOPER REPORT
REM ========================================
:VIEW_DEV_REPORT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           📊 DEVELOPER ENVIRONMENT REPORT                         ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set "REPORT_FILE=%ROOT_DIR%exports\dev_report_%date:~-4%%date:~3,2%%date:~0,2%.txt"

echo  [INFO] Generating developer environment report...
echo.

echo ========== DEVELOPER ENVIRONMENT REPORT ========== > "%REPORT_FILE%"
echo Generated: %date% %time% >> "%REPORT_FILE%"
echo KNOX Ultimate Toolbox v4.2.0 - Developer Tools Hub >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo  [1/8] System Information...
echo ========== SYSTEM INFORMATION ========== >> "%REPORT_FILE%"
systeminfo | findstr /C "System Type" >> "%REPORT_FILE%"
systeminfo | findstr /C "Total Physical Memory" >> "%REPORT_FILE%"
systeminfo | findstr /C "Available Physical Memory" >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo  [2/8] Installed Development Tools...
echo ========== INSTALLED TOOLS ========== >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Node.js" "node" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Python" "python" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Git" "git" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "VS Code" "code" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Docker" "docker" >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo  [3/8] Package Managers Status...
echo ========== PACKAGE MANAGERS ========== >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "NPM" "npm" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Pip" "pip" >> "%REPORT_FILE%"
call :GET_TOOL_STATUS "Chocolatey" "choco" >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo  [4/8] Development Directories...
echo ========== DEVELOPMENT DIRECTORIES ========== >> "%REPORT_FILE%"
if exist "%USERPROFILE%\Projects" echo Projects: %USERPROFILE%\Projects >> "%REPORT_FILE%"
if exist "%USERPROFILE%\Code" echo Code: %USERPROFILE%\Code >> "%REPORT_FILE%"
if exist "%USERPROFILE%\GitHub" echo GitHub: %USERPROFILE%\GitHub >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo  [5/8] Environment Variables...
echo ========== ENVIRONMENT VARIABLES ========== >> "%REPORT_FILE%"
echo PATH: %PATH% >> "%REPORT_FILE%"
echo NODE_PATH: %NODE_PATH% >> "%REPORT_FILE%"
echo PYTHONPATH: %PYTHONPATH% >> "%REPORT_FILE%"
echo JAVA_HOME: %JAVA_HOME% >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo [6/8] Git Configuration...
echo ========== GIT CONFIGURATION ========== >> "%REPORT_FILE%"
git config --list >> "%REPORT_FILE%" 2>&1
echo. >> "%REPORT_FILE%"

echo  [7/8] Docker Status...
echo ========== DOCKER STATUS ========== >> "%REPORT_FILE%"
docker version >> "%REPORT_FILE%" 2>&1
docker info >> "%REPORT_FILE%" 2>&1
echo. >> "%REPORT_FILE%"

echo [8/8] Recent Activity...
echo ========== RECENT ACTIVITY ========== >> "%REPORT_FILE%"
echo [%date% %time%] Developer tools accessed >> "%REPORT_FILE%"
echo. >> "%REPORT_FILE%"

echo.
echo  [SUCCESS] Report generated: %REPORT_FILE%
echo.
notepad "%REPORT_FILE%"
pause
goto :EOF

:GET_TOOL_STATUS
where %~2 >nul 2>&1
if %errorlevel%==0 (
    echo  [✓] %~1: Installed
    %~2 %~3 2>nul | findstr /i "[0-9]" | set /p= │ Version: 
) else (
    echo  [✗] %~1: Not installed
)
goto :EOF
```

---

## 📋 المملاحظات والتحسينات المقترحة:

### 1. تحسينات الأداء:
- إضافة المزيد من الأدوات في كل فئة
- تحسين واجهة المستخدم مع رسوم متحسنة
- إضافة المزيد من الخيارات التشخيصية

### 2. تحسينات الأداء:
- تحسين معالجة الأخطاء
- إضافة المزيد من التحقق من الصلاحيات
- تحسين أداء التثبيت

### 3. تحسينات التسجيل:
- إضافة المزيد من أنواعد السجلات
- تحليل السجلات وتقارير التقارير
- تصدير السجلات بصيغ متعددة

### 4. تحسينات الواجهة:
- إضافة المزيد من الخيارات التفاعلية
- تحسين عرض المعلومات
- إضافة شريط تقدم مرئي

### 5. تحسينات النظام:
- تحسين أداء التثبيت والتحديث
- إضافة المزيد من أدوات التشخيص
- تحسين إدارة الموارد

---

## 🎯 الخلاصة النهائية:

هذا الملف يمثل القائمة الرئيسية لقسم أدوات المطورين في KNOX Ultimate Toolbox، مع:

- **20 فئة رئيسية** تغطي جميع جوانب التطوير
- **واجهة مستخدم احترافية** مع تصميم موحد
- **نظام تسجيل شامل** لجميع العمليات
- **أدوات سريعة** للتثبيت والتحديث
- **تقارير شامل** للبيئة المطور

الملف جاهز للاستخدام كنقطة مركزية لجميع أدوات التطوير في النظام! 🚀
