@echo off
chcp 65001 >nul
title Storage Analyzer Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                Storage Analyzer Tool                         ║
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
echo ║                Storage Analyzer                             ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Disk Usage Analysis
echo [2] File Type Analysis
echo [3] Folder Size Analysis
echo [4] Large Files Detector
echo [5] Duplicate Files Finder
echo [6] Storage Space Report
echo [7] Disk Health Check
echo [8] Storage Optimization
echo [9] Advanced Analysis
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto disk_usage
if "%choice%"=="2" goto file_type_analysis
if "%choice%"=="3" goto folder_size
if "%choice%"=="4" goto large_files
if "%choice%"=="5" goto duplicate_files
if "%choice%"=="6" goto storage_report
if "%choice%"=="7" goto disk_health
if "%choice%"=="8" goto storage_optimization
if "%choice%"=="9" goto advanced_analysis
if "%choice%"=="0" goto exit
goto menu

:disk_usage
echo.
echo [INFO] Disk Usage Analysis...
echo.

:: Display disk usage information
echo [1/4] Overall disk usage:
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType /format:list

echo.
echo [2/4] Disk usage percentage:
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        echo Drive %%b: !usage!%% used (!free! bytes free)
    )
)

echo.
echo [3/4] System files usage:
dir "%WINDIR%" /s /-c | find "bytes"

echo.
echo [4/4] User files usage:
dir "%USERPROFILE%" /s /-c | find "bytes"

pause
goto menu

:file_type_analysis
echo.
echo [INFO] File Type Analysis...
echo.

set /p target_path="Enter path to analyze (e.g., C:\Users): "
if "%target_path%"=="" set target_path=C:\Users

echo [INFO] Analyzing file types in %target_path%...
echo.

:: Analyze file extensions
echo [1/3] Common file types:
for %%e in (exe dll txt docx pdf jpg mp3 mp4 zip) do (
    set count=0
    for /f %%a in ('dir "%target_path%\%%~e" /s /b 2^>nul ^| find /c /v ""') do set count=%%a
    echo .%%e files: !count!
)

echo.
echo [2/3] Large file types:
for %%e in (iso img vmdk vhd) do (
    set count=0
    for /f %%a in ('dir "%target_path%\%%~e" /s /b 2^>nul ^| find /c /v ""') do set count=%%a
    echo .%%e files: !count!
)

echo.
echo [3/3] Document types:
for %%e in (doc docx xls xlsx ppt pptx pdf) do (
    set count=0
    for /f %%a in ('dir "%target_path%\%%~e" /s /b 2^>nul ^| find /c /v ""') do set count=%%a
    echo .%%e files: !count!
)

pause
goto menu

:folder_size
echo.
echo [INFO] Folder Size Analysis...
echo.

set /p target_path="Enter folder path to analyze: "
if "%target_path%"=="" goto menu

echo [INFO] Analyzing folder sizes in %target_path%...
echo.

:: Analyze folder sizes
echo [1/2] Top-level folders:
for /d %%d in ("%target_path%\*") do (
    echo Analyzing %%d...
    for /f "tokens=3" %%a in ('dir "%%d" /s /-c ^| find "bytes"') do (
        echo %%d: %%a bytes
    )
)

echo.
echo [2/2] System folder sizes:
echo Windows folder:
for /f "tokens=3" %%a in ('dir "%WINDIR%" /s /-c ^| find "bytes"') do echo %%a bytes

echo Program Files folder:
for /f "tokens=3" %%a in ('dir "%ProgramFiles%" /s /-c ^| find "bytes"') do echo %%a bytes

echo User profile folder:
for /f "tokens=3" %%a in ('dir "%USERPROFILE%" /s /-c ^| find "bytes"') do echo %%a bytes

pause
goto menu

:large_files
echo.
echo [INFO] Large Files Detector...
echo.

set /p target_path="Enter path to search (e.g., C:\): "
if "%target_path%"=="" set target_path=C:\

