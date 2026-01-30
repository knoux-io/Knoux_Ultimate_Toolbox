@echo off
:: =================================================================
:: KNOUX CREATE REACT APP
:: منشئ تطبيقات React مع مدير المكونات
:: =================================================================
title Knoux - Create React App

echo ═══════════════════════════════════════════════════════════
echo   KNOUX CREATE REACT APP + COMPONENT MANAGER
echo   منشئ تطبيقات React مع مدير المكونات
echo ═══════════════════════════════════════════════════════════
echo.

:: Check if Node.js is installed
echo [Knoux] جاري فحص Node.js...
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [✗] Node.js غير مثبت!
    echo [→] يرجى تثبيت Node.js أولاً
    pause
    exit /b 1
)

echo [→] Node.js مثبت!
node --version
npm --version

:MAIN_MENU
cls
echo ═══════════════════════════════════════════════════════════
echo         KNOUX REACT APP CREATOR
echo ═══════════════════════════════════════════════════════════
echo.
echo [1] إنشاء تطبيق React جديد
echo [2] إنشاء تطبيق React مع TypeScript
echo [3] إنشاء تطبيق React مع Tailwind CSS
echo [4] إضافة مكونات شائعة
echo [5] إضافة مكتبات إضافية
echo [6] إعداد بيئة التطوير
echo [7] بناء التطبيق للإنتاج
echo [8] تشغيل الخادم المحلي
echo [9] عرض المشاريع الحالية
echo [0] خروج
echo.
set /p choice=اختر الخيار: 

if "%choice%"=="1" goto :CREATE_REACT
if "%choice%"=="2" goto :CREATE_REACT_TS
if "%choice%"=="3" goto :CREATE_REACT_TAILWIND
if "%choice%"=="4" goto :ADD_COMPONENTS
if "%choice%"=="5" goto :ADD_LIBRARIES
if "%choice%"=="6" goto :SETUP_DEV
if "%choice%"=="7" goto :BUILD_APP
if "%choice%"=="8" goto :START_SERVER
if "%choice%"=="9" goto :LIST_PROJECTS
if "%choice%"=="0" exit /b
goto :MAIN_MENU

:CREATE_REACT
echo.
echo [Knoux] منشئ تطبيق React
set /p app_name=اسم التطبيق: 
if "%app_name%"=="" set "app_name=my-react-app"

echo [→] جاري إنشاء تطبيق React: %app_name%
npx create-react-app %app_name%

if %errorlevel% equ 0 (
    echo [✓] تم إنشاء التطبيق بنجاح!
    echo [→] المسار: %app_name%
    echo [→] للتشغيل: cd %app_name% && npm start
    echo [→] للبناء: cd %app_name% && npm run build
) else (
    echo [✗] فشل إنشاء التطبيق!
)
pause
goto :MAIN_MENU

:CREATE_REACT_TS
echo.
echo [Knoux] منشئ تطبيق React مع TypeScript
set /p app_name=اسم التطبيق: 
if "%app_name%"=="" set "app_name=my-react-ts-app"

echo [→] جاري إنشاء تطبيق React مع TypeScript: %app_name%
npx create-react-app %app_name% --template typescript

if %errorlevel% equ 0 (
    echo [✓] تم إنشاء التطبيق بنجاح!
    echo [→] المسار: %app_name%
    echo [→] للتشغيل: cd %app_name% && npm start
) else (
    echo [✗] فشل إنشاء التطبيق!
)
pause
goto :MAIN_MENU

:CREATE_REACT_TAILWIND
echo.
echo [Knoux] منشئ تطبيق React مع Tailwind CSS
set /p app_name=اسم التطبيق: 
if "%app_name%"=="" set "app_name=my-react-tailwind-app"

echo [→] جاري إنشاء تطبيق React: %app_name%
npx create-react-app %app_name%

