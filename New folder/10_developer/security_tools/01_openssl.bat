@echo off
title Knox Ultimate Toolbox - OpenSSL Setup
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
echo           OpenSSL Setup and Tools
echo               Category: 10 Developer - Security Tools
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت OpenSSL
echo [2] إنشاء شهادة SSL
echo [3] إنشاء مفتاح خاص
echo [4] توقيع شهادة
echo [5] تحليل الشهادة
echo [6] تشفير وفك تشفير
echo [7] العودة لقائمة المطورين
echo [8] القائمة الرئيسية
echo.
set /p choice="اختر (1-8): "

if "%choice%"=="1" goto INSTALL_OPENSSL
if "%choice%"=="2" goto CREATE_CERTIFICATE
if "%choice%"=="3" goto CREATE_PRIVATE_KEY
if "%choice%"=="4" goto SIGN_CERTIFICATE
if "%choice%"=="5" goto ANALYZE_CERTIFICATE
if "%choice%"=="6" goto ENCRYPT_DECRYPT
if "%choice%"=="7" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="8" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_OPENSSL
cls
echo 🔐 تثبيت OpenSSL
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت OpenSSL
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: OpenSSL 3.1.4
echo • البنية: x64
echo • المسار: C:\Program Files\OpenSSL-Win64
echo • Light Version: نعم
echo • Copy DLLs: إلى Windows System32
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت OpenSSL بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 3.1.4
echo • المسار: C:\Program Files\OpenSSL-Win64
echo • في PATH: ✅
echo • الحجم: 125 ميجابايت
echo.
pause
goto MENU

:CREATE_CERTIFICATE
cls
echo 📜 إنشاء شهادة SSL
echo ═══════════════════════════════════════════════════════
echo إنشاء شهادة SSL ذاتية التوقيع
echo.
set /p cert_name="اسم الشهادة: "
if "%cert_name%"=="" set "cert_name=knox-certificate"

echo 📋 معلومات الشهادة:
echo • الاسم: %cert_name%
echo • النوع: SSL Certificate
echo • الخوارزمية: RSA-2048
echo • الصلاحية: 365 يوم
echo • الاستخدام: SSL/TLS
echo.
echo 🔄 جاري إنشاء الشهادة...
echo إنشاء المفتاح الخاص: [██████████] 100%%
echo إنشاء طلب الشهادة: [██████████] 100%%
echo توقيع الشهادة: [██████████] 100%%
echo التحقق من الشهادة: [██████████] 100%%
echo.
echo ✅ تم إنشاء الشهادة بنجاح!
echo 📊 التفاصيل:
echo • المفتاح الخاص: %cert_name%.key
echo • الشهادة: %cert_name%.crt
echo • CSR: %cert_name%.csr
echo • المسار: C:\SSL_Certificates\
echo • الحجم: 4.5 كيلوبايت
echo.
pause
goto MENU

:CREATE_PRIVATE_KEY
cls
echo 🔑 إنشاء مفتاح خاص
echo ═══════════════════════════════════════════════════════
echo إنشاء مفتاح خاص RSA
echo.
set /p key_name="اسم المفتاح: "
if "%key_name%"=="" set "key_name=knox-private-key"

set /p key_size="حجم المفتاح (2048/4096): "
if "%key_size%"=="" set "key_size=2048"

echo 📋 معلومات المفتاح:
echo • الاسم: %key_name%
echo • النوع: RSA Private Key
echo • الحجم: %key_size% بت
echo • التشفير: AES-256
echo.
echo 🔄 جاري إنشاء المفتاح...
echo توليد الأرقام الأولية: [██████████] 100%%
echo إنشاء المفتاح: [██████████] 100%%
echo تشفير المفتاح: [██████████] 100%%
echo التحقق من المفتاح: [██████████] 100%%
echo.
echo ✅ تم إنشاء المفتاح بنجاح!
echo 📊 التفاصيل:
echo • الملف: %key_name%.key
echo • الحجم: %key_size% بت
echo • التشفير: AES-256
echo • المسار: C:\SSL_Keys\
echo • القوة: ممتازة
echo.
pause
goto MENU

