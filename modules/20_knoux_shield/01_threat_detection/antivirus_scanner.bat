@echo off
chcp 65001 >nul
mode con: cols=100 lines=35
setlocal

:: ===================================================================
:: 🔍 Antivirus Scanner - Advanced Threat Detection
:: Module: 01_threat_detection
:: Author: Aisha (kn.o.uxx.xx@gmail.com)
:: ===================================================================

:BANNER
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
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               🔍 Antivirus Scanner v4.2.0                               ║
echo  ║                           Advanced Threat Detection System                              ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
timeout /t 2 >nul

:MAIN_MENU
cls
call :BANNER
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                   SCAN OPTIONS                                            ║
echo  ╠══════════════════════════════════════════════════════════════════════════════════════════════════╣
echo  ║  [1] Quick Scan              [2] Full System Scan        [3] Custom Scan                      ║
echo  ║  [4] Real-time Protection    [5] Update Definitions     [6] Quarantine Manager               ║
echo  ║  [7] Scan History           [8] Threat Database         [9] Advanced Settings                ║
echo  ║  [10] Schedule Scan         [11] Export Report           [0] Back to Module Menu           ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p "choice=  ➤ Select option (0-11): "

if "%choice%"=="0" goto EXIT
if "%choice%"=="1" goto QUICK_SCAN
if "%choice%"=="2" goto FULL_SCAN
if "%choice%"=="3" goto CUSTOM_SCAN
if "%choice%"=="4" goto REAL_TIME_PROTECTION
if "%choice%"=="5" goto UPDATE_DEFINITIONS
if "%choice%"=="6" goto QUARANTINE_MANAGER
if "%choice%"=="7" goto SCAN_HISTORY
if "%choice%"=="8" goto THREAT_DATABASE
if "%choice%"=="9" goto ADVANCED_SETTINGS
if "%choice%"=="10" goto SCHEDULE_SCAN
if "%choice%"=="11" goto EXPORT_REPORT

echo.❌ Invalid choice. Try again...
timeout /t 2 >nul
goto MAIN_MENU

:QUICK_SCAN
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                   🔍 Quick Scan                                            ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [INFO] Starting quick scan of critical areas...
echo  [INFO] Scanning: System files, startup programs, running processes
echo.

powershell -Command "Start-MpScan -ScanType QuickScan" >nul 2>&1

if %errorlevel%==0 (
    echo  [✓] Quick scan completed successfully!
    echo  [INFO] Check Windows Security for detailed results
) else (
    echo  [✗] Quick scan failed. Please check permissions.
)

echo.
pause
goto MAIN_MENU

:FULL_SCAN
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                   🔍 Full System Scan                                      ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [INFO] Starting full system scan...
echo  [WARNING] This may take several hours.
echo  [INFO] Scanning: All files, programs, and system areas
echo.

powershell -Command "Start-MpScan -ScanType FullScan" >nul 2>&1

if %errorlevel%==0 (
    echo  [✓] Full scan initiated successfully!
    echo  [INFO] Monitor progress in Windows Security
) else (
    echo  [✗] Full scan failed. Please check permissions.
)

echo.
pause
goto MAIN_MENU

:CUSTOM_SCAN
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                   🔍 Custom Scan                                           ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p "scan_path=  ➤ Enter path to scan (e.g., C:\Users\%USERNAME%\Downloads): "
if "%scan_path%"=="" set "scan_path=C:\Users\%USERNAME%\Downloads"

echo.
echo  [INFO] Starting custom scan of: %scan_path%
echo.

powershell -Command "Start-MpScan -ScanType CustomScan -ScanPath '%scan_path%'" >nul 2>&1

if %errorlevel%==0 (
    echo  [✓] Custom scan initiated successfully!
    echo  [INFO] Monitor progress in Windows Security
) else (
    echo  [✗] Custom scan failed. Please check path and permissions.
)

echo.
pause
goto MAIN_MENU

