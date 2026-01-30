@echo off
:: =================================================================
:: KNOUX NODE.JS LTS INSTALLER WITH NPM CACHE OPTIMIZER
:: تثبيت Node.js مع محسن ذاكرة NPM
:: =================================================================
title Knoux - Node.js LTS Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX NODE.JS LTS + NPM CACHE OPTIMIZER
echo   تثبيت Node.js مع محسن ذاكرة NPM
echo ═══════════════════════════════════════════════════════════
echo.

:: Knoux Feature: Check existing installation
echo [Knoux] جاري فحص التثبيتات الحالية...
where node >nul 2>nul
if %errorlevel% equ 0 (
    echo [!] تم العثور على Node.js مثبت مسبقاً!
    node --version
    echo.
    goto :NODE_MENU
)

:: Install Node.js LTS
echo [→] جاري تثبيت Node.js LTS...
echo [→] هذا قد يستغرق بضع دقائق...
winget install OpenJS.NodeJS.LTS --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [✗] فشل التثبيت عبر Winget، جاري المحاولة بطريقة بديلة...
    powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v18.19.0/node-v18.19.0-x64.msi' -OutFile '$env:TEMP\nodejs.msi'"
    msiexec /i "$env:TEMP\nodejs.msi" /quiet /norestart
    timeout /t 10 /nobreak >nul
)

:: Verify installation
echo [→] جاري التحقق من التثبيت...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [✗] فشل تثبيت Node.js!
    pause
    exit /b 1
)

echo [✓] تم تثبيت Node.js بنجاح!
node --version
npm --version

:NODE_MENU
cls
echo ═══════════════════════════════════════════════════════════
echo         KNOUX NODE.JS MANAGER - مدير Node.js
echo ═══════════════════════════════════════════════════════════
echo.
echo [1] تحسين ذاكرة NPM Cache
echo [2] تحديث جميع الحزم العالمية
echo [3] تنظيف NPM Cache
echo [4] تثبيت حزم أساسية
echo [5] فحص الحزم القديمة
echo [6] إصلاح أذونات NPM
echo [7] إنشاء مشروع Node.js جديد
echo [8] التحقق من أداء Node.js
echo [9] إعدادات NPM المتقدمة
echo [0] العودة
echo.
set /p choice=اختر الخيار: 

if "%choice%"=="1" goto :OPTIMIZE_NPM
if "%choice%"=="2" goto :UPDATE_GLOBAL
if "%choice%"=="3" goto :CLEAN_NPM
if "%choice%"=="4" goto :INSTALL_ESSENTIAL
if "%choice%"=="5" goto :CHECK_OUTDATED
if "%choice%"=="6" goto :FIX_PERMISSIONS
if "%choice%"=="7" goto :CREATE_PROJECT
if "%choice%"=="8" goto :CHECK_PERFORMANCE
if "%choice%"=="9" goto :ADVANCED_SETTINGS
if "%choice%"=="0" exit /b
goto :NODE_MENU

:OPTIMIZE_NPM
echo.
echo [Knoux] جاري تحسين ذاكرة NPM...
npm config set cache "%USERPROFILE%\.npm-cache" --global
npm config set cache-min 3600 --global
npm config set fetch-retries 3 --global
echo [✓] تم تحسين إعدادات NPM Cache!
echo.
echo [→] الإعدادات الحالية:
npm config list
pause
goto :NODE_MENU

:UPDATE_GLOBAL
echo.
echo [Knoux] جاري تحديث جميع الحزم العالمية...
npm update -g
echo [✓] تم تحديث جميع الحزم!
pause
goto :NODE_MENU

:CLEAN_NPM
echo.
echo [Knoux] جاري تنظيف NPM Cache...
npm cache clean --force
npm cache verify
echo [✓] تم تنظيف NPM Cache!
echo [→] المساحة المحررة:
dir /s "%USERPROFILE%\.npm" | find "File(s)"
pause
goto :NODE_MENU

:INSTALL_ESSENTIAL
echo.
echo [Knoux] جاري تثبيت الحزم الأساسية...
npm install -g npm@latest
npm install -g nodemon
npm install -g http-server
npm install -g pm2
npm install -g typescript
npm install -g yarn
echo [✓] تم تثبيت الحزم الأساسية!
pause
goto :NODE_MENU

:CREATE_PROJECT
echo.
echo [Knoux] منشئ مشروع Node.js
echo.
set /p project_name=اسم المشروع: 
mkdir "%project_name%"
cd "%project_name%"

:: Create package.json
(
    echo {
    echo   "name": "%project_name%",
    echo   "version": "1.0.0",
    echo   "description": "Knoux Node.js Project",
    echo   "main": "index.js",
    echo   "scripts": {
    echo     "start": "node index.js",
    echo     "dev": "nodemon index.js",
    echo     "test": "echo \"Error: no test specified\" && exit 1"
    echo   },
    echo   "keywords": ["knoux", "nodejs"],
    echo   "author": "",
    echo   "license": "MIT"
    echo }
) > package.json

:: Create index.js
(
    echo // Knoux Node.js Project
    echo // Generated on %date% %time%
    echo 
    echo console.log("====================================");
    echo console.log("  KNOUX NODE.JS PROJECT");
    echo console.log("  Project: %project_name%");
    echo console.log("  Date: %date%");
    echo console.log("====================================");
    echo console.log("");
    echo console.log("🚀 Server is running...");
    echo console.log("📁 Directory: " + __dirname);
    echo console.log("💻 Node Version: " + process.version);
    echo console.log("");
    echo // Start HTTP server
    echo const http = require('http');
    echo const port = 3000;
    echo 
    echo const server = http.createServer((req, res) => {
    echo   res.writeHead(200, {'Content-Type': 'text/html'});
    echo   res.end('<h1>Knoux Node.js Server</h1><p>Project: %project_name%</p>');
    echo });
    echo 
    echo server.listen(port, () => {
    echo   console.log(`🌐 Server running at http://localhost:${port}/`);
    echo });
) > index.js

echo [✓] تم إنشاء مشروع Node.js!
echo [→] المشروع: %project_name%
echo [→] للتشغيل: npm start
echo [→] للتطوير: npm run dev
pause
goto :NODE_MENU
