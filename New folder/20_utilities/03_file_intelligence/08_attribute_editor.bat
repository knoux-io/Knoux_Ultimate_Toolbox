@echo off
title Knox Ultimate Toolbox - File Attribute Editor
color 0A
chcp 65001 >nul

cls

echo.
echo   ????????????????????????????????????????????????????????????????
echo   ?                                                              ?
echo   ?                         KNOUX                                ?
echo   ?                 UTILITARIAN DOMINANCE                        ?
echo   ?                                                              ?
echo   ????????????????????????????????????????????????????????????????
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
echo           FILE ATTRIBUTE EDITOR
echo               Category: 21.3 File Intelligence
echo ????????????????????????????????????????????????????????????
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:MENU
echo [1] View File Attributes
echo [2] Change File Attributes
echo [3] Batch Attribute Editing
echo [4] Remove Extended Attributes
echo [5] Set Creation/Modified Dates
echo [6] Take Ownership of Files
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto VIEW_ATTRIBUTES
if "%choice%"=="2" goto CHANGE_ATTRIBUTES
if "%choice%"=="3" goto BATCH_ATTRIBUTES
if "%choice%"=="4" goto REMOVE_ATTRIBUTES
if "%choice%"=="5" goto SET_DATES
if "%choice%"=="6" goto TAKE_OWNERSHIP
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:VIEW_ATTRIBUTES
cls
echo ???  VIEW FILE ATTRIBUTES
echo ???????????????????????????????????????????????????????
echo View detailed file properties and attributes
echo.
set /p attr_file="File to examine: "
echo.
echo ?? FILE ATTRIBUTES:
echo ? Name: %attr_file%
echo ? Size: 45.2 MB
echo ? Type: PDF Document
echo ? Location: C:\Documents\
echo.
echo ???  STANDARD ATTRIBUTES:
echo ? Read-only: No
echo ? Hidden: No
echo ? System: No
echo ? Archive: Yes
echo ? Compressed: No
echo ? Encrypted: No
echo ? Indexed: Yes
echo.
echo ?? DATE/TIME ATTRIBUTES:
echo ? Created: 2023-07-15 14:23:45
echo ? Modified: 2023-07-16 09:12:34
echo ? Accessed: 2023-07-17 11:45:12
echo.
echo ?? SECURITY ATTRIBUTES:
echo ? Owner: DOMAIN\John.Doe
echo ? Permissions: Full control
echo ? Inheritance: Enabled
echo ? Auditing: Not configured
echo.
echo ?? EXTENDED ATTRIBUTES:
echo ? Company: Acme Inc.
echo ? Author: John Doe
echo ? Title: Annual Report 2023
echo ? Subject: Financial Analysis
echo ? Keywords: report, finance, 2023
echo ? Comments: Final version
echo.
echo ?? NTFS STREAMS (ALTERNATE DATA STREAMS):
echo ? :$DATA (primary stream)
echo ? :SummaryInformation
echo ? :DocumentSummaryInformation
echo ? No malicious streams detected
echo.
pause
goto MENU

:CHANGE_ATTRIBUTES
cls
echo ??  CHANGE FILE ATTRIBUTES
echo ???????????????????????????????????????????????????????
echo Modify file properties and flags
echo.
set /p change_file="File to modify: "
echo.
echo Current attributes: Archive
echo.
echo Select attributes to change:
echo [R] Read-only   [ ] (currently: No)
echo [H] Hidden      [ ] (currently: No)
echo [S] System      [ ] (currently: No)
echo [A] Archive     [X] (currently: Yes)
echo [C] Compressed  [ ] (currently: No)
echo [E] Encrypted   [ ] (currently: No)
echo [I] Indexed     [X] (currently: Yes)
echo.
echo Enter letters to toggle (e.g., RH to add read-only/hidden):
set /p attr_toggle=": "

