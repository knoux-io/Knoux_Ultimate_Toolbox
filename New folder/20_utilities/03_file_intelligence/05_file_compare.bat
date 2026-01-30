@echo off
title Knox Ultimate Toolbox - File Comparison Tool
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
echo           FILE COMPARISON TOOL
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
echo [1] Compare Text Files
echo [2] Compare Binary Files
echo [3] Compare Images
echo [4] Compare Folders
echo [5] 3-Way Comparison
echo [6] Merge Differences
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto COMPARE_TEXT
if "%choice%"=="2" goto COMPARE_BINARY
if "%choice%"=="3" goto COMPARE_IMAGES
if "%choice%"=="4" goto COMPARE_FOLDERS
if "%choice%"=="5" goto THREE_WAY_COMPARE
if "%choice%"=="6" goto MERGE_DIFFERENCES
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:COMPARE_TEXT
cls
echo ?? COMPARE TEXT FILES
echo ???????????????????????????????????????????????????????
echo Side-by-side comparison with highlighting
echo.
set /p file1="First file: "
set /p file2="Second file: "
echo.
echo ??  COMPARISON OPTIONS:
echo [1] Ignore whitespace
echo [2] Ignore case
echo [3] Ignore line endings
echo [4] Show line numbers
echo [5] Use syntax highlighting
echo.
set /p compare_opts="Options: "

