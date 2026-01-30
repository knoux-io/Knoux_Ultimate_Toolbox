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
echo %GRAY%===================================================%WHITE%
echo %GRAY%  🧼 SoapUI - اختبار خدمات SOAP وREST%WHITE%
echo %GRAY%===================================================%WHITE%
echo.

:CHECK_EXISTING
where soapui.exe >nul 2>&1 && (
    echo %GREEN%✓ SoapUI مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/3] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 8

set "INSTALLER=%TEMP%\SoapUI-x64-5.7.0.exe"
powershell -Command "Invoke-WebRequest -Uri 'https://s3.amazonaws.com/downloads.eviware/soapuios/5.7.0/SoapUI-x64-5.7.0.exe' -OutFile '!INSTALLER!'" >nul 2>&1

if not exist "!INSTALLER!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://www.soapui.org/downloads/soapui-os/%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

start /wait "" "!INSTALLER!" /S >nul 2>&1
del "!INSTALLER!" >nul 2>&1

:VERIFY
timeout /t 5 >nul
where soapui.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %YELLOW%[2/3] جارٍ إنشاء مشروع تجريبي...%WHITE%

set "SOAPUI_PROJECT=%USERPROFILE%\soapui-demo"
if not exist "!SOAPUI_PROJECT!" mkdir "!SOAPUI_PROJECT!" >nul

(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <con:soapui-project id="12345678-1234-1234-1234-123456789abc" activeEnvironment="Default" name="API_Demo_Project" resourceRoot="" soapui-version="5.7.0" xmlns:con="http://eviware.com/soapui/config">
echo   <con:settings/>
echo   <con:interface xsi:type="con:WsdlInterface" id="abcd1234-abcd-1234-abcd-123456789def" wsaVersion="NONE" name="WeatherService" bindingName="{http://weather.example.com/}WeatherPortBinding" soapVersion="1_1" anonymous="optional" definition="http://weather.example.com/weather.wsdl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
echo     <con:settings/>
echo     <con:definitionCache type="TEXT" rootPart="http://weather.example.com/weather.wsdl"/>
echo     <con:endpoint>http://weather.example.com/WeatherService</con:endpoint>
echo     <con:operation id="efgh5678-efgh-5678-efgh-987654321cba" name="GetWeather" bindingOperation="GetWeather" type="Request-Response" action="http://weather.example.com/GetWeather">
echo       <con:settings/>
echo       <con:call id="ijkl9012-ijkl-9012-ijkl-fedcba987654" name="GetWeather_Request">
echo         <con:settings/>
echo         <con:encoding>UTF-8</con:encoding>
echo         <con:endpoint>http://weather.example.com/WeatherService</con:endpoint>
echo         <con:request><![CDATA[<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:weat="http://weather.example.com/">
echo    <soapenv:Header/>
echo    <soapenv:Body>
echo       <weat:GetWeather>
echo          <weat:City>الرياض</weat:City>
echo       </weat:GetWeather>
echo    </soapenv:Body>
echo </soapenv:Envelope>]]></con:request>
echo       </con:call>
echo     </con:operation>
echo   </con:interface>
echo </con:soapui-project>
) > "!SOAPUI_PROJECT!\demo-soap-project.xml"

echo %GREEN%✓ تم إنشاء مشروع تجريبي%WHITE%

echo %YELLOW%[3/3] جارٍ إعداد متغيرات البيئة...%WHITE%

(
echo # SoapUI Environment Variables
echo # Created by Knoux Toolbox
echo 
echo # SOAP Endpoint
echo SOAP_ENDPOINT=http://localhost:8080/soap
echo 
echo # Authentication
echo USERNAME=admin
echo PASSWORD=password123
echo 
echo # Test Data
echo TEST_CITY=الرياض
echo TEST_COUNTRY=السعودية
) > "!SOAPUI_PROJECT!\environment.properties"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   SoapUI: %GRAY%ابحث في قائمة ابدأ عن "SoapUI"%WHITE%
echo   مشروع تجريبي: %GRAY%!SOAPUI_PROJECT!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبار خدمات SOAP/WSDL
echo   ✓ اختبار خدمات RESTFUL
echo   ✓ أتمتة الاختبارات (TestSuites)
echo   ✓ دعم Security Testing
echo   ✓ Mock Services
echo   ✓ Load Testing
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. افتح SoapUI
echo   2. File → Import Project ← حدد demo-soap-project.xml
echo   3. ابدأ بتعديل الـ WSDL أو إنشاء طلبات REST

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed SoapUI with demo project and environment setup >> "!LOG_FILE!"

timeout /t 10 >nul
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
