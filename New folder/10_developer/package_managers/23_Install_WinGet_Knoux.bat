@echo off
:: =================================================================
:: KNOUX WINGET PACKAGE MANAGER
:: تثبيت WinGet مع مدير الملفات الشخصية
:: =================================================================
title Knoux - WinGet Package Manager

echo ═══════════════════════════════════════════════════════════
echo   KNOUX WINGET + PROFILE MANAGER
echo   تثبيت WinGet مع مدير الملفات الشخصية
echo ═══════════════════════════════════════════════════════════
echo.

:: Check if WinGet is already installed
echo [Knoux] جاري فحص WinGet...
where winget >nul 2>&1
if %errorlevel% equ 0 (
    echo [!] WinGet مثبت مسبقاً!
    winget --version
    echo.
    goto :WINGET_MENU
)

:: Install WinGet
echo [→] جاري تثبيت WinGet...
powershell -Command "Get-AppxPackage -Name 'Microsoft.DesktopAppInstaller' | Foreach-Object {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppxManifest.xml'}"

echo [→] جاري تحديث WinGet...
winget upgrade --id Microsoft.AppInstaller --source winget

echo [✓] تم تثبيت WinGet!
winget --version

:WINGET_MENU
cls
echo ═══════════════════════════════════════════════════════════
echo         KNOUX WINGET MANAGER - مدير WinGet
echo ═══════════════════════════════════════════════════════════
echo.
echo [1] عرض الحزم المتاحة
echo [2] البحث عن حزمة
echo [3] تثبيت حزمة
echo [4] تحديث حزمة
echo [5] إزالة حزمة
echo [6] عرض الحزم المثبتة
echo [7] تحديث جميع الحزم
echo [8] تصدير قائمة الحزم
echo [9] استيراد قائمة الحزم
echo [0] العودة
echo.
set /p choice=اختر الخيار: 

if "%choice%"=="1" goto :SHOW_AVAILABLE
if "%choice%"=="2" goto :SEARCH_PACKAGE
if "%choice%"=="3" goto :INSTALL_PACKAGE
if "%choice%"=="4" goto :UPDATE_PACKAGE
if "%choice%"=="5" goto :REMOVE_PACKAGE
if "%choice%"=="6" goto :LIST_INSTALLED
if "%choice%"=="7" goto :UPDATE_ALL
if "%choice%"=="8" goto :EXPORT_PACKAGES
if "%choice%"=="9" goto :IMPORT_PACKAGES
if "%choice%"=="0" exit /b
goto :WINGET_MENU

:SHOW_AVAILABLE
echo.
echo [→] جاري عرض الحزم المتاحة...
winget search ""
pause
goto :WINGET_MENU

:SEARCH_PACKAGE
set /p package_name=أدخل اسم الحزمة للبحث: 
echo.
echo [→] جاري البحث عن: %package_name%
winget search %package_name%
pause
goto :WINGET_MENU

:INSTALL_PACKAGE
set /p package_id=أدخل معرف الحزمة: 
set /p package_source=مصدر الحزمة (winget/msstore/wingetdirect) [winget]: 
if "%package_source%"=="" set "package_source=winget"

echo [→] جاري تثبيت: %package_id%
winget install %package_id% --source %package_source%
pause
goto :WINGET_MENU

:UPDATE_PACKAGE
set /p package_id=أدخل معرف الحزمة للتحديث: 
echo [→] جاري تحديث: %package_id%
winget upgrade %package_id%
pause
goto :WINGET_MENU

:REMOVE_PACKAGE
set /p package_id=أدخل معرف الحزمة للإزالة: 
echo [→] جاري إزالة: %package_id%
winget uninstall %package_id%
pause
goto :WINGET_MENU

:LIST_INSTALLED
echo.
echo [→] جاري عرض الحزم المثبتة...
winget list
pause
goto :WINGET_MENU

:UPDATE_ALL
echo.
echo [→] جاري تحديث جميع الحزم...
winget upgrade --all
pause
goto :WINGET_MENU

:EXPORT_PACKAGES
echo.
echo [→] جاري تصدير قائمة الحزم...
winget list > winget_packages.txt
echo [✓] تم حفظ القائمة في: winget_packages.txt
pause
goto :WINGET_MENU

:IMPORT_PACKAGES
echo.
echo [→] جاري استيراد قائمة الحزم...
if exist winget_packages.txt (
    echo [→] تثبيت الحزم من القائمة...
    for /f "tokens=1,2" %%a in (winget_packages.txt) do (
        echo [→] تثبيت: %%a
        winget install %%a
    )
    echo [✓] تم استيراد الحزم!
) else (
    echo [✗] لم يتم العثور على ملف winget_packages.txt
)
pause
goto :WINGET_MENU
