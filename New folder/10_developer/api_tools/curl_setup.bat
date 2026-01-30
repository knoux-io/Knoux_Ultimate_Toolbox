@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🌀 cURL - نقل البيانات عبر سطر الأوامر%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

:CHECK_EXISTING
curl --version >nul 2>&1 && (
    echo %GREEN%✓ cURL مثبت مسبقًا%WHITE%
    curl --version | findstr "curl"
    goto :ADVANCED_SETUP
)

echo %YELLOW%جارٍ التثبيت عبر Winget...%WHITE%
winget install -e --id curl.curl --silent >nul 2>&1

curl --version >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "CURL_EXE=%TEMP%\curl.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://curl.se/windows/dl-8.4.0_3/curl-8.4.0_3-win64-mingw.zip' -OutFile '%TEMP%\curl.zip'" >nul 2>&1
    powershell -Command "Expand-Archive -Path '%TEMP%\curl.zip' -DestinationPath '%TEMP%\curl' -Force" >nul 2>&1
    copy "%TEMP%\curl\curl-8.4.0_3-win64-mingw\bin\curl.exe" "%WINDIR%\System32\curl.exe" >nul 2>&1
    rmdir /s /q "%TEMP%\curl" >nul 2>&1
    del "%TEMP%\curl.zip" >nul 2>&1
)

curl --version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:ADVANCED_SETUP
echo %YELLOW%جارٍ إنشاء أدوات التحقق المتقدمة...%WHITE%

set "CURL_TOOLS=%USERPROFILE%\curl-tools"
if not exist "!CURL_TOOLS!" mkdir "!CURL_TOOLS!" >nul

:: إنشاء سكربت للتحقق من API
(
echo @echo off
echo setlocal
echo 
echo echo API Testing Script - Knoux Toolbox
echo echo ================================
echo 
echo if "%%1"=="" (
echo     echo Usage: %%0 ^<URL^>
echo     echo Example: %%0 https://api.example.com/users
echo     exit /b 1
echo )
echo 
echo echo Testing: %%1
echo curl -X GET -H "Content-Type: application/json" --write-out "HTTP Status: %%{http_code}\nTime: %%{time_total}s\nSize: %%{size_download} bytes\n" --silent --show-error "%%1"
echo 
echo echo.
echo echo Headers:
echo curl -I --silent "%%1" ^| head -10
) > "!CURL_TOOLS!\api-check.bat"

:: إنشاء سكربت لتحميل الملفات
(
echo @echo off
echo setlocal
echo 
echo if "%%1"=="" (
echo     echo Usage: %%0 ^<URL^> [output_filename]
echo     echo Example: %%0 https://example.com/file.zip myfile.zip
echo     exit /b 1
echo )
echo 
echo set URL=%%1
echo set OUTPUT=%%2
echo 
echo if "%%OUTPUT"=="" (
echo     for %%f in ("%%URL") do set OUTPUT=%%~nxf
echo )
echo 
echo echo Downloading: %%URL
echo echo Output: %%OUTPUT
echo curl -L -o "%%OUTPUT" --progress-bar "%%URL"
echo 
echo if %%errorlevel%% equ 0 (
echo     echo Download completed successfully!
echo     dir "%%OUTPUT"
echo ) else (
echo     echo Download failed!
echo )
) > "!CURL_TOOLS!\download.bat"

:: إنشاء سكربت لفحص السرعة
(
echo @echo off
echo echo Speed Test using cURL
echo ========================
echo echo Testing download speed...
echo curl -o NUL -s -w "Speed: %%{speed_download} bytes/s\nTime: %%{time_total}s\n" https://speed.hetzner.de/100MB.bin
echo 
echo echo Testing upload speed...
echo curl -X POST -s -w "Upload Time: %%{time_total}s\n" --upload-file NUL https://speed.hetzner.de/
) > "!CURL_TOOLS!\speed-test.bat"

echo %GREEN%✓ تم إنشاء أدوات cURL متقدمة%WHITE%
echo %CYAN%الموقع:%WHITE% !CURL_TOOLS!

echo.
echo %CYAN%أمثلة على الاستخدام:%WHITE%
echo   cURL GET:    curl -X GET https://api.example.com/data
echo   cURL POST:   curl -X POST -H "Content-Type: application/json" -d "{\"key\":\"value\"}" https://api.example.com/submit
echo   cURL Headers: curl -I https://example.com
echo   cURL Cookies: curl -b "session=abc123" https://example.com/protected

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed cURL with advanced testing tools >> "!LOG_FILE!"

timeout /t 8 >nul
