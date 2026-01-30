@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %BLUE%===================================================%WHITE%
echo %BLUE%  🅱️  Bootstrap 5 - إطار عمل التصميم الشهير%WHITE%
echo %BLUE%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] إنشاء مشروع HTML بسيط مع Bootstrap
echo   [2] تثبيت في مشروع React
echo   [3] تثبيت في مشروع Angular
echo   [4] تثبيت في مشروع Vue.js
echo   [5] تحميل الإصدار الكامل محليًا
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :HTML_PROJECT
if "!CHOICE!"=="2" goto :REACT_PROJECT
if "!CHOICE!"=="3" goto :ANGULAR_PROJECT
if "!CHOICE!"=="4" goto :VUE_PROJECT
if "!CHOICE!"=="5" goto :DOWNLOAD_LOCAL
goto :MENU

:HTML_PROJECT
set /p "PROJECT_NAME=اسم المشروع: "
mkdir "%USERPROFILE%\!PROJECT_NAME!" >nul 2>&1
cd /d "%USERPROFILE%\!PROJECT_NAME!"

(
echo ^<!DOCTYPE html^>
echo ^<html lang="ar" dir="rtl"^>
echo ^<head^>
echo   ^<meta charset="UTF-8"^>
echo   ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo   ^<title^>Bootstrap Project^</title^>
echo   ^<!-- Bootstrap CSS --^>
echo   ^<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"^>
echo   ^<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet"^>
echo ^</head^>
echo ^<body^>
echo   ^<nav class="navbar navbar-expand-lg navbar-dark bg-primary"^>
echo     ^<div class="container"^>
echo       ^<a class="navbar-brand" href="#"^>Bootstrap^</a^>
echo       ^<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"^>
echo         ^<span class="navbar-toggler-icon"^>^</span^>
echo       ^</button^>
echo       ^<div class="collapse navbar-collapse" id="navbarNav"^>
echo         ^<ul class="navbar-nav"^>
echo           ^<li class="nav-item"^>
echo             ^<a class="nav-link active" href="#"^>الرئيسية^</a^>
echo           ^</li^>
echo           ^<li class="nav-item"^>
echo             ^<a class="nav-link" href="#"^>حول^</a^>
echo           ^</li^>
echo         ^</ul^>
echo       ^</div^>
echo     ^</div^>
echo   ^</nav^>
echo 
echo   ^<div class="container mt-5"^>
echo     ^<div class="row"^>
echo       ^<div class="col-md-12 text-center"^>
echo         ^<h1 class="display-4 text-primary"^>Bootstrap جاهز للعمل^</h1^>
echo         ^<p class="lead"^>تم الإعداد بواسطة Knoux Toolbox^</p^>
echo         ^<div class="mt-4"^>
echo           ^<button class="btn btn-primary me-2"^>
echo             ^<i class="bi bi-play-circle"^>^</i^> ابدأ
echo           ^</button^>
echo           ^<button class="btn btn-outline-secondary"^>
echo             ^<i class="bi bi-info-circle"^>^</i^> معلومات
echo           ^</button^>
echo         ^</div^>
echo       ^</div^>
echo     ^</div^>
echo   ^</div^>
echo 
echo   ^<!-- Bootstrap JS --^>
echo   ^<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"^>^</script^>
echo ^</body^>
echo ^</html^>
) > index.html

echo %GREEN%✓ تم إنشاء مشروع HTML مع Bootstrap%WHITE%
echo %YELLOW%افتح index.html في المتصفح لرؤية النتيجة%WHITE%
goto :MENU

:REACT_PROJECT
echo %YELLOW%جارٍ تثبيت Bootstrap في مشروع React...%WHITE%
set /p "PROJECT_PATH=مسار مشروع React: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
npm install bootstrap >nul 2>&1
npm install react-bootstrap bootstrap >nul 2>&1

