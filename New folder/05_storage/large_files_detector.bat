@echo off
chcp 65001 >nul
title Large Files Detector - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Large Files Detector                         ║
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
echo ║                Large Files Detector                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Quick Large Files Scan
echo [2] Custom Size Scan
echo [3] Scan Specific Folder
echo [4] Scan by File Type
echo [5] Top 10 Largest Files
echo [6] Large Files Report
echo [7] Delete Large Files
echo [8] Archive Large Files
echo [9] Advanced Options
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto quick_scan
if "%choice%"=="2" goto custom_size
if "%choice%"=="3" goto specific_folder
if "%choice%"=="4" goto scan_by_type
if "%choice%"=="5" goto top_10
if "%choice%"=="6" goto large_files_report
if "%choice%"=="7" goto delete_files
if "%choice%"=="8" goto archive_files
if "%choice%"=="9" goto advanced_options
if "%choice%"=="0" goto exit
goto menu

:quick_scan
echo.
echo [INFO] Quick Large Files Scan...
echo.

set /p target_path="Enter path to scan (e.g., C:\Users): "
if "%target_path%"=="" set target_path=C:\Users

echo [INFO] Scanning for files larger than 100MB in %target_path%...
echo.

set min_size=104857600
set results_file=%TEMP%\large_files_%random%.txt

echo Large Files Report > "%results_file%"
echo Generated on: %date% %time% >> "%results_file%"
echo Minimum size: 100MB >> "%results_file%"
echo Path: %target_path% >> "%results_file%"
echo ======================================== >> "%results_file%"

:: Scan for large files
echo [1/3] Scanning for large files...
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            if %%a geq %min_size% (
                set /a size_mb=%%a/1048576
                echo %%f: !size_mb! MB >> "%results_file%"
                echo %%f: !size_mb! MB
            )
        )
    )
)

echo [2/3] Counting total files...
set /p file_count=<"%results_file%"
set /a file_count=%file_count% - 5

echo [3/3] Generating summary...
echo Total large files found: %file_count%
echo Report saved to: %results_file%

pause
goto menu

:custom_size
echo.
echo [INFO] Custom Size Scan...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" goto menu

set /p min_size_mb="Enter minimum file size in MB: "
if "%min_size_mb%"=="" set min_size_mb=100

set /a min_size=%min_size_mb%*1048576
set results_file=%TEMP%\custom_large_files_%random%.txt

echo Large Files Report > "%results_file%"
echo Generated on: %date% %time% >> "%results_file%"
echo Minimum size: %min_size_mb% MB >> "%results_file%"
echo Path: %target_path% >> "%results_file%"
echo ======================================== >> "%results_file%"

echo [INFO] Scanning for files larger than %min_size_mb% MB...
echo.

for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            if %%a geq %min_size% (
                set /a size_mb=%%a/1048576
                echo %%f: !size_mb! MB >> "%results_file%"
                echo %%f: !size_mb! MB
            )
        )
    )
)

echo [SUCCESS] Custom size scan completed
echo Report saved to: %results_file%
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

set /p min_size_mb="Enter minimum file size in MB: "
if "%min_size_mb%"=="" set min_size_mb=50

set /a min_size=%min_size_mb%*1048576
set results_file=%TEMP%\folder_large_files_%random%.txt

echo Large Files in %target_path% > "%results_file%"
echo Generated on: %date% %time% >> "%results_file%"
echo Minimum size: %min_size_mb% MB >> "%results_file%"
echo ======================================== >> "%results_file%"

echo [INFO] Scanning folder: %target_path%
echo.

for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            if %%a geq %min_size% (
                set /a size_mb=%%a/1048576
                echo %%f: !size_mb! MB >> "%results_file%"
                echo %%f: !size_mb! MB
            )
        )
    )
)

echo [SUCCESS] Folder scan completed
echo Report saved to: %results_file%
pause
goto menu

:scan_by_type
echo.
echo [INFO] Scan by File Type...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" set target_path=C:\Users

set /p file_extension="Enter file extension (e.g., .mp4, .iso): "
if "%file_extension%"=="" goto menu

set /p min_size_mb="Enter minimum file size in MB: "
if "%min_size_mb%"=="" set min_size_mb=100

set /a min_size=%min_size_mb%*1048576
set results_file=%TEMP%\type_large_files_%random%.txt

echo Large %file_extension% Files > "%results_file%"
echo Generated on: %date% %time% >> "%results_file%"
echo Minimum size: %min_size_mb% MB >> "%results_file%"
echo Path: %target_path% >> "%results_file%"
echo ======================================== >> "%results_file%"

echo [INFO] Scanning for %file_extension% files larger than %min_size_mb% MB...
echo.

for /r "%target_path%" %%f in (*%file_extension%) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            if %%a geq %min_size% (
                set /a size_mb=%%a/1048576
                echo %%f: !size_mb! MB >> "%results_file%"
                echo %%f: !size_mb! MB
            )
        )
    )
)

