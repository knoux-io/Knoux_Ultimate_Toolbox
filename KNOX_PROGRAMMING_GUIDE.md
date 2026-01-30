# 🏗️ KNOX Ultimate Toolbox - دليل البرمجة الشامل

## 📌 القواعد الأساسية لكتابة جميع الملفات

### 1️⃣ البنية الإلزامية لكل ملف .bat:

```batch
@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

REM ========================================
REM   اسم الملف: [FILE_NAME].bat
REM   الوصف: [DESCRIPTION]
REM   الإصدار: 4.2.0
REM   التاريخ: 2025-01-28
REM ========================================

REM --- التحقق من صلاحيات المسؤول ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] This script requires Administrator privileges!
    pause
    exit /b 1
)

REM --- المتغيرات الأساسية ---
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\"
set "LOGS_DIR=%ROOT_DIR%logs\"
set "TEMP_DIR=%ROOT_DIR%temp\"
set "BACKUP_DIR=%ROOT_DIR%backups\"

REM --- تسجيل العملية ---
set "LOG_FILE=%LOGS_DIR%operations.log"
echo [%date% %time%] Starting: %~nx0 >> "%LOG_FILE%"

REM --- المحتوى الرئيسي للسكريبت ---
goto :MAIN

:MAIN
cls
call :DRAW_HEADER
call :SHOW_MENU
call :HANDLE_INPUT
goto :EOF

:DRAW_HEADER
echo.
echo  ╔══════════════════════════════════════════════════════════════╗
echo  ║           KNOUX ULTIMATE TOOLBOX v4.2.0                        ║
echo  ║           [MODULE NAME]                                        ║
echo  ╚══════════════════════════════════════════════════════════════╝
echo.
goto :EOF

:SHOW_MENU
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] Option 1                                                  │
echo  │  [2] Option 2                                                  │
echo  │  [3] Option 3                                                  │
echo  │  [0] Return to Main Menu                                       │
echo  └────────────────────────────────────────────────────────────────┘
echo.
goto :EOF

:HANDLE_INPUT
set /p choice=" Enter your choice: "
if "%choice%"=="1" goto :OPTION_1
if "%choice%"=="2" goto :OPTION_2
if "%choice%"=="3" goto :OPTION_3
if "%choice%"=="0" call "%ROOT_DIR%Knoux.bat"
goto :SHOW_MENU

:OPTION_1
goto :MAIN

:CLEANUP
if exist "%TEMP_DIR%*.*" del /q "%TEMP_DIR%*.*" >nul 2>&1
goto :EOF

:LOG_ERROR
echo [%date% %time%] ERROR: %~1 >> "%LOGS_DIR%errors.log"
goto :EOF

:LOG_SUCCESS
echo [%date% %time%] SUCCESS: %~1 >> "%LOG_FILE%"
goto :EOF
```

---

## 🚀 المبادئ الذهبية للبرمجة:

### 1. التنظيم:
- كل قسم في مجلد منفصل
- كل وظيفة في ملف منفصل
- القوائم الفرعية تبدأ بـ `_menu.bat`

### 2. الترابط:
- استخدام `call` للانتقال بين الملفات
- `exit /b` للعودة إلى القائمة السابقة
- المتغيرات العامة متاحة عبر `setlocal`

### 3. الوظائف:
- Install (التثبيت)
- Update (التحديث)
- Remove (الإزالة)
- Check (الفحص)
- Configure (الإعداد)

### 4. التسجيل:
- تسجيل كل عملية
- فصل أنواع السجلات
- طوابع زمنية دقيقة

### 5. معالجة الأخطاء:
- فحص `errorlevel`
- رسائل واضحة
- خيارات للمحاولة مجدداً

---

## 📋 المكونات الإلزامية في كل ملف تثبيت:

### ✅ Checklist لملفات التثبيت:

