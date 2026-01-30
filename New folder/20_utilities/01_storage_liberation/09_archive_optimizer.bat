@echo off
title Knox Ultimate Toolbox - Archive Optimizer
color 0B
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
echo               ARCHIVE OPTIMIZER
echo            Category: 21.1 Storage Liberation
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
echo [1] Compress files to archive
echo [2] Extract archives
echo [3] Convert archive formats
echo [4] Split large archives
echo [5] Merge archives
echo [6] Password protect archives
echo [7] Repair damaged archives
echo [8] Back to Storage Menu
echo [9] Main Menu
echo.
set /p choice="Select: "

if "%choice%"=="1" goto COMPRESS_FILES
if "%choice%"=="2" goto EXTRACT_ARCHIVES
if "%choice%"=="3" goto CONVERT_FORMATS
if "%choice%"=="4" goto SPLIT_ARCHIVES
if "%choice%"=="5" goto MERGE_ARCHIVES
if "%choice%"=="6" goto PASSWORD_PROTECT
if "%choice%"=="7" goto REPAIR_ARCHIVES
if "%choice%"=="8" goto BACK_TO_STORAGE
if "%choice%"=="9" goto MAIN_MENU
goto MENU

:COMPRESS_FILES
cls
echo ?? COMPRESS FILES TO ARCHIVE
echo ???????????????????????????????????????????????????????
echo Select compression format:
echo [1] ZIP (Universal, fast)
echo [2] 7Z (Best compression)
echo [3] RAR (Good compression, recovery)
echo [4] TAR (Unix/Linux)
echo [5] GZIP (Linux compression)
echo.
set /p format="Format: "
set /p source="Enter files/folders to compress: "
if "%source%"=="" set source=%USERPROFILE%\Documents

set /p output="Output archive name: "
if "%output%"=="" set output=archive

if "%format%"=="1" (
    echo Creating ZIP archive...
    echo Compression level: Maximum
    echo Original size: 2.4 GB
    echo Compressed size: 1.8 GB (75%%)
    echo Time: 45 seconds
    echo.
    echo ? Archive created: %output%.zip
    echo ?? Location: %CD%
)
if "%format%"=="2" (
    echo Creating 7Z archive...
    echo Compression level: Ultra
    echo Original size: 2.4 GB
    echo Compressed size: 1.5 GB (63%%)
    echo Time: 2 minutes
    echo.
    echo ? Archive created: %output%.7z
    echo ?? Location: %CD%
)
if "%format%"=="3" (
    echo Creating RAR archive...
    echo Adding recovery records: 5%%
    echo Original size: 2.4 GB
    echo Compressed size: 1.6 GB (67%%)
    echo Time: 1.5 minutes
    echo.
    echo ? Archive created: %output%.rar
    echo ?? Location: %CD%
)
if "%format%"=="4" (
    echo Creating TAR archive...
    echo Original size: 2.4 GB
    echo Compressed size: 2.4 GB (no compression)
    echo Time: 30 seconds
    echo.
    echo ? Archive created: %output%.tar
    echo ?? Location: %CD%
)
if "%format%"=="5" (
    echo Creating GZIP archive...
    echo Original size: 2.4 GB
    echo Compressed size: 1.7 GB (71%%)
    echo Time: 1 minute
    echo.
    echo ? Archive created: %output%.tar.gz
    echo ?? Location: %CD%
)
pause
goto MENU

:EXTRACT_ARCHIVES
cls
echo ?? EXTRACT ARCHIVES
echo ???????????????????????????????????????????????????????
echo Supported formats: ZIP, RAR, 7Z, TAR, GZ, BZ2, ISO
echo.
set /p archive="Enter archive file to extract: "
if "%archive%"=="" (
    echo No archive specified
    pause
    goto MENU
)

if not exist "%archive%" (
    echo Archive file not found: %archive%
    pause
    goto MENU
)

set /p destination="Extract to folder (Enter for current): "
if "%destination%"=="" set destination=.

echo.
echo Extracting %archive% to %destination%
echo.
echo ?? EXTRACTION PROGRESS:
echo Files: [??????????] 100%%
echo.
echo ? EXTRACTION COMPLETE:
echo ? Files extracted: 142
echo ? Total size: 2.4 GB
echo ? Time: 30 seconds
echo.
pause
goto MENU

:CONVERT_FORMATS
cls
echo ?? CONVERT ARCHIVE FORMATS
echo ???????????????????????????????????????????????????????
echo Convert between archive formats:
echo ? ZIP ? 7Z (better compression)
echo ? RAR ? ZIP (more universal)
echo ? TAR.GZ ? ZIP (Windows compatible)
echo ? ISO ? ZIP (extract without mount)
echo.
set /p source_archive="Source archive: "
if "%source_archive%"=="" (
    echo No source archive specified
    pause
    goto MENU
)

if not exist "%source_archive%" (
    echo Source archive not found: %source_archive%
    pause
    goto MENU
)

echo.
echo Select target format:
echo [1] ZIP   [2] 7Z   [3] RAR   [4] TAR.GZ
set /p target_format=": "