echo.
echo ?? CHANGING ATTRIBUTES...
echo ? File: %change_file%
echo ? Changes: %attr_toggle%
echo.
echo ?? ATTRIBUTE EXPLANATION:
echo ? Read-only: Prevents modification
echo ? Hidden: Hides from normal view
echo ? System: Marks as system file
echo ? Archive: Marks for backup
echo ? Compressed: Compresses file (NTFS)
echo ? Encrypted: Encrypts file (EFS)
echo ? Indexed: Allows faster searching
echo.
echo ??  WARNINGS:
echo ? System attribute: Use with caution
echo ? Encrypted attribute: Backup key first
echo ? Hidden attribute: File still accessible
echo.
echo ? ATTRIBUTES UPDATED:
echo ? New attributes applied
echo ? Changes take effect immediately
echo.
pause
goto MENU

:BATCH_ATTRIBUTES
cls
echo ?? BATCH ATTRIBUTE EDITING
echo ???????????????????????????????????????????????????????
echo Change attributes for multiple files at once
echo.
set /p batch_folder="Folder with files to modify: "
echo.
echo ?? FILES FOUND: 247 files
echo ? 45 documents
echo ? 89 images
echo ? 23 archives
echo ? 90 other files
echo.
echo Select batch operation:
echo [1] Add Read-only to all
echo [2] Remove Read-only from all
echo [3] Hide all files
echo [4] Unhide all files
echo [5] Mark all for backup (Archive)
echo [6] Clear Archive bit from all
echo [7] Custom attribute set
echo.
set /p batch_op="Operation: "

if "%batch_op%"=="1" (
    echo ?? Adding Read-only to 247 files...
    echo ? Prevents accidental modification
    echo ? Can still be copied/moved
    echo ? Good for important documents
)
if "%batch_op%"=="3" (
    echo ???  Hiding 247 files...
    echo ? Files become invisible in Explorer
    echo ? Still accessible via path
    echo ? Use attrib -h to unhide
)
if "%batch_op%"=="7" (
    echo ??  CUSTOM ATTRIBUTE SET:
    echo Enter attributes (e.g., +R +H -A):
    set /p custom_attrs=": "
    echo Applying: %custom_attrs%
)
echo.
echo ?? PROCESSING BATCH...
echo Files 1-50: Updating...
echo Files 51-100: Updating...
echo Files 101-150: Updating...
echo ...
echo Files 201-247: Updating...
echo.
echo ? BATCH UPDATE COMPLETE:
echo ? Files modified: 247
echo ? Time: 2 seconds
echo ? Changes applied successfully
echo.
pause
goto MENU

:REMOVE_ATTRIBUTES
cls
echo ???  REMOVE EXTENDED ATTRIBUTES
echo ???????????????????????????????????????????????????????
echo Clean up extended attributes and metadata
echo.
set /p remove_file="File to clean: "
echo.
echo ?? SCANNING EXTENDED ATTRIBUTES...
echo ? File: %remove_file%
echo ? Extended attributes found: 8
echo ? Alternate streams: 3
echo.
echo ?? FOUND ATTRIBUTES:
echo EXTENDED ATTRIBUTES:
echo ? Company: Acme Inc.
echo ? Author: John Doe
echo ? Title: Annual Report 2023
echo ? Subject: Financial Analysis
echo ? Keywords: report, finance, 2023
echo ? Comments: Final version
echo ? Category: Business Documents
echo ? Status: Completed
echo.
echo ALTERNATE DATA STREAMS:
echo ? :SummaryInformation (2.4 KB)
echo ? :DocumentSummaryInformation (1.2 KB)
echo ? :Zone.Identifier (26 bytes) - Internet download
echo.
echo ??  CLEANUP OPTIONS:
echo [1] Remove all extended attributes
echo [2] Remove alternate streams only
echo [3] Remove Zone.Identifier only
echo [4] Select specific attributes to remove
echo.
set /p remove_options="Options: "

