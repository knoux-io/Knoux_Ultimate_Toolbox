@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ====================================================================
:: 🏆 KNOUX DEVELOPER ENVIRONMENT SETUP MANAGER
:: 📅 Version: 4.2.0 | Section: env_setup
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
set "ENV_SETUP_PATH=%~dp0"
set "BACKUP_PATH=%TOOLBOX_PATH%backups\env_setup\"
set "LOGS_PATH=%TOOLBOX_PATH%logs\"
set "RESOURCES_PATH=%TOOLBOX_PATH%resources\"

:: 📅 إنشاء معرف فريد للجلسة
set "SESSION_ID=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "SESSION_LOG=%LOGS_PATH%env_setup_%SESSION_ID%.log"

:: 📝 تسجيل بدء الجلسة
echo [%DATE% %TIME%] بدء تشغيل env_setup_manager.bat >> "%SESSION_LOG%"

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
echo    ║                    🚀 إعداد بيئات التطوير                   ║
echo    ║                    📅 الإصدار: v4.2.0                    ║
echo    ║                    📂 القسم: env_setup                    ║
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
set "clean=!clean:🚀=!"
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
echo    │   🚀 إعداد بيئات التطوير                                     │
echo    │   📊 الوصف: تثبيت وإدارة بيئات التطوير المتقدمة               │
echo    │   ⚡ الحالة: ✅ جاهز للتشغيل                                   │
echo    │                                                                │
echo    └────────────────────────────────────────────────────────────────┘
echo.

echo    ┌────────────────────────────────────────────────────────────────┐
echo    │   🎯 الخيارات المتاحة:                                        │
echo    │                                                                │
echo    │   🟢 Node.js:                                                   │
echo    │   [1] 🟢 Node.js LTS (مستقر)                                  │
echo    │   [2] 🌈 Node.js Latest (أحدث)                                │
echo    │   [3] 📦 NVM (إدارة إصدارات متعددة)                           │
echo    │                                                                │
echo    │   🐍 Python:                                                   │
echo    │   [4] 🐍 Python 3.12 (أحدث)                                  │
echo    │   [5] 🐍 Python 3.11 (للتوافق)                               │
echo    │   [6] 🐍 Python Multi-Version Manager                        │
echo    │   [7] 🏝️  Python Virtual Environment Manager                   │
echo    │                                                                │
echo    │   ☕ Java:                                                     │
echo    │   [8] ☕ Java JDK 21 (LTS حديث)                               │
echo    │   [9] ☕ Java JDK 17 (LTS شائع)                               │
echo    │                                                                │
echo    │   🌐 .NET:                                                     │
echo    │   [10] 🌐 .NET 8 SDK (أحدث)                                   │
echo    │   [11] 🌐 .NET 6 SDK (LTS)                                     │
echo    │                                                                │
echo    │   🐹 Go:                                                       │
echo    │   [12] 🐹 Go Programming Language                              │
echo    │                                                                │
echo    │   🦀 Rust:                                                     │
echo    │   [13] 🦀 Rust Programming Language                           │
echo    │                                                                │
echo    │   💎 Ruby:                                                     │
echo    │   [14] 💎 Ruby + DevKit                                       │
echo    │                                                                │
echo    │   🐘 PHP:                                                      │
echo    │   [15] 🐘 PHP 8.3 + Composer                                  │
echo    │   [16] 🎵 Composer Package Manager                             │
echo    │                                                                │
echo    │   🐪 Perl:                                                     │
echo    │   [17] 🐪 Perl + CPAN                                          │
echo    │                                                                │
echo    │   🛠️  أدوات النظام:                                            │
echo    │   [18] 🛣️  مدير متغيرات البيئة                                │
echo    │   [19] ➕ مدير مسار النظام (PATH)                              │
echo    │   [20] 💾 تصدير إعدادات البيئة                               │
echo    │                                                                │
echo    │   [0] ↩ العودة إلى القائمة الرئيسية                          │
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
set /p "SELECTION=   🔍 أدخل رقم الخيار أو الحرف [0-20/R/H]: "

:: ====================================================================
:: 🔄 معالجة الاختيارات
:: ====================================================================

:: العودة للقائمة الرئيسية
if "!SELECTION!"=="0" goto :RETURN_TO_MAIN

:: إعادة تشغيل الوحدة
if /i "!SELECTION!"=="R" (
    echo 🔄 جاري إعادة تشغيل الوحدة...
    timeout /t 2 /nobreak >nul
    goto :MAIN_MENU
)

:: عرض المساعدة
if /i "!SELECTION!"=="H" goto :SHOW_HELP

