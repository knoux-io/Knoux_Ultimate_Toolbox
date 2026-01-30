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
echo %ORANGE%===================================================%WHITE%
echo %ORANGE%  🛡️  Katalon Studio - اختبار تطبيقات شامل%WHITE%
echo %ORANGE%===================================================%WHITE%
echo.

:CHECK_EXISTING
where katalon.exe >nul 2>&1 && (
    echo %GREEN%✓ Katalon Studio مثبت مسبقًا%WHITE%
    timeout /t 3 >nul
    exit /b 0
)

echo %YELLOW%[1/4] جارٍ التثبيت عبر Winget...%WHITE%
call :LOADING_ANIMATION 10

winget install -e --id Katalon.KatalonStudio --silent --accept-source-agreements --accept-package-agreements >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "INSTALLER=%TEMP%\KatalonStudio.exe"
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/katalon-studio/katalon-studio/releases/latest/download/Katalon_Studio_Windows_64bit.exe' -OutFile '!INSTALLER!'" >nul 2>&1
    
    if not exist "!INSTALLER!" (
        echo %RED%✗ فشل التنزيل%WHITE%
        echo %YELLOW%الحل اليدوي: نزّل من https://www.katalon.com/download/%WHITE%
        timeout /t 6 >nul
        exit /b 1
    )
    
    start /wait "" "!INSTALLER!" /S >nul 2>&1
    del "!INSTALLER!" >nul 2>&1
)

where katalon.exe >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Katalon Studio%WHITE%

