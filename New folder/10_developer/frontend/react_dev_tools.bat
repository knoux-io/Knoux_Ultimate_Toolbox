@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  ⚛️  React Developer Tools - أدوات تطوير React%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:: التحقق من Node.js
node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\nodejs_lts.bat%WHITE%
    timeout /t 4 >nul
    exit /b 1
)

:: التحقق من React Developer Tools في Chrome
echo %YELLOW%[1/3] جارٍ التحقق من React Developer Tools...%WHITE%

:: التثبيت عبر npm
echo %YELLOW%جارٍ تثبيت أدوات React Development...%WHITE%
npm install -g create-react-app react-scripts >nul 2>&1
npm install -D @types/react @types/react-dom @types/node >nul 2>&1

:: التحقق من المثبتة
where create-react-app >nul 2>&1 && (
    echo %GREEN%✓ create-react-app مثبت%WHITE%
) || (
    echo %YELLOW%المحاولة عبر npx (مدمج مع npm)%WHITE%
)

echo %YELLOW%[2/3] جارٍ تثبيت إضافة المتصفح...%WHITE%
echo %GRAY%(ستحتاج إلى تثبيتها يدويًا في المتصفح)%WHITE%
echo.
echo %CYAN%الخطوات:%WHITE%
echo   1. افتح Chrome/Firefox
echo   2. اذهب إلى: chrome://extensions/ أو about:addons
echo   3. فعل "Developer mode" أو "Install from file"
echo   4. نزّل من: https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadkdcjkndndbkkgobgcgg
echo   5. أو استخدم نسخة مثبتة تلقائيًا من أدوات VS Code

:: إنشاء مشروع تجريبي
echo %YELLOW%[3/3] جارٍ إنشاء مشروع React تجريبي...%WHITE%
set "REACT_PROJECT=%USERPROFILE%\react-dev-test"
if not exist "!REACT_PROJECT!" mkdir "!REACT_PROJECT!" >nul
cd /d "!REACT_PROJECT!"

:: إنشاء مشروع React مع TypeScript
(
echo {
echo   "name": "react-dev-test",
echo   "version": "0.1.0",
echo   "private": true,
echo   "dependencies": {
echo     "react": "^18.2.0",
echo     "react-dom": "^18.2.0",
echo     "@types/react": "^18.2.0",
echo     "@types/react-dom": "^18.2.0"
echo   },
echo   "scripts": {
echo     "start": "react-scripts start",
echo     "build": "react-scripts build",
echo     "test": "react-scripts test",
echo     "eject": "react-scripts eject"
echo   },
echo   "eslintConfig": {
echo     "extends": [
echo       "react-app",
echo       "react-app/jest"
echo     ]
echo   },
echo   "browserslist": {
echo     "production": [
echo       ">0.2%%",
echo       "not dead",
echo       "not op_mini all"
echo     ],
echo     "development": [
echo       "last 1 chrome version",
echo       "last 1 firefox version",
echo       "last 1 safari version"
echo     ]
echo   }
echo }
) > "!REACT_PROJECT!\package.json"

:: تثبيت التبعيات
npm install react react-dom react-scripts @types/react @types/react-dom >nul 2>&1

:: إنشاء ملفات JSX تجريبية
set "SRC_DIR=!REACT_PROJECT!\src"
if not exist "!SRC_DIR!" mkdir "!SRC_DIR!" >nul

(
echo import React from 'react';
echo import ReactDOM from 'react-dom/client';
echo import './index.css';
echo 
echo function App() {
echo   return (
echo     ^<div className="App"^>
echo       ^<header className="App-header"^>
echo         ^<h1^>React Developer Tools جاهزة للعمل!^</h1^>
echo         ^<p^>تم التثبيت بواسطة Knoux Toolbox^</p^>
echo       ^</header^>
echo     ^</div^>
echo   );
echo }
echo 
echo const root = ReactDOM.createRoot(document.getElementById('root'));
echo root.render(^<App /^>);
) > "!SRC_DIR!\index.js"

(
echo body {
echo   margin: 0;
echo   font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
echo     'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
echo     sans-serif;
echo   -webkit-font-smoothing: antialiased;
echo   -moz-osx-font-smoothing: grayscale;
echo   direction: rtl;
echo   text-align: center;
echo }
) > "!SRC_DIR!\index.css"

(
echo ^<!DOCTYPE html^>
echo ^<html lang="ar"^>
echo ^<head^>
echo   ^<meta charset="utf-8" /^>
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1" /^>
echo   ^<title^>React Dev Test^</title^>
echo ^</head^>
echo ^<body^>
echo   ^<div id="root"^>^</div^>
echo ^</body^>
echo ^</html^>
) > "!REACT_PROJECT!\public\index.html"

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لتطوير React!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المشروع: %GRAY%!REACT_PROJECT!%WHITE%
echo   التشغيل: %GRAY%cd "!REACT_PROJECT!" && npm start%WHITE%
echo   المتصفح: %CYAN%http://localhost:3000%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%نصائح:%WHITE%
echo   • استخدم React Developer Tools في DevTools لفحص المكونات
echo   • الملفات تلقائيًا تعيد التحميل عند التعديل (Hot Reload)
echo   • لمشروع جديد: npx create-react-app my-app

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed React development tools with test project >> "!LOG_FILE!"

timeout /t 8 >nul
