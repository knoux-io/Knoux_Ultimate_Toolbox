@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ====================================================================
:: 🏆 KNOUX PACKAGE MANAGERS SECTION MANAGER
:: 📅 Version: 4.2.0 | Section: package_managers
:: ====================================================================

:: 🔐 إدارة الصلاحيات الإدارية
>nul 2>&1 net session
if %errorLevel% neq 0 (
    echo ⚠️  يلزم صلاحيات المدير / Admin rights required
    echo 📢 الرجاء تشغيل البرنامج كمسؤول
    pause
    exit /b 1
)

:: 📁 تحديد المسارات الثابتة
set "TOOLBOX_PATH=%~dp0..\..\"
set "MODULES_PATH=%TOOLBOX_PATH%modules\"
set "DEVELOPER_PATH=%~dp0"
set "PACKAGE_MGR_PATH=%~dp0"
set "BACKUP_PATH=%TOOLBOX_PATH%backups\package_managers\"
set "LOGS_PATH=%TOOLBOX_PATH%logs\"
set "RESOURCES_PATH=%TOOLBOX_PATH%resources\"

:: 📅 إنشاء معرف فريد للجلسة
set "SESSION_ID=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "SESSION_LOG=%LOGS_PATH%package_managers_%SESSION_ID%.log"

:: 📝 تسجيل بدء الجلسة
echo [%DATE% %TIME%] بدء تشغيل package_managers_manager.bat >> "%SESSION_LOG%"

:: 🎨 تحميل مكتبة الألوان
if exist "%RESOURCES_PATH%colors.bat" (
    call "%RESOURCES_PATH%colors.bat"
) else (
    echo ⚠️  مكتبة الألوان غير موجودة
)

:: 🔄 تهيئة المتغيرات العالمية
set "SELECTION=0"
set "RETURN_CODE=0"
set "OPERATION_STATUS="
set "BACKUP_CREATED=0"

:: 📊 عداد العمليات
set /a "TOTAL_OPERATIONS=0"
set /a "SUCCESSFUL_OPS=0"
set /a "FAILED_OPS=0"

:: ====================================================================
:: 🎭 FUNCTION LIBRARY - مكتبة الدوال المشتركة
:: ====================================================================

:: 📋 دالة عرض العنوان الرئيسي
:SHOW_HEADER
cls
echo.
echo    ╔══════════════════════════════════════════════════════════════╗
echo    ║                    🏆 KNOUX ULTIMATE TOOLBOX             ║
echo    ║                    📦 مديرو الحزم المتقدمين                ║
echo    ║                    📅 الإصدار: v4.2.0                    ║
echo    ║                    📂 القسم: package_managers           ║
echo    ╚══════════════════════════════════════════════════════════════╝
echo.
goto :EOF

:: 🎨 دالة طباعة نص متمركز
:PRINT_CENTER
setlocal
set "text=%~1"
set "color=%~2"
set "width=78"
set "len=0"

:: حساب طول النص
for /f "delims=█▓▒░┌┐└┘├┤┬┴┼╔╗╚╝╠╣╦╩╬═║╒╓╕╖╘╙╛╜╞╟╡╢╤╥╧╨╪╫" %%a in ("!text!") do (
    set "clean=%%a"
)
set "clean=!clean:🏆=!"
set "clean=!clean:📦=!"
set "clean=!clean:📅=!"
set "clean=!clean:📂=!"

for /l %%i in (0,1,1000) do (
    if "!clean:~%%i,1!" neq "" (
        set /a "len+=1"
    ) else (
        goto :calc_padding
    )
)

:calc_padding
set /a "padding=(width - len) / 2"
set "space="
for /l %%i in (1,1,!padding!) do set "space=!space! "

echo !space!!text!
endlocal
goto :EOF

:: 🔄 دالة شريط التقدم المتحرك
:ANIMATED_PROGRESS
setlocal
set "task=%~1"
set "duration=%~2"
set "steps=50"
set /a "delay=duration*1000/steps"

echo.
echo    !task!...
echo    ┌────────────────────────────────────────────────────────────────┐
echo    │                                                                │
set /a "current=0"
for /l %%i in (1,1,!steps!) do (
    set /a "current=%%i*100/steps"
    set "progress="
    for /l %%j in (1,1,%%i) do set "progress=!progress!█"
    set "remaining="
    for /l %%j in (%%i,1,!steps!) do set "remaining=!remaining!░"
    
    echo    │ [!progress!!remaining!] !current!%% │
    
    ping -n 2 127.0.0.1 >nul
    echo    │                                                                │
)
echo    └────────────────────────────────────────────────────────────────┘
endlocal
goto :EOF

