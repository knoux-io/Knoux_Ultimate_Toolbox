@echo off
chcp 65001 >nul
mode con: cols=130 lines=50
setlocal enabledelayedexpansion

:: ===================================================================
:: 🛡️  Knoux Shield - Main Gateway
:: Author: Aisha (kn.o.uxx.xx@gmail.com)
:: Location: F:\Knoux_Ultimate_Toolbox\modules\20_knoux_shield\
:: ===================================================================

:DISPLAY_BANNER
cls
echo.
echo.                                knoux is here
echo.
echo                                             ____====-_  _-====____                                      
echo                                           _--^^^#####//      \\#####^^^--_                            
echo                                        _-^##########// (    ) \\##########^-_                      
echo                                       -############//  ^|\^^/^|  \\############-                     
echo                                     _/############//   (@::@)   \\############\_                   
echo                                    /#############((     \\//     ))#############\                  
echo                                   -###############\\    (oo)    //###############-                 
echo                                  -#################\\  / VV \  //#################-                
echo                                 -###################\\/      \//###################-               
echo                                _#/^|##########/\######(   /\   )######/\##########^|\#_              
echo                                ^|/ ^|#/\#/\#/\/  \#/\##\  ^|  ^|  /##/\#/  \/\#/\#/\#^| \|              
echo                                   ^|/  V  V      V  \#\^| ^|  ^| ^|/#/  V      V  V  \^|                
echo                                                   \/^| ^|  ^| ^|\/                                   
echo                                                     \  \/  /                                     
echo                                                     __\  /__                                     
echo                                                    (vvv(VVV)                                     
echo.
timeout /t 2 >nul

:MAIN_MENU
cls
call :DISPLAY_BANNER
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                     🔒 Knoux Shield - Security Hub                                ║
echo  ╠══════════════════════════════════════════════════════════════════════════════════════════════════╣
echo  ║  [1] Threat Detection        [2] Network Security       [3] System Hardening                     ║
echo  ║  [4] Encryption Security     [5] Privacy Protector      [6] Advanced Monitoring                  ║
echo  ║  [7] Forensic Tools          [8] Incident Response      [9] Vulnerability Management             ║
echo  ║  [10] Advanced Tools         [0] Exit                                                            ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p "choice=  ➤ Choose a module (0-10): "

if "%choice%"=="0" goto EXIT
if "%choice%"=="1" goto MODULE_01
if "%choice%"=="2" goto MODULE_02
if "%choice%"=="3" goto MODULE_03
if "%choice%"=="4" goto MODULE_04
if "%choice%"=="5" goto MODULE_05
if "%choice%"=="6" goto MODULE_06
if "%choice%"=="7" goto MODULE_07
if "%choice%"=="8" goto MODULE_08
if "%choice%"=="9" goto MODULE_09
if "%choice%"=="10" goto MODULE_10

echo.❌ Invalid input. Try again...
timeout /t 2 >nul
goto MAIN_MENU

:MODULE_01
call "%~dp0module_01_threat_detection.bat"
goto MAIN_MENU

:MODULE_02
call "%~dp0module_02_network_security.bat"
goto MAIN_MENU

:MODULE_03
call "%~dp0module_03_system_hardening.bat"
goto MAIN_MENU

:MODULE_04
call "%~dp0module_04_encryption_security.bat"
goto MAIN_MENU

:MODULE_05
call "%~dp0module_05_privacy_protector.bat"
goto MAIN_MENU

:MODULE_06
call "%~dp0module_06_advanced_monitoring.bat"
goto MAIN_MENU

:MODULE_07
call "%~dp0module_07_forensic_tools.bat"
goto MAIN_MENU

:MODULE_08
call "%~dp0module_08_incident_response.bat"
goto MAIN_MENU

:MODULE_09
call "%~dp0module_09_vulnerability_management.bat"
goto MAIN_MENU

:MODULE_10
call "%~dp0module_10_advanced_tools.bat"
goto MAIN_MENU

:EXIT
cls
echo.
echo.  ████████████████████████████████████████████████████████████████████
echo.  █                                                              █
echo.  █   Thank you for using Knoux Shield — Stay Secure, Aisha!    █
echo.  █                                                              █
echo.  ████████████████████████████████████████████████████████████████████
timeout /t 3 >nul
exit
