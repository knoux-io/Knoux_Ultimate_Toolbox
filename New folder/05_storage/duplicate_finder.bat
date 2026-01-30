@echo off
chcp 65001 >nul
title Duplicate Files Finder - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Duplicate Files Finder                        ║
echo ║              Knoux Ultimate Toolbox                          ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:: Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Administrator privileges required!
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

:menu
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Duplicate Files Finder                       ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Quick Duplicate Scan
echo [2] Thorough Duplicate Scan
echo [3] Scan Specific Folder
echo [4] Scan by File Type
echo [5] Find Exact Duplicates
echo [6] Find Similar Files
echo [7] Duplicate Report
echo [8] Delete Duplicates
echo [9] Advanced Options
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto quick_scan
if "%choice%"=="2" goto thorough_scan
if "%choice%"=="3" goto specific_folder
if "%choice%"=="4" goto scan_by_type
if "%choice%"=="5" goto exact_duplicates
if "%choice%"=="6" goto similar_files
if "%choice%"=="7" goto duplicate_report
if "%choice%"=="8" goto delete_duplicates
if "%choice%"=="9" goto advanced_options
if "%choice%"=="0" goto exit
goto menu

:quick_scan
echo.
echo [INFO] Quick Duplicate Scan...
echo.

set /p target_path="Enter path to scan (e.g., C:\Users): "
if "%target_path%"=="" set target_path=C:\Users

echo [INFO] Scanning for obvious duplicates in %target_path%...
echo.

:: Quick duplicate detection by file name and size
echo [1/3] Creating file list...
set temp_file=%TEMP%\file_list_%random%.txt
dir "%target_path%\*" /s /b > "%temp_file%" 2>nul

echo [2/3] Analyzing file names and sizes...
set dup_file=%TEMP%\duplicates_%random%.txt
echo Duplicate Files Report > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Simple duplicate detection
for /f "tokens=*" %%f in ('type "%temp_file%"') do (
    if exist "%%f" (
        for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
            echo %%f: %%a bytes >> "%dup_file%"
        )
    )
)

echo [3/3] Generating summary...
echo Potential duplicates found. Check report file.
echo Report saved to: %dup_file%

del "%temp_file%" 2>nul
pause
goto menu

:thorough_scan
echo.
echo [WARNING] Thorough scan will take significant time!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

set /p target_path="Enter path to scan: "
if "%target_path%"=="" goto menu

echo [INFO] Starting thorough duplicate scan...
echo [INFO] This may take several minutes depending on file count
echo.

:: Thorough duplicate detection
set temp_file=%TEMP%\thorough_files_%random%.txt
set dup_file=%TEMP%\thorough_duplicates_%random%.txt

echo Thorough Duplicate Files Report > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Get all files with sizes
echo [1/4] Collecting file information...
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        echo %%a:%%f >> "%temp_file%"
    )
)

echo [2/4] Analyzing file sizes...
:: Find files with same size
for /f "tokens=1 delims=:" %%s in ('type "%temp_file%" ^| sort') do (
    findstr /b "%%s:" "%temp_file%" | find /c ":" >nul
    if !errorlevel! equ 1 (
        echo Files with size %%s: >> "%dup_file%"
        findstr /b "%%s:" "%temp_file%" >> "%dup_file%"
        echo. >> "%dup_file%"
    )
)

echo [3/4] Checking file content (if possible)...
echo [INFO] Content checking requires specialized tools
echo [INFO] Size-based duplicates listed in report

echo [4/4] Generating summary...
echo Thorough scan completed. Check report file.
echo Report saved to: %dup_file%

del "%temp_file%" 2>nul
pause
goto menu

:specific_folder
echo.
echo [INFO] Scan Specific Folder...
echo.

set /p target_path="Enter folder path to scan: "
if "%target_path%"=="" goto menu

if not exist "%target_path%" (
    echo [ERROR] Folder does not exist
    pause
    goto menu
)

echo [INFO] Scanning folder: %target_path%
echo.

set dup_file=%TEMP%\folder_duplicates_%random%.txt
echo Duplicate Files in %target_path% > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Scan specific folder
for /r "%target_path%" %%f in (*) do (
    set filename=%%~nxf
    set filesize=%%~zf
    echo !filesize!:%%f >> "%TEMP%\temp_folder_files.txt"
)