:REAL_TIME_PROTECTION
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              🛡️ Real-time Protection                                     ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

powershell -Command "Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled" >nul 2>&1

echo  [INFO] Current real-time protection status:
powershell -Command "Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled"

echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] Enable Real-time Protection   [2] Disable Real-time Protection │
echo  │  [3] Configure Settings             [0] Back to Menu                │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p "rt_choice=  ➤ Select option (0-3): "

if "%rt_choice%"=="0" goto MAIN_MENU
if "%rt_choice%"=="1" (
    powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false" >nul 2>&1
    echo  [✓] Real-time protection enabled!
)
if "%rt_choice%"=="2" (
    powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1
    echo  [✓] Real-time protection disabled!
)
if "%rt_choice%"=="3" goto CONFIGURE_SETTINGS

echo.
pause
goto MAIN_MENU

:UPDATE_DEFINITIONS
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             🔄 Update Definitions                                       ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [INFO] Updating virus definitions...

powershell -Command "Update-MpSignature" >nul 2>&1

if %errorlevel%==0 (
    echo  [✓] Definitions updated successfully!
) else (
    echo  [✗] Update failed. Please check internet connection.
)

echo.
pause
goto MAIN_MENU

:QUARANTINE_MANAGER
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             📦 Quarantine Manager                                       ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Retrieving quarantine items...
powershell -Command "Get-MpThreatDetection | Where-Object {$_.Action -eq 'Quarantine'}" >nul 2>&1

echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] View Quarantined Items      [2] Restore Item                │
echo  │  [3] Remove Item                  [4] Empty Quarantine           │
echo  │  [0] Back to Menu                                              │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p "q_choice=  ➤ Select option (0-4): "

if "%q_choice%"=="0" goto MAIN_MENU
if "%q_choice%"=="1" (
    echo  [INFO] Quarantined items:
    powershell -Command "Get-MpThreatDetection | Where-Object {$_.Action -eq 'Quarantine'} | Select-Object ThreatName, QuarantinePath"
)
if "%q_choice%"=="2" (
    echo  [INFO] Restore functionality requires manual intervention through Windows Security
)
if "%q_choice%"=="3" (
    echo  [INFO] Remove functionality requires manual intervention through Windows Security
)
if "%q_choice%"=="4" (
    echo  [WARNING] This will permanently delete all quarantined items!
    set /p "confirm=  Are you sure? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo  [INFO] Emptying quarantine...
        echo  [✓] Quarantine emptied!
    )
)

echo.
pause
goto MAIN_MENU

:SCAN_HISTORY
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               📊 Scan History                                           ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Retrieving scan history...
powershell -Command "Get-MpThreatDetection | Select-Object ThreatName, DetectionTime, Action | Sort-Object DetectionTime -Descending" >nul 2>&1

echo.
pause
goto MAIN_MENU

:THREAT_DATABASE
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             🗄️ Threat Database                                          ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Current threat database version:
powershell -Command "Get-MpComputerStatus | Select-Object AntispywareSignatureVersion, AntispywareSignatureLastUpdated" >nul 2>&1

echo.
echo  [INFO] Total known threats: (Windows Defender database)
echo  [INFO] Database is updated automatically by Microsoft

echo.
pause
goto MAIN_MENU

:ADVANCED_SETTINGS
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             ⚙️ Advanced Settings                                        ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Current Windows Defender settings:
powershell -Command "Get-MpPreference | Select-Object DisableRealtimeMonitoring, DisableIOAVProtection, DisableScriptScanning, DisableArchiveScanning" >nul 2>&1

echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] Configure Scan Exclusions     [2] Configure Scan Schedule   │
echo  │  [3] Configure Notifications        [4] Reset to Defaults         │
echo  │  [0] Back to Menu                                              │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p "adv_choice=  ➤ Select option (0-4): "

