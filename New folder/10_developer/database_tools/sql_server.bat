@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🏢 SQL Server 2022 Express - خادم مايكروسوفت الرسمي%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query MSSQL$SQLEXPRESS >nul 2>&1 && (
    echo %GREEN%✓ SQL Server Express قيد التشغيل%WHITE%
    sqlcmd -S .\SQLEXPRESS -Q "SELECT @@VERSION" | findstr "SQL Server"
    goto :INSTALL_SSMS
)

echo %YELLOW%ملاحظات هامة قبل التثبيت:%WHITE%
echo   - الحجم: ~2.5 جيجابايت
echo   - يتطلب: .NET Framework 4.8+, Windows 10+
echo   - كلمة المرور الافتراضية ستكون معقدة تلقائيًا
echo.
set /p "CONFIRM=هل تريد المتابعة؟ (y/n): "
if /i "!CONFIRM!" neq "y" exit /b 0

echo %YELLOW%[1/4] جارٍ تنزيل المثبت...%WHITE%
set "INSTALLER=%TEMP%\SQL2022-SSEI-Dev.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/p/?linkid=2216019' -OutFile '!INSTALLER!'" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.microsoft.com/sql-server/sql-server-downloads%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

:GENERATE_PASSWORD
set "PASS=Sql@Knoux%RANDOM%!RANDOM!!RANDOM!"
echo %YELLOW%[2/4] كلمة مرور SA المؤقتة:%WHITE% %CYAN%!PASS!%WHITE%
echo %RED%⚠️  احفظها الآن - لن تظهر مرة أخرى!%WHITE%
timeout /t 5 >nul

:INSTALL_ENGINE
echo %YELLOW%[3/4] جارٍ التثبيت الصامت...%WHITE%
call :LOADING_ANIMATION 12

start /wait "" "!INSTALLER!" /qs /ACTION=Install /FEATURES=SQL /INSTANCENAME=SQLEXPRESS ^
    /SQLSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" ^
    /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" ^
    /SAPWD="!PASS!" ^
    /SECURITYMODE=SQL ^
    /TCPENABLED=1 ^
    /IACCEPTSQLSERVERLICENSETERMS >nul 2>&1

del "!INSTALLER!" >nul 2>&1

:VERIFY
timeout /t 10 >nul
sc query MSSQL$SQLEXPRESS >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

:INSTALL_SSMS
echo %YELLOW%[4/4] جارٍ تثبيت SQL Server Management Studio (SSMS)...%WHITE%
winget install -e --id Microsoft.SQLServerManagementStudio --silent >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%معلومات الاتصال:%WHITE%
echo   الخادم: %GRAY%.\SQLEXPRESS%WHITE% أو %GRAY%localhost\SQLEXPRESS%WHITE%
echo   المصادقة: %GRAY%SQL Server Authentication%WHITE%
echo   المستخدم: %GRAY%sa%WHITE%
echo   كلمة المرور: %GRAY%!PASS!%WHITE%
echo   المنفذ: %GRAY%1433 (افتراضي)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الأوامر السريعة:%WHITE%
echo   sqlcmd -S .\SQLEXPRESS -U sa -P "!PASS!" -Q "SELECT @@VERSION"
echo.
echo %YELLOW%نصيحة أمان:%WHITE% غيّر كلمة مرور sa فورًا بعد التسجيل الأول:
echo   ALTER LOGIN sa WITH PASSWORD = 'كلمة_مرور_جديدة_قوية';

:: حفظ بيانات الاعتماد
set "CRED_FILE=%~dp0..\..\..\backups\database\sqlserver_credentials.txt"
(
echo SQL Server 2022 Express Credentials - Knoux Toolbox
echo Generated: !TIMESTAMP!
echo ========================================
echo Instance: .\SQLEXPRESS
echo Authentication: SQL Server
echo Username: sa
echo Password: !PASS!
echo Port: 1433
echo ========================================
echo ⚠️  احفظ هذا الملف في مكان آمن ثم احذفه
) > "!CRED_FILE!"

echo %YELLOW%✓ تم حفظ بيانات الاعتماد في: !CRED_FILE!%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed SQL Server 2022 Express + SSMS >> "!LOG_FILE!"

timeout /t 10 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=◰◳◲◱"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 4"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
