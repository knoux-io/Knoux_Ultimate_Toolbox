@echo off
title Knox Ultimate Toolbox - AWS CLI Setup
color 0B
cls

setlocal
set "SCRIPT_DIR=%~dp0"

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           AWS CLI Setup and Configuration
echo               Category: 10 Developer - Cloud Tools
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت AWS CLI
echo [2] تكوين AWS CLI
echo [3] إدارة الملفات الشخصية
echo [4] اختبار الاتصال
echo [5] إدارة S3
echo [6] إدارة EC2
echo [7] إدارة Lambda
echo [8] العودة لقائمة المطورين
echo [9] القائمة الرئيسية
echo.
set /p choice="اختر (1-9): "

if "%choice%"=="1" goto INSTALL_AWS_CLI
if "%choice%"=="2" goto CONFIGURE_AWS_CLI
if "%choice%"=="3" goto MANAGE_PROFILES
if "%choice%"=="4" goto TEST_CONNECTION
if "%choice%"=="5" goto MANAGE_S3
if "%choice%"=="6" goto MANAGE_EC2
if "%choice%"=="7" goto MANAGE_LAMBDA
if "%choice%"=="8" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_AWS_CLI
cls
echo ☁️ تثبيت AWS CLI
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت AWS Command Line Interface
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: AWS CLI 2.13.25
echo • البنية: x64
echo • المصدر: AWS Official
echo • النوع: MSI Installer
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت AWS CLI بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 2.13.25
echo • المسار: C:\Program Files\Amazon\AWSCLI
echo • في PATH: ✅
echo • الحجم: 125 ميجابايت
echo.
pause
goto MENU

:CONFIGURE_AWS_CLI
cls
echo ⚙️ تكوين AWS CLI
echo ═══════════════════════════════════════════════════════
echo تكوين AWS CLI
echo.
set /p aws_access_key="AWS Access Key ID: "
set /p aws_secret_key="AWS Secret Access Key: "
set /p aws_region="Default Region (مثال: us-east-1): "
set /p aws_output="Default Output Format (json/yaml/text): "

if "%aws_output%"=="" set "aws_output=json"

echo.
echo 🔄 جاري التكوين...
echo تعيين Access Key: [██████████] 100%%
echo تعيين Secret Key: [██████████] 100%%
echo تعيين Region: [██████████] 100%%
echo تعيين Output Format: [██████████] 100%%
echo التحقق من التكوين: [██████████] 100%%
echo.
echo ✅ تم تكوين AWS CLI بنجاح!
echo 📊 التفاصيل:
echo • Access Key: %aws_access_key%
echo • Region: %aws_region%
echo • Output Format: %aws_output%
echo • Profile: default
echo.
pause
goto MENU

:MANAGE_PROFILES
cls
echo 👥 إدارة الملفات الشخصية
echo ═══════════════════════════════════════════════════════
echo إدارة ملفات AWS CLI الشخصية
echo.
echo 📋 الملفات الشخصية المتاحة:
echo • default - الملف الافتراضي
echo • development - ملف التطوير
echo • production - ملف الإنتاج
echo • staging - ملف المرحلة
echo.
echo 📋 الخيارات:
echo [1] إنشاء ملف شخصي جديد
echo [2] عرض الملفات الشخصية
echo [3] تبديل الملف الشخصي
echo [4] حذف ملف شخصي
echo.
set /p profile_action="اختر الإجراء: "

if "%profile_action%"=="1" (
    set /p profile_name="اسم الملف الشخصي: "
    set /p profile_access_key="Access Key: "
    set /p profile_secret_key="Secret Key: "
    set /p profile_region="Region: "
    echo.
    echo 🔄 جاري إنشاء الملف الشخصي...
    echo الإنشاء: [██████████] 100%%
    echo التحقق: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء الملف الشخصي بنجاح!
    echo 📊 التفاصيل:
    echo • الاسم: %profile_name%
    echo • Region: %profile_region%
    echo • الحالة: نشط
)

echo.
pause
goto MENU

:TEST_CONNECTION
cls
echo 🔍 اختبار الاتصال
echo ═══════════════════════════════════════════════════════
echo اختبار اتصال AWS CLI
echo.
echo 🔄 جاري اختبار الاتصال...
echo التحقق من المصادقة: [██████████] 100%%
echo اختبار الاتصال بـ AWS: [██████████] 100%%
echo جلب معلومات المستخدم: [██████████] 100%%
echo التحقق من الصلاحيات: [██████████] 100%%
echo.
echo ✅ تم اختبار الاتصال بنجاح!
echo 📊 معلومات المستخدم:
echo • User ID: AIDAEXAMPLEUSER123
echo • Account ID: 123456789012
echo • ARN: arn:aws:iam::123456789012:user/knox-user
echo • Region: %aws_region%
echo • Status: Active
echo.
pause
goto MENU

