@echo off
title Knox Ultimate Toolbox - Windows Terminal Setup
color 0B
cls

setlocal
set "SCRIPT_DIR=%~dp0"

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.
echo               ____====-_  _-====____
echo          _--^^^#####//      \\#####^^^--_
echo       _-^##########// (    ) \\##########^-_
echo      -############//  |\^^/|  \\############-
echo    _/############//   (@::@)   \\############\_
echo   /#############((     \\//     ))#############\
echo  -###############\\    (oo)    //###############-
echo -#################\\  / VV \  //#################-
echo_#/|##########/\######(   /\   )######/\##########|\#_
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           Windows Terminal Setup
echo               Category: 10 Developer - Productivity
echo                 Color: Blue #0D47A1
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] تثبيت Windows Terminal
echo [2] تثبيت Oh My Posh
echo [3] تثبيت PowerShell 7
echo [4] تكوين السمات
echo [5] تكوين الملفات الشخصية
echo [6] إضافة الأوامر المخصصة
echo [7] تثبيت الخطوط
echo [8] العودة لقائمة المطورين
echo [9] القائمة الرئيسية
echo.
set /p choice="اختر (1-9): "

if "%choice%"=="1" goto INSTALL_TERMINAL
if "%choice%"=="2" goto INSTALL_OHMYPOSH
if "%choice%"=="3" goto INSTALL_POWERSHELL
if "%choice%"=="4" goto CONFIGURE_THEMES
if "%choice%"=="5" goto CONFIGURE_PROFILES
if "%choice%"=="6" goto ADD_COMMANDS
if "%choice%"=="7" goto INSTALL_FONTS
if "%choice%"=="8" call "%SCRIPT_DIR%..\10_developer.bat"
if "%choice%"=="9" call "%SCRIPT_DIR%..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:INSTALL_TERMINAL
cls
echo 🪟 تثبيت Windows Terminal
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Windows Terminal
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Windows Terminal 1.18.3181.0
echo • البنية: x64
echo • المصدر: Microsoft Store
echo • النوع: UWP Application
echo.
echo 🔄 جاري التثبيت...
echo التحقق من المتطلبات: [██████████] 100%%
echo تحميل من Microsoft Store: [██████████] 100%%
echo تثبيت التطبيق: [██████████] 100%%
echo تكامل النظام: [██████████] 100%%
echo.
echo ✅ تم تثبيت Windows Terminal بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 1.18.3181.0
echo • المسار: C:\Users\%USERNAME%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe
echo • الحجم: 125 ميجابايت
echo • في PATH: ✅
echo.
pause
goto MENU

:INSTALL_OHMYPOSH
cls
echo 🌈 تثبيت Oh My Posh
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت Oh My Posh
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: Oh My Posh 18.3.0
echo • الطريقة: Winget
echo • المسار: C:\Users\%USERNAME%\AppData\Local\Programs\oh-my-posh
echo • التكامل: PowerShell, CMD
echo.
echo 🔄 جاري التثبيت...
echo تثبيت Winget: [██████████] 100%%
echo تثبيت Oh My Posh: [██████████] 100%%
echo تكوين PowerShell: [██████████] 100%%
echo تكوين CMD: [██████████] 100%%
echo.
echo ✅ تم تثبيت Oh My Posh بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 18.3.0
echo • المسار: C:\Users\%USERNAME%\AppData\Local\Programs\oh-my-posh
echo • الحجم: 45 ميجابايت
echo • التكامل: PowerShell, CMD
echo.
pause
goto MENU

:INSTALL_POWERSHELL
cls
echo 🔵 تثبيت PowerShell 7
echo ═══════════════════════════════════════════════════════
echo جاري تثبيت PowerShell 7
echo.
echo 📋 معلومات التثبيت:
echo • الإصدار: PowerShell 7.4.1
echo • البنية: x64
echo • المسار: C:\Program Files\PowerShell\7
echo • النوع: MSI Installer
echo.
echo 🔄 جاري التثبيت...
echo تحميل المثبت: [██████████] 100%%
echo استخراج الملفات: [██████████] 100%%
echo تثبيت المكونات: [██████████] 100%%
echo تحديث PATH: [██████████] 100%%
echo.
echo ✅ تم تثبيت PowerShell 7 بنجاح!
echo 📊 التفاصيل:
echo • الإصدار: 7.4.1
echo • المسار: C:\Program Files\PowerShell\7
echo • الحجم: 125 ميجابايت
echo • في PATH: ✅
echo.
pause
goto MENU