:: تعديل App.js/App.tsx لاستخدام Bootstrap
(
echo import 'bootstrap/dist/css/bootstrap.min.css';
echo import { Container, Row, Col, Button, Navbar, Nav } from 'react-bootstrap';
echo import './App.css';
echo 
echo function App() {
echo   return (
echo     ^<<Navbar bg="dark" variant="dark" expand="lg"^>
echo       ^<<Container^>
echo         ^<<Navbar.Brand href="#home"^>Bootstrap^</Navbar.Brand^>
echo         ^<<Navbar.Toggle aria-controls="basic-navbar-nav" /^>
echo         ^<<Navbar.Collapse id="basic-navbar-nav"^>
echo           ^<<Nav className="me-auto"^>
echo             ^<<Nav.Link href="#home"^>الرئيسية^</Nav.Link^>
echo             ^<<Nav.Link href="#about"^>حول^</Nav.Link^>
echo           ^</Nav^>
echo         ^</Navbar.Collapse^>
echo       ^</Container^>
echo     ^</Navbar^>
echo     ^<<Container className="mt-4"^>
echo       ^<<Row^>
echo         ^<<Col^>
echo           ^<<h1 className="text-primary"^>Bootstrap مع React^</h1^>
echo           ^<<Button variant="primary"^>زر Bootstrap^</Button^>
echo         ^</Col^>
echo       ^</Row^>
echo     ^</Container^>
echo   );
echo }
echo 
echo export default App;
) > src\App.js

echo %GREEN%✓ تم تثبيت Bootstrap في مشروع React%WHITE%
goto :MENU

:ANGULAR_PROJECT
echo %YELLOW%جارٍ تثبيت Bootstrap في مشروع Angular...%WHITE%
set /p "PROJECT_PATH=مسار مشروع Angular: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
ng add @ng-bootstrap/ng-bootstrap >nul 2>&1

:: تعديل angular.json لإضاف Bootstrap
powershell -Command "(Get-Content 'angular.json' -Raw) -replace '\"styles\": \[', '\"styles\": [\"node_modules/bootstrap/dist/css/bootstrap.min.css\", '" | Set-Content 'angular.json'" >nul 2>&1

echo %GREEN%✓ تم تثبيت Bootstrap في مشروع Angular%WHITE%
goto :MENU

:VUE_PROJECT
echo %YELLOW%جارٍ تثبيت Bootstrap في مشروع Vue.js...%WHITE%
set /p "PROJECT_PATH=مسار مشروع Vue.js: "
if not exist "!PROJECT_PATH!" (
    echo %RED%✗ المشروع غير موجود%WHITE%
    goto :MENU
)

cd /d "!PROJECT_PATH!"
npm install bootstrap >nul 2>&1
npm install vue3-bootstrap >nul 2>&1

:: إضافة Bootstrap إلى main.js
powershell -Command "Add-Content 'src/main.js' 'import 'bootstrap/dist/css/bootstrap.min.css''" >nul 2>&1

echo %GREEN%✓ تم تثبيت Bootstrap في مشروع Vue.js%WHITE%
goto :MENU

:DOWNLOAD_LOCAL
echo %YELLOW%جارٍ تحميل Bootstrap محليًا...%WHITE%
set "BOOTSTRAP_DIR=%USERPROFILE%\bootstrap"
if not exist "!BOOTSTRAP_DIR!" mkdir "!BOOTSTRAP_DIR!" >nul

powershell -Command "Invoke-WebRequest -Uri 'https://github.com/twbs/bootstrap/releases/download/v5.3.2/bootstrap-5.3.2-dist.zip' -OutFile '%TEMP%\bootstrap.zip'" >nul 2>&1
powershell -Command "Expand-Archive -Path '%TEMP%\bootstrap.zip' -DestinationPath '!BOOTSTRAP_DIR!' -Force" >nul 2>&1
del "%TEMP%\bootstrap.zip" >nul 2>&1

echo %GREEN%✓ تم تحميل Bootstrap إلى: !BOOTSTRAP_DIR!%WHITE%
echo %CYAN%الملفات:%WHITE%
echo   - !BOOTSTRAP_DIR!\bootstrap-5.3.2-dist\css
echo   - !BOOTSTRAP_DIR!\bootstrap-5.3.2-dist\js
goto :MENU