if %errorlevel% equ 0 (
    echo [→] جاري إضافة Tailwind CSS...
    cd %app_name%
    npm install -D tailwindcss postcss autoprefixer
    npx tailwindcss init -p
    
    echo [→] جاري تكوين Tailwind...
    (
        echo /** @type {import('tailwindcss').Config} */
        echo module.exports = {
        echo   content: [
        echo     "./src/**/*.{js,jsx,ts,tsx}",
        echo   ],
        echo   theme: {
        echo     extend: {},
        echo   },
        echo   plugins: [],
        echo }
    ) > tailwind.config.js
    
    (
        echo @tailwind base;
        echo @tailwind components;
        echo @tailwind utilities;
    ) > src/index.css
    
    echo [✓] تم إضافة Tailwind CSS بنجاح!
    cd ..
) else (
    echo [✗] فشل إنشاء التطبيق!
)
pause
goto :MAIN_MENU

:ADD_COMPONENTS
echo.
echo [Knoux] إضافة مكونات شائعة
set /p project_path=مسار المشروع: 
if "%project_path%"=="" (
    echo [✗] يرجى تحديد مسار المشروع!
    pause
    goto :MAIN_MENU
)

if not exist "%project_path%\src" (
    echo [✗] مسار المشروع غير صحيح!
    pause
    goto :MAIN_MENU
)

echo [→] جاري إنشاء مجلد المكونات...
mkdir "%project_path%\src\components" 2>nul

:: Create Header component
(
    echo import React from 'react';
    echo.
    echo const Header = ({ title }) =^> {
    echo   return (
    echo     ^<header className="bg-blue-600 text-white p-4"^>
    echo       ^<h1 className="text-2xl font-bold"^>{title}^</h1^>
    echo     ^</header^>
    echo   );
    echo };
    echo.
    echo export default Header;
) > "%project_path%\src\components\Header.jsx"

:: Create Footer component
(
    echo import React from 'react';
    echo.
    echo const Footer = () =^> {
    echo   return (
    echo     ^<footer className="bg-gray-800 text-white p-4 text-center"^>
    echo       ^<p^>© 2024 Knoux React App. All rights reserved.^</p^>
    echo     ^</footer^>
    echo   );
    echo };
    echo.
    echo export default Footer;
) > "%project_path%\src\components\Footer.jsx"

:: Create Button component
(
    echo import React from 'react';
    echo.
    echo const Button = ({ children, onClick, className = '' }) =^> {
    echo   return (
    echo     ^<button
    echo       onClick={onClick}
    echo       className={`bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded ${className}`}
    echo     ^>
    echo       {children}
    echo     ^</button^>
    echo   );
    echo };
    echo.
    echo export default Button;
) > "%project_path%\src\components\Button.jsx"

echo [✓] تم إضافة المكونات الشائعة!
echo [→] Header.jsx
echo [→] Footer.jsx
echo [→] Button.jsx
pause
goto :MAIN_MENU

:ADD_LIBRARIES
echo.
echo [Knoux] إضافة مكتبات إضافية
set /p project_path=مسار المشروع: 
if "%project_path%"=="" (
    echo [✗] يرجى تحديد مسار المشروع!
    pause
    goto :MAIN_MENU
)

echo [→] جاري إضافة مكتبات شائعة...
cd "%project_path%"

echo [→] إضافة React Router...
npm install react-router-dom

echo [→] إضافة Axios...
npm install axios

echo [→] إضافة Lodash...
npm install lodash

echo [→] إضافة Moment.js...
npm install moment

echo [→] إضافة Chart.js...
npm install chart.js react-chartjs-2

echo [✓] تم إضافة المكتبات بنجاح!
cd ..
pause
goto :MAIN_MENU

:START_SERVER
echo.
echo [Knoux] تشغيل الخادم المحلي
set /p project_path=مسار المشروع: 
if "%project_path%"=="" (
    echo [✗] يرجى تحديد مسار المشروع!
    pause
    goto :MAIN_MENU
)

echo [→] جاري تشغيل الخادم...
cd "%project_path%"
start cmd /k "npm start"
cd ..

echo [✓] تم تشغيل الخادم على http://localhost:3000
pause
goto :MAIN_MENU

:LIST_PROJECTS
echo.
echo [Knoux] المشاريع الحالية
echo.
dir /b /ad 2>nul | findstr /v "node_modules"
echo.
pause
goto :MAIN_MENU