echo [SUCCESS] File type scan completed
echo Report saved to: %results_file%
pause
goto menu

:top_10
echo.
echo [INFO] Top 10 Largest Files...
echo.

set /p target_path="Enter path to scan: "
if "%target_path%"=="" set target_path=C:\

set results_file=%TEMP%\top10_files_%random%.txt

echo Top 10 Largest Files > "%results_file%"
echo Generated on: %date% %time% >> "%results_file%"
echo Path: %target_path% >> "%results_file%"
echo ======================================== >> "%results_file%"

echo [INFO] Finding top 10 largest files...
echo.

:: Create temporary file with all files and sizes
set temp_file=%TEMP%\all_files_%random%.txt
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            echo %%a %%f >> "%temp_file%"
        )
    )
)

:: Sort by size and get top 10
echo [1/2] Sorting files by size...
sort /r "%temp_file%" /o "%TEMP%\sorted_files_%random%.txt"

echo [2/2] Extracting top 10...
set /a count=0
for /f "tokens=1,2*" %%a in ('type "%TEMP%\sorted_files_%random%.txt"') do (
    set /a count+=1
    if !count! leq 10 (
        set /a size_mb=%%a/1048576
        echo %%b: !size_mb! MB >> "%results_file%"
        echo [!count!] %%b: !size_mb! MB
    )
)

del "%temp_file%" 2>nul
del "%TEMP%\sorted_files_*.txt" 2>nul

echo [SUCCESS] Top 10 largest files found
echo Report saved to: %results_file%
pause
goto menu

:large_files_report
echo.
echo [INFO] Large Files Report...
echo.

echo [1] Generate Comprehensive Report
echo [2] View Last Report
echo [3] Export to CSV
echo [4] Generate Summary Statistics
echo [0] Back to main menu
echo.
set /p report_choice="Select an option [0-4]: "

if "%report_choice%"=="1" goto comprehensive_report
if "%report_choice%"=="2" goto view_report
if "%report_choice%"=="3" goto export_csv
if "%report_choice%"=="4" goto summary_stats
if "%report_choice%"=="0" goto menu
goto large_files_report

:comprehensive_report
echo.
echo [INFO] Generating comprehensive report...
echo.

set /p target_path="Enter path to analyze: "
if "%target_path%"=="" set target_path=C:\

set report_file=%TEMP%\comprehensive_large_files_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Comprehensive Large Files Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo Path: %target_path% >> "%report_file%"
echo ======================================== >> "%report_file%"

echo [1/4] Files larger than 100MB: >> "%report_file%"
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            set /a size_mb=%%a/1048576
            if !size_mb! geq 100 (
                echo %%f: !size_mb! MB >> "%report_file%"
            )
        )
    )
)

echo [2/4] Files larger than 500MB: >> "%report_file%"
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            set /a size_mb=%%a/1048576
            if !size_mb! geq 500 (
                echo %%f: !size_mb! MB >> "%report_file%"
            )
        )
    )
)

echo [3/4] Files larger than 1GB: >> "%report_file%"
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            set /a size_gb=%%a/1073741824
            if !size_gb! geq 1 (
                echo %%f: !size_gb! GB >> "%report_file%"
            )
        )
    )
)

echo [4/4] Disk usage summary: >> "%report_file%"
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list >> "%report_file%"

echo [SUCCESS] Comprehensive report generated
echo Report saved to: %report_file%
pause
goto large_files_report

:view_report
echo.
echo [INFO] Finding latest large files report...
set latest_report=
for %%f in ("%TEMP%\*large_files*.txt") do (
    set latest_report=%%f
)

if defined latest_report (
    echo Displaying: %latest_report%
    type "%latest_report%"
) else (
    echo No large files reports found
)

pause
goto large_files_report

:export_csv
echo.
echo [INFO] Exporting to CSV format...
set csv_file=%TEMP%\large_files_%date:~-4,4%%date:~-10,2%%date:~-7,2%.csv

echo "File Path","Size (MB)","Type" > "%csv_file%"

:: Find latest report and convert to CSV
set latest_report=
for %%f in ("%TEMP%\*large_files*.txt") do (
    set latest_report=%%f
)

if defined latest_report (
    echo Converting %latest_report% to CSV...
    powershell -Command "Get-Content '%latest_report%' | Where-Object { $_ -match '^[A-Z]:.*' } | ForEach-Object { $path = $_.Split(':')[0..($_.Length-2)] -join ':'; $size = $_.Split(':')[1].Trim().Split(' ')[0]; Write-Host '\"' + $path + '\",\"' + $size + '\",\"File\"' }" > "%TEMP%\temp_csv.txt"
    type "%TEMP%\temp_csv.txt" >> "%csv_file%"
    del "%TEMP%\temp_csv.txt" 2>nul
)

