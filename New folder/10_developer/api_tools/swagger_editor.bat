@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  📖 Swagger Editor - تصميم وثائق API (OpenAPI)%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] تثبيت Swagger Editor (VS Code Extension)
echo   [2] تثبيت Swagger UI (لعرض الوثائق)
echo   [3] إنشاء مشروع OpenAPI تجريبي
echo   [4] تثبيت Swagger Inspector (لتحليل API)
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :SWAGGER_EDITOR_EXTENSION
if "!CHOICE!"=="2" goto :SWAGGER_UI
if "!CHOICE!"=="3" goto :OPENAPI_DEMO
if "!CHOICE!"=="4" goto :SWAGGER_INSPECTOR
goto :MENU

:SWAGGER_EDITOR_EXTENSION
where code >nul 2>&1 || (
    echo %RED%✗ VS Code غير مثبت%WHITE%
    timeout /t 3 >nul
    goto :MENU
)

echo %YELLOW%جارٍ تثبيت Swagger Editor Extension...%WHITE%
code --install-extension 42Crunch.vscode-openapi >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل: افتح VS Code ← Ctrl+Shift+X ← ابحث عن "OpenAPI (Swagger) editor"%WHITE%
) else (
    echo %GREEN%✓ تم التثبيت%WHITE%
)
goto :MENU

:SWAGGER_UI
echo %YELLOW%جارٍ تثبيت Swagger UI (Node.js)...%WHITE%
npm install -g swagger-ui >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "SWAGGER_UI=%USERPROFILE%\swagger-ui"
    if not exist "!SWAGGER_UI!" mkdir "!SWAGGER_UI!" >nul
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/swagger-api/swagger-ui/archive/master.zip' -OutFile '%TEMP%\swagger-ui.zip'" >nul 2>&1
    powershell -Command "Expand-Archive -Path '%TEMP%\swagger-ui.zip' -DestinationPath '!SWAGGER_UI!' -Force" >nul 2>&1
    del "%TEMP%\swagger-ui.zip" >nul 2>&1
    echo %GREEN%✓ تم التنزيل إلى: !SWAGGER_UI!%WHITE%
) else (
    echo %GREEN%✓ تم التثبيت%WHITE%
)
goto :MENU

:OPENAPI_DEMO
set "OPENAPI_PROJECT=%USERPROFILE%\openapi-demo"
if not exist "!OPENAPI_PROJECT!" mkdir "!OPENAPI_PROJECT!" >nul

(
echo openapi: 3.0.0
echo info:
echo   title: API Demo Service
echo   description: خدمة API تجريبية باللغة العربية
echo   version: 1.0.0
echo servers:
echo   - url: http://localhost:3000
echo     description: الخادم التنموي
echo paths:
echo   /users:
echo     get:
echo       summary: الحصول على جميع المستخدمين
echo       responses:
echo         '200':
echo           description: نجاح
echo           content:
echo             application/json:
echo               schema:
echo                 type: array
echo                 items:
echo                   $ref: '#/components/schemas/User'
echo   /users/{id}:
echo     get:
echo       summary: الحصول على مستخدم حسب المعرف
echo       parameters:
echo         - in: path
echo           name: id
echo           required: true
echo           schema:
echo             type: integer
echo           description: معرف المستخدم
echo       responses:
echo         '200':
echo           description: نجاح
echo           content:
echo             application/json:
echo               schema:
echo                 $ref: '#/components/schemas/User'
echo         '404':
echo           description: المستخدم غير موجود
echo components:
echo   schemas:
echo     User:
echo       type: object
echo       properties:
echo         id:
echo           type: integer
echo         name:
echo           type: string
echo         email:
echo           type: string
) > "!OPENAPI_PROJECT!\openapi.yaml"

echo %GREEN%✓ تم إنشاء مشروع OpenAPI تجريبي%WHITE%
echo %CYAN%الملف:%WHITE% !OPENAPI_PROJECT!\openapi.yaml
goto :MENU

:SWAGGER_INSPECTOR
echo %YELLOW%Swagger Inspector متوفر عبر الإنترنت%WHITE%
echo %CYAN%الرابط:%WHITE% https://inspector.swagger.io/
echo %YELLOW%ملاحظة:%WHITE% أداة على الإنترنت لتحليل وتصميم API
goto :MENU
