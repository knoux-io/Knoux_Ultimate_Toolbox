@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  📦 Newman - Postman CLI for Automation%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node --version >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:CHECK_EXISTING
where newman >nul 2>&1 && (
    echo %GREEN%✓ Newman مثبت مسبقًا%WHITE%
    newman --version
    goto :CREATE_WORKSPACE
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
npm install -g newman >nul 2>&1

where newman >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:CREATE_WORKSPACE
echo %YELLOW%جارٍ إنشاء مساحة عمل تجريبية...%WHITE%

set "NEWMAN_WS=%USERPROFILE%\newman-workspace"
if not exist "!NEWMAN_WS!" mkdir "!NEWMAN_WS!" >nul

:: إنشاء Collection تجريبية
(
echo {
echo   "info": {
echo     "name": "Knoux API Tests",
echo     "_postman_id": "knoux-test-collection",
echo     "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collections.json"
echo   },
echo   "item": [
echo     {
echo       "name": "GET Users",
echo       "request": {
echo         "method": "GET",
echo         "header": [],
echo         "url": {
echo           "raw": "https://jsonplaceholder.typicode.com/users",
echo           "protocol": "https",
echo           "host": [
echo             "jsonplaceholder",
echo             "typicode",
echo             "com"
echo           ],
echo           "path": [
echo             "users"
echo           ]
echo         }
echo       },
echo       "response": []
echo     },
echo     {
echo       "name": "POST User",
echo       "request": {
echo         "method": "POST",
echo         "header": [
echo           {
echo             "key": "Content-Type",
echo             "value": "application/json"
echo           }
echo         ],
echo         "body": {
echo           "mode": "raw",
echo           "raw": "{\n  \"name\": \"John Doe\",\n  \"email\": \"john@example.com\"\n}"
echo         },
echo         "url": {
echo           "raw": "https://jsonplaceholder.typicode.com/users",
echo           "protocol": "https",
echo           "host": [
echo             "jsonplaceholder",
echo             "typicode",
echo             "com"
echo           ],
echo           "path": [
echo             "users"
echo           ]
echo         }
echo       },
echo       "response": []
echo     }
echo   ]
echo }
) > "!NEWMAN_WS!\knoux-collection.json"

:: إنشاء Environment تجريبية
(
echo {
echo   "id": "knoux-environment",
echo   "name": "Knoux Environment",
echo   "values": [
echo     {
echo       "key": "baseUrl",
echo       "value": "https://jsonplaceholder.typicode.com",
echo       "enabled": true
echo     },
echo     {
echo       "key": "userId",
echo       "value": "1",
echo       "enabled": true
echo     }
echo   ],
echo   "_postman_variable_scope": "environment",
echo   "_postman_exported_at": "2024-01-29T00:00:00.000Z",
echo   "_postman_exported_using": "Postman/10.0.0"
echo }
) > "!NEWMAN_WS!\knoux-environment.json"

:: إنشاء سكربت للتشغيل التلقائي
(
echo @echo off
echo echo Newman API Testing - Knoux Toolbox
echo echo ==================================
echo echo.
echo echo Running collection tests...
echo newman run "!NEWMAN_WS!\knoux-collection.json" -e "!NEWMAN_WS!\knoux-environment.json" --reporters cli,junit --reporter-junit-export results.xml
echo 
echo if %%errorlevel%% equ 0 (
echo     echo Tests passed successfully!
echo ) else (
echo     echo Some tests failed.
echo )
) > "!NEWMAN_WS!\run-tests.bat"

echo %GREEN%✓ تم إنشاء مساحة عمل Newman%WHITE%
echo %CYAN%الموقع:%WHITE% !NEWMAN_WS!

echo.
echo %CYAN%أوامر Newman شائعة:%WHITE%
echo   newman run collection.json
echo   newman run collection.json -e environment.json
echo   newman run collection.json --folder "specific-folder"
echo   newman run collection.json --reporters cli,junit,html
echo   newman run collection.json --delay-request 1000
echo.
echo %YELLOW%الاستخدام في CI/CD:%WHITE%
echo   newman run collection.json --reporters json --reporter-json-export report.json

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Newman with test workspace >> "!LOG_FILE!"

timeout /t 8 >nul
