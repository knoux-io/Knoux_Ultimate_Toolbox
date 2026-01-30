@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"
set "JMETER_HOME=%USERPROFILE%\apache-jmeter"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  📊 Apache JMeter - اختبار أداء الشبكة%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
if exist "%JMETER_HOME%\bin\jmeter.bat" (
    echo %GREEN%✓ JMeter مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/4] جارٍ تنزيل JMeter...%WHITE%
call :LOADING_ANIMATION 8

set "ZIP=%TEMP%\apache-jmeter.zip"
powershell -Command "Invoke-WebRequest -Uri 'https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.zip' -OutFile '!ZIP!'" >nul 2>&1

if not exist "!ZIP!" (
    echo %RED%✗ فشل التنزيل%WHITE%
    echo %YELLOW%الحل اليدوي: نزّل من https://jmeter.apache.org/download_jmeter.cgi%WHITE%
    timeout /t 6 >nul
    exit /b 1
)

echo %YELLOW%[2/4] جارٍ الاستخراج...%WHITE%
powershell -Command "Expand-Archive -Path '!ZIP!' -DestinationPath '%USERPROFILE%' -Force" >nul 2>&1
del "!ZIP!" >nul 2>&1

:: إعادة تسمية المجلد
for /d %%D in ("%USERPROFILE%\apache-jmeter-*") do (
    ren "%%D" "apache-jmeter"
)

:SETUP_ENVIRONMENT
echo %YELLOW%[3/4] جارٍ إعداد متغيرات البيئة...%WHITE%

setx JMETER_HOME "%JMETER_HOME%" >nul 2>&1
setx PATH "%PATH%;%JMETER_HOME%\bin" >nul 2>&1

echo %GREEN%✓ تم تعيين المتغيرات:%WHITE%
echo   JMETER_HOME = %GRAY%%JMETER_HOME%%WHITE%
echo   PATH         = %GRAY%...;%JMETER_HOME%\bin%WHITE%

echo %YELLOW%[4/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

set "JMETER_PROJECT=%JMETER_HOME%\test-plans"
if not exist "!JMETER_PROJECT!" mkdir "!JMETER_PROJECT!" >nul

:: إنشاء ملف JMX تجريبي (XML)
(
echo ^<?xml version="1.0" encoding="UTF-8"?^>
echo ^<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.6.3"^>
echo   ^<hashTree^>
echo     ^<TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="Knoux JMeter Test Plan" enabled="true"^>
echo       ^<stringProp name="TestPlan.comments"^>Test plan created by Knoux Toolbox^</stringProp^>
echo       ^<boolProp name="TestPlan.functional_mode"^>false^</boolProp^>
echo       ^<boolProp name="TestPlan.tearDown_on_shutdown"^>true^</boolProp^>
echo       ^<boolProp name="TestPlan.serialize_threadgroups"^>false^</boolProp^>
echo       ^<elementProp name="TestPlan.arguments" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true"^>
echo         ^<collectionProp name="Arguments.arguments"/^>
echo       ^</elementProp^>
echo       ^<stringProp name="TestPlan.user_define_classpath"^>^</stringProp^>
echo     ^</TestPlan^>
echo     ^<hashTree^>
echo       ^<ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="API Load Test" enabled="true"^>
echo         ^<stringProp name="ThreadGroup.on_sample_error"^>continue^</stringProp^>
echo         ^<elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true"^>
echo           ^<boolProp name="LoopController.continue_forever"^>false^</boolProp^>
echo           ^<stringProp name="LoopController.loops"^>10^</stringProp^>
echo         ^</elementProp^>
echo         ^<stringProp name="ThreadGroup.num_threads"^>5^</stringProp^>
echo         ^<stringProp name="ThreadGroup.ramp_time"^>10^</stringProp^>
echo         ^<boolProp name="ThreadGroup.scheduler"^>false^</boolProp^>
echo         ^<stringProp name="ThreadGroup.duration"^>^</stringProp^>
echo         ^<stringProp name="ThreadGroup.delay"^>^</stringProp^>
echo       ^</ThreadGroup^>
echo       ^<hashTree^>
echo         ^<HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="GET Users API" enabled="true"^>
echo           ^<elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true"^>
echo             ^<collectionProp name="Arguments.arguments"/^>
echo           ^</elementProp^>
echo           ^<stringProp name="HTTPSampler.domain"^>jsonplaceholder.typicode.com^</stringProp^>
echo           ^<stringProp name="HTTPSampler.port"^>^</stringProp^>
echo           ^<stringProp name="HTTPSampler.protocol"^>https^</stringProp^>
echo           ^<stringProp name="HTTPSampler.contentEncoding"^>^</stringProp^>
echo           ^<stringProp name="HTTPSampler.path"^>/users^</stringProp^>
echo           ^<stringProp name="HTTPSampler.method"^>GET^</stringProp^>
echo           ^<boolProp name="HTTPSampler.follow_redirects"^>true^</boolProp^>
echo           ^<boolProp name="HTTPSampler.use_keepalive"^>true^</boolProp^>
echo           ^<boolProp name="HTTPSampler.DO_MULTIPART_POST"^>false^</boolProp^>
echo           ^<stringProp name="HTTPSampler.embedded_url_re"^>^</stringProp^>
echo           ^<stringProp name="HTTPSampler.connect_timeout"^>5000^</stringProp^>
echo           ^<stringProp name="HTTPSampler.response_timeout"^>10000^</stringProp^>
echo         ^</HTTPSamplerProxy^>
echo         ^<hashTree/^>
echo       ^</hashTree^>
echo     ^</hashTree^>
echo   ^</hashTree^>
echo ^</jmeterTestPlan^>
) > "!JMETER_PROJECT!\knoux-test-plan.jmx"

:: إنشاء سكربت لتشغيل JMeter
(
echo @echo off
echo echo Starting JMeter GUI...
echo echo ====================
echo echo.
echo echo To run this test plan:
echo echo 1. Open JMeter GUI: jmeter.bat
echo echo 2. File -> Open -> %JMETER_PROJECT%\knoux-test-plan.jmx
echo echo 3. Click Run -> Start
echo echo.
echo echo Or run from command line:
echo echo jmeter -n -t "%JMETER_PROJECT%\knoux-test-plan.jmx" -l results.jtl -j jmeter.log
echo.
echo pause
) > "!JMETER_PROJECT!\readme-run.txt"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم التثبيت الكامل بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   JMeter: %GRAY%%JMETER_HOME%\bin\jmeter.bat%WHITE%
echo   GUI: %GRAY%jmeter (from any command prompt)%WHITE%
echo   CLI: %GRAY%jmeter -n -t test.jmx -l results.jtl%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبار تحميل الشبكة (Load Testing)
echo   ✓ اختبار الأداء (Performance Testing)
echo   ✓ اختبار التحمل (Stress Testing)
echo   ✓ اختبار الحجم (Volume Testing)
echo   ✓ اختبار الاستقرار (Soak Testing)
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. jmeter ← لفتح واجهة المستخدم
echo   2. استخدم knoux-test-plan.jmx كنقطة بداية
echo   3. أضف مكونات (Listeners) لعرض النتائج
echo   4. ابدأ الاختبار وحلل النتائج

:: إنشاء اختصار على سطح المكتب
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\JMeter.lnk'); $s.TargetPath='%JMETER_HOME%\bin\jmeter.bat'; $s.IconLocation='%JMETER_HOME%\bin\jmeter.ico'; $s.Save()" >nul 2>&1

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Apache JMeter with sample test plan >> "!LOG_FILE!"

timeout /t 12 >nul
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