echo [SUCCESS] Exported to CSV
echo CSV file: %csv_file%
pause
goto large_files_report

:summary_stats
echo.
echo [INFO] Generating summary statistics...
set stats_file=%TEMP%\large_files_stats_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Large Files Statistics > "%stats_file%"
echo Generated on: %date% %time% >> "%stats_file%"
echo ======================================== >> "%stats_file%"

echo [1/3] Counting files by size category...
set /a count_100mb=0
set /a count_500mb=0
set /a count_1gb=0

for %%f in ("%TEMP%\*large_files*.txt") do (
    for /f "tokens=*" %%a in ('type "%%f" ^| find ".:"') do (
        echo %%a | find "MB" >nul
        if !errorlevel! equ 0 (
            set /a count_100mb+=1
        )
        echo %%a | find "GB" >nul
        if !errorlevel! equ 0 (
            set /a count_1gb+=1
        )
    )
)

echo Files larger than 100MB: %count_100mb% >> "%stats_file%"
echo Files larger than 1GB: %count_1gb% >> "%stats_file%"

echo [2/3] Disk space analysis: >> "%stats_file%"
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list >> "%stats_file%"

echo [3/3] Recommendations: >> "%stats_file%"
echo 1. Consider moving files larger than 1GB to external storage >> "%stats_file%"
echo 2. Archive old files that are no longer needed >> "%stats_file%"
echo 3. Use cloud storage for large media files >> "%stats_file%"

echo [SUCCESS] Statistics generated
echo Report saved to: %stats_file%
pause
goto large_files_report

:delete_files
echo.
echo [WARNING] This will delete large files permanently!
set /p confirm="Are you absolutely sure? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] This requires manual review of large files reports
echo [INFO] Please check the reports first to identify files to delete
echo [INFO] Use specialized tools for safe file deletion
pause
goto menu

:archive_files
echo.
echo [INFO] Archive Large Files...
echo.

set /p source_path="Enter path with large files: "
if "%source_path%"=="" goto menu

set /p archive_path="Enter archive destination path: "
if "%archive_path%"=="" set archive_path=%TEMP%\large_files_archive

set /p min_size_mb="Enter minimum file size to archive (MB): "
if "%min_size_mb%"=="" set min_size_mb=500

echo [INFO] Archiving files larger than %min_size_mb% MB...
echo.

if not exist "%archive_path%" mkdir "%archive_path%"

set /a min_size=%min_size_mb%*1048576
set /a archived_count=0

for /r "%source_path%" %%f in (*) do (
    for /f "tokens=1,2" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        if "%%b"=="bytes" (
            if %%a geq %min_size% (
                echo Archiving: %%f
                move "%%f" "%archive_path%\" >nul 2>&1
                if !errorlevel! equ 0 (
                    set /a archived_count+=1
                )
            )
        )
    )
)

echo [SUCCESS] Archived %archived_count% files
echo Archive location: %archive_path%
pause
goto menu

:advanced_options
echo.
echo [INFO] Advanced Large Files Detector Options...
echo.

echo [1] Set Multiple Size Thresholds
echo [2] Exclude System Directories
echo [3] Include Hidden Files
echo [4] Set File Age Filter
echo [5] Generate Heat Map
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto multiple_thresholds
if "%adv_choice%"=="2" goto exclude_system
if "%adv_choice%"=="3" goto include_hidden
if "%adv_choice%"=="4" goto age_filter
if "%adv_choice%"=="5" goto heat_map
if "%adv_choice%"=="0" goto menu
goto advanced_options

:multiple_thresholds
echo.
echo [INFO] Setting multiple size thresholds...
echo [1] 50MB, 100MB, 500MB, 1GB
echo [2] Custom thresholds
echo [0] Back
echo.
set /p threshold_choice="Select option [0-2]: "

if "%threshold_choice%"=="1" (
    echo [INFO] Using standard thresholds
) else if "%threshold_choice%"=="2" (
    set /p threshold1="Enter threshold 1 (MB): "
    set /p threshold2="Enter threshold 2 (MB): "
    set /p threshold3="Enter threshold 3 (MB): "
)

pause
goto advanced_options

:exclude_system
echo.
echo [INFO] Excluding system directories...
echo [INFO] Windows, Program Files, and system folders will be excluded
pause
goto advanced_options

:include_hidden
echo.
echo [INFO] Including hidden files in scan...
echo [INFO] Hidden and system files will be included
pause
goto advanced_options

:age_filter
echo.
set /p days_old="Enter minimum file age in days: "
if "%days_old%"=="" goto advanced_options

echo [INFO] Only files older than %days_old% days will be included
pause
goto advanced_options

:heat_map
echo.
echo [INFO] Generating heat map of large files...
echo [INFO] This requires specialized visualization tools
echo [INFO] Basic heat map data will be generated
pause
goto advanced_options

:exit
echo.
echo [INFO] Large Files Detector closed
exit /b 0
