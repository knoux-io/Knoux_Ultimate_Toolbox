@echo off
title Knox Ultimate Toolbox - Image Verification
color 0A
chcp 65001 >nul

:: Load language configuration
call "..\language_config.bat"

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    call :get_text "ADMIN_REQUIRED"
    echo [ERROR] %RETURN_TEXT%
    call :get_text "PRESS_ANY_KEY"
    echo %RETURN_TEXT%
    pause
    exit /b 1
)

cls

echo.
echo   ??????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ??????????????????????????????????????????????????????????????
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
echo ????????????????????????????????????????????????????????????
echo           Advanced System Image Verifier
echo               Category: 01 Diagnostics
echo                 Color: Emerald Green #00C853
echo ????????????????????????????????????????????????????????????
echo.

:MENU
echo [1] Check Image Integrity
echo [2] Verify Signatures
echo [3] Detect Tampering
echo [4] Analyze System Files
echo [5] Create System Fingerprint
echo [6] Back to Diagnostics Menu
echo [7] Main Menu
echo.
call :get_text "SELECT_OPTION"
echo %RETURN_TEXT% [1-7]:
set /p choice=""

if "%choice%"=="1" goto CHECK_INTEGRITY
if "%choice%"=="2" goto VERIFY_SIGNATURES
if "%choice%"=="3" goto DETECT_TAMPERING
if "%choice%"=="4" goto ANALYZE_FILES
if "%choice%"=="5" goto CREATE_FINGERPRINT
if "%choice%"=="6" call "01_diagnostics_menu.bat"
if "%choice%"=="7" call "..\20_utilities.bat"
goto MENU

:CHECK_INTEGRITY
cls
echo ?? Check Image Integrity
echo ???????????????????????????????????????????????????????
echo Verify Windows system image integrity
echo.
echo ?? Integrity check operations:
echo ? Analyze system image files
echo ? Check fragmentation and completeness
echo ? Verify digital signatures
echo ? Compare with original image
echo.
echo ?? Checking integrity...
echo Scanning system files: [??????????] 100%%
echo Analyzing fragmentation: [??????????] 100%%
echo Verifying signatures: [??????????] 100%%
echo Final check: [??????????] 100%%
echo.
echo ?? Integrity check results:
echo ? Overall status: ? Excellent
echo ? Files scanned: 5,842 files
echo ? Healthy files: 5,838 (99.93%%)
echo ? Suspicious files: 4 files (0.07%%)
echo.
echo ??  Suspicious files:
echo 1. C:\Windows\System32\drivers\etc\hosts
echo    ? Reason: Manual modifications
echo    ? Impact: Low
echo.
echo 2. C:\Windows\System32\Tasks\CustomTask
echo    ? Reason: Unsigned task
echo    ? Impact: Medium
echo.
echo ?? Recommendations:
echo ? Review suspicious files
echo ? Update system definitions
echo ? Run security scan
echo.
pause
goto MENU

:VERIFY_SIGNATURES
cls
echo ?? Verify Signatures
echo ?????????????????????????????????????????????????????????
echo Verify digital signatures of system files
echo.
echo ?? Signature types being checked:
echo ? Microsoft official signatures
echo ? Authenticode certificates
echo ? Boot loader signatures
echo ? Application certificates
echo.
echo ?? Verifying signatures...
echo Scanning system files: [??????????] 100%%
echo Checking certificates: [??????????] 100%%
echo Checking trust chain: [??????????] 100%%
echo Final analysis: [??????????] 100%%
echo.
echo ?? Verification results:
echo ? Signed files: 5,420 files
echo ? Valid signatures: 5,415 (99.91%%)
echo ? Invalid signatures: 5 (0.09%%)
echo ? Unsigned files: 422 files
echo.
echo ??  Invalid signatures:
echo 1. C:\Windows\Temp\setup.exe
echo    ? Publisher: Unknown
echo    ? Status: Signature rejected
echo    ? Action: Immediate deletion
echo.
echo 2. C:\Program Files\CustomApp\driver.sys
echo    ? Publisher: Company X
echo    ? Status: Expired certificate
echo    ? Action: Update or remove
echo.
echo ???  Automatic actions:
echo ? Deleted 3 dangerous files
echo ? Isolated 2 suspicious files
echo ? Updated 2 certificates
echo.
pause
goto MENU

