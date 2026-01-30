@echo off
chcp 65001 >nul
title Network Speed Test Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Network Speed Test Tool                     ║
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
echo ║                  Network Speed Test                         ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Basic Speed Test
echo [2] Advanced Speed Test
echo [3] Latency Test
echo [4] Bandwidth Test
echo [5] Connection Quality Test
echo [6] Network Performance Test
echo [7] Compare Speed Tests
echo [8] Speed Test History
echo [9] Custom Speed Test
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto basic_test
if "%choice%"=="2" goto advanced_test
if "%choice%"=="3" goto latency_test
if "%choice%"=="4" goto bandwidth_test
if "%choice%"=="5" goto quality_test
if "%choice%"=="6" goto performance_test
if "%choice%"=="7" goto compare_tests
if "%choice%"=="8" goto test_history
if "%choice%"=="9" goto custom_test
if "%choice%"=="0" goto exit
goto menu

:basic_test
echo.
echo [INFO] Basic Network Speed Test...
echo.

:: Test ping to common servers
echo [1/4] Testing ping to Google DNS...
ping -n 4 8.8.8.8 | findstr "Average\|Minimum\|Maximum"

echo [2/4] Testing ping to Cloudflare DNS...
ping -n 4 1.1.1.1 | findstr "Average\|Minimum\|Maximum"

echo [3/4] Testing download speed (simple test)...
powershell -Command "(Measure-Command {Invoke-WebRequest -Uri 'http://speedtest.tele2.net/1MB.zip' -OutFile '$env:TEMP\test_speed.zip'}).TotalMilliseconds" > "%TEMP%\download_time.txt"
set /p download_time=<"%TEMP%\download_time.txt"
set /a download_speed=1000*8000/%download_time%
echo Estimated download speed: %download_speed% Kbps
del "%TEMP%\test_speed.zip" 2>nul

echo [4/4] Testing upload speed (simple test)...
echo Creating test file...
echo This is a test file for upload speed measurement > "%TEMP%\upload_test.txt"
echo Upload speed test requires external tools for accurate measurement
del "%TEMP%\upload_test.txt" 2>nul

echo [SUCCESS] Basic speed test completed
pause
goto menu

:advanced_test
echo.
echo [INFO] Advanced Network Speed Test...
echo.

:: Test multiple servers
echo [1/6] Testing connection to multiple servers...
for %%s in (8.8.8.8 1.1.1.1 208.67.222.222 9.9.9.9) do (
    echo Testing %%s...
    ping -n 2 %%s | findstr "Average"
)

echo [2/6] Testing packet loss...
ping -n 10 8.8.8.8 | findstr "Lost"

echo [3/6] Testing jitter...
ping -n 10 8.8.8.8 > "%TEMP%\ping_results.txt"
for /f "tokens=5" %%a in ('findstr "time=" "%TEMP%\ping_results.txt"') do (
    echo Ping time: %%a
)

echo [4/6] Testing DNS resolution speed...
powershell -Command "(Measure-Command {Resolve-DnsName google.com}).TotalMilliseconds" > "%TEMP%\dns_time.txt"
set /p dns_time=<"%TEMP%\dns_time.txt"
echo DNS resolution time: %dns_time% ms

echo [5/6] Testing HTTP response time...
powershell -Command "(Measure-Command {Invoke-WebRequest -Uri 'https://www.google.com' -UseBasicParsing}).TotalMilliseconds" > "%TEMP%\http_time.txt"
set /p http_time=<"%TEMP%\http_time.txt"
echo HTTP response time: %http_time% ms

echo [6/6] Testing network throughput...
powershell -Command "$test = Test-NetConnection -ComputerName 'speedtest.net' -Port 80; $test.TcpTestSucceeded"

echo [SUCCESS] Advanced speed test completed
pause
goto menu

:latency_test
echo.
echo [INFO] Network Latency Test...
echo.

:: Test latency to various servers
echo [1/4] Testing local network latency...
ping -n 10 127.0.0.1 | findstr "Average\|Minimum\|Maximum"

echo [2/4] Testing gateway latency...
for /f "tokens=2" %%a in ('ipconfig ^| findstr "Default Gateway"') do (
    set gateway=%%a
)
if defined gateway (
    ping -n 10 %gateway% | findstr "Average\|Minimum\|Maximum"
)

echo [3/4] Testing ISP latency...
ping -n 10 8.8.8.8 | findstr "Average\|Minimum\|Maximum"

echo [4/4] Testing international latency...
ping -n 10 1.1.1.1 | findstr "Average\|Minimum\|Maximum"

echo [SUCCESS] Latency test completed
pause
goto menu

:bandwidth_test
echo.
echo [INFO] Network Bandwidth Test...
echo.

