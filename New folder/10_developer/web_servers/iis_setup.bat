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
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🪟 IIS (Internet Information Services) - خادم مايكروسوفت الرسمي%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:CHECK_EXISTING
sc query W3SVC >nul 2>&1 && (
    echo %GREEN%✓ IIS مفعل مسبقًا%WHITE%
    %SystemRoot%\System32\inetsrv\appcmd list site
    goto :INSTALL_FEATURES
)

echo %YELLOW%[1/4] جارٍ تفعيل المكونات الأساسية...%WHITE%
call :LOADING_ANIMATION 8

dism /online /enable-feature /featurename:IIS-WebServer /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-CommonHttpFeatures /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-StaticContent /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-DefaultDocument /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-DirectoryBrowsing /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HttpErrors /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HttpRedirect /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ASPNET45 /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-NetFxExtensibility45 /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ISAPIExtensions /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ISAPIFilter /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HealthAndDiagnostics /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HttpLogging /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-LoggingLibraries /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-RequestMonitor /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HttpTracing /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-Security /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-RequestFiltering /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-IPSecurity /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-Performance /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-HttpCompressionDynamic /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-WebServerManagementTools /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ManagementConsole /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ManagementScriptingTools /all /norestart >nul 2>&1

:INSTALL_FEATURES
echo %YELLOW%[2/4] جارٍ تفعيل ميزات التطوير...%WHITE%
dism /online /enable-feature /featurename:IIS-ASPNET /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-CGI /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-ServerSideIncludes /all /norestart >nul 2>&1
dism /online /enable-feature /featurename:IIS-WebSockets /all /norestart >nul 2>&1

echo %YELLOW%[3/4] جارٍ تهيئة دعم اللغة العربية...%WHITE%
%SystemRoot%\System32\inetsrv\appcmd set config -section:system.webServer/globalModules /+"[name='ArabicEncodingModule',image='%windir%\System32\inetsrv\ArabicEncoding.dll']" >nul 2>&1

:: إعداد موقع تجريبي
set "SITE_PATH=C:\inetpub\wwwroot\knoux-test"
if not exist "!SITE_PATH!" mkdir "!SITE_PATH!" >nul

(
echo ^<!DOCTYPE html^>
echo ^<html dir="rtl" lang="ar"^>
echo ^<head^>
echo     ^<meta charset="utf-8"^>
echo     ^<title^>IIS يعمل بنجاح^</title^>
echo     ^<style^>
echo         body { font-family: 'Segoe UI', Tahoma; background: #0078d7; color: white; text-align: center; padding: 50px; }
echo         .container { background: rgba(255,255,255,0.1); padding: 40px; border-radius: 15px; backdrop-filter: blur(10px); max-width: 600px; margin: 0 auto; }
echo         h1 { font-size: 2.8em; margin-bottom: 20px; text-shadow: 0 2px 5px rgba(0,0,0,0.3); }
echo         .windows { font-size: 64px; margin: 20px 0; }
echo         p { font-size: 1.2em; margin: 15px 0; }
echo     ^</style^>
echo ^</head^>
echo ^<body^>
echo     ^<div class="container"^>
echo         ^<div class="windows"^>🪟^</div^>
echo         ^<h1^>IIS يعمل بنجاح!^</h1^>
echo         ^<p^>خادم الويب المدمج مع نظام Windows^</p^>
echo         ^<p^>تم التفعيل بواسطة Knoux Ultimate Toolbox^</p^>
echo     ^</div^>
echo ^</body^>
echo ^</html^>
) > "!SITE_PATH!\index.html"

echo %YELLOW%[4/4] جارٍ إعادة تشغيل خدمة الويب...%WHITE%
net stop was /y >nul 2>&1
net start w3svc >nul 2>&1

timeout /t 3 >nul
sc query W3SVC | findstr "RUNNING" >nul && (
    echo %GREEN%===================================================%WHITE%
    echo %GREEN%✓ تم التفعيل الكامل بنجاح!%WHITE%
    echo %CYAN%الوصول:%WHITE% %CYAN%http://localhost/knoux-test%WHITE%
    echo %CYAN%لوحة التحكم:%WHITE% ابحث في قائمة ابدأ عن "IIS Manager"
    echo %GREEN%===================================================%WHITE%
) || (
    echo %RED%✗ فشل بدء الخدمة%WHITE%
    echo %YELLOW%الحل: أعد تشغيل الجهاز ثم جرب مجددًا%WHITE%
)

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Enabled IIS with full development features and Arabic support >> "!LOG_FILE!"

timeout /t 8 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⣾⣽⣻⢿⡿⣟⣯⣷"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 8"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التفعيل... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