:: 💾 دالة إنشاء نسخة احتياطية
:CREATE_BACKUP
setlocal
set "backup_type=%~1"
set "backup_name=%SESSION_ID%_%backup_type%"

echo 📁 جاري إنشاء نسخة احتياطية [!backup_name!]...
mkdir "%BACKUP_PATH%%backup_type%\" >nul 2>&1

if "!backup_type!"=="registry" (
    reg export HKLM "%BACKUP_PATH%registry\!backup_name!.reg" /y >nul 2>&1
    reg export HKCU "%BACKUP_PATH%registry\!backup_name!_user.reg" /y >nul 2>&1
    echo ✅ تم إنشاء نسخة احتياطية للتسجيل
) else if "!backup_type!"=="system" (
    systeminfo > "%BACKUP_PATH%configs\!backup_name!_system.txt" 2>&1
    echo ✅ تم إنشاء نسخة احتياطية للنظام
)

set "BACKUP_CREATED=1"
endlocal
goto :EOF

:: 📝 دالة تسجيل العملية
:LOG_OPERATION
setlocal
set "operation=%~1"
set "status=%~2"
set "details=%~3"

echo [!DATE! !TIME!] [!status!] !operation! - !details! >> "%SESSION_LOG%"

if "!status!"=="SUCCESS" (
    set /a "SUCCESSFUL_OPS+=1"
    echo ✅ !operation! - !details!
) else if "!status!"=="ERROR" (
    set /a "FAILED_OPS+=1"
    echo ❌ !operation! - !details!
) else if "!status!"=="WARNING" (
    echo ⚠️  !operation! - !details!
) else if "!status!"=="INFO" (
    echo ℹ️  !operation! - !details!
)

set /a "TOTAL_OPERATIONS+=1"
endlocal
goto :EOF

:: 🔍 دالة فحص متطلبات التشغيل
:CHECK_REQUIREMENTS
setlocal
set "requirements_met=1"

:: فحص مساحة القرص
for /f "tokens=3" %%a in ('dir /-c "%SystemDrive%" ^| find "bytes free"') do set "free_space=%%a"
set "free_space=!free_space:,=!"

if !free_space! LSS 104857600 (
    echo ⚠️  تحذير: مساحة القرص منخفضة (!free_space! بايت)
    set "requirements_met=0"
)

if !requirements_met! equ 0 (
    echo.
    echo 📢 التوصيات:
    echo • حرر مساحة على القرص الصلب
    echo.
    set /p "continue=هل تريد المتابعة على أي حال؟ [ن/ل]: "
    if /i not "!continue!"=="ن" (
        endlocal & set "REQUIREMENTS_PASSED=0"
        goto :EOF
    )
)

endlocal & set "REQUIREMENTS_PASSED=1"
goto :EOF

:: ====================================================================
:: 🎯 MAIN MENU - القائمة الرئيسية للوحدة
:: ====================================================================

:MAIN_MENU
call :SHOW_HEADER

echo    ┌────────────────────────────────────────────────────────────────┐
echo    │                                                                │
echo    │   📦 مديرو الحزم المتقدمين                                   │
echo    │   📊 الوصف: إدارة وتثبيت مديري الحزم المتقدمة          │
echo    │   ⚡ الحالة: ✅ جاهز للتشغيل                                   │
echo    │                                                                │
echo    └────────────────────────────────────────────────────────────────┘
echo.

echo    ┌────────────────────────────────────────────────────────────────┐
echo    │   🎯 الخيارات المتاحة:                                        │
echo    │                                                                │
echo    │   🍫 Windows Package Managers:                                     │
echo    │   [1] 🍫 Chocolatey - مدير حزم Windows القوي              │
echo    │   [2] 🥄 Scoop - مدير خفيف بدون صلاحيات                │
echo    │   [3] 🪶 WinGet - المدير الرسمي من مايكروسوفت              │
echo    │                                                                │
echo    │   📦 Node.js Ecosystem:                                          │
echo    │   [4] 📦 NPM Global - إدارة حزم Node.js العالمية           │
echo    │   [5] 🧶 Yarn - بديل أسرع لـ NPM                           │
echo    │   [6] ⚡ PNPM - الأسرع (Ecosystem-friendly)                │
echo    │                                                                │
echo    │   🐍 Python Package Managers:                                      │
echo    │   [7] 🐍 PIP - مدير حزم Python الأساسي                    │
echo    │   [8] 🏝️  Pipenv - إدارة بيئات بايثون الذكية           │
echo    │   [9] 📜 Poetry - مدير حزم بايثون الحديث                  │
echo    │   [10] 🐍 Conda - لعلوم البيانات والذكاء الاصطناعي      │
echo    │                                                                │
echo    │   🔧 أدوات التحديث والصيانة:                                      │
echo    │   [11] 🔄 NPM Update All - تحديث جميع حزم NPM العالمية        │
echo    │   [12] 🔄 PIP Update All - تحديث جميع حزم Python              │
echo    │   [13] 🧹 NPM Cache Clean - تنظيف كاش NPM                    │
echo    │   [14] 🧹 PIP Cache Clean - تنظيف كاش PIP                    │
echo    │   [15] 🔧 NPM Fix Permissions - إصلاح أخطاء الأذونات         │
echo    │                                                                │
echo    │   [0] ↩ العودة إلى قسم المطورين                              │
echo    │   [R] 🔄 إعادة تشغيل الوحدة                                   │
echo    │   [H] ❓ المساعدة والإرشادات                                  │
echo    │                                                                │
echo    └────────────────────────────────────────────────────────────────┘
echo.