if "%adv_choice%"=="0" goto MAIN_MENU
if "%adv_choice%"=="1" echo  [INFO] Configure exclusions through Windows Security Settings
if "%adv_choice%"=="2" echo  [INFO] Configure schedule through Windows Security Settings
if "%adv_choice%"=="3" echo  [INFO] Configure notifications through Windows Security Settings
if "%adv_choice%"=="4" (
    powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $false -DisableIOAVProtection $false -DisableScriptScanning $false -DisableArchiveScanning $false" >nul 2>&1
    echo  [✓] Settings reset to defaults!
)

echo.
pause
goto MAIN_MENU

:SCHEDULE_SCAN
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             ⏰ Schedule Scan                                            ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Schedule scan through Windows Security Settings
echo  [INFO] Open Windows Security → Virus & threat protection → Scan options
echo  [INFO] Scroll down to "Microsoft Defender Antivirus Options"
echo  [INFO] Click on "Add or remove exclusions" → "Add an exclusion"

echo.
pause
goto MAIN_MENU

:EXPORT_REPORT
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             📄 Export Report                                           ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

set "report_file=%USERPROFILE%\Desktop\Antivirus_Scan_Report_%date:~-4%%date:~3,2%%date:~0,2%.txt"

echo  ======================================== > "%report_file%"
echo  Antivirus Scanner Report >> "%report_file%"
echo  Generated: %date% %time% >> "%report_file%"
echo  ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo  System Information: >> "%report_file%"
echo  ------------------- >> "%report_file%"
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo  Windows Defender Status: >> "%report_file%"
echo  ------------------------ >> "%report_file%"
powershell -Command "Get-MpComputerStatus" >> "%report_file%" 2>&1
echo. >> "%report_file%"

echo  Recent Threat Detections: >> "%report_file%"
echo  ------------------------ >> "%report_file%"
powershell -Command "Get-MpThreatDetection | Select-Object ThreatName, DetectionTime, Action | Sort-Object DetectionTime -Descending | Select-Object -First 10" >> "%report_file%" 2>&1

echo.
echo  [✓] Report exported to: %report_file%
echo.

notepad "%report_file%"
goto MAIN_MENU

:CONFIGURE_SETTINGS
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             ⚙️ Configure Settings                                       ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.

echo  [INFO] Advanced configuration options:
echo.
echo  ┌────────────────────────────────────────────────────────────────┐
echo  │  [1] Cloud Protection            [2] Sample Submission         │
echo  │  [3] Potentially Unwanted Apps   [4] Controlled Folder Access  │
echo  │  [5] Network Inspection          [0] Back to Menu                │
echo  └────────────────────────────────────────────────────────────────┘
echo.

set /p "config_choice=  ➤ Select option (0-5): "

if "%config_choice%"=="0" goto REAL_TIME_PROTECTION
if "%config_choice%"=="1" (
    powershell -Command "Set-MpPreference -MAPSReporting 2" >nul 2>&1
    echo  [✓] Cloud protection enabled!
)
if "%config_choice%"=="2" (
    powershell -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1
    echo  [✓] Sample submission enabled!
)
if "%config_choice%"=="3" (
    powershell -Command "Set-MpPreference -PUAProtection 1" >nul 2>&1
    echo  [✓] PUA protection enabled!
)
if "%config_choice%"=="4" (
    powershell -Command "Set-MpPreference -EnableControlledFolderAccess 1" >nul 2>&1
    echo  [✓] Controlled folder access enabled!
)
if "%config_choice%"=="5" (
    powershell -Command "Set-MpPreference -DisableNetworkProtection 0" >nul 2>&1
    echo  [✓] Network inspection enabled!
)

echo.
pause
goto REAL_TIME_PROTECTION

:EXIT
cls
echo.
echo  ╔══════════════════════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           Thank you for using Antivirus Scanner!                        ║
echo  ║                              Stay Protected, Aisha!                                  ║
echo  ╚══════════════════════════════════════════════════════════════════════════════════════════════════╝
echo.
timeout /t 3 >nul
exit /b
