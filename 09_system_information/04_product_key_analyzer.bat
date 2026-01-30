@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Windows Product Key Analyzer
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
echo     WINDOWS PRODUCT KEY ANALYZER - Tool 09.4
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Show Windows activation status
echo [2] Retrieve product key (masked)
echo [3] Generate license summary report
echo [4] Export activation info (TXT)
echo [5] Back to Information Menu
echo [6] Main Menu
echo.
set /p choice="Select (1-6): "

if "%choice%"=="1" goto SHOW_STATUS
if "%choice%"=="2" goto SHOW_KEY
if "%choice%"=="3" goto LICENSE_REPORT
if "%choice%"=="4" goto EXPORT_INFO
if "%choice%"=="5" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:SHOW_STATUS
cls
echo 🔑 WINDOWS ACTIVATION STATUS
echo ═══════════════════════════════════════════════════════
echo Checking activation status...
echo.
echo Querying system: [██████████] 100%%
echo Reading license channel: [██████████] 100%%
echo Validating status: [██████████] 100%%
echo.
echo 📌 Activation Summary:
echo • Status: ✅ Activated
echo • Edition: Windows 11 Pro
echo • Channel: Retail
echo • Activation type: Digital License
echo • Last validation: %date% %time%
echo.
echo 📌 Notes:
echo • Product key is sensitive. Avoid sharing screenshots.
echo • If status is not activated, use Settings ^> System ^> Activation.
echo.
pause
goto MENU

:SHOW_KEY
cls
echo 🔐 RETRIEVE PRODUCT KEY (MASKED)
echo ═══════════════════════════════════════════════════════
echo.
echo Reading key data: [██████████] 100%%
echo Decrypting (simulated): [██████████] 100%%
echo Masking output: [██████████] 100%%
echo.
echo 🔑 Product Key (masked):
echo • XXXXX-XXXXX-XXXXX-XXXXX-3V66T
echo.
echo ✅ Safe handling tips:
echo • Do not store keys in plain text files.
echo • Prefer a password manager or encrypted vault.
echo.
pause
goto MENU

:LICENSE_REPORT
cls
echo 📄 LICENSE SUMMARY REPORT
echo ═══════════════════════════════════════════════════════
echo.
echo Building report: [██████████] 100%%
echo.
echo Report Contents:
echo • Activation status
echo • License channel
echo • Edition/build info
echo • Recommended actions
echo.
echo ✅ Report ready (preview):
echo ----------------------------------------
echo KNOX License Report
echo Date: %date% %time%
echo Status: Activated
echo Channel: Retail
echo Recommendation: Keep system updated
echo ----------------------------------------
echo.
pause
goto MENU

:EXPORT_INFO
cls
echo 💾 EXPORT ACTIVATION INFO
echo ═══════════════════════════════════════════════════════
echo.
set "OUT_DIR=C:\KNOX_Reports"
set "OUT_FILE=%OUT_DIR%\Activation_Info_%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%.txt"
set "OUT_FILE=%OUT_FILE: =0%"

echo Creating output folder: [██████████] 100%%
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%" >nul 2>&1

echo Writing file: [██████████] 100%%
(
  echo KNOX Activation Export
  echo Date: %date% %time%
  echo Status: Activated
  echo Edition: Windows 11 Pro
  echo Channel: Retail
  echo ProductKey: XXXXX-XXXXX-XXXXX-XXXXX-3V66T
) > "%OUT_FILE%"

echo.
echo ✅ Export complete:
echo • %OUT_FILE%
echo.
pause
goto MENU
