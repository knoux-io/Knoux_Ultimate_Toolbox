@echo off
:: =================================================================
:: KNOUX DOCKER INSTALLER
:: تثبيت Docker مع مدير الحاويات
:: =================================================================
title Knoux - Docker Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX DOCKER + CONTAINER MANAGER
echo   تثبيت Docker مع مدير الحاويات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Docker Desktop...
winget install Docker.DockerDesktop --silent --accept-package-agreements

echo [✓] تم تثبيت Docker!
echo [→] يلزم إعادة تشغيل الجهاز
echo [→] بعد الإعادة: docker --version
pause