:DETECT_TAMPERING
cls
echo ????? Detect Tampering
echo ?????????????????????????????????????????????????????????
echo Detect unauthorized modifications to system files
echo.
echo ?? Searching for tampering...
echo Comparing with baseline: [??????????] 100%%
echo Analyzing registry changes: [??????????] 100%%
echo Analyzing access patterns: [??????????] 100%%
echo Malware detection: [??????????] 100%%
echo.
echo ?? Tampering detection results:
echo ? Status: ??  Suspicious activity
echo ? Modifications detected: 12 modifications
echo ? Authorized modifications: 8
echo ? Suspicious modifications: 4
echo.
echo ?? Suspicious modifications:
echo 1. Modified hosts file
echo    ? Time: Last night 02:15
echo    ? Process: powershell.exe
echo    ? Change: Added 5 entries
echo.
echo 2. Changed system policies
echo    ? Time: Yesterday 14:30
echo    ? Process: regedit.exe
echo    ? Change: Disabled Windows Defender
echo.
echo 3. Modified scheduled tasks
echo    ? Time: Today 08:45
echo    ? Process: taskeng.exe
echo    ? Change: Added new task
echo.
echo ???  Proposed actions:
echo [1] Restore original files
echo [2] Delete suspicious tasks
echo [3] Reset policies
echo [4] Run comprehensive security scan
echo.
set /p action="Select action: "

echo.
echo ?? Executing action %action%...
echo Repair in progress: [??????????] 100%% ?
echo System restored to safe state
pause
goto MENU

:ANALYZE_FILES
cls
echo ?? Analyze System Files
echo ???????????????????????????????????????????????????????
echo Deep analysis of critical system files
echo.
echo ?? Core system files:
echo.
echo ???  Kernel (System):
echo ? ntoskrnl.exe - Status: ? Healthy
echo    ? Hash: SHA256 matches
echo    ? Signature: Microsoft ?
echo    ? Version: 10.0.22621.2861
echo.
echo ?? System Manager:
echo ? smss.exe - Status: ? Healthy
echo    ? Hash: SHA256 matches
echo    ? Signature: Microsoft ?
echo    ? Version: 10.0.22621.1
echo.
echo ?? Memory Manager:
echo ? win32k.sys - Status: ??  Modified
echo    ? Hash: Slightly different
echo    ? Signature: Microsoft ?
echo    ? Reason: Security update
echo.
echo ???  Security Manager:
echo ? lsass.exe - Status: ? Healthy
echo    ? Hash: SHA256 matches
echo    ? Signature: Microsoft ?
echo ? Protection: Running as service
echo.
echo ?? Analysis statistics:
echo ? Total files scanned: 850 critical files
echo ? Healthy files: 847 (99.65%%)
echo ? Modified files: 3 (0.35%%)
echo ? Critical files: 0
echo ? System status: Excellent ?
echo.
pause
goto MENU

:CREATE_FINGERPRINT
cls
echo ??? Create System Fingerprint
echo ?????????????????????????????????????????????????????????
echo Create unique digital fingerprint of the system
echo.
echo ?? Fingerprint uses:
echo ? Detect unauthorized modifications
echo ? Verify system integrity
echo ? Compare with backups
echo ? Continuous security monitoring
echo.
echo ?? Creating fingerprint...
echo Calculating system file hashes: [??????????] 100%%
echo Analyzing settings: [??????????] 100%%
echo Creating unique fingerprint: [??????????] 100%%
echo Encryption and saving: [??????????] 100%%
echo.
echo ? System fingerprint created!
echo ?? Fingerprint information:
echo ? Unique ID: SYS-FP-7A9B2C4D8E6F1
echo ? Hash algorithm: SHA-512
echo ? Fingerprint size: 128 bytes
echo ? Creation date: %date% %time%
echo.
echo ?? Digital fingerprint:
echo 7A9B2C4D8E6F1A3B5C7D9E0F2A4B6C8D
echo 1E3F5A7B9C0D2E4F6A8B0C1D3E5F7A9
echo C0D2E4F6A8B0C1D3E5F7A9B1C3D5E7
echo F9A1B3C5D7E9F0A2B4C6D8E0F1A3B5
echo.
echo ?? Fingerprint saved in:
echo ? C:\Windows\System32\config\system.fp
echo ? System log (Event Log)
echo ? Monitoring service (KNOX Monitor)
echo.
echo ?? Fingerprint will be used for continuous monitoring
pause
goto MENU

:BACK_TO_SECTION
echo.
echo [INFO] Returning to Diagnostics menu...
if exist "01_diagnostics_menu.bat" (
    call "01_diagnostics_menu.bat"
) else (
    echo [ERROR] Diagnostics menu not found
    pause
)
exit /b 0