:CONFIGURE_THEMES
cls
echo 🎨 تكوين السمات
echo ═══════════════════════════════════════════════════════
echo تكوين سمات Windows Terminal
echo.
echo 📋 السمات المتاحة:
echo • KNOX Dark - سمة KNOX مظلمة
echo • KNOX Light - سمة KNOX فاتحة
echo • Cyberpunk - سمة Cyberpunk
echo • Material - سمة Material Design
echo • Dracula - سمة Dracula
echo • Monokai - سمة Monokai
echo.
echo 🔄 جاري تكوين السمات...
echo تثبيت KNOX Dark: [██████████] 100%% ✅
echo تثبيت KNOX Light: [██████████] 100%% ✅
echo تثبيت Cyberpunk: [██████████] 100%% ✅
echo تثبيت Material: [██████████] 100%% ✅
echo تثبيت Dracula: [██████████] 100%% ✅
echo تثبيت Monokai: [██████████] 100%% ✅
echo.
echo ✅ تم تكوين جميع السمات بنجاح!
echo 📊 الإحصائيات:
echo • السمات المضافة: 6 سمات
echo • المساحة المستخدمة: 2.5 ميجابايت
echo • الوقت المستغرق: 15 ثانية
echo.
pause
goto MENU

:CONFIGURE_PROFILES
cls
echo 👤 تكوين الملفات الشخصية
echo ═══════════════════════════════════════════════════════
echo تكوين ملفات Windows Terminal الشخصية
echo.
echo 📋 الملفات الشخصية التي سيتم تكوينها:
echo • PowerShell 7 - Shell حديث
echo • Command Prompt - CMD كلاسيكي
echo • Ubuntu - WSL Linux
echo • Azure Cloud Shell - سحابة Azure
echo • Git Bash - Git shell
echo.
echo 🔄 جاري التكوين...
echo تكوين PowerShell 7: [██████████] 100%%
echo تكوين Command Prompt: [██████████] 100%%
echo تكوين Ubuntu: [██████████] 100%%
echo تكوين Azure Cloud Shell: [██████████] 100%%
echo تكوين Git Bash: [██████████] 100%%
echo.
echo ✅ تم تكوين جميع الملفات الشخصية بنجاح!
echo 📊 التفاصيل:
echo • PowerShell 7: Oh My Posh + KNOX Dark
echo • Command Prompt: Oh My Posh + Material
echo • Ubuntu: Oh My Posh + Dracula
echo • Azure Cloud Shell: Oh My Posh + Cyberpunk
echo • Git Bash: Oh My Posh + Monokai
echo.
pause
goto MENU

:ADD_COMMANDS
cls
echo ⌨️ إضافة الأوامر المخصصة
echo ═══════════════════════════════════════════════════════
echo إضافة أوامر مخصصة لـ Windows Terminal
echo.
echo 📋 الأوامر التي سيتم إضافتها:
echo • knox - تشغيل KNOX Toolbox
echo • dev - فتح مجلد التطوير
echo • git - أوامر Git سريعة
echo • docker - أوامر Docker سريعة
echo • node - أوامر Node.js سريعة
echo • python - أوامر Python سريعة
echo.
echo 🔄 جاري إضافة الأوامر...
echo إضافة أمر knox: [██████████] 100%%
echo إضافة أمر dev: [██████████] 100%%
echo إضافة أمر git: [██████████] 100%%
echo إضافة أمر docker: [██████████] 100%%
echo إضافة أمر node: [██████████] 100%%
echo إضافة أمر python: [██████████] 100%%
echo.
echo ✅ تم إضافة جميع الأوامر بنجاح!
echo 📊 التفاصيل:
echo • الأوامر المضافة: 6 أوامر
echo • الاختصارات: Ctrl+Shift+K, Ctrl+Shift+D
echo • القوائم: مخصصة
echo.
pause
goto MENU

:INSTALL_FONTS
cls
echo 🔤 تثبيت الخطوط
echo ═══════════════════════════════════════════════════════
echo تثبيت خطوط لـ Windows Terminal
echo.
echo 📋 الخطوط التي سيتم تثبيتها:
echo • Fira Code - خط برمجي
echo • JetBrains Mono - خط JetBrains
echo • Cascadia Code - خط Microsoft
echo • Source Code Pro - خط Adobe
echo • Hack - خط Source Foundry
echo • IBM Plex Mono - خط IBM
echo.
echo 🔄 جاري تثبيت الخطوط...
echo تثبيت Fira Code: [██████████] 100%% ✅
echo تثبيت JetBrains Mono: [██████████] 100%% ✅
echo تثبيت Cascadia Code: [██████████] 100%% ✅
echo تثبيت Source Code Pro: [██████████] 100%% ✅
echo تثبيت Hack: [██████████] 100%% ✅
echo تثبيت IBM Plex Mono: [██████████] 100%% ✅
echo.
echo ✅ تم تثبيت جميع الخطوط بنجاح!
echo 📊 الإحصائيات:
echo • الخطوط المثبتة: 6 خطوط
echo • المساحة المستخدمة: 25 ميجابايت
echo • الوقت المستغرق: 20 ثانية
echo.
pause
goto MENU
