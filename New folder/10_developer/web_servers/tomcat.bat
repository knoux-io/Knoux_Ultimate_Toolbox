@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "TOMCAT_DIR=C:\tomcat"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %RED%===================================================%WHITE%
echo %RED%  🐱 Apache Tomcat 10 - خادم تطبيقات Java%WHITE%
echo %RED%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت (مطلوب لـ Tomcat)%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

if exist "!TOMCAT_DIR!" (
    echo %GREEN%✓ Tomcat مثبت مسبقًا%WHITE%
    if exist "!TOMCAT_DIR!\bin\version.bat" (
        call "!TOMCAT_DIR!\bin\version.bat" | findstr "Server version"
    )
    goto :CONFIGURE
)

echo %YELLOW%[1/4] جارٍ التنزيل...%WHITE%
call :LOADING_ANIMATION 6

set "ZIP=%TEMP%\tomcat.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18-windows-x64.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    exit /b 1
)

echo %YELLOW%[2/4] جارٍ الاستخراج...%WHITE%
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath 'C:\' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

:: إعادة تسمية المجلد
for /d %%D in ("C:\apache-tomcat-*") do (
    ren "%%D" "tomcat"
)

:CONFIGURE
echo %YELLOW%[3/4] جارٍ التهيئة الأساسية...%WHITE%

:: إعداد كلمة مرور المسؤول
set "TOMCAT_USERS=!TOMCAT_DIR!\conf\tomcat-users.xml"
(
echo ^<?xml version='1.0' encoding='utf-8'?^>
echo ^<tomcat-users xmlns="http://tomcat.apache.org/xml"^
echo           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^
echo           xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"^
echo           version="1.0"^>
echo   ^<role rolename="manager-gui"/^>
echo   ^<role rolename="admin-gui"/^>
echo   ^<user username="admin" password="Knoux@Tomcat!%RANDOM%" roles="manager-gui,admin-gui"/^>
echo ^</tomcat-users^>
) > "!TOMCAT_USERS!"

:: تفعيل مدير التطبيقات عن بعد
set "MANAGER=!TOMCAT_DIR!\webapps\manager\META-INF\context.xml"
powershell -Command "(Get-Content '!MANAGER!' -Raw) -replace '<Valve.*allow=\"127', '<!-- <Valve' -replace '127\.\d+\.\d+\.\d+', '.*' -replace '-->', '-->' | Set-Content '!MANAGER!'" >nul 2>&1

:START_SERVICE
echo %YELLOW%[4/4] جارٍ بدء الخدمة...%WHITE%
"!TOMCAT_DIR!\bin\startup.bat" >nul 2>&1

timeout /t 8 >nul
tasklist | findstr "java.exe" >nul && (
    echo %GREEN%===================================================%WHITE%
    echo %GREEN%✓ تم التثبيت والتشغيل بنجاح!%WHITE%
    echo %CYAN%لوحة التحكم:%WHITE% %CYAN%http://localhost:8080/manager/html%WHITE%
    echo %CYAN%اسم المستخدم:%WHITE% admin
    echo %CYAN%كلمة المرور:%WHITE% مطبوعة في ملف التهيئة (احفظها!)
    echo %CYAN%لنشر تطبيق:%WHITE% ضع ملف .war في !TOMCAT_DIR!\webapps
    echo %GREEN%===================================================%WHITE%
) || (
    echo %RED%✗ فشل التشغيل%WHITE%
    echo %YELLOW%الحل: تحقق من عدم تعارض المنفذ 8080%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Apache Tomcat 10 with admin access >> "!LOG_FILE!"

timeout /t 8 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