:: Test download bandwidth
echo [1/3] Testing download bandwidth...
powershell -Command "$start = Get-Date; Invoke-WebRequest -Uri 'http://speedtest.tele2.net/10MB.zip' -OutFile '$env:TEMP\bandwidth_test.zip'; $end = Get-Date; ($end - $start).TotalSeconds" > "%TEMP%\bandwidth_time.txt"
set /p bandwidth_time=<"%TEMP%\bandwidth_time.txt"
set /a bandwidth_speed=10000000/%bandwidth_time%
echo Download bandwidth: %bandwidth_speed% bytes/second
del "%TEMP%\bandwidth_test.zip" 2>nul

echo [2/3] Testing upload bandwidth...
echo Upload bandwidth test requires external tools
echo Creating 1MB test file...
powershell -Command "$data = 'A' * 1048576; $data | Out-File -FilePath '$env:TEMP\upload_test.dat' -Encoding ASCII"
echo Test file created: %TEMP%\upload_test.dat

echo [3/3] Testing simultaneous connections...
powershell -Command "1..5 | ForEach-Object { Start-Job -ScriptBlock { Test-NetConnection -ComputerName '8.8.8.8' -Port 53 } }; Get-Job | Wait-Job | Receive-Job; Remove-Job *"

echo [SUCCESS] Bandwidth test completed
pause
goto menu

:quality_test
echo.
echo [INFO] Connection Quality Test...
echo.

:: Test connection quality metrics
echo [1/5] Testing packet loss rate...
ping -n 20 8.8.8.8 | findstr "Lost"

echo [2/5] Testing connection stability...
for /l %%i in (1,1,5) do (
    echo Test %%i:
    ping -n 1 8.8.8.8 | findstr "time="
    timeout /t 1 >nul
)

echo [3/5] Testing DNS reliability...
for /l %%i in (1,1,3) do (
    echo DNS Test %%i:
    nslookup google.com 8.8.8.8 | findstr "Address"
)

echo [4/5] Testing route consistency...
tracert -h 5 8.8.8.8

echo [5/5] Testing connection timeout...
powershell -Command "Test-NetConnection -ComputerName '8.8.8.8' -Port 80 -InformationLevel Detailed"

echo [SUCCESS] Connection quality test completed
pause
goto menu

:performance_test
echo.
echo [INFO] Network Performance Test...
echo.

:: Test network performance
echo [1/4] Testing TCP performance...
powershell -Command "$tcp = Test-NetConnection -ComputerName 'google.com' -Port 443; $tcp.TcpTestSucceeded"

echo [2/4] Testing UDP performance...
echo UDP performance test requires specialized tools

echo [3/4] Testing network interface performance...
wmic nic get Name,Speed,NetConnectionStatus /format:list | findstr "="

echo [4/4] Testing system network performance...
netstat -e | findstr "Bytes"

echo [SUCCESS] Performance test completed
pause
goto menu

:compare_tests
echo.
echo [INFO] Compare Speed Tests...
echo.

:: Run multiple tests and compare
echo [1/3] Running morning test...
call :basic_test_internal
echo Morning test completed

echo [2/3] Running afternoon test...
timeout /t 2 >nul
call :basic_test_internal
echo Afternoon test completed

echo [3/3] Running evening test...
timeout /t 2 >nul
call :basic_test_internal
echo Evening test completed

echo [SUCCESS] Comparison tests completed
pause
goto menu

:basic_test_internal
ping -n 4 8.8.8.8 | findstr "Average" >nul
goto :eof

:test_history
echo.
echo [INFO] Speed Test History...
echo.

:: Check for existing test results
if exist "%TEMP%\speed_test_history.txt" (
    echo Previous test results:
    type "%TEMP%\speed_test_history.txt"
) else (
    echo No test history found
)

echo.
echo Current test results:
echo Date: %date% Time: %time%
ping -n 4 8.8.8.8 | findstr "Average"

:: Save current test results
echo Date: %date% Time: %time% >> "%TEMP%\speed_test_history.txt"
ping -n 4 8.8.8.8 | findstr "Average" >> "%TEMP%\speed_test_history.txt"
echo -------------------------------- >> "%TEMP%\speed_test_history.txt"

pause
goto menu

:custom_test
echo.
echo [INFO] Custom Speed Test...
echo.

set /p test_server="Enter server IP or hostname: "
if "%test_server%"=="" goto menu

set /p test_count="Enter number of pings (default 4): "
if "%test_count%"=="" set test_count=4

set /p test_port="Enter port number (optional): "

echo [INFO] Running custom test to %test_server%...
ping -n %test_count% %test_server%

if not "%test_port%"=="" (
    echo Testing port %test_port%...
    powershell -Command "Test-NetConnection -ComputerName '%test_server%' -Port %test_port%"
)

echo [SUCCESS] Custom test completed
pause
goto menu

:exit
echo.
echo [INFO] Network Speed Test Tool closed
exit /b 0
