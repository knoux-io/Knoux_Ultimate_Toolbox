@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🐹 Go Programming Language Setup%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

go version >nul 2>&1 && (
    echo %GREEN%✓ Go مثبت مسبقًا%WHITE%
    go version
    goto :SETUP_ENV
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
winget install -e --id GoLang.Go --silent >nul 2>&1

go version >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:SETUP_ENV
:: إعداد مجلدات العمل
set "GOPATH=%USERPROFILE%\go"
if not exist "!GOPATH!\bin" mkdir "!GOPATH!\bin" >nul
if not exist "!GOPATH!\src" mkdir "!GOPATH!\src" >nul
if not exist "!GOPATH!\pkg" mkdir "!GOPATH!\pkg" >nul

:: إضافة إلى PATH
setx GOPATH "!GOPATH!" >nul
setx PATH "%%GOPATH%%\bin;%%PATH%%" >nul

echo %GREEN%✓ تم الإعداد الكامل!%WHITE%
echo   GOPATH = %GRAY%!GOPATH!%WHITE%
echo   PATH   = %GRAY%!GOPATH!\bin مضاف إلى المتغيرات%WHITE%

echo.
echo %CYAN%إنشاء مشروع جديد:%WHITE%
echo   mkdir myapp && cd myapp
echo   go mod init myapp
echo   go run main.go

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Go with GOPATH setup >> "!LOG_FILE!"

timeout /t 4 >nul