```batch
REM [✓] 1. فحص الصلاحيات
net session >nul 2>&1 || goto :NO_ADMIN

REM [✓] 2. فحص الاتصال بالإنترنت
ping -n 1 google.com >nul 2>&1 || goto :NO_CONNECTION

REM [✓] 3. فحص إذا كان البرنامج مثبت
where program.exe >nul 2>&1 && goto :ALREADY_INSTALLED

REM [✓] 4. تسجيل بدء العملية
call :LOG_OPERATION "INFO" "Starting installation of [PROGRAM]"

REM [✓] 5. عرض شريط التقدم
call :PROGRESS_BAR 25

REM [✓] 6. معالجة الأخطاء
if %errorlevel% neq 0 goto :INSTALL_FAILED

REM [✓] 7. التحقق من نجاح التثبيت
where program.exe >nul 2>&1 || goto :VERIFY_FAILED

REM [✓] 8. تسجيل النجاح
call :LOG_OPERATION "SUCCESS" "[PROGRAM] installed successfully"

REM [✓] 9. عرض رسالة نجاح
call :PRINT_SUCCESS "Installation completed!"

REM [✓] 10. السؤال عن الخطوات التالية
echo.
echo  What would you like to do next?
echo  [1] Configure [PROGRAM]
echo  [2] Install additional packages
echo  [3] Return to menu
```

---

## 🎨 نظام الألوان والرسوم (colors.bat):

```batch
@echo off

REM تعريف الألوان
set "C_RESET=[0m"
set "C_RED=[91m"
set "C_GREEN=[92m"
set "C_YELLOW=[93m"
set "C_BLUE=[94m"
set "C_PURPLE=[95m"
set "C_CYAN=[96m"
set "C_WHITE=[97m"

REM دوال عرض ملونة
:PRINT_SUCCESS
echo %C_GREEN%[✓]%C_RESET% %~1
goto :EOF

:PRINT_ERROR
echo %C_RED%[✗]%C_RESET% %~1
goto :EOF

:PRINT_WARNING
echo %C_YELLOW%[!]%C_RESET% %~1
goto :EOF

:PRINT_INFO
echo %C_BLUE%[i]%C_RESET% %~1
goto :EOF

REM شريط التقدم
:PROGRESS_BAR
set /a percent=%1
set /a filled=%percent%/2
set /a empty=50-%filled%

set "bar="
for /l %%i in (1,1,%filled%) do set "bar=!bar!█"
for /l %%i in (1,1,%empty%) do set "bar=!bar!░"

echo  [!bar!] %percent%%%
goto :EOF
```

---

## 📊 نظام التسجيل (Logging):

```batch
REM دالة تسجيل شاملة

:LOG_OPERATION
REM Parameters: %1=Type, %2=Message
set "LOG_TYPE=%~1"
set "LOG_MSG=%~2"
set "TIMESTAMP=%date% %time%"

REM تحديد ملف السجل بناءً على النوع
if /i "%LOG_TYPE%"=="ERROR" (
    echo [%TIMESTAMP%] ERROR: %LOG_MSG% >> "%LOGS%errors.log"
) else if /i "%LOG_TYPE%"=="SUCCESS" (
    echo [%TIMESTAMP%] SUCCESS: %LOG_MSG% >> "%LOGS%operations.log"
) else if /i "%LOG_TYPE%"=="INFO" (
    echo [%TIMESTAMP%] INFO: %LOG_MSG% >> "%LOGS%operations.log"
) else if /i "%LOG_TYPE%"=="WARNING" (
    echo [%TIMESTAMP%] WARNING: %LOG_MSG% >> "%LOGS%operations.log"
)

REM إرسال أيضاً إلى السجل الرئيسي
echo [%TIMESTAMP%] [%LOG_TYPE%] %LOG_MSG% >> "%LOGS%operations.log"

goto :EOF

REM استخدام الدالة:
call :LOG_OPERATION "INFO" "Starting Python 3.12 installation"
call :LOG_OPERATION "SUCCESS" "Python installed successfully"
call :LOG_OPERATION "ERROR" "Failed to download package"
```

---

## 🔧 نظام التحديثات:

