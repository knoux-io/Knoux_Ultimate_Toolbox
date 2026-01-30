@echo off
:: =================================================================
:: KNOUX JAVA JDK 21 INSTALLER
:: تثبيت Java JDK 21 مع ضبط JAVA_HOME تلقائي
:: =================================================================
title Knoux - Java JDK 21 Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX JAVA JDK 21 + AUTO CONFIGURATOR
echo   تثبيت Java JDK 21 مع ضبط تلقائي
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Java JDK 21...
winget install Oracle.JDK.21 --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe' -OutFile '$env:TEMP\jdk21.exe'"
    start /wait "" "$env:TEMP\jdk21.exe" /s
)

:: Wait for installation
timeout /t 10 /nobreak >nul

:: Auto-detect Java installation
echo [Knoux] جاري اكتشاف تثبيت Java تلقائياً...
set "JAVA_FOUND=0"
set "JAVA_PATH="

for /d %%i in ("C:\Program Files\Java\jdk-21*") do (
    if exist "%%i\bin\java.exe" (
        set "JAVA_PATH=%%i"
        set "JAVA_FOUND=1"
        goto :JAVA_FOUND
    )
)

:JAVA_FOUND
if %JAVA_FOUND%==1 (
    echo [✓] تم العثور على Java JDK 21 في: %JAVA_PATH%
    
    :: Set JAVA_HOME
    echo [→] جاري ضبط JAVA_HOME...
    setx JAVA_HOME "%JAVA_PATH%" /M
    set "JAVA_HOME=%JAVA_PATH%"
    
    :: Add Java to PATH
    echo [→] جاري إضافة Java إلى PATH...
    setx PATH "%PATH%;%JAVA_PATH%\bin" /M
    
    echo [✓] تم ضبط بيئة Java بنجاح!
    echo [→] JAVA_HOME: %JAVA_HOME%
) else (
    echo [✗] لم يتم العثور على Java JDK 21!
)

:: Verify installation
echo [→] جاري التحقق من التثبيت...
java -version >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Java command يعمل!
    java -version
) else (
    echo [✗] Java command لا يعمل!
)

echo [✓] تم تثبيت Java JDK 21 بنجاح!
pause
