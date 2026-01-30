@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - BIOS/UEFI Information Analyzer
color 0C
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /09/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo     BIOS/UEFI INFORMATION ANALYZER - Tool 09.8
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Show BIOS/UEFI overview (simulated)
echo [2] Show Secure Boot status (simulated)
echo [3] Show TPM status (simulated)
echo [4] Export BIOS report (TXT)
echo [5] Back to Information Menu
echo [6] Main Menu
echo.
set /p choice="Select (1-6): "

if "%choice%"=="1" goto OVERVIEW
if "%choice%"=="2" goto SECUREBOOT
if "%choice%"=="3" goto TPM
if "%choice%"=="4" goto EXPORT
if "%choice%"=="5" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:OVERVIEW
cls
echo 🧬 BIOS/UEFI OVERVIEW (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Reading firmware info: [██████████] 100%%
echo.
echo Firmware:
echo • Vendor: AMI
echo • Version: F.14
echo • Release date: 2023-11-02
echo • Boot mode: UEFI
echo • SMBIOS: 3.5
echo.
pause
goto MENU

:SECUREBOOT
cls
echo 🛡️ SECURE BOOT STATUS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Checking policy: [██████████] 100%%
echo.
echo • Secure Boot: ✅ Enabled
echo • Platform Key: Present
echo • DB/DBX: Updated
echo.
pause
goto MENU

:TPM
cls
echo 🔐 TPM STATUS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Querying TPM: [██████████] 100%%
echo.
echo • TPM Present: ✅ Yes
echo • TPM Version: 2.0
echo • Ready: ✅ Yes
echo.
pause
goto MENU

:EXPORT
cls
echo 💾 EXPORT BIOS REPORT
echo ═══════════════════════════════════════════════════════
echo.
set "OUT_DIR=C:\KNOX_Reports"
set "OUT_FILE=%OUT_DIR%\BIOS_Report_%date:~-4%%date:~4,2%%date:~7,2%.txt"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%" >nul 2>&1

echo Building report: [██████████] 100%%
(
  echo KNOX BIOS/UEFI Report
  echo Date: %date% %time%
  echo Vendor: AMI
  echo Version: F.14
  echo BootMode: UEFI
  echo SecureBoot: Enabled
  echo TPM: 2.0 Ready
) > "%OUT_FILE%"

echo.
echo ✅ Report saved:
echo • %OUT_FILE%
echo.
pause
goto MENU
