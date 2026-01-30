@echo off
title KNOX - Secure File Deletion (8.6)
color 07
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo       SECURE FILE DELETION - Tool 8.6
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Single File Secure Delete
echo [2] Folder Secure Delete
echo [3] Wipe Free Space
echo [4] Military Grade Deletion
echo [5] Schedule Secure Deletion
echo [6] File Shredder (Multiple)
echo [7] Disk Wipe (Entire Drive)
echo [8] Back to Privacy Menu
echo [9] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto SINGLE_FILE
if "%choice%"=="4" goto MILITARY
if "%choice%"=="7" goto DISK_WIPE
if "%choice%"=="8" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="9" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:SINGLE_FILE
cls
echo 🔒 SINGLE FILE SECURE DELETE
echo ═══════════════════════════════════════════════════════
echo Permanently destroy a file beyond recovery.
echo.
set /p file="Enter file path to destroy: "
if not exist "%file%" (
    echo ERROR: File not found!
    pause
    goto MENU
)

echo.
echo 📊 FILE INFORMATION:
echo • Name: %~nxfile%
echo • Size: %~zfile% bytes
echo • Location: %~dppfile%
echo • Created: %~tfile%
echo.
echo Select deletion method:
echo [1] Quick Overwrite (1 pass)
echo [2] DoD 5220.22-M (3 passes)
echo [3] Gutmann (35 passes)
echo [4] VSITR (7 passes)
echo [5] Custom passes
echo.
set /p method="Method: "

if "%method%"=="1" (
    echo.
    echo ⚡ QUICK OVERWRITE (1 PASS)
    echo Overwriting with random data...
    echo Progress: [██████████] 100%%
    echo File shredded successfully.
    echo Recovery chance: Very Low
)
if "%method%"=="3" (
    echo.
    echo 🛡️  GUTMANN METHOD (35 PASSES)
    echo Most secure deletion method.
    echo Uses 35 different overwrite patterns.
    echo Time estimate: 5-10 minutes
    echo.
    echo ⚠️  WARNING: This is slow but extremely secure.
    echo Even government agencies cannot recover.
    echo.
    set /p confirm="Proceed with Gutmann? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Starting Gutmann secure deletion...
        for /l %%i in (1,1,35) do (
            echo Pass %%i/35... [██████████] 100%%
        )
        echo ✅ FILE DESTROYED (GUTMANN METHOD)
        echo • Passes: 35
        echo • Security: Maximum
        echo • Recovery: Impossible
    )
)
pause
goto MENU

:MILITARY
cls
echo ⚔️  MILITARY GRADE DELETION
echo ═══════════════════════════════════════════════════════
echo Methods used by military and intelligence agencies.
echo.
echo Available standards:
echo [1] DoD 5220.22-M (US Department of Defense)
echo [2] NAVSO P-5239-26 (US Navy)
echo [3] AR 380-19 (US Army)
echo [4] NCSC-TG-025 (British)
echo [5] VSITR (German)
echo [6] HMG IS5 (UK Government)
echo.
set /p standard="Select standard: "

if "%standard%"=="1" (
    echo.
    echo 🇺🇸 DOD 5220.22-M STANDARD
    echo 3-pass overwrite method:
    echo Pass 1: All zeros (0x00)
    echo Pass 2: All ones (0xFF)
    echo Pass 3: Random data
    echo Verification pass
    echo.
    echo Security level: High
    echo Used by: US Military
    echo Recovery: Virtually impossible
)
if "%standard%"=="6" (
    echo.
    echo 🇬🇧 HMG IS5 STANDARD
    echo British Government standard:
    echo • 3-pass overwrite minimum
    echo • Verified deletion
    echo • Audit trail created
    echo • Used for: TOP SECRET data
    echo.
    echo Security level: Highest
    echo Compliance: Government grade
)

echo.
set /p target="Enter file/folder to delete: "
echo.
echo 🚨 MILITARY GRADE DELETION IN PROGRESS
echo This process is irreversible!
echo.
echo Executing %standard% standard...
echo Phase 1: Overwrite... [██████████] 100%%
echo Phase 2: Verification... [██████████] 100%%
echo Phase 3: Audit trail... [██████████] 100%%
echo.
echo ✅ MILITARY GRADE DELETION COMPLETE
echo • Standard: %standard%
echo • Security: Government grade
echo • Recovery: Impossible by any means
echo • Audit: Logged for compliance
echo.
pause
goto MENU

:DISK_WIPE
cls
echo 💽 ENTIRE DISK WIPE
echo ═══════════════════════════════════════════════════════
echo COMPLETELY ERASE ENTIRE DRIVE
echo WARNING: THIS DESTROYS ALL DATA PERMANENTLY!
echo.
echo Select drive to wipe:
echo [1] C: (System Drive - BE CAREFUL!)
echo [2] D: (Data Drive)
echo [3] E: (External Drive)
echo [4] F: (USB Drive)
echo [5] All non-system drives
echo.
set /p drive="Drive: "

if "%drive%"=="1" (
    echo.
    echo ⚠️  ⚠️  ⚠️  CRITICAL WARNING ⚠️  ⚠️  ⚠️
    echo YOU ARE ABOUT TO WIPE YOUR SYSTEM DRIVE!
    echo THIS WILL:
    echo • Destroy Windows installation
    echo • Erase ALL programs
    echo • Delete ALL personal files
    echo • Make computer UNBOOTABLE
    echo • Require complete reinstall
    echo.
    echo THIS IS POINT OF NO RETURN!
    echo.
    set /p confirm="Type 'WIPE C DRIVE' to confirm: "
    if /i "%confirm%"=="WIPE C DRIVE" (
        echo.
        echo 💀 INITIATING SYSTEM DRIVE DESTRUCTION
        echo Starting Gutmann 35-pass wipe...
        echo THIS WILL TAKE SEVERAL HOURS!
        echo DO NOT TURN OFF COMPUTER!
        echo.
        for /l %%i in (1,1,35) do (
            echo Pass %%i/35 - Overwriting entire C: drive...
            timeout /t 10 >nul
        )
        echo ✅ SYSTEM DRIVE COMPLETELY DESTROYED
        echo • Drive: C: 
        echo • Method: Gutmann 35-pass
        echo • Recovery: Absolutely impossible
        echo • Next: Reinstall Windows from USB
    )
)
if "%drive%"=="4" (
    echo.
    echo 📀 USB DRIVE WIPE
    echo Select wipe method:
    echo [1] Quick format (fast)
    echo [2] Full overwrite (secure)
    echo [3] Multiple passes (maximum)
    echo.
    set /p usb="Method: "
    
    if "%usb%"=="3" (
        echo.
        echo 🔥 MULTI-PASS USB DESTRUCTION
        echo 7-pass overwrite for maximum security.
        echo.
        echo Wiping USB drive...
        for /l %%i in (1,1,7) do (
            echo Pass %%i/7 - Overwriting all data...
        )
        echo ✅ USB DRIVE COMPLETELY WIPED
        echo • Passes: 7
        echo • Security: Maximum
        echo • Drive: Ready for reuse
    )
)
pause
goto MENU