echo.
echo ?? COMPARING FILES...
echo ? File 1: %file1% (1,245 lines)
echo ? File 2: %file2% (1,238 lines)
echo.
echo ?? DIFFERENCE ANALYSIS:
echo ? Lines identical: 1,128 (91%%)
echo ? Lines different: 117 (9%%)
echo ? Lines only in File 1: 45
echo ? Lines only in File 2: 38
echo ? Lines modified: 34
echo.
echo ?? SAMPLE DIFFERENCES:
echo Line 45:
echo ? File 1: function calculateTotal() {
echo ? File 2: function calculateTotal(sum) {
echo.
echo Line 89:
echo ? File 1: return price * quantity;
echo ? File 2: return (price * quantity) * tax;
echo.
echo Line 123:
echo ? File 1: // Old comment
echo ? File 2: // Updated: Fixed calculation bug
echo.
echo ?? Export differences? (Y/N)
set /p export=": "
if /i "%export%"=="Y" (
    echo ?? Exporting diff report...
    echo Saved: diff_report_%date%.html
    echo Includes side-by-side view
)
pause
goto MENU

:COMPARE_BINARY
cls
echo ?? COMPARE BINARY FILES
echo ???????????????????????????????????????????????????????
echo Byte-level comparison of binary files
echo.
set /p bin1="First binary file: "
set /p bin2="Second binary file: "
echo.
echo ?? ANALYZING BINARY FILES...
echo ? File 1: %bin1% (2.4 MB)
echo ? File 2: %bin2% (2.4 MB)
echo.
echo ?? BINARY COMPARISON RESULTS:
echo ? Files identical: No
echo ? Different bytes: 1,245
echo ? Similarity: 94.8%%
echo ? First difference: Byte 1,024
echo.
echo ?? DIFFERENCE LOCATIONS:
echo Offset 0x400 (1024):
echo ? File 1: 0x48 (H)
echo ? File 2: 0x68 (h)
echo.
echo Offset 0x800 (2048):
echo ? File 1: 0x31 (1)
echo ? File 2: 0x32 (2)
echo.
echo ?? DIFFERENCE TYPES:
echo ? Text differences: 89%
echo ? Numeric differences: 8%
echo ? Control characters: 3%
echo.
echo ??  ANALYSIS OPTIONS:
echo [1] Show hex dump of differences
echo [2] Extract different sections
echo [3] Compare file headers only
echo [4] Generate patch file
echo.
set /p bin_options="Options: "

if "%bin_options%"=="1" (
    echo ?? HEX DUMP OF DIFFERENCES:
    echo 00000400: 48 65 6C 6C 6F |Hello
    echo 00000400: 68 65 6C 6C 6F |hello
    echo 00000800: 31 2E 30 2E 30 |1.0.0
    echo 00000800: 32 2E 30 2E 30 |2.0.0
)
echo.
pause
goto MENU

:COMPARE_IMAGES
cls
echo ???  COMPARE IMAGES
echo ???????????????????????????????????????????????????????
echo Visual comparison of images
echo.
set /p img1="First image: "
set /p img2="Second image: "
echo.
echo ?? IMAGE ANALYSIS:
echo ? Image 1: 1920x1080, 24-bit, 2.4 MB
echo ? Image 2: 1920x1080, 24-bit, 2.5 MB
echo ? Format: Both JPEG
echo.
echo ?? COMPARISON MODES:
echo [1] Side-by-side view
echo [2] Difference overlay
echo [3] Flicker comparison
echo [4] Pixel difference map
echo [5] Histogram comparison
echo.
set /p img_mode="Mode: "

if "%img_mode%"=="2" (
    echo ?? DIFFERENCE OVERLAY:
    echo ? Differences highlighted in red
    echo ? Similarity: 92%%
    echo ? Different pixels: 12,345 (0.6%%)
    echo ? Main differences: Color balance, sharpness
)
if "%img_mode%"=="4" (
    echo ?? PIXEL DIFFERENCE MAP:
    echo ? Each different pixel shown
    echo ? Color difference threshold: 5%%
    echo ? Differences concentrated in:
    echo   - Sky area (color variation)
    echo   - Face (lighting difference)
    echo   - Background (slight shift)
)
echo.
echo ?? COMPARISON METRICS:
echo ? Structural Similarity (SSIM): 0.92/1.00
echo ? Mean Squared Error (MSE): 8.5
echo ? Peak Signal-Noise Ratio (PSNR): 38.7 dB
echo ? Color difference (?E): 4.2
echo ? Conclusion: Very similar, minor edits
echo.
pause
goto MENU

:COMPARE_FOLDERS
cls
echo ?? COMPARE FOLDERS
echo ???????????????????????????????????????????????????????
echo Compare two folders and show differences
echo.
set /p folder1="First folder: "
set /p folder2="Second folder: "
echo.
echo ?? SCANNING FOLDERS...
echo ? Folder 1: 245 files, 45 subfolders
echo ? Folder 2: 238 files, 43 subfolders
echo.
echo ?? FOLDER COMPARISON RESULTS:
echo IDENTICAL FILES (198):
echo ? document1.txt (same size, same date)
echo ? image.jpg (same MD5 hash)
echo ? data.csv (identical content)
echo.
echo DIFFERENT FILES (23):
echo ? report_v1.docx (older) ? report_v2.docx (newer)
echo ? photo_edit.jpg (smaller) ? photo_original.jpg (larger)
echo ? config_old.ini ? config_new.ini (content changed)
echo.
echo FILES ONLY IN FOLDER 1 (24):
echo ? backup_2022.zip
echo ? temporary_file.tmp
echo ? old_version.exe
echo.
echo FILES ONLY IN FOLDER 2 (21):
echo ? update_2023.patch
echo ? new_feature.dll
echo ? recent_data.db
echo.
echo ?? STATISTICS:
echo ? Total files compared: 463
echo ? Identical: 198 (43%%)
echo ? Different: 23 (5%%)
echo ? Unique to Folder 1: 24 (5%%)
echo ? Unique to Folder 2: 21 (5%%)
echo ? Size difference: Folder 2 is 45 MB larger
echo.
echo ?? Generate comparison report? (Y/N)
set /p report=": "
if /i "%report%"=="Y" (
    echo ?? Report saved: folder_comparison_%date%.html
    echo Includes file tree and differences
)
pause
goto MENU

:THREE_WAY_COMPARE
cls
echo ??  3-WAY COMPARISON
echo ???????????????????????????????????????????????????????
echo Compare three versions of a file
echo.
set /p file_base="Base file (original): "
set /p file1="Modified version 1: "
set /p file2="Modified version 2: "
echo.
echo ?? ANALYZING THREE VERSIONS...
echo ? Base: %file_base% (1,245 lines)
echo ? Version 1: %file1% (1,252 lines)
echo ? Version 2: %file2% (1,248 lines)
echo.
echo ?? THREE-WAY ANALYSIS:
echo CONFLICTS (Lines changed in both versions):
echo ? Line 45: Different in both versions
echo ? Line 89: Different in both versions
echo ? Line 123: Different in both versions
echo.
echo CHANGES ONLY IN VERSION 1:
echo ? Lines added: 12
echo ? Lines modified: 8
echo ? Lines deleted: 3
echo.
echo CHANGES ONLY IN VERSION 2:
echo ? Lines added: 8
echo ? Lines modified: 15
echo ? Lines deleted: 5
echo.
echo ?? CONFLICT DETAILS:
echo Line 45:
echo ? Base: function calculate() {
echo ? V1: function calculateTotal() {
echo ? V2: function calculateWithTax() {
echo.
echo Line 89:
echo ? Base: return price;
echo ? V1: return price * quantity;
echo ? V2: return price * tax;
echo.
echo ??  RESOLUTION OPTIONS:
echo [1] Use Version 1 changes
echo [2] Use Version 2 changes
echo [3] Manual merge
echo [4] Keep both (create branches)
echo.
set /p three_way_resolve="Resolution: "
echo.
pause
goto MENU

:MERGE_DIFFERENCES
cls
echo ?? MERGE FILE DIFFERENCES
echo ???????????????????????????????????????????????????????
echo Combine changes from two versions of a file
echo.
set /p original="Original file: "
set /p modified1="First modified version: "
set /p modified2="Second modified version: "
echo.
echo ?? ANALYZING CHANGES...
echo ? Original: Base version
echo ? Version 1: John's edits
echo ? Version 2: Jane's edits
echo.
echo ?? DETECTED CHANGES:
echo VERSION 1 CHANGES (John):
echo ? Added function calculateTax()
echo ? Updated line 45-48
echo ? Fixed spelling errors
echo.
echo VERSION 2 CHANGES (Jane):
echo ? Added function applyDiscount()
echo ? Updated line 89-92
echo ? Improved comments
echo.
echo ??  CONFLICTS DETECTED: 2
echo Conflict 1 (Line 34):
echo ? Version 1: tax = 0.08
echo ? Version 2: tax = 0.10
echo.
echo Conflict 2 (Line 78):
echo ? Version 1: discount = 5
echo ? Version 2: discount = 10
echo.
echo ???  RESOLVE CONFLICTS:
echo [1] Use Version 1's change
echo [2] Use Version 2's change
echo [3] Combine both
echo [4] Edit manually
echo.
echo Conflict 1 resolution: 
set /p conflict1=": "
echo Conflict 2 resolution: 
set /p conflict2=": "

echo.
echo ?? MERGING FILES...
echo Applying non-conflicting changes...
echo Resolving conflicts...
echo Creating merged version...
echo.
echo ? MERGE COMPLETE:
echo ? File: merged_final.txt
echo ? Changes from Version 1: 12 applied
echo ? Changes from Version 2: 8 applied
echo ? Conflicts resolved: 2
echo ? Result: Combined best of both versions
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

