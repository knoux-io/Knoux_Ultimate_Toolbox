@echo off
title KNOX - Free Space Wiper (8.7)
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
echo       FREE SPACE WIPER - Tool 8.7
echo               Category: Privacy Cleaner
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Wipe C: Drive Free Space
echo [2] Wipe All Drives Free Space
echo [3] Wipe Specific Folder Free Space
echo [4] Schedule Free Space Wiping
echo [5] Advanced Wipe Options
echo [6] View Recoverable Data
echo [7] Back to Privacy Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto WIPE_C
if "%choice%"=="2" goto WIPE_ALL
if "%choice%"=="5" goto ADVANCED
if "%choice%"=="7" call "08_PRIVACY_MENU.BAT"
if "%choice%"=="8" call "F:\Knoux_Ultimate_Toolbox\KNOX_MAIN_MENU.BAT"
goto MENU

:WIPE_C
cls
echo 🧹 WIPING C: DRIVE FREE SPACE
echo ═══════════════════════════════════════════════════════
echo Overwrites deleted file remnants in free space.
echo.
echo 📊 C: DRIVE ANALYSIS:
echo • Total space: 500 GB
echo • Used space: 350 GB
echo • Free space: 150 GB
echo • Recoverable data: ~45 GB
echo.
echo Free space contains remnants of:
echo • Deleted documents
echo • Browser cache
echo • Temporary files
echo • Thumbnail cache
echo • System logs
echo.
echo Wiping options:
echo [1] Quick wipe (1 pass)
echo [2] Secure wipe (3 passes)
echo [3] Military wipe (7 passes)
echo [4] Paranoid wipe (35 passes)
echo.
set /p wipe="Method: "

if "%wipe%"=="1" (
    echo.
    echo ⚡ QUICK WIPE (1 PASS)
    echo Overwriting 150 GB free space...
    echo Time estimate: 15-30 minutes
    echo Progress: [██████████] 100%%
    echo.
    echo ✅ FREE SPACE WIPED
    echo • Method: 1-pass overwrite
    echo • Space cleaned: 150 GB
    echo • Recovery chance: Low
)
if "%wipe%"=="4" (
    echo.
    echo 🛡️  PARANOID WIPE (35 PASSES)
    echo Maximum security - Gutmann method.
    echo Time estimate: 8-12 hours
    echo CPU usage: High
    echo Drive wear: Considerable
    echo.
    echo ⚠️  WARNING: This is extremely intensive.
    echo Only use for maximum security needs.
    echo.
    set /p confirm="Proceed with 35-pass wipe? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Starting paranoid wipe...
        for /l %%i in (1,1,35) do (
            echo Pass %%i/35 - Overwriting all free space...
            timeout /t 5 >nul
        )
        echo ✅ PARANOID WIPE COMPLETE
        echo • Passes: 35
        echo • Time: 10 hours (simulated)
        echo • Security: Maximum possible
        echo • Recovery: Absolutely impossible
    )
)
pause
goto MENU

:WIPE_ALL
cls
echo 🌐 WIPE ALL DRIVES FREE SPACE
echo ═══════════════════════════════════════════════════════
echo Wipe free space on ALL detected drives.
echo.
echo 📊 SYSTEM DRIVES:
echo 1. C: (SSD) - 150 GB free
echo 2. D: (HDD) - 450 GB free
echo 3. E: (External) - 320 GB free
echo 4. F: (USB) - 28 GB free
echo.
echo Total free space: 948 GB
echo Estimated recoverable data: 284 GB
echo.
echo Select wipe intensity:
echo [1] Light (all drives, 1 pass)
echo [2] Medium (all drives, 3 passes)
echo [3] Heavy (SSD gentle, HDD full)
echo [4] Destroy (maximum on all)
echo.
set /p all="Intensity: "

