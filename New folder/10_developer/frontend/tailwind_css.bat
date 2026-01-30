@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🎨  تثبيت وتهيئة Tailwind CSS%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] تثبيت في مشروع جديد
echo   [2] تثبيت في مشروع موجود
echo   [3] إنشاء مشروع HTML بسيط مع Tailwind
echo   [4] إنشاء مشروع React مع Tailwind
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :NEW_PROJECT
if "!CHOICE!"=="2" goto :EXISTING_PROJECT
if "!CHOICE!"=="3" goto :HTML_PROJECT
if "!CHOICE!"=="4" goto :REACT_WITH_TAILWIND
goto :MENU

:NEW_PROJECT
set /p "PROJECT_NAME=اسم المشروع: "
mkdir "%USERPROFILE%\!PROJECT_NAME!" >nul 2>&1
cd /d "%USERPROFILE%\!PROJECT_NAME!"

echo %YELLOW%جارٍ إنشاء مشروع جديد مع Tailwind...%WHITE%

(
echo {
echo   "name": "!PROJECT_NAME!",
echo   "version": "1.0.0",
echo   "scripts": {
echo     "dev": "npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch",
echo     "build": "npx tailwindcss -i ./src/input.css -o ./dist/output.css --minify"
echo   }
echo }
) > package.json

npm install -D tailwindcss postcss autoprefixer >nul 2>&1
npx tailwindcss init -p >nul 2>&1

mkdir src dist >nul 2>&1

(
echo /** @type {import('tailwindcss').Config} */
echo module.exports = {
echo   content: ["./src/**/*.{html,js}"],
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
) > src\input.css

(
echo ^<!DOCTYPE html^>
echo ^<html lang="ar" dir="rtl"^>
echo ^<head^>
echo   ^<meta charset="UTF-8"^>
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo   ^<title^>Tailwind CSS جاهز^</title^>
echo   ^<link href="./dist/output.css" rel="stylesheet"^>
echo ^</head^>
echo ^<body class="bg-gray-100 text-center p-8"^>
echo   ^<div class="max-w-4xl mx-auto"^>
echo     ^<h1 class="text-4xl font-bold text-red-600 mb-4"^>Tailwind CSS يعمل!^</h1^>
echo     ^<p class="text-lg text-gray-700 mb-8"^>تم الإعداد بواسطة Knoux Toolbox^</p^>
echo     ^<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"^>
echo       زر مثال
echo     ^</button^>
echo   ^</div^>
echo ^</body^>
echo ^</html^>
) > index.html

echo %GREEN%✓ تم إنشاء المشروع مع Tailwind CSS%WHITE%
echo %YELLOW%التشغيل:%WHITE% cd "%USERPROFILE%\!PROJECT_NAME!" && npm run dev
goto :MENU

:EXISTING_PROJECT
set /p "PROJECT_PATH=مسار المشروع الحالي: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المجلد غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
npm install -D tailwindcss postcss autoprefixer >nul 2>&1
npx tailwindcss init -p >nul 2>&1

echo %GREEN%✓ تم تثبيت Tailwind CSS في المشروع%WHITE%
echo %YELLOW%الخطوات التالية:%WHITE%
echo   1. تعديل tailwind.config.js لتحديد ملفات المحتوى
echo   2. إضافة @tailwind rules إلى ملف CSS
echo   3. تشغيل watch: npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch
goto :MENU

:HTML_PROJECT
set /p "PROJECT_NAME=اسم المشروع: "
mkdir "%USERPROFILE%\!PROJECT_NAME!" >nul 2>&1
cd /d "%USERPROFILE%\!PROJECT_NAME!"

npm install -D tailwindcss >nul 2>&1
npx tailwindcss init >nul 2>&1

(
echo /** @type {import('tailwindcss').Config} */
echo module.exports = {
echo   content: ["./**/*.html"],
echo   theme: {
echo     extend: {},
echo   },
echo   plugins: [],
echo }
) > tailwind.config.js

(
echo ^<!DOCTYPE html^>
echo ^<html lang="ar" dir="rtl"^>
echo ^<head^>
echo   ^<meta charset="UTF-8"^>
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo   ^<title^>Project !PROJECT_NAME!^</title^>
echo   ^<script src="https://cdn.tailwindcss.com"^></script^>
echo ^</head^>
echo ^<body class="bg-gray-50 min-h-screen flex items-center justify-center"^>
echo   ^<div class="text-center"^>
echo     ^<h1 class="text-5xl font-bold text-indigo-600 mb-6"^>!PROJECT_NAME!^</h1^>
echo     ^<p class="text-xl text-gray-600 mb-8"^>Tailwind CSS جاهز للاستخدام^</p^>
echo     ^<div class="flex justify-center space-x-4"^>
echo       ^<button class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-lg transition"^>ابدأ^</button^>
echo       ^<button class="border border-blue-500 text-blue-500 hover:bg-blue-50 px-6 py-3 rounded-lg transition"^>تعلم^</button^>
echo     ^</div^>
echo   ^</div^>
echo ^</body^>
echo ^</html^>
) > index.html

echo %GREEN%✓ تم إنشاء مشروع HTML مع Tailwind CSS%WHITE%
echo %YELLOW%افتح index.html في المتصفح لرؤية النتيجة%WHITE%
goto :MENU

:REACT_WITH_TAILWIND
echo %YELLOW%جارٍ إنشاء مشروع React مع Tailwind CSS...%WHITE%
call "%~dp0create_react.bat"
:: تعديل المشروع لدمج Tailwind
cd /d "%USERPROFILE%\!PROJECT_NAME!" 2>nul
npm install -D tailwindcss postcss autoprefixer >nul 2>&1
npx tailwindcss init -p >nul 2>&1

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
) > src\tailwind.css

:: تعديل App.css ليشمل Tailwind
echo @import './tailwind.css'; > src\App.css

echo %GREEN%✓ تم دمج Tailwind CSS مع مشروع React%WHITE%
goto :MENU
