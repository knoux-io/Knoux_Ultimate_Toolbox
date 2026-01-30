@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🔒 إعداد SSL محلي موثوق (للمواقع الآمنة في التطوير)%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

:: التحقق من وجود mkcert (أفضل أداة للـ SSL المحلي)
where mkcert.exe >nul 2>&1 || (
    echo %YELLOW%جارٍ تثبيت mkcert (أداة إنشاء شهادات محلية)...%WHITE%
    choco install mkcert -y >nul 2>&1 || (
        echo %RED%✗ فشل تثبيت mkcert%WHITE%
        echo %YELLOW%الشرط المسبق: تثبيت Chocolatey أولاً%WHITE%
        timeout /t 5 >nul
        exit /b 1
    )
)

:: تثبيت شهادة الجذر الموثوقة
echo %YELLOW%[1/3] جارٍ تثبيت شهادة الجذر الموثوقة في النظام...%WHITE%
mkcert -install >nul 2>&1 && (
    echo %GREEN%✓ تم تثبيت شهادة الجذر%WHITE%
) || (
    echo %RED%✗ فشل التثبيت - قد تحتاج صلاحيات مسؤول%WHITE%
    exit /b 1
)

:: إنشاء شهادات لـ localhost ونطاقات مخصصة
echo %YELLOW%[2/3] جارٍ إنشاء شهادات SSL للتطوير...%WHITE%
set "CERT_DIR=%USERPROFILE%\.localhost-certs"
if not exist "!CERT_DIR!" mkdir "!CERT_DIR!" >nul

mkcert -key-file "!CERT_DIR!\localhost-key.pem" -cert-file "!CERT_DIR!\localhost.pem" localhost 127.0.0.1 ::1 "*.test" "*.local" >nul 2>&1 && (
    echo %GREEN%✓ تم إنشاء الشهادات:%WHITE%
    echo   - !CERT_DIR!\localhost.pem
    echo   - !CERT_DIR!\localhost-key.pem
) || (
    echo %RED%✗ فشل إنشاء الشهادات%WHITE%
    exit /b 1
)

:: إعداد لخوادم مختلفة
echo %YELLOW%[3/3] جارٍ إنشاء دليل الاستخدام مع خوادم مختلفة...%WHITE%

(
echo # شهادات SSL المحلية من Knoux Toolbox
echo # التاريخ: !TIMESTAMP!
echo.
echo ## لاستخدام مع Apache:
echo # SSLCertificateFile "!CERT_DIR!/localhost.pem"
echo # SSLCertificateKeyFile "!CERT_DIR!/localhost-key.pem"
echo.
echo ## لاستخدام مع Nginx:
echo # ssl_certificate "!CERT_DIR!/localhost.pem";
echo # ssl_certificate_key "!CERT_DIR!/localhost-key.pem";
echo.
echo ## لاستخدام مع Node.js:
echo const https = require('https');
echo const fs = require('fs');
echo const options = {
echo   key: fs.readFileSync('!CERT_DIR:/=\!/localhost-key.pem'),
echo   cert: fs.readFileSync('!CERT_DIR:/=\!/localhost.pem')
echo };
echo https.createServer(options, app).listen(443);
echo.
echo ## للاختبار:
echo افتح: https://localhost
echo يجب أن تظهر الصفحة بدون تحذيرات أمان
) > "!CERT_DIR!\README.txt"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ SSL المحلي!%WHITE%
echo %CYAN%الموقع الآمن:%WHITE% %CYAN%https://localhost%WHITE%
echo %CYAN%ملاحظة:%WHITE% الشهادات موثوقة في هذا الجهاز فقط (وليس للإنتاج)
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الدعم مع الحزم الشائعة:%WHITE%
echo   • Laravel Valet: valet secure
echo   • Create React App: HTTPS=true npm start
echo   • Next.js: في ملف next.config.js أضف: { devServer: { https: true } }

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Generated trusted local SSL certificates with mkcert >> "!LOG_FILE!"

timeout /t 8 >nul
