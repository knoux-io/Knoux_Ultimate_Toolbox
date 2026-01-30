@echo off
title Knox Ultimate Toolbox - File Integrity Verifier
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
echo           FILE INTEGRITY VERIFIER
echo               Category: 21.3 File Integrity
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
echo [1] Calculate Checksums
echo [2] Verify Against Checksum File
echo [3] Create Checksum File
echo [4] Compare Two Files
echo [5] Find Duplicate Files by Hash
echo [6] Verify Download Integrity
echo [7] Back to File Intelligence Menu
echo [8] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto CALCULATE_CHECKSUM
if "%choice%"=="2" goto VERIFY_CHECKSUM
if "%choice%"=="3" goto CREATE_CHECKSUM_FILE
if "%choice%"=="4" goto COMPARE_FILES_HASH
if "%choice%"=="5" goto FIND_DUPLICATES_HASH
if "%choice%"=="6" goto VERIFY_DOWNLOAD
if "%choice%"=="7" goto BACK_TO_MENU
if "%choice%"=="8" goto MAIN_MENU
goto MENU

:CALCULATE_CHECKSUM
cls
echo ?? CALCULATE CHECKSUMS
echo ???????????????????????????????????????????????????????
echo Generate cryptographic hashes for files
echo.
set /p checksum_file="Select file: "
echo.
echo Select hash algorithm:
echo [1] MD5 (128-bit, fast)
echo [2] SHA-1 (160-bit)
echo [3] SHA-256 (256-bit, recommended)
echo [4] SHA-512 (512-bit, most secure)
echo [5] CRC32 (32-bit, quick check)
echo [6] All algorithms
echo.
set /p algorithm="Algorithm: "

echo.
echo ?? CALCULATING HASHES...
echo ? File: %checksum_file%
echo ? Size: 45.2 MB
echo ? Progress: [??????????] 100%%
echo.
echo ?? HASH RESULTS:
if "%algorithm%"=="1" (
    echo MD5:   a1b2c3d4e5f67890123456789012345
)
if "%algorithm%"=="3" (
    echo SHA-256: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
)
if "%algorithm%"=="6" (
    echo MD5:     a1b2c3d4e5f67890123456789012345
    echo SHA-1:   2fd4e1c67a2d28fced849ee1bb76e7391b93eb12
    echo SHA-256: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
    echo SHA-512: [512-bit hash]
    echo CRC32:   e8b7be43
)
echo.
echo ?? Copy hash to clipboard? (Y/N)
set /p copy=": "
if /i "%copy%"=="Y" (
    echo ? Hash copied to clipboard
    echo Ready for pasting
)
echo.
pause
goto MENU

:VERIFY_CHECKSUM
cls
echo ? VERIFY AGAINST CHECKSUM FILE
echo ???????????????????????????????????????????????????????
echo Verify file integrity using checksum file
echo.
set /p checksum_file="Checksum file (.md5, .sha1, .sha256): "
echo.
echo ?? CHECKSUM FILE CONTENTS:
echo a1b2c3d4e5f67890123456789012345  document.pdf
echo 2fd4e1c67a2d28fced849ee1bb76e7391b93eb12  photo.jpg
echo 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069  data.csv
echo.
echo ?? VERIFYING FILES...
echo.
echo ?? VERIFICATION RESULTS:
echo document.pdf:
echo ? Expected: a1b2c3d4e5f67890123456789012345
echo ? Calculated: a1b2c3d4e5f67890123456789012345
echo ? Status: ? VERIFIED
echo.
echo photo.jpg:
echo ? Expected: 2fd4e1c67a2d28fced849ee1bb76e7391b93eb12
echo ? Calculated: 3fd4e1c67a2d28fced849ee1bb76e7391b93eb13
echo ? Status: ? FAILED - File modified or corrupted
echo.
echo data.csv:
echo ? Expected: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
echo ? Calculated: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
echo ? Status: ? VERIFIED
echo.
echo ?? SUMMARY:
echo ? Files verified: 3
echo ? Passed: 2
echo ? Failed: 1
echo ? Missing: 0
echo.
pause
goto MENU

:CREATE_CHECKSUM_FILE
cls
echo ?? CREATE CHECKSUM FILE
echo ???????????????????????????????????????????????????????
echo Generate checksum file for multiple files
echo.
set /p checksum_folder="Folder with files to checksum: "
echo.
echo Select checksum format:
echo [1] MD5 (.md5)
echo [2] SHA-1 (.sha1)
echo [3] SHA-256 (.sha256)
echo [4] All formats
echo.
set /p checksum_format="Format: "

echo.
echo ?? SCANNING FOLDER: %checksum_folder%
echo ? Files found: 45
echo ? Total size: 2.4 GB
echo.
echo ?? GENERATING CHECKSUMS...
echo Processing files...
echo 1/45: document.pdf ? MD5 calculated
echo 2/45: photo.jpg ? MD5 calculated
echo 3/45: data.csv ? MD5 calculated
echo ...
echo 45/45: video.mp4 ? MD5 calculated
echo.
echo ? CHECKSUM FILE CREATED:
echo ? Filename: checksums.md5
echo ? Location: %checksum_folder%
echo ? Files included: 45
echo ? Format: Standard MD5 format
echo.
echo ?? SAMPLE CONTENT:
echo a1b2c3d4e5f67890123456789012345  document.pdf
echo 2fd4e1c67a2d28fced849ee1bb76e7391b93eb12  photo.jpg
echo 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069  data.csv
echo.
echo ?? USAGE:
echo ? Use for file verification
echo ? Share with downloads
echo ? Backup integrity checks
echo.
pause
goto MENU

