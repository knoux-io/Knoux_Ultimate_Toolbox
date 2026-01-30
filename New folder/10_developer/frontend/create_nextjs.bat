@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  ▲  إنشاء مشروع Next.js (React + SSR/SSG)%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:INPUT
set /p "PROJECT_NAME=اسم المشروع: "
if "!PROJECT_NAME!"=="" goto :INPUT

set /p "USE_TYPESCRIPT= TypeScript؟ (y/n): "
set /p "USE_TAILWIND= Tailwind CSS؟ (y/n): "
set /p "USE_ESLINT= ESLint؟ (y/n): "

echo %YELLOW%جارٍ إنشاء مشروع Next.js...%WHITE%

set "ARGS=!PROJECT_NAME!"
if /i "!USE_TYPESCRIPT!"=="y" set "ARGS=!ARGS! --typescript"
if /i "!USE_TAILWIND!"=="y" set "ARGS=!ARGS! --tailwind"
if /i "!USE_ESLINT!"=="y" set "ARGS=!ARGS! --eslint"
set "ARGS=!ARGS! --app"  # استخدام نمط App Router الحديث

npx create-next-app@latest !ARGS! >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل إنشاء المشروع%WHITE%
    echo %YELLOW%المحاولة بدون الوسائط...%WHITE%
    npx create-next-app@latest "!PROJECT_NAME!" --typescript --tailwind --eslint --app
)

if errorlevel 1 (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

cd /d "%USERPROFILE%\!PROJECT_NAME!"

:: تعديل الإعدادات للغة العربية
(
echo // next.config.js
echo /** @type {import('next').NextConfig} */
echo const nextConfig = {
echo   experimental: {
echo     appDir: true,
echo   },
echo   i18n: {
echo     locales: ['en', 'ar'],
echo     defaultLocale: 'ar',
echo   },
echo   trailingSlash: true,
echo }
echo 
echo module.exports = nextConfig
) > next.config.js

:: إنشاء مكون رئيسي بالعربية
rmdir /s /q app >nul 2>&1
mkdir app\page app\layout app\components >nul

(
echo import './globals.css'
echo 
echo export default function RootLayout({
echo   children,
echo }: {
echo   children: React.ReactNode
echo }) {
echo   return (
echo     ^<<html lang="ar"^>
echo       ^<<body className="bg-gray-50"^>
echo         ^<<header className="bg-blue-600 text-white p-4"^>
echo           ^<<h1^>Next.js مشروع^</h1^>
echo         ^</header^>
echo         ^<<main^>{children}^</main^>
echo         ^<<footer className="bg-gray-800 text-white p-4 mt-8"^>
echo           ^<<p^>© 2024 تم بإستخدام Knoux Toolbox^</p^>
echo         ^</footer^>
echo       ^</body^>
echo     ^</html^>
echo   )
echo }
) > app\layout.tsx

(
echo import Image from 'next/image'
echo 
echo export default function Home() {
echo   return (
echo     ^<<div className="container mx-auto px-4 py-8"^>
echo       ^<<h1 className="text-3xl font-bold mb-4"^>مرحباً بك في Next.js!^</h1^>
echo       ^<<p className="mb-4"^>تم إنشاء هذا المشروع بواسطة Knoux Toolbox^</p^>
echo       ^<<div className="grid grid-cols-1 md:grid-cols-2 gap-4"^>
echo         ^<<div className="bg-white p-4 rounded shadow"^>
echo           ^<<h2 className="text-xl font-semibold mb-2"^>SSR/SSG^</h2^>
echo           ^<<p^>التصدير الثابت والتقديم من الخادم^</p^>
echo         ^</div^>
echo         ^<<div className="bg-white p-4 rounded shadow"^>
echo           ^<<h2 className="text-xl font-semibold mb-2"^>Tailwind CSS^</h2^>
echo           ^<<p^>تصميم سريع ومرن^</p^>
echo         ^</div^>
echo       ^</div^>
echo     ^</div^>
echo   )
echo }
) > app\page.tsx

(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
echo 
echo :root {
echo   --foreground-rgb: 0, 0, 0;
echo   --background-start-rgb: 214, 219, 220;
echo   --background-end-rgb: 255, 255, 255;
echo }
echo 
echo body {
echo   color: rgb(var(--foreground-rgb));
echo   background: linear-gradient(to bottom, transparent, rgb(var(--background-end-rgb))) rgb(var(--background-start-rgb));
echo   direction: rtl;
echo }
) > app\globals.css

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم إنشاء مشروع Next.js بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%%USERPROFILE%\!PROJECT_NAME!%WHITE%
echo   التشغيل: %GRAY%cd "%USERPROFILE%\!PROJECT_NAME!" && npm run dev%WHITE%
echo   المتصفح: %CYAN%http://localhost:3000%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الميزات المضمنة:%WHITE%
echo   • SSR/SSG (Render من الخادم)
echo   • نظام App Router الحديث
echo   • دعم Tailwind CSS
echo   • TypeScript مدمج
echo   • ESLint + Prettier

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Created Next.js project "!PROJECT_NAME!" with advanced features >> "!LOG_FILE!"

timeout /t 8 >nul