echo %YELLOW%[2/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

set "KATALON_PROJECT=%USERPROFILE%\KatalonDemo"
if not exist "!KATALON_PROJECT!" mkdir "!KATALON_PROJECT!" >nul

:: إنشاء هيكل مشروع Katalon
mkdir "!KATALON_PROJECT!\Include" "!KATALON_PROJECT!\Keywords" "!KATALON_PROJECT!\Libs" "!KATALON_PROJECT!\Object Repository" "!KATALON_PROJECT!\Reports" "!KATALON_PROJECT!\Scripts" "!KATALON_PROJECT!\Settings" >nul 2>&1
mkdir "!KATALON_PROJECT!\Scripts\WebUI" "!KATALON_PROJECT!\Scripts\API" "!KATALON_PROJECT!\Scripts\Mobile" >nul 2>&1

:: إنشاء ملف إعدادات المشروع
(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <project>
echo     <name>Katalon Demo Project</name>
echo     <description>Knoux Katalon Studio Demo Project</description>
echo     <dateCreated>!TIMESTAMP!</dateCreated>
echo     <webUi>
echo         <defaultBrowser>Chrome</defaultBrowser>
echo         <timeout>30</timeout>
echo         <implicitWait>5</implicitWait>
echo     </webUi>
echo     <mobile>
echo         <defaultDeviceType>Android</defaultDeviceType>
echo         <timeout>30</timeout>
echo     </mobile>
echo     <api>
echo         <timeout>30</timeout>
echo     </api>
echo     <execution>
echo         <defaultExecutionProfile>default</defaultExecutionProfile>
echo     </execution>
echo </project>
) > "!KATALON_PROJECT!\project.prj"

:: إنشاء اختبار ويب تجريبي
(
echo package WebUI
echo 
echo import static com.kms.katalon.core.checkpoint.CheckpointFactory.findCheckpoint
echo import static com.kms.katalon.core.testcase.TestCaseFactory.findTestCase
echo import static com.kms.katalon.core.testdata.TestDataFactory.findTestData
echo import static com.kms.katalon.core.testobject.ObjectRepository.findTestObject
echo import static com.kms.katalon.core.testobject.ObjectRepository.findWindowsObject
echo import com.kms.katalon.core.checkpoint.Checkpoint
echo import com.kms.katalon.core.cucumber.keyword.CucumberBuiltinKeywords as CucumberKW
echo import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
echo import com.kms.katalon.core.model.FailureHandling
echo import com.kms.katalon.core.testcase.TestCase
echo import com.kms.katalon.core.testdata.TestData
echo import com.kms.katalon.core.testobject.TestObject
echo import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
echo import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
echo import internal.GlobalVariable
echo 
echo public class TC_WebDemo {
echo 
echo     public static void execute() {
echo         // Open browser and navigate to example site
echo         WebUI.openBrowser('https://example.com')
echo         WebUI.maximizeWindow()
echo         
echo         // Verify page title
echo         String title = WebUI.getTitle()
echo         WebUI.verifyMatch(title, 'Example Domain', false)
echo         
echo         // Verify main heading
echo         WebUI.verifyElementPresent(findTestObject('Page_Example/h1_Example'), 10)
echo         
echo         // Perform some actions
echo         WebUI.delay(2)
echo         
echo         // Close browser
echo         WebUI.closeBrowser()
echo     }
echo }
) > "!KATALON_PROJECT!\Scripts\WebUI\TC_WebDemo.groovy"

:: إنشاء اختبار API تجريبي
(
echo package API
echo 
echo import static com.kms.katalon.core.testobject.ResponseObject
echo import com.kms.katalon.core.testobject.RequestObject
echo import com.kms.katalon.core.testobject.impl.HttpTextBodyContent
echo import com.kms.katalon.core.webservice.keyword.WSBuiltInKeywords as WS
echo import com.kms.katalon.core.webui.keyword.WebUiBuiltInKeywords as WebUI
echo import com.kms.katalon.core.mobile.keyword.MobileBuiltInKeywords as Mobile
echo import internal.GlobalVariable
echo import com.kms.katalon.core.annotation.TearDown
echo import com.kms.katalon.core.annotation.SetUp
echo import groovy.json.JsonSlurper
echo 
echo public class TC_APIDemo {
echo 
echo     public static void execute() {
echo         // Test GET request
echo         ResponseObject response = WS.sendRequest(findTestObject('API_GetUsers'))
echo         WS.verifyResponseStatusCode(response, 200)
echo         WS.verifyElementPropertyValue(response, '[0].id', 1)
echo         
echo         // Test POST request
echo         RequestObject postRequest = findTestObject('API_CreateUser')
echo         ResponseObject postResponse = WS.sendRequest(postRequest)
echo         WS.verifyResponseStatusCode(postResponse, 201)
echo         
echo         // Parse JSON response
echo         def jsonSlurper = new JsonSlurper()
echo         def jsonResponse = jsonSlurper.parseText(postResponse.getResponseText())
echo         println('Created user ID: ' + jsonResponse.id)
echo     }
echo }
) > "!KATALON_PROJECT!\Scripts\API\TC_APIDemo.groovy"

:: إنشاء ملفات الكائنات
(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <WebElementEntity>
echo     <description>Main heading on example.com</description>
echo     <name>h1_Example</name>
echo     <tag></tag>
echo     <elementGuidId></elementGuidId>
echo     <selectorMethod></selectorMethod>
echo     <smartLocatorEnabled>false</smartLocatorEnabled>
echo     <useRalativeImagePath>true</useRalativeImagePath>
echo     <webElementProperties>
echo         <isSelected>true</isSelected>
echo         <matchCondition>equals</matchCondition>
echo         <name>tag</name>
echo         <type>Main</type>
echo         <value>h1</value>
echo     </webElementProperties>
echo     <webElementProperties>
echo         <isSelected>true</isSelected>
echo         <matchCondition>equals</matchCondition>
echo         <name>text</name>
echo         <value>Example Domain</value>
echo     </webElementProperties>
echo </WebElementEntity>
) > "!KATALON_PROJECT!\Object Repository\Page_Example\h1_Example.rs"

:: إنشاء إعدادات التشغيل
(
echo [Settings]
echo # Default execution profile
echo default.browser = Chrome
echo default.wait.for.page.load.timeout = 30
echo default.wait.for.element.timeout = 10
echo default.take.screenshot.on.failure = true
echo 
echo [Capabilities]
echo # Chrome capabilities
echo chrome.capabilities.binary = 
echo chrome.capabilities.arguments = --no-sandbox,--disable-dev-shm-usage
echo 
echo [Mobile]
echo # Android settings
echo android.app.package = 
echo android.app.activity = 
echo 
echo [API]
echo # API settings
echo api.default.timeout = 30
echo api.default.retry.count = 3
) > "!KATALON_PROJECT!\Settings\execution.properties"

:: إنشاء اختصار على سطح المكتب
powershell -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Katalon Studio.lnk'); $s.TargetPath='C:\Katalon Studio\Katalon Studio.exe'; $s.IconLocation='C:\Katalon Studio\Katalon Studio.exe'; $s.Description='Katalon Studio - Automated Testing Platform'; $s.Save()" >nul 2>&1

echo %YELLOW%[3/4] جارٍ تثبيت المكونات الإضافية...%WHITE%

:: تثبيت Katalon Recorder (كملحق Chrome)
echo %CYAN%ملاحظة:%WHITE% Katalon Recorder هو ملحق Chrome يمكن تثبيته من:
echo %GRAY%https://chrome.google.com/webstore/detail/katalon-recorder/ljdobmjcdnncaafjfkehnnjejcnleggp%WHITE%
echo.

:: إنشاء ملف تعليمات
(
echo # Katalon Studio Setup Guide
echo 
echo ## Overview
echo Katalon Studio is a comprehensive test automation solution for Web, API, Mobile, and Desktop applications.
echo 
echo ## Getting Started
echo 1. Launch Katalon Studio from Start Menu
echo 2. Open the demo project located at: !KATALON_PROJECT!
echo 3. Run the WebUI demo test to verify installation
echo 
echo ## Key Features
echo - Record and playback test scripts
echo - Built-in keywords for common actions
echo - Cross-platform testing (Web, Mobile, API)
echo - Integration with CI/CD tools
echo - Comprehensive reporting
echo 
echo ## Demo Project Structure
echo - Scripts/: Contains test scripts
echo - Object Repository/: Stores web elements
echo - Keywords/: Custom keywords
echo - Reports/: Test execution reports
echo - Settings/: Execution configurations
echo 
echo ## Running Tests
echo 1. Open Katalon Studio
echo 2. File -> Open -> Select demo project
echo 3. Right-click on test script -> Execute
echo 
echo ## Additional Resources
echo - Official Documentation: https://docs.katalon.com/
echo - Community Forum: https://forum.katalon.com/
echo - YouTube Channel: https://www.youtube.com/user/KatalonStudio
) > "!KATALON_PROJECT!\README.txt"

echo %YELLOW%[4/4] جارٍ إنشاء بيئة التطوير...%WHITE%

:: إنشاء ملف متطلبات
(
echo # Katalon Studio Requirements
echo - Java 8 or higher
echo - Chrome, Firefox, Edge browsers
echo - Android SDK (for mobile testing)
echo - Xcode (for iOS testing, macOS only)
echo 
echo # Recommended Setup
echo 1. Ensure browsers are updated
echo 2. Install Android Studio for mobile testing
echo 3. Configure desired capabilities in Settings
echo 4. Import test objects from Object Repository
) > "!KATALON_PROJECT!\requirements.txt"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Katalon Studio!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   التثبيت: %GRAY%C:\Katalon Studio%WHITE%
echo   مشروع تجريبي: %GRAY%!KATALON_PROJECT!%WHITE%
echo   اختصار: %GRAY%سطح المكتب ← Katalon Studio%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبار ويب شامل
echo   ✓ اختبار API
echo   ✓ اختبار جوال
echo   ✓ تسجيل الإجراءات
echo   ✓ تقارير مفصلة
echo   ✓ بيئة IDE متكاملة
echo   ✓ دعم CI/CD
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. افتح Katalon Studio من سطح المكتب
echo   2. افتح مشروع !KATALON_PROJECT!
echo   3. شغل اختبار TC_WebDemo للتجربة
echo   4. استكشف Object Repository لإدارة العناصر

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Katalon Studio with demo project >> "!LOG_FILE!"

timeout /t 12 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