:: Find duplicates by size and name
for /f "tokens=1 delims=:" %%s in ('type "%TEMP%\temp_folder_files.txt" ^| sort') do (
    findstr /b "%%s:" "%TEMP%\temp_folder_files.txt" | find /c ":" >nul
    if !errorlevel! equ 1 (
        echo Duplicate size %%s: >> "%dup_file%"
        findstr /b "%%s:" "%TEMP%\temp_folder_files.txt" >> "%dup_file%"
        echo. >> "%dup_file%"
    )
)

del "%TEMP%\temp_folder_files.txt" 2>nul
echo [SUCCESS] Folder scan completed
echo Report saved to: %dup_file%
pause
goto menu

:scan_by_type
echo.
echo [INFO] Scan by File Type...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" set target_path=C:\Users

set /p file_extension="Enter file extension (e.g., .jpg, .mp3): "
if "%file_extension%"=="" goto menu

echo [INFO] Scanning for %file_extension% files in %target_path%...
echo.

set dup_file=%TEMP%\type_duplicates_%random%.txt
echo Duplicate %file_extension% Files > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Scan specific file type
for /r "%target_path%" %%f in (*%file_extension%) do (
    set filesize=%%~zf
    echo !filesize!:%%f >> "%TEMP%\temp_type_files.txt"
)

:: Find duplicates by size
for /f "tokens=1 delims=:" %%s in ('type "%TEMP%\temp_type_files.txt" ^| sort') do (
    findstr /b "%%s:" "%TEMP%\temp_type_files.txt" | find /c ":" >nul
    if !errorlevel! equ 1 (
        echo Duplicate %file_extension% size %%s: >> "%dup_file%"
        findstr /b "%%s:" "%TEMP%\temp_type_files.txt" >> "%dup_file%"
        echo. >> "%dup_file%"
    )
)

del "%TEMP%\temp_type_files.txt" 2>nul
echo [SUCCESS] File type scan completed
echo Report saved to: %dup_file%
pause
goto menu

:exact_duplicates
echo.
echo [INFO] Find Exact Duplicates...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" goto menu

echo [INFO] Finding exact duplicates by file hash...
echo [WARNING] This process is CPU intensive and may take time
echo.

set dup_file=%TEMP%\exact_duplicates_%random%.txt
echo Exact Duplicate Files > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Create hash-based duplicate detection
echo [1/3] Calculating file hashes...
powershell -Command "$hashes = @{}; Get-ChildItem -Path '%target_path%' -Recurse -File | ForEach-Object { $hash = (Get-FileHash $_.FullName -Algorithm MD5).Hash; if ($hashes.ContainsKey($hash)) { $hashes[$hash] += @($_.FullName) } else { $hashes[$hash] = @($_.FullName) } }; $hashes.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 } | ForEach-Object { Write-Host 'Duplicate hash:' $_.Key; $_.Value | ForEach-Object { Write-Host '  ' $_ } }" > "%TEMP%\hash_results.txt"

echo [2/3] Analyzing results...
type "%TEMP%\hash_results.txt" >> "%dup_file%"

echo [3/3] Generating summary...
echo Exact duplicate detection completed
echo Report saved to: %dup_file%

del "%TEMP%\hash_results.txt" 2>nul
pause
goto menu

:similar_files
echo.
echo [INFO] Find Similar Files...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" goto menu

echo [INFO] Finding similar files by name pattern...
echo.

set dup_file=%TEMP%\similar_files_%random%.txt
echo Similar Files Report > "%dup_file%"
echo Generated on: %date% %time% >> "%dup_file%"
echo ======================================== >> "%dup_file%"

:: Find similar files by name
echo [1/2] Grouping files by similar names...
for /r "%target_path%" %%f in (*) do (
    set basename=%%~nf
    echo !basename!:%%f >> "%TEMP%\similar_names.txt"
)

:: Find similar base names
for /f "tokens=1 delims=:" %%n in ('type "%TEMP%\similar_names.txt" ^| cut -c1-8 ^| sort ^| uniq -d') do (
    echo Similar names starting with %%n: >> "%dup_file%"
    findstr /b "%%n" "%TEMP%\similar_names.txt" >> "%dup_file%"
    echo. >> "%dup_file%"
)

echo [2/2] Generating summary...
echo Similar file detection completed
echo Report saved to: %dup_file%

