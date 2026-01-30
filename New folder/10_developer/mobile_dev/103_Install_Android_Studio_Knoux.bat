@echo off
:: =================================================================
:: KNOUX ANDROID STUDIO INSTALLER
:: تثبيت Android Studio
:: =================================================================
title Knoux - Android Studio Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX ANDROID STUDIO + SDK MANAGER
echo   تثبيت Android Studio مع مدير SDK
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Android Studio...
winget install Google.AndroidStudio --silent --accept-package-agreements

echo [✓] تم تثبيت Android Studio!
echo [→] يرجى إكمال الإعداد داخل البرنامج
pause
