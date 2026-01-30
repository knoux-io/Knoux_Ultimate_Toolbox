@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  ⚛️  إنشاء مشروع React جديد%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:INPUT
set /p "PROJECT_NAME=اسم المشروع (استخدم حروف صغيرة وواصلات): "
if "!PROJECT_NAME!"=="" goto :INPUT

set /p "USE_TYPESCRIPT=هل تريد استخدام TypeScript؟ (y/n): "
set /p "USE_ROUTER=هل تريد تثبيت React Router؟ (y/n): "
set /p "USE_STYLES=نظام التصميم: [1] CSS [2] SCSS [3] Tailwind [4] styled-components: "

:: التحقق من وجود المشروع
if exist "%USERPROFILE%\!PROJECT_NAME!" (
    echo %RED%✗ يوجد مجلد بنفس الاسم%WHITE%
    set /p "OVERWRITE=هل تريد الكتابة فوقه؟ (y/n): "
    if /i "!OVERWRITE!" neq "y" exit /b 0
    rmdir /s /q "%USERPROFILE%\!PROJECT_NAME!" >nul 2>&1
)

:: إنشاء المشروع
echo %YELLOW%جارٍ إنشاء المشروع...%WHITE%
if /i "!USE_TYPESCRIPT!"=="y" (
    npx create-react-app "!PROJECT_NAME!" --template typescript
) else (
    npx create-react-app "!PROJECT_NAME!"
)

if errorlevel 1 (
    echo %RED%✗ فشل إنشاء المشروع%WHITE%
    exit /b 1
)

cd /d "%USERPROFILE%\!PROJECT_NAME!"

:: تثبيت React Router
if /i "!USE_ROUTER!"=="y" (
    echo %YELLOW%جارٍ تثبيت React Router...%WHITE%
    npm install react-router-dom
    npm install -D @types/react-router-dom
)

:: تثبيت أنظمة التصميم
if "!USE_STYLES!"=="2" (
    echo %YELLOW%جارٍ تثبيت SCSS...%WHITE%
    npm install sass
)
if "!USE_STYLES!"=="3" (
    echo %YELLOW%جارٍ تثبيت Tailwind CSS...%WHITE%
    npm install -D tailwindcss postcss autoprefixer
    npx tailwindcss init -p
    (
    echo module.exports = {
    echo   content: [
    echo     "./src/**/*.{js,jsx,ts,tsx}",
    echo   ],
    echo   theme: {
    echo     extend: {},
    echo   },
    echo   plugins: [],
    echo }
    ) > "tailwind.config.js"
)
if "!USE_STYLES!"=="4" (
    echo %YELLOW%جارٍ تثبيت styled-components...%WHITE%
    npm install styled-components
    npm install -D @types/styled-components
)

:: إنشاء هيكل مشروع مطور
mkdir src\components src\pages src\hooks src\utils src\styles >nul 2>&1

(
echo import React from 'react';
echo import ReactDOM from 'react-dom/client';
echo import './index.css';
echo import App from './App';
echo 
echo const root = ReactDOM.createRoot(document.getElementById('root'));
echo root.render(
echo   ^<<App /^>
echo );
) > src\index.tsx

(
echo import React from 'react';
echo import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
echo import Home from './pages/Home';
echo import About from './pages/About';
echo import './App.css';
echo 
echo function App() {
echo   return (
echo     ^<<Router^>
echo       ^<<Routes^>
echo         ^<<Route path="/" element={^<<Home /^>} /^>
echo         ^<<Route path="/about" element={^<<About /^>} /^>
echo       ^</Routes^>
echo     ^</Router^>
echo   );
echo }
echo 
echo export default App;
) > src\App.tsx

(
echo import React from 'react';
echo 
echo const Home: React.FC = () => {
echo   return (
echo     ^<<div className="home"^>
echo       ^<<h1^>مرحباً بك في مشروع React!^</h1^>
echo       ^<<p^>تم إنشاؤه بواسطة Knoux Toolbox^</p^>
echo     ^</div^>
echo   );
echo };
echo 
echo export default Home;
) > src\pages\Home.tsx

(
echo import React from 'react';
echo 
echo const About: React.FC = () => {
echo   return (
echo     ^<<div className="about"^>
echo       ^<<h1^>عن هذا المشروع^</h1^>
echo       ^<<p^>تم إعداده مع أفضل الممارسات^</p^>
echo     ^</div^>
echo   );
echo };
echo 
echo export default About;
) > src\pages\About.tsx

:: إعداد CSS الأساسي
(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
echo 
echo body {
echo   margin: 0;
echo   font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
echo     'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
echo     sans-serif;
echo   -webkit-font-smoothing: antialiased;
echo   -moz-osx-font-smoothing: grayscale;
echo   direction: rtl;
echo }
) > src\App.css

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم إنشاء مشروع React بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%%USERPROFILE%\!PROJECT_NAME!%WHITE%
echo   التشغيل: %GRAY%cd "%USERPROFILE%\!PROJECT_NAME!" && npm start%WHITE%
echo   الإنتاج: %GRAY%npm run build%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الخطوات التالية:%WHITE%
echo   1. cd "%USERPROFILE%\!PROJECT_NAME!"
echo   2. npm start ← لبدء الخادم التنموي
echo   3. افتح المتصفح: http://localhost:3000
echo   4. ابدأ بالتعديل في src\App.tsx

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Created React project "!PROJECT_NAME!" with advanced setup >> "!LOG_FILE!"

timeout /t 8 >nul
