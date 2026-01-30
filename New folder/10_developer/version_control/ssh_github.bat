@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🔐 ربط مفتاح SSH تلقائيًا بـ GitHub%WHITE%
echo %RED%===================================================%WHITE%
echo.

:: التحقق من وجود المفتاح
if not exist "%USERPROFILE%\.ssh\id_ed25519.pub" (
    if not exist "%USERPROFILE%\.ssh\id_rsa.pub" (
        echo %RED%✗ لم يتم العثور على مفتاح SSH%WHITE%
        echo %YELLOW%الحل: شغّل أولاً version_control\ssh_keygen.bat%WHITE%
        timeout /t 5 >nul
        exit /b 1
    ) else (
        set "KEY_FILE=%USERPROFILE%\.ssh\id_rsa.pub"
    )
) else (
    set "KEY_FILE=%USERPROFILE%\.ssh\id_ed25519.pub"
)

:: قراءة المفتاح
set /p "PUB_KEY=" < "!KEY_FILE!"

echo %YELLOW%تم اكتشاف المفتاح العام:%WHITE%
echo !PUB_KEY:~0,40!...
echo.

:: جمع رمز الوصول الشخصي (PAT)
echo %YELLOW%ملاحظة أمان هامة:%WHITE%
echo سيتم استخدام رمز وصول شخصي (Personal Access Token) مؤقت فقط لإضافة المفتاح.
echo لن يتم حفظ الرمز في أي مكان.
echo.
echo %CYAN%لإنشاء رمز وصول شخصي:%WHITE%
echo   1. اذهب إلى: https://github.com/settings/tokens
echo   2. انقر "Generate new token (classic)"
echo   3. اختر النطاق: %GREEN%write:public_key%WHITE%
echo   4. انقر "Generate token" وانسخ القيمة
echo.
set /p "TOKEN=الصق رمز الوصول الشخصي هنا: "

if "!TOKEN!"=="" (
    echo %RED%✗ لم يتم إدخال الرمز%WHITE%
    exit /b 1
)

:: إرسال الطلب إلى GitHub API
echo %YELLOW%جارٍ إضافة المفتاح إلى حساب GitHub...%WHITE%

for /f "delims=" %%a in ('powershell -Command "$keyContent = Get-Content '!KEY_FILE!' -Raw; $body = @{title='Knoux Toolbox - %COMPUTERNAME%'; key=$keyContent} | ConvertTo-Json; Invoke-RestMethod -Uri 'https://api.github.com/user/keys' -Method Post -Headers @{Authorization='token !TOKEN!'; Accept='application/vnd.github.v3+json'} -Body $body -ContentType 'application/json' | ConvertTo-Json -Compress" 2^>nul') do set "RESPONSE=%%a"

if "!RESPONSE!"=="" (
    echo %RED%✗ فشل الإضافة - تحقق من صحة الرمز والاتصال%WHITE%
    echo %YELLOW%الحل اليدوي: الصق المفتاح يدويًا في إعدادات GitHub%WHITE%
    type "!KEY_FILE!"
    timeout /t 6 >nul
    exit /b 1
)

echo %GREEN%✓ تم إضافة المفتاح بنجاح إلى حساب GitHub!%WHITE%
echo %CYAN%التفاصيل:%WHITE% !RESPONSE!

:: اختبار الاتصال
echo.
echo %YELLOW%جارٍ اختبار الاتصال بـ GitHub...%WHITE%
ssh -T git@github.com 2>&1 | findstr "successfully" && (
    echo %GREEN%✓ تم التوثيق بنجاح مع GitHub!%WHITE%
) || (
    echo %YELLOW%لم يتم التوثيق التلقائي - جرب يدويًا:%WHITE%
    echo   ssh -T git@github.com
)

:: تسجيل العملية (بدون حفظ الرمز)
echo [!TIMESTAMP!] SUCCESS: SSH key added to GitHub account >> "!LOG_FILE!"

timeout /t 6 >nul
