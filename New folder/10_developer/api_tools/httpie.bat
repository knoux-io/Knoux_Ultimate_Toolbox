@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🎨 HTTPie - cURL بسيط وجميل%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

pip --version >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:CHECK_EXISTING
where http >nul 2>&1 && (
    echo %GREEN%✓ HTTPie مثبت مسبقًا%WHITE%
    http --version
    goto :CREATE_DEMOS
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
pip install httpie >nul 2>&1

where http >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:CREATE_DEMOS
echo %YELLOW%جارٍ إنشاء أمثلة استخدام...%WHITE%

set "HTTP_DEMOS=%USERPROFILE%\httpie-demos"
if not exist "!HTTP_DEMOS!" mkdir "!HTTP_DEMOS!" >nul

:: إنشاء ملف تعليمات
(
echo # HTTPie Examples - Knoux Toolbox
echo 
echo ## Basic Usage
echo http https://httpbin.org/get
echo http POST https://httpbin.org/post name=John age:=25
echo 
echo ## Headers
echo http GET https://api.example.com/users Authorization:Bearer\ token123
echo 
echo ## JSON Data
echo http POST https://api.example.com/users name="John Doe" email=john@example.com
echo 
echo ## Files
echo http POST https://api.example.com/upload file@/path/to/file.txt
echo 
echo ## Sessions
echo http --session=my-session https://api.example.com/login
echo 
echo ## Output Formatting
echo http --print=hH --headers https://api.example.com/users
echo 
echo ## Save Response
echo http GET https://api.example.com/data > response.json
) > "!HTTP_DEMOS!\examples.txt"

:: إنشاء سكربت تجريبي
(
echo @echo off
echo echo HTTPie Demo - Knoux Toolbox
echo echo ==========================
echo echo.
echo echo Testing GET request...
echo http --headers https://httpbin.org/get
echo 
echo echo Testing POST request...
echo http --json POST https://httpbin.org/post name=John city=Riyadh
echo 
echo echo Testing with headers...
echo http GET https://httpbin.org/headers User-Agent:Knoux-Toolbox
) > "!HTTP_DEMOS!\demo.bat"

echo %GREEN%✓ تم إنشاء أمثلة الاستخدام%WHITE%
echo %CYAN%الموقع:%WHITE% !HTTP_DEMOS!

echo.
echo %CYAN%لماذا HTTPie؟%WHITE%
echo   ✓ واجهة بسيطة وسهلة (مقارنة بـ cURL)
echo   ✓ تلوين النتائج تلقائيًا
echo   ✓ دعم JSON مدمج
echo   ✓ مخرجات منظمة وسهلة القراءة
echo   ✓ دعم الجلسات والمتغيرات
echo.
echo %YELLOW%أمثلة:%WHITE%
echo   http GET https://api.example.com/users
echo   http POST https://api.example.com/users name=John age:=25
echo   http --json POST https://api.example.com/users ^< data.json

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed HTTPie with demo examples >> "!LOG_FILE!"

timeout /t 6 >nul
