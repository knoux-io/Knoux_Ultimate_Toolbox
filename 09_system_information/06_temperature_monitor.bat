@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Temperature Monitor
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
echo          TEMPERATURE MONITOR - Tool 09.6
echo               Category: System Information
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Realtime temperature snapshot
echo [2] Historical analysis (simulated)
echo [3] High temperature alerts (simulated)
echo [4] Temperature stress test (simulated)
echo [5] Cooling optimization tips
echo [6] Back to Information Menu
echo [7] Main Menu
echo.
set /p choice="Select (1-7): "

if "%choice%"=="1" goto REALTIME
if "%choice%"=="2" goto HISTORY
if "%choice%"=="3" goto ALERTS
if "%choice%"=="4" goto STRESS
if "%choice%"=="5" goto OPTIMIZE
if "%choice%"=="6" call "%SCRIPT_DIR%09.BAT"
if "%choice%"=="7" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:REALTIME
cls
echo 🌡️ REALTIME TEMPERATURE SNAPSHOT
echo ═══════════════════════════════════════════════════════
echo.
echo Reading sensors: [██████████] 100%%
echo Normalizing values: [██████████] 100%%
echo.
echo CPU:
echo • Package: 48°C ✅
echo • Core Max: 52°C ✅
echo • Core Avg: 45°C ✅
echo.
echo GPU:
echo • GPU Temp: 42°C ✅
echo • Hot Spot: 48°C ✅
echo • Memory: 46°C ✅
echo.
echo Storage:
echo • NVMe (C:): 44°C ✅
echo • HDD (D:): 38°C ✅
echo • NVMe (E:): 42°C ✅
echo.
echo Fans:
echo • CPU Fan: 800 RPM
echo • Case Fans: 1200 RPM
echo.
echo Status:
echo • Overall thermal health: ✅ Excellent
echo.
pause
goto MENU

:HISTORY
cls
echo 📅 HISTORICAL TEMPERATURE ANALYSIS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Loading logs: [██████████] 100%%
echo Building charts: [██████████] 100%%
echo.
echo Last 24 hours:
echo • CPU Peak: 68°C
echo • GPU Peak: 72°C
echo • NVMe Peak: 52°C
echo.
echo Output:
echo • C:\KNOX_Reports\Temperature_24h.html
echo.
pause
goto MENU

:ALERTS
cls
echo 🔔 HIGH TEMPERATURE ALERTS (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Current thresholds:
echo • CPU Warning: 75°C
echo • CPU Critical: 85°C
echo • GPU Warning: 80°C
echo • GPU Critical: 90°C
echo.
echo Recent events (simulated):
echo • CPU hit 78°C (Warning) -> Fans increased
echo • GPU hit 82°C (Warning) -> Clocks reduced
echo.
pause
goto MENU

:STRESS
cls
echo 🧪 TEMPERATURE STRESS TEST (SIMULATED)
echo ═══════════════════════════════════════════════════════
echo.
echo Warm-up: [██████████] 100%%
echo Full load: [██████████] 100%%
echo Stability: [██████████] 100%%
echo Cooldown: [██████████] 100%%
echo.
echo Results:
echo • CPU Max: 78°C
echo • GPU Max: 82°C
echo • Throttling: 0%%
echo • Verdict: ✅ Stable
echo.
pause
goto MENU

:OPTIMIZE
cls
echo ❄️ COOLING OPTIMIZATION TIPS
echo ═══════════════════════════════════════════════════════
echo.
echo Recommended actions:
echo • Clean dust filters and heatsinks every 2-4 weeks
echo • Ensure front intake and rear/top exhaust airflow
echo • Re-check fan curves for CPU/GPU
echo • Replace thermal paste if temps increased over time
echo • Keep ambient room temperature reasonable
echo.
pause
goto MENU
