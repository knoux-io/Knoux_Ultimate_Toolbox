@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🟢  إنشاء مشروع Vue.js مع Vite%WHITE%
echo %GREEN%===================================================%WHITE%
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
set /p "USE_VUE_ROUTER= Vue Router؟ (y/n): "
set /p "USE_PINIA= Pinia (State Management)؟ (y/n): "

echo %YELLOW%جارٍ إنشاء مشروع Vue.js باستخدام Vite...%WHITE%

:: إنشاء المشروع
if /i "!USE_TYPESCRIPT!"=="y" (
    npx create-vue@latest "!PROJECT_NAME!" --typescript --router --pinia
) else (
    npx create-vue@latest "!PROJECT_NAME!" --router --pinia
)

if errorlevel 1 (
    echo %RED%✗ فشل الإنشاء%WHITE%
    exit /b 1
)

cd /d "%USERPROFILE%\!PROJECT_NAME!"

:: تعديل الإعدادات للعربية
(
echo import { defineConfig } from 'vite'
echo import vue from '@vitejs/plugin-vue'
echo 
echo // https://vitejs.dev/config/
echo export default defineConfig({
echo   plugins: [vue()],
echo   resolve: {
echo     alias: {
echo       '@': '/src',
echo     },
echo   },
echo   css: {
echo     preprocessorOptions: {
echo       scss: {
echo         additionalData: `@import "@/styles/variables.scss";`,
echo       },
echo     },
echo   },
echo })
) > vite.config.ts

:: إنشاء هيكل الملفات بالعربية
mkdir src\styles src\components src\views src\stores >nul

(
echo // src/styles/variables.scss
echo $primary-color: #42b883;
echo $secondary-color: #35495e;
echo $font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
) > src\styles\variables.scss

(
echo @import '../styles/variables.scss';
echo 
echo #app {
echo   font-family: $font-family;
echo   text-align: center;
echo   color: $secondary-color;
echo   direction: rtl;
echo }
) > src\assets\main.scss

(
echo <script setup lang="ts">
echo import HelloWorld from '@/components/HelloWorld.vue'
echo </script>
echo 
echo <template>
echo   <div id="app">
echo     <img alt="Vue logo" src="@/assets/logo.png" />
echo     <HelloWorld msg="مرحباً بك في مشروع Vue.js!" />
echo   </div>
echo </template>
echo 
echo <style lang="scss">
echo @import '@/assets/main.scss';
echo </style>
) > src\App.vue

(
echo <script setup lang="ts">
echo defineProps<{
echo   msg: string
echo }>()
echo </script>
echo 
echo <template>
echo   <div class="greetings">
echo     <h1 class="green">{{ msg }}</h1>
echo     <h3>
echo       You've successfully created a project with
echo       <a href="https://vitejs.dev/" target="_blank" rel="noopener">Vite</a> +
echo       <a href="https://vuejs.org/" target="_blank" rel="noopener">Vue 3</a>.
echo     </h3>
echo   </div>
echo </template>
echo 
echo <style scoped lang="scss">
echo h1 {
echo   font-weight: 500;
echo   font-size: 2.6rem;
echo   top: -10px;
echo }
echo 
echo h3 {
echo   font-size: 1.2rem;
echo }
echo 
echo .greetings h1,
echo .greetings h3 {
echo   text-align: center;
echo }
echo 
echo @media (min-width: 1024px) {
echo   .greetings h1,
echo   .greetings h3 {
echo     text-align: left;
echo   }
echo }
echo </style>
) > src\components\HelloWorld.vue

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم إنشاء مشروع Vue.js بنجاح!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   المسار: %GRAY%%USERPROFILE%\!PROJECT_NAME!%WHITE%
echo   التشغيل: %GRAY%cd "%USERPROFILE%\!PROJECT_NAME!" && npm run dev%WHITE%
echo   المتصفح: %CYAN%http://localhost:5173%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %YELLOW%الميزات:%WHITE%
echo   • Vite (Build سريع جداً)
echo   • Vue 3 Composition API
echo   • TypeScript (إذا تم اختياره)
echo   • Vue Router للتنقل بين الصفحات
echo   • Pinia لادارة الحالة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Created Vue.js project "!PROJECT_NAME!" with Vite and advanced features >> "!LOG_FILE!"

timeout /t 8 >nul