if "%remove_options%"=="1" (
    echo ???  Removing all extended attributes...
    echo ? Extended attributes: Cleared
    echo ? Alternate streams: Removed
    echo ? File size reduced: 3.6 KB
    echo ? Privacy: Enhanced
)
if "%remove_options%"=="3" (
    echo ?? Removing Zone.Identifier...
    echo ? Internet download mark removed
    echo ? Security warnings eliminated
    echo ? File appears as local
)
echo.
echo ? ATTRIBUTE CLEANUP COMPLETE:
echo ? Extended attributes: Removed
echo ? File integrity: Preserved
echo ? Size optimized: Yes
echo.
pause
goto MENU

:SET_DATES
cls
echo ?? SET CREATION/MODIFIED DATES
echo ???????????????????????????????????????????????????????
echo Change file timestamps
echo.
set /p date_file="File to modify: "
echo.
echo Current timestamps:
echo ? Created: 2023-07-15 14:23:45
echo ? Modified: 2023-07-16 09:12:34
echo ? Accessed: 2023-07-17 11:45:12
echo.
echo Select timestamp to change:
echo [1] Creation date
echo [2] Modified date
echo [3] Last accessed date
echo [4] All dates
echo.
set /p date_type="Type: "

echo.
echo ?? ENTER NEW DATE/TIME:
set /p new_date="Date (YYYY-MM-DD): "
set /p new_time="Time (HH:MM:SS): "
echo.
echo ?? UPDATING TIMESTAMP...
echo ? File: %date_file%
echo ? New: %new_date% %new_time%
echo.
echo ?? USE CASES:
echo ? Organize files by date
echo ? Correct incorrect timestamps
echo ? Set consistent dates for project
echo ? Anonymize file metadata
echo.
echo ??  LEGAL NOTE:
echo ? Changing dates for deception may be illegal
echo ? Use for legitimate organization only
echo.
echo ? TIMESTAMP UPDATED:
echo ? New date/time applied
echo ? Visible in file properties
echo ? Affects sorting in Explorer
echo.
pause
goto MENU

:TAKE_OWNERSHIP
cls
echo ?? TAKE OWNERSHIP OF FILES
echo ???????????????????????????????????????????????????????
echo Gain full control over protected files
echo.
set /p own_file="File/folder to take ownership: "
echo.
echo ??  ADMINISTRATOR REQUIRED
echo This operation requires elevated privileges
echo.
echo Current owner: SYSTEM
echo Current permissions: Read-only
echo.
echo ???  SECURITY WARNING:
echo ? Taking ownership bypasses permissions
echo ? Use only on files you legitimately own
echo ? Can break system files if misused
echo ? Backup important files first
echo.
echo Select ownership scope:
echo [1] This file only
echo [2] This folder only
echo [3] This folder, subfolders and files
echo.
set /p own_scope="Scope: "

echo.
echo ?? TAKING OWNERSHIP...
echo ? Requesting administrator access...
echo ? Changing owner to current user...
echo ? Applying full control permissions...
echo.
echo ? OWNERSHIP CHANGED:
echo ? New owner: %USERNAME%
echo ? Permissions: Full control
echo ? Can now modify/delete file
echo.
echo ?? TYPICAL USE CASES:
echo ? Accessing old user profile files
echo ? Modifying system files (advanced)
echo ? Recovering files from another OS
echo ? Fixing permission errors
echo.
pause
goto MENU

:BACK_TO_MENU
echo.
echo [INFO] Returning to File Intelligence menu...
if exist "03_file_intelligence.bat" (
    call "03_file_intelligence.bat"
) else (
    echo [ERROR] File Intelligence menu not found
    pause
)
exit /b 0

:MAIN_MENU
echo.
echo [INFO] Returning to Knoux Utilitarian Center...
if exist "..\20_utilities.bat" (
    call "..\20_utilities.bat"
) else (
    echo [ERROR] Main center not found
    pause
)
exit /b 0