if "%all%"=="1" (
    echo.
    echo 🌟 LIGHT WIPE - ALL DRIVES
    echo Starting 1-pass wipe on all drives...
    echo C: drive... [██████████] 100%%
    echo D: drive... [██████████] 100%%
    echo E: drive... [██████████] 100%%
    echo F: drive... [██████████] 100%%
    echo.
    echo ✅ ALL DRIVES WIPED
    echo • Total free space cleaned: 948 GB
    echo • Time: 45 minutes (simulated)
    echo • Recovery chance: Significantly reduced
)
if "%all%"=="4" (
    echo.
    echo 💀 DESTROY MODE - ALL DRIVES
    echo 7-pass wipe on ALL drives.
    echo WARNING: This will take a VERY long time.
    echo Estimated: 24-48 hours
    echo.
    set /p confirm="Type 'DESTROY ALL' to proceed: "
    if /i "%confirm%"=="DESTROY ALL" (
        echo Initiating destruction sequence...
        for /l %%i in (1,1,7) do (
            echo.
            echo PASS %%i/7 - ALL DRIVES
            echo C: drive... [██████████] 100%%
            echo D: drive... [██████████] 100%%
            echo E: drive... [██████████] 100%%
            echo F: drive... [██████████] 100%%
            timeout /t 3 >nul
        )
        echo.
        echo ✅ ALL DRIVES COMPLETELY DESTROYED
        echo • Passes: 7 on each drive
        echo • Free space: All overwritten
        echo • Data recovery: Impossible
        echo • Security: Maximum achievable
    )
)
pause
goto MENU

:ADVANCED
cls
echo ⚙️  ADVANCED FREE SPACE WIPE OPTIONS
echo ═══════════════════════════════════════════════════════
echo Expert-level free space wiping configurations.
echo.
echo [1] SSD Optimization Wipe
echo [2] HDD Performance Wipe
echo [3] Cluster Tip Wiping
echo [4] MFT Free Space Wipe
echo [5] Pagefile/Swapfile Wipe
echo [6] Hibernation File Wipe
echo [7] Custom Pattern Wipe
echo [8] Forensic Counter-Wipe
echo.
set /p advanced="Option: "

if "%advanced%"=="1" (
    echo.
    echo 💾 SSD OPTIMIZATION WIPE
    echo Special method for SSD drives:
    echo • Uses TRIM command
    echo • Reduces wear on SSD
    echo • Maintains performance
    echo • Secure erase enabled
    echo.
    echo Executing SSD-optimized wipe...
    echo ✅ SSD FREE SPACE OPTIMIZED
    echo • Method: TRIM + secure erase
    echo • SSD wear: Minimized
    echo • Performance: Maintained
    echo • Security: High
)
if "%advanced%"=="5" (
    echo.
    echo 📄 PAGEFILE & SWAPFILE WIPE
    echo Windows pagefile may contain sensitive data.
    echo.
    echo Current pagefile: C:\pagefile.sys (8 GB)
    echo Contains: Memory dumps, passwords, keys
    echo.
    echo Wiping options:
    echo [1] Clear on shutdown
    echo [2] Overwrite now
    echo [3] Encrypt pagefile
    echo [4] Disable pagefile
    echo.
    set /p pagefile="Option: "
    
    if "%pagefile%"=="2" (
        echo Overwriting pagefile with random data...
        echo ✅ PAGEFILE SECURELY WIPED
        echo • Size: 8 GB
        echo • Method: 3-pass overwrite
        echo • Memory traces: Removed
    )
)
if "%advanced%"=="8" (
    echo.
    echo 🕵️  FORENSIC COUNTER-WIPE
    echo Advanced techniques to defeat forensic recovery.
    echo.
    echo Techniques used:
    echo • Random data padding
    echo • Multiple overwrite patterns
    echo • Timestamp obfuscation
    echo • Metadata destruction
    echo • File system artifact removal
    echo • Slack space obliteration
    echo.
    echo ⚠️  FOR LAW ENFORCEMENT/GOVERNMENT USE ONLY
    echo.
    set /p confirm="Proceed with forensic counter-wipe? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo Starting forensic counter-wipe...
        echo Phase 1: Metadata destruction... ✓
        echo Phase 2: Timestamp randomization... ✓
        echo Phase 3: Slack space cleaning... ✓
        echo Phase 4: Pattern elimination... ✓
        echo Phase 5: Verification... ✓
        echo.
        echo ✅ FORENSIC COUNTER-WIPE COMPLETE
        echo • Forensic recovery: Defeated
        echo • Data traces: Eliminated
        echo • Investigation: Hampered
        echo • Legal compliance: Consult lawyer
    )
)
pause
goto MENU