```batch
:UPDATE_SYSTEM
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           🔄 SYSTEM UPDATE CENTER                              ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

echo [INFO] Current Version: %VERSION%
echo [INFO] Checking for updates...
echo.

REM فحص إصدار GitHub
set "CURRENT_VERSION=4.2.0"
set "UPDATE_URL=https://github.com/knoux/ultimate-toolbox/releases/latest"

echo Current Version: %CURRENT_VERSION%
echo Checking remote version...

REM يمكن استخدام curl أو wget للفحص
curl -s %UPDATE_URL% > temp\latest_version.txt

REM مقارنة الإصدارات
REM إذا كان هناك تحديث:
echo.
echo [UPDATE AVAILABLE] New version: 4.3.0
echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] Download and Install Update                               │
echo  │  [2] View Changelog                                            │
echo  │  [3] Skip Update                                               │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p update_choice=" Select option: "

if "%update_choice%"=="1" goto :DOWNLOAD_UPDATE
if "%update_choice%"=="2" goto :VIEW_CHANGELOG
if "%update_choice%"=="3" goto :MAIN_MENU

:DOWNLOAD_UPDATE
echo [INFO] Downloading update...
REM كود التحديث
goto :MAIN_MENU
```

---

## 💾 نظام النسخ الاحتياطي:

```batch
:CREATE_BACKUP
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║           💾 BACKUP MANAGER                                    ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

set "BACKUP_DATE=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "BACKUP_DATE=%BACKUP_DATE: =0%"
set "BACKUP_PATH=%BACKUP_DIR%KNOUX_Backup_%BACKUP_DATE%"

echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  SELECT BACKUP TYPE:                                           │
echo  │                                                              │
echo  │  [1] Full System Backup (Registry + Configs + Logs)            │
echo  │  [2] Registry Only                                             │
echo  │  [3] Services Configuration                                    │
echo  │  [4] Network Settings                                          │
echo  │  [5] Custom Backup                                             │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p backup_choice=" Select backup type [1-5]: "

if "%backup_choice%"=="1" goto :FULL_BACKUP
if "%backup_choice%"=="2" goto :REGISTRY_BACKUP

:FULL_BACKUP
echo.
echo [INFO] Creating full system backup...
mkdir "%BACKUP_PATH%" 2>nul

echo [1/4] Backing up Registry...
reg export HKLM "%BACKUP_PATH%\HKLM_backup.reg" /y >nul 2>&1
reg export HKCU "%BACKUP_PATH%\HKCU_backup.reg" /y >nul 2>&1

echo [2/4] Backing up Services configuration...
sc query > "%BACKUP_PATH%\services_state.txt"

echo [3/4] Backing up Network settings...
ipconfig /all > "%BACKUP_PATH%\network_config.txt"

echo [4/4] Copying configuration files...
xcopy /E /I /Y "%CONFIG%\*.*" "%BACKUP_PATH%\configs\"

echo.
echo [SUCCESS] Backup completed: %BACKUP_PATH%
pause
goto :MAIN_MENU
```

---

## 📋 الخلاصة النهائية:

### المبادئ الأساسية:
1. **التنظيم المنطقي** - هيكلية واضحة للمجلدات والملفات
2. **الترابط الموثوق** - استخدام `call` و `exit /b` بشكل صحيح
3. **التسجيل الشامل** - تسجيل كل العمليات والأخطاء
4. **معالجة الأخطاء** - التحقق من `errorlevel` وتقديم حلول
5. **واجهة المستخدم** - رسائل واضحة وتفاعلية

### الهيكل الموصى به:
```
KNOX_ULTIMATE_TOOLBOX/
├── Knoux.bat (الملف الرئيسي)
├── modules/ (الأقسام الرئيسية)
│   ├── 01_diagnostics.bat
│   ├── 02_optimization.bat
│   ├── 03_security.bat
│   ├── 04_network.bat
│   ├── 05_disk.bat
│   ├── 06_registry.bat
│   ├── 07_services.bat
│   ├── 08_tweaks.bat
│   ├── 09_sysinfo.bat
│   └── 10_developer.bat
├── resources/ (الموارد المشتركة)
│   ├── colors.bat
│   ├── animations.bat
│   └── logo.txt
├── logs/ (سجلات العمليات)
├── backups/ (النسخ الاحتياطية)
├── config/ (إعدادات النظام)
├── temp/ (ملفات مؤقتة)
└── exports/ (تصدير التقارير)
```

هذا الدليل الشامل يضمن أن جميع ملفات KNOX Ultimate Toolbox تتبع نفس المعايير والجودة العالية!
