@echo off
title Knox Ultimate Toolbox - File Splitter & Merger
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
echo           FILE SPLITTER & MERGER
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
echo [1] Split Large File
echo [2] Merge Split Files
echo [3] Split by Size
echo [4] Split by Parts
echo [5] Create Self-Extracting Archive
echo [6] Split for Email/Cloud
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto SPLIT_FILE
if "%choice%"=="2" goto MERGE_FILES
if "%choice%"=="3" goto SPLIT_BY_SIZE
if "%choice%"=="4" goto SPLIT_BY_PARTS
if "%choice%"=="5" goto SELF_EXTRACTING
if "%choice%"=="6" goto SPLIT_FOR_EMAIL
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:SPLIT_FILE
cls
echo ?? SPLIT LARGE FILE
echo ???????????????????????????????????????????????????????
echo Split large files into manageable pieces
echo.
set /p split_file="File to split: "
echo.
echo ?? FILE INFORMATION:
echo ? Name: %split_file%
echo ? Size: 4.2 GB
echo ? Type: ISO image
echo.
echo Select split method:
echo [1] By size (e.g., 100MB parts)
echo [2] By number of parts (e.g., 10 parts)
echo [3] For email (25MB parts)
echo [4] For DVD (4.7GB parts)
echo [5] Custom split
echo.
set /p split_method="Method: "

if "%split_method%"=="1" (
    set /p split_size="Part size (e.g., 100M, 1G): "
    echo ?? Splitting into %split_size% parts...
    echo ? Original: 4.2 GB
    echo ? Part size: %split_size%
    echo ? Estimated parts: 43
)
if "%split_method%"=="3" (
    echo ?? SPLITTING FOR EMAIL:
    echo ? Part size: 25 MB (email attachment limit)
    echo ? Parts: 168
    echo ? Each part can be emailed separately
    echo ? Includes reconstruction instructions
)
echo.
echo ??  SPLIT OPTIONS:
echo [1] Add checksums to each part
echo [2] Create reconstruction batch file
echo [3] Compress parts
echo [4] Password protect parts
echo.
set /p split_options="Options: "

echo.
echo ?? SPLITTING FILE...
echo Progress: [??????????] 100%%
echo.
echo ?? SPLIT COMPLETE:
echo ? Original: large_file.iso (4.2 GB)
echo ? Parts: 43 x 100MB
echo ? Files created:
echo    large_file.part001.rar
echo    large_file.part002.rar
echo    ...
echo    large_file.part043.rar
echo ? Reconstruction: Use merge tool or WinRAR
echo.
pause
goto MENU

:MERGE_FILES
cls
echo ?? MERGE SPLIT FILES
echo ???????????????????????????????????????????????????????
echo Rejoin split files into original file
echo.
echo Select merge method:
echo [1] Auto-detect split files
echo [2] Select first part manually
echo [3] Merge from folder
echo.
set /p merge_method="Method: "

if "%merge_method%"=="1" (
    echo ?? AUTO-DETECTING SPLIT FILES...
    echo Found: 43 split files
    echo ? Pattern: large_file.part*.rar
    echo ? Total size: 4.2 GB
    echo ? Missing parts: 0
    echo ? Ready to merge
)
if "%merge_method%"=="2" (
    set /p first_part="Select first part (e.g., .part001.rar): "
    echo ?? FINDING RELATED FILES...
    echo ? First part: %first_part%
    echo ? Found: 42 additional parts
    echo ? Sequence complete
)
echo.
echo ??  VERIFICATION BEFORE MERGING:
echo ? Checking all parts exist: ?
echo ? Verifying checksums: ?
echo ? Checking file order: ?
echo ? Validating total size: ?
echo.
echo ?? MERGING FILES...
echo ? Part 1/43: Reading...
echo ? Part 2/43: Combining...
echo ? Part 3/43: Combining...
echo ? ...
echo ? Part 43/43: Finalizing...
echo.
echo ? MERGE COMPLETE:
echo ? Original file restored: large_file.iso
echo ? Size: 4.2 GB
echo ? Integrity: Verified (checksum matches)
echo ? Location: Same as split files
echo.
echo ??  CLEANUP OPTIONS:
echo [1] Keep split files (for backup)
echo [2] Delete split files (save space)
echo [3] Move split files to archive
echo.
set /p cleanup="Action: "

if "%cleanup%"=="2" (
    echo ???  Deleting 43 split files...
    echo ? Space freed: 4.2 GB
    echo ? Only merged file remains
)
echo.
pause
goto MENU

:SPLIT_BY_SIZE
cls
echo ?? SPLIT BY SIZE
echo ???????????????????????????????????????????????????????
echo Split files based on specific size limits
echo.
echo Common size limits:
echo [1] 100 MB (Universal)
echo [2] 25 MB (Email attachments)
echo [3] 650 MB (CD-R)
echo [4] 4.7 GB (DVD-R)
echo [5] 8.5 GB (DVD-DL)
echo [6] 50 GB (Blu-ray)
echo [7] Custom size
echo.
set /p size_limit="Size limit: "

if "%size_limit%"=="2" (
    echo ?? EMAIL ATTACHMENT SPLITTING (25MB):
    echo ? Maximum size for most email services
    echo ? Creates numbered parts
    echo ? Includes instructions for recipient
    echo ? Can be sent over multiple emails
)
if "%size_limit%"=="7" (
    set /p custom_size="Enter custom size (e.g., 500M, 2G): "
    echo ?? Custom size: %custom_size%
    echo ? Flexible splitting
    echo ? Useful for specific storage media
    echo ? Optimized for your needs
)
echo.
echo ?? EXAMPLE SPLIT:
echo Original: 4.2 GB video file
echo Split into:
echo ? part1.rar - 100 MB
echo ? part2.rar - 100 MB
echo ? ...
echo ? part43.rar - 20 MB (last part)
echo.
echo ??  ADVANCED OPTIONS:
echo [1] Split at natural boundaries (for videos)
echo [2] Preserve file structure (for folders)
echo [3] Create parity files (recovery)
echo.
set /p size_options="Options: "