:: معالجة الخيارات العددية
if "!SELECTION!"=="1" goto :LAUNCH_SCRIPT "nodejs_lts.bat" "Node.js LTS"
if "!SELECTION!"=="2" goto :LAUNCH_SCRIPT "nodejs_latest.bat" "Node.js Latest"
if "!SELECTION!"=="3" goto :LAUNCH_SCRIPT "nvm_setup.bat" "NVM for Windows"
if "!SELECTION!"=="4" goto :LAUNCH_SCRIPT "python_312.bat" "Python 3.12"
if "!SELECTION!"=="5" goto :LAUNCH_SCRIPT "python_311.bat" "Python 3.11"
if "!SELECTION!"=="6" goto :LAUNCH_SCRIPT "python_multi.bat" "Python Multi-Version"
if "!SELECTION!"=="7" goto :LAUNCH_SCRIPT "python_env.bat" "Python Virtual Environment"
if "!SELECTION!"=="8" goto :LAUNCH_SCRIPT "java_21.bat" "Java JDK 21"
if "!SELECTION!"=="9" goto :LAUNCH_SCRIPT "java_17.bat" "Java JDK 17"
if "!SELECTION!"=="10" goto :LAUNCH_SCRIPT "dotnet_8.bat" ".NET 8 SDK"
if "!SELECTION!"=="11" goto :LAUNCH_SCRIPT "dotnet_6.bat" ".NET 6 SDK"
if "!SELECTION!"=="12" goto :LAUNCH_SCRIPT "go_setup.bat" "Go Programming"
if "!SELECTION!"=="13" goto :LAUNCH_SCRIPT "rust_setup.bat" "Rust Programming"
if "!SELECTION!"=="14" goto :LAUNCH_SCRIPT "ruby_setup.bat" "Ruby + DevKit"
if "!SELECTION!"=="15" goto :LAUNCH_SCRIPT "php_83.bat" "PHP 8.3 + Composer"
if "!SELECTION!"=="16" goto :LAUNCH_SCRIPT "composer_setup.bat" "Composer Manager"
if "!SELECTION!"=="17" goto :LAUNCH_SCRIPT "perl_setup.bat" "Perl + CPAN"
if "!SELECTION!"=="18" goto :LAUNCH_SCRIPT "env_variables.bat" "Environment Variables Manager"
if "!SELECTION!"=="19" goto :LAUNCH_SCRIPT "path_manager.bat" "PATH Manager"
if "!SELECTION!"=="20" goto :LAUNCH_SCRIPT "export_settings.bat" "Export Settings"

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
if not exist "%ENV_SETUP_PATH%!SCRIPT_FILE!" (
    echo.
    echo ❌ ملف السكربت غير موجود: !SCRIPT_FILE!
    echo 📢 الرجاء التحقق من وجود الملف
    timeout /t 3 /nobreak >nul
    goto :MAIN_MENU
)

:: LAUNCH SCRIPT
cd /d "%ENV_SETUP_PATH%"
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
echo    │   ❓ المساعدة - إعداد بيئات التطوير                          │
echo    │                                                                │
echo    │   📖 الوصف:                                                   │
echo    │   هذا القسم يحتوي على أدوات متقدمة لإعداد بيئات التطوير،      │
echo    │   تثبيت لغات البرمجة، وإدارة الأدوات اللازمة للمطورين.       │
echo    │                                                                │
echo    │   ⚡ المميزات:                                                │
echo    │   • تثبيت تلقائي لأدوات التطوير                              │
echo    │   • إدارة إصدارات متعددة من اللغات                           │
echo    │   • إعدادات متغيرات البيئة                                   │
echo    │   • إدارة مسارات النظام                                       │
echo    │   • تصدير الإعدادات                                           │
echo    │                                                                │
echo    │   🎯 نصائح سريعة:                                            │
echo    │   • ابدأ بـ Node.js LTS (الخيار 1)                            │
echo    │   • قم بتثبيت Python 3.12 (الخيار 4)                          │
echo    │   • استخدم مدير البيئة الافتراضية (الخيار 7)                  │
echo    │   • قم بتصدير الإعدادات (الخيار 20)                           │
echo    │                                                                │
echo    │   ⚠️  تحذيرات:                                               │
echo    │   • بعض التثبيتات تتطلب اتصال بالإنترنت                       │
echo    │   • قد تحتاج إلى إعادة تشغيل بعد التثبيت                      │
echo    │   • بعض الأدوات تتطلب صلاحيات مسؤول                          │
echo    │                                                                │
echo    └────────────────────────────────────────────────────────────────┘
echo.

set /p "help_return=   ↩ اضغط Enter للعودة: "
goto :MAIN_MENU

:: ====================================================================
:: 🔙 العودة للقائمة الرئيسية
:: ====================================================================

:RETURN_TO_MAIN
echo.
call :LOG_OPERATION "خروج من إعداد بيئات التطوير" "INFO" "العودة للقائمة الرئيسية"

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
echo 🔄 العودة إلى القائمة الرئيسية...
timeout /t 2 /nobreak >nul

:: العودة لملف Knoux.bat
cd /d "%TOOLBOX_PATH%"
call "Knoux.bat"

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