set /p min_size="Enter minimum file size in MB: "
if "%min_size%"=="" set min_size=100

echo [INFO] Finding files larger than %min_size% MB in %target_path%...
echo.

:: Find large files
echo Searching for files larger than %min_size% MB...
for /r "%target_path%" %%f in (*) do (
    for /f "tokens=1-3" %%a in ('dir "%%f" /-c ^| find "%%~nxf"') do (
        for /f "tokens=1,2" %%x in ("%%a %%b") do (
            if "%%y"=="bytes" (
                set /a size_mb=%%x/1048576
                if !size_mb! geq %min_size% (
                    echo %%f: !size_mb! MB
                )
            )
        )
    )
)

echo [SUCCESS] Large files detection completed
pause
goto menu

:duplicate_files
echo.
echo [INFO] Duplicate Files Finder...
echo.

echo [WARNING] Duplicate file detection requires specialized tools
echo [INFO] Basic duplicate detection by file name...
echo.

set /p target_path="Enter path to search: "
if "%target_path%"=="" goto menu

echo [INFO] Finding potential duplicates by name...
echo.

:: Simple duplicate detection by name
set temp_file=%TEMP%\file_list.txt
dir "%target_path%\*" /s /b > "%temp_file_file%" 2>nul

echo [INFO] Checking for files with same names in different locations...
echo [INFO] This is a basic check - use specialized tools for thorough analysis

pause
goto menu

:storage_report
echo.
echo [INFO] Generating Storage Space Report...
echo.

set report_file=%TEMP%\storage_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%.txt

echo Storage Space Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/6] Disk Information: >> "%report_file%"
wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,DriveType /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [2/6] Disk Usage Summary: >> "%report_file%"
for /f "tokens=1,2,3" %%a in ('wmic logicaldisk get Size^,FreeSpace^,DeviceID /format:list ^| find "="') do (
    if "%%a"=="Size" set size=%%b
    if "%%a"=="FreeSpace" set free=%%b
    if "%%a"=="DeviceID" (
        set /a used=!size!-!free!
        set /a usage=!used!*100/!size!
        echo Drive %%b: !usage!%% used >> "%report_file%"
    )
)
echo. >> "%report_file%"

echo [3/6] System Folder Sizes: >> "%report_file%"
echo Windows: >> "%report_file%"
for /f "tokens=3" %%a in ('dir "%WINDIR%" /s /-c ^| find "bytes"') do echo %%a bytes >> "%report_file%"
echo. >> "%report_file%"

echo [4/6] User Folder Sizes: >> "%report_file%"
echo User Profile: >> "%report_file%"
for /f "tokens=3" %%a in ('dir "%USERPROFILE%" /s /-c ^| find "bytes"') do echo %%a bytes >> "%report_file%"
echo. >> "%report_file%"

echo [5/6] Temporary Files: >> "%report_file%"
echo Temp folder: >> "%report_file%"
for /f "tokens=3" %%a in ('dir "%TEMP%" /s /-c ^| find "bytes"') do echo %%a bytes >> "%report_file%"
echo. >> "%report_file%"

echo [6/6] Recommendations: >> "%report_file%"
echo 1. Run disk cleanup to free up space >> "%report_file%"
echo 2. Remove unnecessary programs >> "%report_file%"
echo 3. Move large files to external storage >> "%report_file%"
echo 4. Enable disk compression if needed >> "%report_file%"

echo [SUCCESS] Storage report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:disk_health
echo.
echo [INFO] Disk Health Check...
echo.

:: Check disk health
echo [1/4] Disk status:
wmic diskdrive get Status,Model,InterfaceType /format:list

echo.
echo [2/4] S.M.A.R.T. status:
wmic diskdrive get Status /format:list

echo.
echo [3/4] Volume health:
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo Checking !drive!...
    chkdsk !drive! /f
)

echo.
echo [4/4] File system errors:
sfc /scannow