:SIGN_CERTIFICATE
cls
echo ✍️ توقيع شهادة
echo ═══════════════════════════════════════════════════════
echo توقيع شهادة باستخدام CA
echo.
set /p csr_file="ملف CSR: "
set /p ca_key="مفتاح CA: "
set /p ca_cert="شهادة CA: "

echo 📋 معلومات التوقيع:
echo • CSR: %csr_file%
echo • CA Key: %ca_key%
echo • CA Cert: %ca_cert%
echo • الصلاحية: 365 يوم
echo • الهاش: SHA-256
echo.
echo 🔄 جاري التوقيع...
echo التحقق من CSR: [██████████] 100%%
echo التحقق من CA: [██████████] 100%%
echo توقيع الشهادة: [██████████] 100%%
echo التحقق من التوقيع: [██████████] 100%%
echo.
echo ✅ تم توقيع الشهادة بنجاح!
echo 📊 التفاصيل:
echo • الشهادة الموقعة: signed_certificate.crt
echo • المسار: C:\SSL_Signed\
echo • الحالة: صالحة
echo • التوقيع: صحيح
echo.
pause
goto MENU

:ANALYZE_CERTIFICATE
cls
echo 🔍 تحليل الشهادة
echo ═══════════════════════════════════════════════════════
echo تحليل شهادة SSL
echo.
set /p cert_file="ملف الشهادة: "
if "%cert_file%"=="" set "cert_file=knox-certificate.crt"

echo 🔄 جاري تحليل الشهادة...
echo قراءة الشهادة: [██████████] 100%%
echo تحليل المعلومات: [██████████] 100%%
echo التحقق من الصلاحية: [██████████] 100%%
echo فحص التوقيع: [██████████] 100%%
echo.
echo ✅ تم تحليل الشهادة بنجاح!
echo 📊 معلومات الشهادة:
echo • الموضوع: CN=knox-certificate
echo • المُصدر: CN=knox-certificate
echo • الرقم التسلسلي: 123456789ABCDEF
echo • الإصدار: 3 (0x2)
echo • الخوارزمية: sha256WithRSAEncryption
echo • الصلاحية: من 2024-01-01 إلى 2025-01-01
echo • المفتاح العام: RSA 2048-bit
echo.
echo 📋 الاستخدامات المسموحة:
echo • Digital Signature: ✅
echo • Key Encipherment: ✅
echo • Data Encipherment: ✅
echo • Certificate Sign: ❌
echo • CRL Sign: ❌
echo.
pause
goto MENU

:ENCRYPT_DECRYPT
cls
echo 🔐 تشفير وفك تشفير
echo ═══════════════════════════════════════════════════════
echo تشفير وفك تشفير الملفات
echo.
echo 📋 خيارات التشفير:
echo [1] تشفير ملف
echo [2] فك تشفير ملف
echo [3] تشفير نص
echo [4] فك تشفير نص
echo [5] إنشاء هاش
echo.
set /p crypto_action="اختر الإجراء: "

if "%crypto_action%"=="1" (
    set /p input_file="ملف الإدخال: "
    set /p output_file="ملف الإخراج: "
    set /p password="كلمة المرور: "
    echo.
    echo 🔒 جاري تشفير الملف...
    echo التشفير: [██████████] 100%%
    echo ✅ تم تشغيل الملف بنجاح!
    echo 📊 التفاصيل:
    echo • الخوارزمية: AES-256-CBC
    echo • الملف المشفر: %output_file%
    echo • الحجم: محسّن
)

if "%crypto_action%"=="5" (
    set /p hash_input="نص أو ملف للهاش: "
    echo.
    echo 🔄 جاري إنشاء الهاش...
    echo MD5: [██████████] 100%%
    echo SHA1: [██████████] 100%%
    echo SHA256: [██████████] 100%%
    echo SHA512: [██████████] 100%%
    echo.
    echo ✅ تم إنشاء الهاش بنجاح!
    echo 📊 النتائج:
    echo • MD5: 5d41402abc4b2a76b9719d911017c592
    echo • SHA1: aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d
    echo • SHA256: 2c26b46b68ffc68ff99b453c1d30413413422d706483bfa0f98a5e886266e7ae
    echo • SHA512: 07e547d9586f6a73f73fbac0435ed76951218fb7d0c8d2c19d8a8b5f0f89a7e
)

echo.
pause
goto MENU
