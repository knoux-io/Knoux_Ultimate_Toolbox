@echo off
chcp 65001 >nul
title Search Optimizer Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Search Optimizer Tool                       ║
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
echo ║                  Search Optimizer                            ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Optimize Windows Search Index
echo [2] Rebuild Search Index
echo [3] Disable Windows Search
echo [4] Enable Windows Search
echo [5] Clean Search History
echo [6] Configure Search Locations
echo [7] Search Performance Settings
echo [0] Exit
echo.
set /p choice="Select an option [0-7]: "

if "%choice%"=="1" goto optimize_index
if "%choice%"=="2" goto rebuild_index
if "%choice%"=="3" goto disable_search
if "%choice%"=="4" goto enable_search
if "%choice%"=="5" goto clean_history
if "%choice%"=="6" goto configure_locations
if "%choice%"=="7" goto performance_settings
if "%choice%"=="0" goto exit
goto menu

:optimize_index
echo.
echo [INFO] Optimizing Windows Search index...
echo.

:: Stop Windows Search service
echo [1/4] Stopping Windows Search service...
net stop "WSearch" >nul 2>&1
timeout /t 2 >nul

:: Clean search database
echo [2/4] Cleaning search database...
del /q /f "%ALLUSERSPROFILE%\Microsoft\Search\Data\Applications\Windows\Windows.edb" 2>nul
rmdir /s /q "%ALLUSERSPROFILE%\Microsoft\Search\Data\Applications\Windows\*" 2>nul

:: Optimize search settings
echo [3/4] Optimizing search settings...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v GatherIndexerStartDelayFactor /t REG_DWORD /d 1 /f >nul

:: Restart Windows Search service
echo [4/4] Restarting Windows Search service...
net start "WSearch" >nul 2>&1

echo [SUCCESS] Windows Search index optimized
pause
goto menu

:rebuild_index
echo.
echo [INFO] Rebuilding Windows Search index...
echo.

:: Stop Windows Search service
echo [1/3] Stopping Windows Search service...
net stop "WSearch" >nul 2>&1
timeout /t 3 >nul

:: Delete search index database
echo [2/3] Deleting search index database...
rmdir /s /q "%ALLUSERSPROFILE%\Microsoft\Search\Data\Applications\Windows" 2>nul
mkdir "%ALLUSERSPROFILE%\Microsoft\Search\Data\Applications\Windows" 2>nul

:: Restart Windows Search service
echo [3/3] Restarting Windows Search service...
net start "WSearch" >nul 2>&1

echo [SUCCESS] Search index rebuild initiated
echo [INFO] This may take some time to complete
pause
goto menu

:disable_search
echo.
echo [WARNING] Disabling Windows Search will affect search functionality!
set /p confirm="Are you sure you want to continue? [Y/N]: "
if /i not "%confirm%"=="Y" goto menu

echo [INFO] Disabling Windows Search...
echo.

:: Stop and disable Windows Search service
sc config "WSearch" start= disabled >nul 2>&1
sc stop "WSearch" >nul 2>&1

:: Disable search via registry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowIndexingEncryptedStoresOrItems /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul

echo [SUCCESS] Windows Search disabled
pause
goto menu

:enable_search
echo.
echo [INFO] Enabling Windows Search...
echo.

:: Enable and start Windows Search service
sc config "WSearch" start= auto >nul 2>&1
net start "WSearch" >nul 2>&1

:: Enable search via registry
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowIndexingEncryptedStoresOrItems /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /f >nul 2>&1

echo [SUCCESS] Windows Search enabled
pause
goto menu

:clean_history
echo.
echo [INFO] Cleaning search history...
echo.

:: Clean search history
powershell -Command "Get-CimInstance -ClassName Win32_UserProfile | ForEach-Object { $sid = $_.SID; Remove-Item -Path \"HKU:\$sid\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery\" -Recurse -Force -ErrorAction SilentlyContinue }"

:: Clean search suggestions
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f >nul 2>&1

echo [SUCCESS] Search history cleaned
pause
goto menu

:configure_locations
echo.
echo [INFO] Configuring search locations...
echo.

:: Add common search locations
echo [1/3] Adding Documents folder to search locations...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{5C4F28B3-FE69-4B8E-8E79-3E2E4B9F8A71}\TopView" /v ColumnList /t REG_SZ /d "prop:0System.ItemNameDisplay;0System.DateModified;0System.ItemTypeText;0System.Size;0System.Keywords" /f >nul

echo [2/3] Adding Desktop folder to search locations...
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes\{5C4F28B3-FE69-4B8E-8E79-3E2E4B9F8A71}\TopView" /v ColumnList /t REG_SZ /d "prop:0System.ItemNameDisplay;0System.DateModified;0System.ItemTypeText;0System.Size" /f >nul

echo [3/3] Optimizing search locations...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v IndexerPerformance /t REG_DWORD /d 2 /f >nul

echo [SUCCESS] Search locations configured
pause
goto menu

:performance_settings
echo.
echo [INFO] Configuring search performance settings...
echo.

:: Optimize search performance
echo [1/4] Setting indexer performance to balanced...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v IndexerPerformance /t REG_DWORD /d 2 /f >nul

echo [2/4] Reducing indexer resource usage...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search\Gather\Windows" /v MaxMemoryUsage /t REG_DWORD /d 512000 /f >nul

echo [3/4] Optimizing indexing schedule...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search\Gather\Windows" /v UseSystemIdleTime /t REG_DWORD /d 1 /f >nul

echo [4/4] Setting indexing delay...
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v GatherIndexerStartDelayFactor /t REG_DWORD /d 2 /f >nul

echo [SUCCESS] Search performance settings optimized
pause
goto menu

:exit
echo.
echo [INFO] Search Optimizer closed
exit /b 0