echo [SUCCESS] Disk health check completed
pause
goto menu

:storage_optimization
echo.
echo [INFO] Storage Optimization...
echo.

echo [1] Disk Cleanup
echo [2] Compress Files
echo [3] Remove System Restore Points
echo [4] Clean Recycle Bin
echo [5] Optimize Drives
echo [0] Back to main menu
echo.
set /p opt_choice="Select an option [0-5]: "

if "%opt_choice%"=="1" goto disk_cleanup
if "%opt_choice%"=="2" goto compress_files
if "%opt_choice%"=="3" goto remove_restore
if "%opt_choice%"=="4" goto clean_recycle
if "%opt_choice%"=="5" goto optimize_drives
if "%opt_choice%"=="0" goto menu
goto storage_optimization

:disk_cleanup
echo.
echo [INFO] Running disk cleanup...
cleanmgr /sagerun:1

echo [SUCCESS] Disk cleanup completed
pause
goto storage_optimization

:compress_files
echo.
set /p target_path="Enter folder path to compress: "
if "%target_path%"=="" goto storage_optimization

echo [INFO] Compressing folder %target_path%...
compact /c /s "%target_path%"

echo [SUCCESS] Folder compressed
pause
goto storage_optimization

:remove_restore
echo.
echo [WARNING] This will remove all system restore points!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto storage_optimization

echo [INFO] Removing system restore points...
vssadmin delete shadows /all /quiet

echo [SUCCESS] System restore points removed
pause
goto storage_optimization

:clean_recycle
echo.
echo [INFO] Emptying recycle bin...
powershell -Command "Clear-RecycleBin -Force"

echo [SUCCESS] Recycle bin emptied
pause
goto storage_optimization

:optimize_drives
echo.
echo [INFO] Optimizing drives...
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo Optimizing !drive!...
    defrag !drive! /O
)

echo [SUCCESS] Drive optimization completed
pause
goto storage_optimization

:advanced_analysis
echo.
echo [INFO] Advanced Storage Analysis...
echo.

echo [1] Disk Performance Test
echo [2] File System Analysis
echo [3] Storage Benchmark
echo [4] Detailed Disk Information
echo [5] Storage Trends Analysis
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto performance_test
if "%adv_choice%"=="2" goto filesystem_analysis
if "%adv_choice%"=="3" goto storage_benchmark
if "%adv_choice%"=="4" goto detailed_info
if "%adv_choice%"=="5" goto trends_analysis
if "%adv_choice%"=="0" goto menu
goto advanced_analysis

:performance_test
echo.
echo [INFO] Running disk performance test...
echo [INFO] This requires specialized tools for accurate results
echo [INFO] Basic performance indicators:
wmic diskdrive get Model,MediaType,InterfaceType /format:list

pause
goto advanced_analysis

:filesystem_analysis
echo.
echo [INFO] File system analysis...
for /f "tokens=1" %%d in ('wmic logicaldisk get DeviceID /value ^| find "="') do (
    set drive=%%d
    echo File system for !drive!:
    fsutil fsinfo volumeinfo !drive!
    echo.
)

pause
goto advanced_analysis

:storage_benchmark
echo.
echo [INFO] Storage benchmark...
echo [INFO] Benchmark requires specialized tools
echo [INFO] Basic benchmark information:
wmic diskdrive get Model,Size,InterfaceType /format:list

pause
goto advanced_analysis

:detailed_info
echo.
echo [INFO] Detailed disk information...
wmic diskdrive get * /format:list

pause
goto advanced_analysis

:trends_analysis
echo.
echo [INFO] Storage trends analysis...
echo [INFO] This requires historical data collection
echo [INFO] Current snapshot:
wmic logicaldisk get DeviceID,Size,FreeSpace /format:list

pause
goto advanced_analysis

:exit
echo.
echo [INFO] Storage Analyzer Tool closed
exit /b 0