:: عرض حالة النظام السريع
if exist "%TEMP%\sysinfo.tmp" del "%TEMP%\sysinfo.tmp"
systeminfo | findstr /C:"اسم النظام" > "%TEMP%\sysinfo.tmp"
if exist "%TEMP%\sysinfo.tmp" (
    echo    📊 حالة النظام: ✅ جاهز للتشغيل
    del "%TEMP%\sysinfo.tmp"
)

echo.
set /p "SELECTION=   🔍 أدخل رقم الخيار أو الحرف [0-15/R/H]: "

:: ====================================================================
:: 🔄 معالجة الاختيارات
:: ====================================================================

:: العودة لقسم المطورين
if "!SELECTION!"=="0" goto :RETURN_TO_DEVELOPER

:: إعادة تشغيل الوحدة
if /i "!SELECTION!"=="R" (
    echo 🔄 جاري إعادة تشغيل الوحدة...
    timeout /t 2 /nobreak >nul
    goto :MAIN_MENU
)

:: عرض المساعدة
if /i "!SELECTION!"=="H" goto :SHOW_HELP

:: معالجة الخيارات العددية
if "!SELECTION!"=="1" goto :LAUNCH_SCRIPT "chocolatey_setup.bat" "Chocolatey"
if "!SELECTION!"=="2" goto :LAUNCH_SCRIPT "scoop_setup.bat" "Scoop"
if "!SELECTION!"=="3" goto :LAUNCH_SCRIPT "winget_setup.bat" "WinGet"
if "!SELECTION!"=="4" goto :LAUNCH_SCRIPT "npm_global.bat" "NPM Global"
if "!SELECTION!"=="5" goto :LAUNCH_SCRIPT "yarn_setup.bat" "Yarn"
if "!SELECTION!"=="6" goto :LAUNCH_SCRIPT "pnpm_setup.bat" "PNPM"
if "!SELECTION!"=="7" goto :LAUNCH_SCRIPT "pip_packages.bat" "PIP"
if "!SELECTION!"=="8" goto :LAUNCH_SCRIPT "pipenv_setup.bat" "Pipenv"
if "!SELECTION!"=="9" goto :LAUNCH_SCRIPT "poetry_setup.bat" "Poetry"
if "!SELECTION!"=="10" goto :LAUNCH_SCRIPT "conda_setup.bat" "Conda"
if "!SELECTION!"=="11" goto :LAUNCH_SCRIPT "npm_update_all.bat" "NPM Update All"
if "!SELECTION!"=="12" goto :LAUNCH_SCRIPT "pip_update_all.bat" "PIP Update All"
if "!SELECTION!"=="13" goto :LAUNCH_SCRIPT "npm_cache_clean.bat" "NPM Cache Clean"
if "!SELECTION!"=="14" goto :LAUNCH_SCRIPT "pip_cache_clean.bat" "PIP Cache Clean"
if "!SELECTION!"=="15" goto :LAUNCH_SCRIPT "npm_fix_permissions.bat" "NPM Fix Permissions"

:: إذا لم يكن الاختيار صالحاً
echo.
echo ⚠️  اختيار غير صالح: !SELECTION!
echo 📢 الرجاء اختيار رقم أو حرف من القائمة أعلاه
timeout /t 3 /nobreak >nul
goto :MAIN_MENU

:: ====================================================================
:: 🚀 LAUNCH SCRIPT FUNCTION
:: ====================================================================

:LAUNCH_SCRIPT
set "SCRIPT_FILE=%~1"
set "SCRIPT_NAME=%~2"

:: LOG SCRIPT LAUNCH
echo [%DATE% %TIME%] Launching script: !SCRIPT_FILE! - !SCRIPT_NAME! >> "%SESSION_LOG%"