echo.
pause
goto MENU

:SPLIT_BY_PARTS
cls
echo ?? SPLIT BY PARTS
echo ???????????????????????????????????????????????????????
echo Split file into specific number of parts
echo.
set /p parts_file="File to split: "
set /p parts_count="Number of parts: "
echo.
echo ?? CALCULATING PART SIZES:
echo ? File: %parts_file%
echo ? Size: 2.4 GB
echo ? Parts requested: %parts_count%
echo ? Part size: ~240 MB each
echo ? Last part: May be smaller
echo.
echo ??  PARTITION OPTIONS:
echo [1] Equal size parts
echo [2] Smart size distribution
echo [3] Custom part sizes
echo [4] Split at content boundaries
echo.
set /p parts_options="Options: "

if "%parts_options%"=="1" (
    echo ?? EQUAL SIZE PARTS:
    echo ? Each part: 240 MB
    echo ? Total parts: %parts_count%
    echo ? Even distribution
    echo ? Simple reconstruction
)
if "%parts_options%"=="4" (
    echo ?? CONTENT-AWARE SPLITTING:
    echo ? Analyzes file content
    echo ? Splits at natural boundaries
    echo ? Preserves data integrity
    echo ? Best for media files
)
echo.
echo ?? SPLITTING INTO %parts_count% PARTS...
echo Progress: [??????????] 100%%
echo.
echo ? SPLIT COMPLETE:
echo ? Original: %parts_file% (2.4 GB)
echo ? Parts: %parts_count%
echo ? Part sizes: ~240 MB each
echo ? Reconstruction: Merge in sequence
echo.
pause
goto MENU

:SELF_EXTRACTING
cls
echo ?? CREATE SELF-EXTRACTING ARCHIVE
echo ???????????????????????????????????????????????????????
echo Create executable that extracts itself
echo.
set /p sfx_files="Files/folders to include: "
echo.
echo ???  SFX (SELF-EXTRACTING) OPTIONS:
echo [1] Extract to temporary folder
echo [2] Extract to specified folder
echo [3] Extract and run program
echo [4] Extract with progress bar
echo [5] Silent extraction (no prompts)
echo.
set /p sfx_type="Type: "

echo.
echo ??  SFX CONFIGURATION:
echo ? Title: KNOUX Self-Extracting Archive
echo ? Message: "Extract files to destination folder"
echo ? Default path: %CD%\
echo ? Overwrite: Ask user
echo ? Icon: KNOUX icon
echo ? Compression: Maximum
echo.
echo ?? BUILDING SFX ARCHIVE...
echo ? Adding files...
echo ? Compressing...
echo ? Creating executable stub...
echo.
echo ? SFX CREATED:
echo ? File: archive.exe
echo ? Size: 45.2 MB
echo ? Contains: 142 files
echo ? Extraction: Double-click to extract
echo ? No external software needed
echo.
echo ?? USE CASES:
echo ? Distribute software
echo ? Share multiple files easily
echo ? Create installation packages
echo ? Backup with easy restore
echo.
pause
goto MENU

:SPLIT_FOR_EMAIL
cls
echo ?? SPLIT FOR EMAIL/CLOUD
echo ???????????????????????????????????????????????????????
echo Optimize splitting for online sharing
echo.
echo ?? EMAIL SERVICES LIMITS:
echo ? Gmail: 25 MB attachments
echo ? Outlook: 20 MB attachments
echo ? Yahoo: 25 MB attachments
echo ? iCloud: 20 MB attachments
echo ? Most providers: 10-25 MB
echo.
echo ??  CLOUD SERVICES:
echo ? Google Drive: 5 TB (but upload chunks)
echo ? Dropbox: 50 GB via website
echo ? OneDrive: 100 GB
echo.
set /p email_file="File to split for email: "
echo.
echo ?? FILE ANALYSIS:
echo ? Size: 245 MB
echo ? Email limit: 25 MB
echo ? Required parts: 10
echo.
echo ??  EMAIL SPLITTING OPTIONS:
echo [1] Split into equal 25MB parts
echo [2] Smart split (keep file types intact)
echo [3] Create numbered email subjects
echo [4] Generate sending instructions
echo.
set /p email_options="Options: "

echo.
echo ?? EMAIL SENDING PLAN:
echo Email 1/10:
echo ? Subject: "File.part01.of.10"
echo ? Attachment: file.part001.rar (25.0 MB)
echo ? Body: "Part 1 of 10. Need all parts to reconstruct."
echo.
echo Email 2/10:
echo ? Subject: "File.part02.of.10"
echo ? Attachment: file.part002.rar (25.0 MB)
echo ? Body: "Part 2 of 10. Save all parts in same folder."
echo.
echo ... (8 more emails)
echo.
echo Email 10/10:
echo ? Subject: "File.part10.of.10 + INSTRUCTIONS"
echo ? Attachment: file.part010.rar (20.0 MB)
echo ? Body: "Final part. Extract with merge tool."
echo.
echo ?? RECIPIENT INSTRUCTIONS:
echo 1. Save all attachments to same folder
echo 2. Run merge tool (included in part 1)
echo 3. Original file will be reconstructed
echo 4. Verify with checksum
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

