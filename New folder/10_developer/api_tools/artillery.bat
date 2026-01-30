@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:HEADER
cls
echo %RED%===================================================%WHITE%
echo %RED%  🏹 Artillery - اختبار تحميل API المتقدم%WHITE%
echo %RED%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:CHECK_EXISTING
where artillery >nul 2>&1 && (
    echo %GREEN%✓ Artillery مثبت مسبقًا%WHITE%
    artillery --version
    goto :CREATE_SCENARIO
)

echo %YELLOW%[1/3] جارٍ التثبيت...%WHITE%
call :LOADING_ANIMATION 5

npm install -g artillery >nul 2>&1

where artillery >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:CREATE_SCENARIO
echo %YELLOW%[2/3] جارٍ إنشاء سيناريوهات اختبار...%WHITE%

set "ARTILLERY_DIR=%USERPROFILE%\artillery-tests"
if not exist "!ARTILLERY_DIR!" mkdir "!ARTILLERY_DIR!" >nul

:: إنشاء سيناريو اختبار بسيط
(
echo config:
echo   target: "https://jsonplaceholder.typicode.com"
echo   phases:
echo     - duration: 30
echo       arrivalRate: 5
echo       name: "Warm up phase"
echo     - duration: 60
echo       arrivalRate: 10
echo       name: "Sustained load"
echo   defaults:
echo     headers:
echo       User-Agent: "Artillery Knoux Toolbox"
echo scenarios:
echo   - name: "API Load Test"
echo     weight: 80
echo     flow:
echo       - get:
echo           url: "/posts"
echo           expect:
echo             - statusCode: 200
echo             - contentType: "application/json"
echo   - name: "User Creation Test"
echo     weight: 20
echo     flow:
echo       - post:
echo           url: "/posts"
echo           json:
echo             title: "Test Post"
echo             body: "This is a test post for load testing"
echo             userId: 1
echo           expect:
echo             - statusCode: 201
) > "!ARTILLERY_DIR!\simple-load-test.yml"

:: إنشاء سيناريو اختبار معقد
(
echo config:
echo   target: "https://api.example.com"
echo   phases:
echo     - duration: 60
echo       arrivalRate: 2
echo       rampTo: 10
echo       name: "Ramp up"
echo     - duration: 300
echo       arrivalRate: 10
echo       name: "Sustained load"
echo     - duration: 60
echo       arrivalRate: 2
echo       rampTo: 0
echo       name: "Ramp down"
echo   payload:
echo     path: "./users.csv"
echo     fields:
echo       - email
echo       - name
echo   processor: "./helpers.js"
echo scenarios:
echo   - name: "Authentication Flow"
echo     flow:
echo       - post:
echo           url: "/auth/login"
echo           json:
echo             email: "{{ email }}"
echo             password: "password123"
echo           capture:
echo             - json: "$.token"
echo               as: "authToken"
echo           expect:
echo             - statusCode: 200
echo       - get:
echo           url: "/dashboard"
echo           headers:
echo             Authorization: "Bearer {{ authToken }}"
echo           expect:
echo             - statusCode: 200
echo   - name: "Data Submission"
echo     weight: 3
echo     flow:
echo       - post:
echo           url: "/api/data"
echo           headers:
echo             Authorization: "Bearer {{ authToken }}"
echo           json:
echo             userId: 1
echo             data: "Sample data for load testing"
echo           expect:
echo             - statusCode: 200
) > "!ARTILLERY_DIR!\complex-load-test.yml"

:: إنشاء ملف مساعدين
(
echo module.exports = {
echo   generateRandomEmail: function() {
echo     return `user_${Math.random().toString(36).substr(2, 9)}@example.com`;
echo   },
echo   validateResponse: function(response, context, ee, next) {
echo     if (response.statusCode !== 200) {
echo       console.log('Error occurred:', response.statusCode);
echo     }
echo     return next();
echo   }
echo };
) > "!ARTILLERY_DIR!\helpers.js"

:: إنشاء ملف بيانات
(
echo email,name
echo john@example.com,John Doe
echo jane@example.com,Jane Smith
echo ahmed@example.com,Ahmed Ali
echo fatima@example.com,Fatima Noor
) > "!ARTILLERY_DIR!\users.csv"

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Artillery Load Testing - Knoux Toolbox
echo echo =====================================
echo echo.
echo echo Running simple load test...
echo artillery run --output results-simple.json "!ARTILLERY_DIR!\simple-load-test.yml"
echo 
echo echo Running complex load test...
echo artillery run --output results-complex.json "!ARTILLERY_DIR!\complex-load-test.yml"
echo 
echo echo Generating report...
echo artillery report results-complex.json
echo 
echo echo View detailed report in results-complex.json
) > "!ARTILLERY_DIR!\run-all-tests.bat"

echo %YELLOW%[3/3] جارٍ إنشاء تقرير تحليلي...%WHITE%

(
echo # Artillery Load Testing Report
echo 
echo ## Test Scenarios
echo - Simple Load Test: Basic GET/POST requests
echo - Complex Load Test: Authentication + Data submission
echo 
echo ## Performance Metrics
echo - Target: {{ config.target }}
echo - Peak Load: {{ config.phases[1].arrivalRate }} requests/sec
echo - Duration: {{ config.phases[1].duration }} seconds
echo 
echo ## Results Summary
echo - Success Rate: 
echo - Average Response Time:
echo - 95th Percentile:
echo - Throughput:
echo 
echo ## Recommendations
echo - Optimize slow endpoints
echo - Scale database connections
echo - Implement caching strategies
) > "!ARTILLERY_DIR!\report-template.md"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لاختبار التحميل!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   Artillery CLI: %GRAY%artillery run test.yml%WHITE%
echo   مساحة العمل: %GRAY%!ARTILLERY_DIR!%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%أوامر Artillery شائعة:%WHITE%
echo   artillery run test.yml
echo   artillery run test.yml --target https://api.example.com
echo   artillery run test.yml --overrides '{"config":{"target":"https://new-target.com"}}'
echo   artillery report results.json
echo   artillery open-visualizer results.json
echo.
echo %YELLOW%الاستخدام في CI/CD:%WHITE%
echo   artillery run test.yml --output results.json && node analyze-results.js

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Artillery with comprehensive load testing scenarios >> "!LOG_FILE!"

timeout /t 10 >nul
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
