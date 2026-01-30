@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %YELLOW%===================================================%WHITE%
echo %YELLOW%  ⚡ Thunder Client - VS Code API Client%WHITE%
echo %YELLOW%===================================================%WHITE%
echo.

where code >nul 2>&1 || (
    echo %RED%✗ VS Code غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً editors_ides\vscode_setup.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %YELLOW%جارٍ تثبيت Thunder Client...%WHITE%

code --install-extension rangav.vscode-thunder-client >nul 2>&1

if errorlevel 1 (
    echo %RED%✗ فشل التثبيت%WHITE%
    echo %YELLOW%الحل اليدوي: افتح VS Code ← Ctrl+Shift+X ← ابحث عن "Thunder Client"%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

echo %CYAN%مزايا Thunder Client:%WHITE%
echo   ✓ مدمج مع VS Code (لا يحتاج تطبيق منفصل)
echo   ✓ دعم كامل لجميع أنواع الطلبات HTTP
echo   ✓ إدارة البيئات والمتغيرات
echo   ✓ مزامنة مع Git
echo   ✓ دعم JavaScript Tests
echo   ✓ تصدير/استيراد المجموعات
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. افتح VS Code
echo   2. Ctrl+Shift+P ← اكتب "Thunder Client"
echo   3. اختر "Thunder Client: Open Thunder Client"
echo   4. أنشئ أول طلب API
echo.
echo %CYAN%أوامر VS Code:%WHITE%
echo   Ctrl+Shift+P → "Thunder Client: Open Thunder Client"
echo   Ctrl+Shift+P → "Thunder Client: Import Collection"
echo   Ctrl+Shift+P → "Thunder Client: Export Collection"

:: إنشاء ملف تعليمات داخل VS Code
(
echo # Thunder Client Guide
echo 
echo ## Getting Started
echo 1. Open VS Code
echo 2. Press Ctrl+Shift+P
echo 3. Type: Thunder Client
echo 4. Select: Open Thunder Client
echo 
echo ## Features
echo - HTTP Request Testing
echo - Environment Variables
echo - Request Collections
echo - Response History
echo - Tests (JavaScript)
echo - Git Integration
) > "%USERPROFILE%\thunder-client-guide.md"

echo %GREEN%✓ تم إنشاء ملف تعليمات%WHITE%

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Thunder Client VS Code extension >> "!LOG_FILE!"

timeout /t 6 >nul