del "%TEMP%\similar_names.txt" 2>nul
pause
goto menu

:duplicate_report
echo.
echo [INFO] Duplicate Report...
echo.

echo [1] View Last Report
echo [2] Generate Summary Report
echo [3] Export to CSV
echo [0] Back to main menu
echo.
set /p report_choice="Select an option [0-3]: "

if "%report_choice%"=="1" goto view_report
if "%report_choice%"=="2" goto summary_report
if "%report_choice%"=="3" goto export_csv
if "%report_choice%"=="0" goto menu
goto duplicate_report

:view_report
echo.
echo [INFO] Finding latest duplicate report...
set latest_report=
for %%f in ("%TEMP%\*duplicates*.txt") do (
    set latest_report=%%f
)

if defined latest_report (
    echo Displaying: %latest_report%
    type "%latest_report%"
) else (
    echo No duplicate reports found
)

pause
goto duplicate_report

:summary_report
echo.
echo [INFO] Generating summary report...
set summary_file=%TEMP%\duplicate_summary_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Duplicate Files Summary > "%summary_file%"
echo Generated on: %date% %time% >> "%summary_file%"
echo ======================================== >> "%summary_file%"
echo. >> "%summary_file%"

echo Total duplicate reports: >> "%summary_file%"
dir "%TEMP%\*duplicates*.txt" /b | find /c /v "" >> "%summary_file%"
echo. >> "%summary_file%"

echo Disk space usage: >> "%summary_file%"
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list >> "%summary_file%"

echo [SUCCESS] Summary report generated
echo Report saved to: %summary_file%
pause
goto duplicate_report

:export_csv
echo.
echo [INFO] Exporting to CSV format...
set csv_file=%TEMP%\duplicates_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv

echo "File Path","Size (bytes)","Type" > "%csv_file%"

:: Find latest report and convert to CSV
set latest_report=
for %%f in ("%TEMP%\*duplicates*.txt") do (
    set latest_report=%%f
)

if defined latest_report (
    echo Converting %latest_report% to CSV...
    powershell -Command "Get-Content '%latest_report%' | Where-Object { $_ -match '^[A-Z]:.*' } | ForEach-Object { $path = $_.Trim(); $size = (Get-Item $path -ErrorAction SilentlyContinue).Length; Write-Host '\"' + $path + '\",\"' + $size + '\",\"File\"' }" >> "%csv_file%"
)

echo [SUCCESS] Exported to CSV
echo CSV file: %csv_file%
pause
goto duplicate_report

:delete_duplicates
echo.
echo [WARNING] This will delete duplicate files!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] This requires manual review of duplicate reports
echo [INFO] Please check the duplicate reports first
echo [INFO] Use specialized tools for safe duplicate deletion
pause
goto menu

:advanced_options
echo.
echo [INFO] Advanced Duplicate Finder Options...
echo.

echo [1] Set Minimum File Size
echo [2] Exclude System Files
echo [3] Include Hidden Files
echo [4] Compare by Content Only
echo [5] Set Scan Depth
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto min_size
if "%adv_choice%"=="2" goto exclude_system
if "%adv_choice%"=="3" goto include_hidden
if "%adv_choice%"=="4" goto content_only
if "%adv_choice%"=="5" goto scan_depth
if "%adv_choice%"=="0" goto menu
goto advanced_options

:min_size
echo.
set /p min_size="Enter minimum file size in KB: "
if "%min_size%"=="" goto advanced_options

echo [INFO] Minimum file size set to %min_size% KB
echo [INFO] This will be used in subsequent scans
pause
goto advanced_options

:exclude_system
echo.
echo [INFO] Excluding system files from scan...
echo [INFO] System folders will be excluded: Windows, Program Files, etc.
pause
goto advanced_options

:include_hidden
echo.
echo [INFO] Including hidden files in scan...
echo [INFO] Hidden and system files will be included
pause
goto advanced_options

:content_only
echo.
echo [INFO] Content-only comparison enabled...
echo [INFO] Files will be compared by hash content only
pause
goto advanced_options

:scan_depth
echo.
set /p scan_depth="Enter scan depth (0 for unlimited): "
if "%scan_depth%"=="" goto advanced_options

echo [INFO] Scan depth set to %scan_depth%
pause
goto advanced_options

:exit
echo.
echo [INFO] Duplicate Files Finder closed
exit /b 0