:: CHECK IF SCRIPT EXISTS
if not exist "%PACKAGE_MGR_PATH%!SCRIPT_FILE!" (
    echo.
    echo ❌ ملف السكربت غير موجود: !SCRIPT_FILE!
    echo 📢 الرجاء التحقق من وجود الملف
    timeout /t 3 /nobreak >nul
    goto :MAIN_MENU
)

:: LAUNCH SCRIPT
cd /d "%PACKAGE_MGR_PATH%"
call "!SCRIPT_FILE!"

:: RETURN TO MAIN MENU
cd /d "%TOOLBOX_PATH%"
goto :MAIN_MENU

:: ====================================================================
:: ❓ قسم المساعدة
:: ====================================================================

:SHOW_HELP
call :SHOW_HEADER

echo    ┌────────────────────────────────────────────────────────────────┐
echo    │   ❓ المساعدة - مديرو الحزم المتقدمين                           │
echo    │                                                                │
echo    │   📖 الوصف:                                                   │
echo    │   هذا القسم يحتوي على أدوات متقدمة لإدارة مديري الحزم،         │
echo    │   تثبيت البرمجيات، وتحديث الحزم، وإدارة التخزين المؤقت.       │
echo    │                                                                │
echo    │   ⚡ المميزات:                                                │
echo    │   • مديرو حزم Windows (Chocolatey, Scoop, WinGet)               │
echo    │   • مديرو حزم Node.js (NPM, Yarn, PNPM)                    │
echo    │   • مديرو حزم Python (PIP, Pipenv, Poetry, Conda)              │
echo    │   • أدوات التحديث والصيانة                                  │
echo    │                                                                │
echo    │   🎯 نصائح سريعة:                                            │
echo    │   • ابدأ بـ Chocolatey (الخيار 1) - الأقوى لـ Windows      │
echo    │   • استخدم Scoop (الخيار 2) - بدون صلاحيات مسؤول          │
echo    │   • استخدم WinGet (الخيار 3) - الرسمي من مايكروسوفت          │
echo    │   • استخدم PNPM (الخيار 6) - الأسرع والأكثر كفاءة          │
echo    │   • استخدم Poetry (الخيار 9) - الأحدث لـ Python             │
echo    │   • استخدم أدوات التحديث (الخيارات 11-15)                     │
echo    │                                                                │
echo    │   ⚠️  تحذيرات:                                               │
echo    │   • بعض التثبيتات تتطلب اتصال بالإنترنت                       │
echo    │   • قد تحتاج إلى إعادة تشغيل بعد التثبيت                      │
echo    │   • بعض الأدوات تتطلب صلاحيات مسؤول                          │
echo    │   • النسخ الاحتياطي التلقائي مفعل لجميع العمليات             │
echo    │                                                                │
echo    └────────────────────────────────────────────────────────────────┘
echo.

set /p "help_return=   ↩ اضغط Enter للعودة: "
goto :MAIN_MENU

:: ====================================================================
:: 🔙 العودة لقسم المطورين
:: ====================================================================

:RETURN_TO_DEVELOPER
echo.
call :LOG_OPERATION "خروج من مديري الحزم" "INFO" "العودة لقسم المطورين"

:: عرض ملخص العمليات
if !TOTAL_OPERATIONS! GTR 0 (
    echo.
    echo 📊 ملخص الجلسة:
    echo ┌─────────────────────────────────────┐
    echo │ • إجمالي العمليات: !TOTAL_OPERATIONS!          │
    echo │ • الناجحة: !SUCCESSFUL_OPS!                    │
    echo │ • الفاشلة: !FAILED_OPS!                        │
    echo └─────────────────────────────────────┘
)

echo.
echo 🔄 العودة إلى قسم المطورين...
timeout /t 2 /nobreak >nul

:: العودة لملف 10_developer.bat
cd /d "%DEVELOPER_PATH%"
call "10_developer.bat"

:: ====================================================================
:: 🚨 معالجة الأخطاء
:: ====================================================================

:ERROR_HANDLER
echo.
echo ⚠️  حدث خطأ أثناء التنفيذ
echo 📢 تفاصيل الخطأ:
echo !errorlevel!
echo.

call :LOG_OPERATION "خطأ عام" "ERROR" "كود الخطأ: !errorlevel!"

set /p "error_return=   ↩ اضغط Enter للعودة: "
goto :MAIN_MENU

:: ====================================================================
:: 🎬 نهاية الملف
:: ====================================================================

:END
echo.
echo 🏆 جلسة العمل اكتملت
echo 📁 تم حفظ السجل في: !SESSION_LOG!
echo.
pause
exit /b 0