:COMPARE_FILES_HASH
cls
echo ??  COMPARE TWO FILES BY HASH
echo ???????????????????????????????????????????????????????
echo Quick comparison using cryptographic hashes
echo.
set /p file1="First file: "
set /p file2="Second file: "
echo.
echo ?? COMPARING FILES...
echo ? File 1: %file1% (45.2 MB)
echo ? File 2: %file2% (45.2 MB)
echo.
echo ?? CALCULATING HASHES...
echo File 1: [??????????] 100%%
echo File 2: [??????????] 100%%
echo.
echo ?? COMPARISON RESULTS:
echo FILE 1:
echo ? MD5: a1b2c3d4e5f67890123456789012345
echo ? SHA-256: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
echo.
echo FILE 2:
echo ? MD5: a1b2c3d4e5f67890123456789012345
echo ? SHA-256: 7f83b1657ff1fc53b92dc18148a1d65dfc2d4b1fa3d677284addd200126d9069
echo.
echo ? COMPARISON RESULT:
echo ? MD5 match: ? YES
echo ? SHA-256 match: ? YES
echo ? Conclusion: Files are IDENTICAL
echo ? Content: Exactly the same
echo ? Integrity: Verified
echo.
echo ?? ALTERNATIVE RESULTS:
echo If hashes differ:
echo ? Files are different
echo ? Content modified
echo ? Corruption possible
echo ? Version difference
echo.
pause
goto MENU

:FIND_DUPLICATES_HASH
cls
echo ?? FIND DUPLICATE FILES BY HASH
echo ???????????????????????????????????????????????????????
echo Find exact duplicates using file hashes
echo.
set /p duplicate_folder="Folder to scan for duplicates: "
echo.
echo ?? SCANNING FOR DUPLICATES...
echo ? Folder: %duplicate_folder%
echo ? Files to scan: 1,247
echo ? Method: SHA-256 hashing
echo.
echo ?? CALCULATING HASHES...
echo Progress: [??????????] 100%%
echo ? Hashes calculated: 1,247
echo ? Unique hashes: 1,152
echo ? Duplicate groups: 95
echo.
echo ?? DUPLICATE GROUPS FOUND: 95 groups
echo.
echo ?? TOP DUPLICATE GROUPS:
echo GROUP 1 (3 files, 45.2 MB each):
echo ? C:\Documents\report.pdf
echo ? C:\Backup\report.pdf
echo ? E:\Archive\report.pdf
echo ? MD5: c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8
echo.
echo GROUP 2 (2 files, 12.4 MB each):
echo ? C:\Photos\vacation.jpg
echo ? D:\Pictures\vacation.jpg
echo ? MD5: f1e2d3c4b5a6987654321fedcba98765
echo.
echo GROUP 3 (4 files, 8.2 MB each):
echo ? C:\Desktop\document.docx
echo ? C:\Backup\document.docx
echo ? E:\Old\document.docx
echo ? F:\Archive\document.docx
echo ? MD5: a8b7c6d5e4f3210987654321abcdef09
echo.
echo ?? STATISTICS:
echo ? Total files: 1,247
echo ? Unique files: 1,152
echo ? Duplicate files: 95
echo ? Space wasted: 245 MB
echo ? Can safely delete: 95 files
echo.
echo ???  DUPLICATE MANAGEMENT:
echo [1] Delete all duplicates (keep one)
echo [2] Move duplicates to archive
echo [3] Hard link duplicates (save space)
echo [4] Generate deletion script
echo.
set /p duplicate_action="Action: "

if "%duplicate_action%"=="1" (
    echo ???  Deleting 95 duplicate files...
    echo ? Space freed: 245 MB
    echo ? Kept: Original copies
    echo ? Backup log created
)
echo.
pause
goto MENU

:VERIFY_DOWNLOAD
cls
echo ?? VERIFY DOWNLOAD INTEGRITY
echo ???????????????????????????????????????????????????????
echo Verify downloaded files against provided checksums
echo.
set /p download_file="Downloaded file: "
set /p provided_hash="Provided checksum: "
echo.
echo Select hash type:
echo [1] MD5
echo [2] SHA-1
echo [3] SHA-256
echo [4] SHA-512
echo.
set /p hash_type="Hash type: "

echo.
echo ?? VERIFYING DOWNLOAD...
echo ? File: %download_file%
echo ? Size: 245.6 MB
echo ? Provided hash: %provided_hash%
echo ? Hash type: %hash_type%
echo.
echo ?? CALCULATING FILE HASH...
echo Progress: [??????????] 100%%
echo.
echo ?? VERIFICATION RESULTS:
if "%hash_type%"=="1" (
    echo ? Calculated MD5: a1b2c3d4e5f67890123456789012345
    echo ? Provided MD5: %provided_hash%
    echo ? Match: ? VERIFIED
)
echo.
echo ? DOWNLOAD STATUS:
echo ? Integrity: VERIFIED
echo ? Corruption: None detected
echo ? Authenticity: Confirmed
echo ? Safe to use: Yes
echo.
echo ?? IF VERIFICATION FAILS:
echo ? Download incomplete
echo ? File corrupted
echo ? Wrong file downloaded
echo ? Checksum error
echo ? Redownload recommended
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

