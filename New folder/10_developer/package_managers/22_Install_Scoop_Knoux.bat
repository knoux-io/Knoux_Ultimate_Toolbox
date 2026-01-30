@echo off
:: =================================================================
:: KNOUX SCOOP PACKAGE MANAGER
:: تثبيت Scoop مع مدير Buckets
:: =================================================================
title Knoux - Scoop Package Manager

echo ═══════════════════════════════════════════════════════════
echo   KNOUX SCOOP + BUCKET MANAGER
echo   تثبيت Scoop مع مدير Buckets
echo ═══════════════════════════════════════════════════════════
echo.

:: Install Scoop
echo [→] جاري تثبيت Scoop...
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
powershell -Command "iwr -useb get.scoop.sh | iex"

echo [✓] تم تثبيت Scoop!
scoop --version

:: Add essential buckets
echo [→] جاري إضافة Buckets أساسية...
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

echo [✓] تم إضافة Buckets!
pause
