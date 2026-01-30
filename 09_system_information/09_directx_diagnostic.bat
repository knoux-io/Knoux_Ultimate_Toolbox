@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - DirectX Diagnostic Checker
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
echo      DIRECTX DIAGNOSTIC CHECKER - Tool 09.9
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Show DirectX summary (simulated)
echo [2] Graphics diagnostics (simulated)
echo [3] Audio diagnostics (simulated)
echo [4] Export DxDiag report (TXT)
echo [5] Back to Information Menu
echo [6] Main Menu
echo.
set /p choice="Select (1-6): "

if "%choice%"=="1" goto SUMMARY
if "%choice%"=="2" goto GRAPHICS
if "%choice%"=="3" goto AUDIO
if "%choice%"=="4" goto EXPORT
if "%choice%"=="5" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="6" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:SUMMARY
cls
echo 🧾 DIRECTX SUMMARY (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Querying DirectX: [██████████] 100%%
echo.
echo • DirectX Version: DirectX 12 Ultimate
echo • WDDM: 3.2
echo • Feature Levels: 12_2, 12_1, 12_0, 11_1
echo • HDR: Enabled
echo.
pause
goto MENU

:GRAPHICS
cls
echo 🎮 GRAPHICS DIAGNOSTICS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo GPU:
echo • NVIDIA GeForce RTX 4090
echo • Driver: 551.23
echo • VRAM: 24 GB
echo • Direct3D: OK
echo • Vulkan: OK
echo.
echo Notes:
echo • If games crash, try clean driver install.
echo • Keep chipset and GPU drivers updated.
echo.
pause
goto MENU

:AUDIO
cls
echo 🔊 AUDIO DIAGNOSTICS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Device:
echo • Realtek High Definition Audio
echo • Driver: 6.0.9625.1
echo • Status: OK
echo.
echo Tips:
echo • If sound issues occur, reinstall Realtek driver.
echo.
pause
goto MENU

:EXPORT
cls
echo 💾 EXPORT DXDIAG REPORT
echo ═══════════════════════════════════════════════════════
echo.
set "OUT_DIR=C:\KNOX_Reports"
set "OUT_FILE=%OUT_DIR%\DxDiag_%date:~-4%%date:~4,2%%date:~7,2%.txt"
if not exist "%OUT_DIR%" mkdir "%OUT_DIR%" >nul 2>&1

echo Creating report: [██████████] 100%%
(
  echo KNOX DxDiag Export
  echo Date: %date% %time%
  echo DirectX: 12 Ultimate
  echo GPU: RTX 4090
  echo GPU Driver: 551.23
  echo Audio: Realtek HD Audio
) > "%OUT_FILE%"

echo.
echo ✅ Report saved:
echo • %OUT_FILE%
echo.
pause
goto MENU