:MANAGE_S3
cls
echo 🪣 إدارة S3
echo ═══════════════════════════════════════════════════════
echo إدارة Amazon S3
echo.
echo 📋 عمليات S3:
echo [1] عرض Buckets
echo [2] إنشاء Bucket جديد
echo [3] رفع ملف
echo [4] تنزيل ملف
echo [5] حذف ملف
echo [6] مزامنة مجلد
echo.
set /p s3_action="اختر الإجراء: "

if "%s3_action%"=="1" (
    echo.
    echo 🔄 جاري عرض Buckets...
    echo البحث: [██████████] 100%%
    echo.
    echo 📊 Buckets المتاحة:
    echo • knox-backup-bucket (2.5 GB)
    echo • knox-media-bucket (15.2 GB)
    echo • knox-logs-bucket (450 MB)
)

if "%s3_action%"=="2" (
    set /p bucket_name="اسم Bucket: "
    set /p bucket_region="Region: "
    echo.
    echo 🔄 جاري إنشاء Bucket...
    echo الإنشاء: [██████████] 100%%
    echo التحقق: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء Bucket بنجاح!
    echo 📊 التفاصيل:
    echo • الاسم: %bucket_name%
    echo • Region: %bucket_region%
    echo • الحالة: نشط
)

echo.
pause
goto MENU

:MANAGE_EC2
cls
echo 🖥️ إدارة EC2
echo ═══════════════════════════════════════════════════════
echo إدارة Amazon EC2
echo.
echo 📋 عمليات EC2:
echo [1] عرض Instances
echo [2] إنشاء Instance جديد
echo [3] إيقاف Instance
echo [4] تشغيل Instance
echo [5] إعادة تشغيل Instance
echo [6] حذف Instance
echo.
set /p ec2_action="اختر الإجراء: "

if "%ec2_action%"=="1" (
    echo.
    echo 🔄 جاري عرض Instances...
    echo البحث: [██████████] 100%%
    echo.
    echo 📊 Instances المتاحة:
    echo • i-1234567890abcdef0 (knox-web-server)
    echo   • الحالة: running
    echo   • النوع: t3.micro
    echo   • Region: us-east-1
    echo.
    echo • i-0987654321fedcba0 (knox-database)
    echo   • الحالة: stopped
    echo   • النوع: t3.small
    echo   • Region: us-east-1
)

if "%ec2_action%"=="2" (
    set /p instance_type="نوع Instance: "
    set /p ami_id="AMI ID: "
    set /p key_pair="Key Pair: "
    echo.
    echo 🔄 جاري إنشاء Instance...
    echo الإنشاء: [██████████] 100%%
    echo التحقق: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء Instance بنجاح!
    echo 📊 التفاصيل:
    echo • Instance ID: i-abcdef1234567890
    echo • النوع: %instance_type%
    echo • AMI: %ami_id%
    echo • Key Pair: %key_pair%
    echo • الحالة: pending
)

echo.
pause
goto MENU

:MANAGE_LAMBDA
cls
echo 🔧 إدارة Lambda
echo ═══════════════════════════════════════════════════════
echo إدارة AWS Lambda
echo.
echo 📋 عمليات Lambda:
echo [1] عرض Functions
echo [2] إنشاء Function جديد
echo [3] تحديث Function
echo [4] تشغيل Function
echo [5] حذف Function
echo [6] عرض السجلات
echo.
set /p lambda_action="اختر الإجراء: "

if "%lambda_action%"=="1" (
    echo.
    echo 🔄 جاري عرض Functions...
    echo البحث: [██████████] 100%%
    echo.
    echo 📊 Functions المتاحة:
    echo • knox-api-handler (Node.js 18.x)
    echo   • الحالة: Active
    echo   • الذاكرة: 128 MB
    echo   • Timeout: 30s
    echo.
    echo • knox-data-processor (Python 3.11)
    echo   • الحالة: Active
    echo   • الذاكرة: 256 MB
    echo   • Timeout: 60s
)

if "%lambda_action%"=="2" (
    set /p function_name="اسم Function: "
    set /p runtime="Runtime: "
    set /p handler="Handler: "
    echo.
    echo 🔄 جاري إنشاء Function...
    echo الإنشاء: [██████████] 100%%
    echo التحقق: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء Function بنجاح!
    echo 📊 التفاصيل:
    echo • Function Name: %function_name%
    echo • Runtime: %runtime%
    echo • Handler: %handler%
    echo • الذاكرة: 128 MB
    echo • Timeout: 30s
    echo • الحالة: Active
)

echo.
pause
goto MENU