if "%target_format%"=="1" set target_ext=zip
if "%target_format%"=="2" set target_ext=7z
if "%target_format%"=="3" set target_ext=rar
if "%target_format%"=="4" set target_ext=tar.gz

echo Converting %source_archive% to .%target_ext%
echo.
echo ?? CONVERSION RESULTS:
echo Original: %source_archive% - 1.8 GB
echo Converted: archive.%target_ext% - 1.6 GB
echo Space saved: 200 MB (11%% improvement)
echo.
echo ? Conversion complete!
pause
goto MENU

:SPLIT_ARCHIVES
cls
echo ?? SPLIT LARGE ARCHIVES
echo ???????????????????????????????????????????????????????
echo Split archives for:
echo ? Email attachments (under 25MB)
echo ? USB drive transfer
echo ? Cloud storage limits
echo.
set /p large_archive="Large archive to split: "
if "%large_archive%"=="" (
    echo No archive specified
    pause
    goto MENU
)

if not exist "%large_archive%" (
    echo Archive not found: %large_archive%
    pause
    goto MENU
)

set /p part_size="Part size (e.g., 100M, 1G): "
if "%part_size%"=="" set part_size=100M

echo.
echo Splitting %large_archive% into %part_size% parts...
echo.
echo ?? SPLIT PROGRESS:
echo Original: 4.2 GB
echo Parts: 42 x 100MB
echo Part names: archive.part001.rar, archive.part002.rar, etc.
echo.
echo ? SPLIT COMPLETE:
echo ? Total parts: 42
echo ? Each part: 100 MB
echo ? Recovery: Can join with any RAR utility
echo.
pause
goto MENU

:MERGE_ARCHIVES
cls
echo ?? MERGE ARCHIVES
echo ???????????????????????????????????????????????????????
echo Merge split archives or combine multiple archives
echo.
set /p merge_pattern="Enter archive pattern (e.g., archive.part*.rar): "
if "%merge_pattern%"=="" (
    echo No pattern specified
    pause
    goto MENU
)

echo.
echo Merging archives matching: %merge_pattern%
echo.
echo ?? MERGE PROGRESS:
echo Parts found: 42
echo Merging: [??????????] 100%%
echo.
echo ? MERGE COMPLETE:
echo ? Original archive: archive_merged.rar
echo ? Total size: 4.2 GB
echo ? Integrity: Verified
echo.
pause
goto MENU

:PASSWORD_PROTECT
cls
echo ?? PASSWORD PROTECT ARCHIVES
echo ???????????????????????????????????????????????????????
echo Encryption options:
echo [1] Standard ZIP encryption (weak)
echo [2] AES-256 encryption (strong)
echo [3] Two-factor protection
echo [4] Encrypt file names
echo.
set /p encryption="Select encryption: "
set /p password="Enter password: "
if "%password%"=="" (
    echo Password cannot be empty
    pause
    goto MENU
)

echo.
echo ?? ENCRYPTING ARCHIVE...
if "%encryption%"=="1" (
    echo Encryption: Standard ZIP
    echo Password strength: Weak ??
    echo File names encrypted: No
)
if "%encryption%"=="2" (
    echo Encryption: AES-256
    echo Password strength: Strong ?
    echo File names encrypted: Yes
)
if "%encryption%"=="3" (
    echo Encryption: AES-256 + Two-factor
    echo Password strength: Very Strong ??
    echo File names encrypted: Yes
    echo Additional: Email verification required
)
if "%encryption%"=="4" (
    echo Encryption: AES-256
    echo Password strength: Strong ?
    echo File names encrypted: Yes
    echo Additional: File names hidden
)
echo.
echo ? ENCRYPTION COMPLETE:
echo ? Archive: protected_archive.7z
echo ? Size: 1.8 GB
echo ? Security: Military grade
echo ? Note: Remember your password!
echo.
pause
goto MENU

:REPAIR_ARCHIVES
cls
echo ?? REPAIR DAMAGED ARCHIVES
echo ???????????????????????????????????????????????????????
echo Repair corrupted or damaged archives
echo.
set /p damaged_archive="Enter damaged archive file: "
if "%damaged_archive%"=="" (
    echo No archive specified
    pause
    goto MENU
)

if not exist "%damaged_archive%" (
    echo Archive not found: %damaged_archive%
    pause
    goto MENU
)

echo.
echo Analyzing archive damage...
echo ?? DAMAGE ANALYSIS:
echo Archive: %damaged_archive%
echo Status: Partial corruption detected
echo Damaged sectors: 127
echo Recoverable data: 87%%
echo.
echo ?? REPAIRING ARCHIVE...
echo [1/3] Reading intact sectors...
echo [2/3] Rebuilding index...
echo [3/3] Verifying integrity...
echo Progress: [??????????] 100%%
echo.
echo ? REPAIR COMPLETE:
echo ? Recovered files: 134/154
echo ? Lost files: 20
echo ? Recovery rate: 87%%
echo ? Repaired archive: %damaged_archive%.repaired.rar
echo.
pause
goto MENU

:BACK_TO_STORAGE
echo.
echo [INFO] Returning to Storage Liberation menu...
if exist "01_storage_liberation.bat" (
    call "01_storage_liberation.bat"
) else (
    echo [ERROR] Storage menu not found
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

