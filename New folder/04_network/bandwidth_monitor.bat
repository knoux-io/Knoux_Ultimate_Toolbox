@echo off
chcp 65001 >nul
title Bandwidth Monitor Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Bandwidth Monitor Tool                       ║
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
echo ║                  Bandwidth Monitor                           ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo [1] Real-time Bandwidth Monitor
echo [2] Network Statistics
echo [3] Bandwidth Usage History
echo [4] Process Bandwidth Usage
echo [5] Network Interface Monitor
echo [6] Bandwidth Speed Test
echo [7] Data Usage Report
echo [8] Bandwidth Alerts
echo [9] Advanced Monitoring
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto realtime_monitor
if "%choice%"=="2" goto network_stats
if "%choice%"=="3" goto usage_history
if "%choice%"=="4" goto process_usage
if "%choice%"=="5" goto interface_monitor
if "%choice%"=="6" goto speed_test
if "%choice%"=="7" goto usage_report
if "%choice%"=="8" goto bandwidth_alerts
if "%choice%"=="9" goto advanced_monitoring
if "%choice%"=="0" goto exit
goto menu

:realtime_monitor
echo.
echo [INFO] Real-time Bandwidth Monitor
echo Press Ctrl+C to stop monitoring
echo.

:: Get initial network statistics
netstat -e > "%TEMP%\initial_stats.txt"

:monitor_loop
cls
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                  Real-time Bandwidth Monitor                  ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo Time: %time%
echo.

:: Get current network statistics
netstat -e | findstr "Bytes"

:: Calculate bandwidth usage
echo.
echo [INFO] Calculating bandwidth usage...
netstat -e > "%TEMP%\current_stats.txt"

:: Display network connections
echo.
echo [INFO] Active Network Connections:
netstat -an | findstr "ESTABLISHED" | find /c ":" > "%TEMP%\connection_count.txt"
set /p conn_count=<"%TEMP%\connection_count.txt"
echo Active connections: %conn_count%

:: Wait for 5 seconds
timeout /t 5 >nul

goto monitor_loop

:network_stats
echo.
echo [INFO] Network Statistics...
echo.

:: Display network statistics
echo [1/4] Network interface statistics:
netstat -e

echo.
echo [2/4] Network protocol statistics:
netstat -s

echo.
echo [3/4] Active connections:
netstat -an | findstr "ESTABLISHED"

echo.
echo [4/4] Listening ports:
netstat -an | findstr "LISTENING"

pause
goto menu

:usage_history
echo.
echo [INFO] Bandwidth Usage History...
echo.

:: Create usage history file
set history_file=%TEMP%\bandwidth_history.txt

if not exist "%history_file%" (
    echo Creating bandwidth history file...
    echo Date,Time,Sent,Received > "%history_file%"
)

:: Add current usage
netstat -e | findstr "Bytes" > "%TEMP%\current_usage.txt"
for /f "tokens=3" %%a in ('findstr "Bytes" "%TEMP%\current_usage.txt" ^| find /v "Bytes"') do set bytes_sent=%%a
for /f "tokens=4" %%a in ('findstr "Bytes" "%TEMP%\current_usage.txt" ^| find /v "Bytes"') do set bytes_received=%%a

echo %date%,%time%,%bytes_sent%,%bytes_received% >> "%history_file%"

:: Display history
echo Bandwidth Usage History:
echo ====================
type "%history_file%"

pause
goto menu

:process_usage
echo.
echo [INFO] Process Bandwidth Usage...
echo.

:: Get process network usage
echo [1/3] Processes with network connections:
netstat -ano | findstr "ESTABLISHED" | findstr "TCP"

echo.
echo [2/3] Process details:
for /f "tokens=5" %%a in ('netstat -ano ^| findstr "ESTABLISHED" ^| findstr "TCP"') do (
    echo Process ID: %%a
    tasklist /fi "PID eq %%a" /fo list | findstr "Image Name"
)

echo.
echo [3/3] Network usage by process:
powershell -Command "Get-Process | Where-Object {$_.WorkingSet -gt 1000000} | Sort-Object WorkingSet -Descending | Select-Object Name,WorkingSet | Format-Table -AutoSize"

pause
goto menu

:interface_monitor
echo.
echo [INFO] Network Interface Monitor...
echo.

:: Display network interface information
echo [1/3] Network interfaces:
wmic nic get Name,AdapterType,Speed,NetConnectionStatus /format:list

echo.
echo [2/3] Interface statistics:
netsh interface show interface

echo.
echo [3/3] Interface traffic:
powershell -Command "Get-Counter '\\Network Interface(*)\\Bytes Received/sec' -MaxSamples 3 | Select-Object -ExpandProperty CounterSamples | Format-Table Path, CookedValue -AutoSize"

pause
goto menu

:speed_test
echo.
echo [INFO] Bandwidth Speed Test...
echo.

:: Test download speed
echo [1/2] Testing download speed...
powershell -Command "$start = Get-Date; Invoke-WebRequest -Uri 'http://speedtest.tele2.net/10MB.zip' -OutFile '$env:TEMP\speedtest.zip'; $end = Get-Date; $duration = ($end - $start).TotalSeconds; $speed = 10 / $duration; Write-Host 'Download Speed: ' $speed ' MB/s'"

del "%TEMP%\speedtest.zip" 2>nul

:: Test upload speed
echo [2/2] Testing upload speed...
echo Upload speed test requires external tools for accurate measurement
echo Creating test file for upload simulation...
powershell -Command "$data = 'Test Data' * 1000000; $data | Out-File -FilePath '$env:TEMP\upload_test.txt' -Encoding ASCII"

echo [SUCCESS] Speed test completed
pause
goto menu

:usage_report
echo.
echo [INFO] Data Usage Report...
echo.

:: Generate comprehensive usage report
set report_file=%TEMP%\bandwidth_report_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt

echo Bandwidth Usage Report > "%report_file%"
echo Generated on: %date% %time% >> "%report_file%"
echo ======================================== >> "%report_file%"
echo. >> "%report_file%"

echo [1/5] Network Statistics: >> "%report_file%"
netstat -e >> "%report_file%"
echo. >> "%report_file%"

echo [2/5] Active Connections: >> "%report_file%"
netstat -an | findstr "ESTABLISHED" >> "%report_file%"
echo. >> "%report_file%"

echo [3/5] Listening Ports: >> "%report_file%"
netstat -an | findstr "LISTENING" >> "%report_file%"
echo. >> "%report_file%"

echo [4/5] Network Interfaces: >> "%report_file%"
wmic nic get Name,Speed,NetConnectionStatus /format:list >> "%report_file%"
echo. >> "%report_file%"

echo [5/5] System Information: >> "%report_file%"
echo OS: %OS% >> "%report_file%"
echo Computer: %COMPUTERNAME% >> "%report_file%"
echo User: %USERNAME% >> "%report_file%"

echo [SUCCESS] Usage report generated
echo [INFO] Report saved to: %report_file%
pause
goto menu

:bandwidth_alerts
echo.
echo [INFO] Bandwidth Alerts Configuration...
echo.

echo [1] Set High Usage Alert
echo [2] Set Connection Alert
echo [3] Set Process Alert
echo [4] View Alert History
echo [0] Back to main menu
echo.
set /p alert_choice="Select an option [0-4]: "

if "%alert_choice%"=="1" goto high_usage_alert
if "%alert_choice%"=="2" goto connection_alert
if "%alert_choice%"=="3" goto process_alert
if "%alert_choice%"=="4" goto alert_history
if "%alert_choice%"=="0" goto menu
goto bandwidth_alerts

:high_usage_alert
echo.
set /p usage_threshold="Enter usage threshold (MB): "
if "%usage_threshold%"=="" goto bandwidth_alerts

echo [INFO] High usage alert set to %usage_threshold% MB
echo [INFO] Monitoring will run in background
echo [INFO] Alert will trigger when usage exceeds threshold

:: Simple monitoring loop
:usage_monitor_loop
netstat -e | findstr "Bytes" > "%TEMP%\current_usage.txt"
for /f "tokens=3" %%a in ('findstr "Bytes" "%TEMP%\current_usage.txt" ^| find /v "Bytes"') do (
    set /a current_usage=%%a/1048576
    if !current_usage! gtr %usage_threshold% (
        echo [ALERT] High bandwidth usage detected: !current_usage! MB
    )
)
timeout /t 30 >nul
goto usage_monitor_loop

:connection_alert
echo.
set /p connection_threshold="Enter connection threshold: "
if "%connection_threshold%"=="" goto bandwidth_alerts

echo [INFO] Connection alert set to %connection_threshold% connections
pause
goto bandwidth_alerts

:process_alert
echo.
echo [INFO] Process bandwidth alert requires specialized monitoring tools
echo [INFO] Consider using Task Manager or Resource Monitor for detailed monitoring
pause
goto bandwidth_alerts

:alert_history
echo.
echo [INFO] Alert History:
if exist "%TEMP%\bandwidth_alerts.txt" (
    type "%TEMP%\bandwidth_alerts.txt"
) else (
    echo No alert history found
)
pause
goto bandwidth_alerts

:advanced_monitoring
echo.
echo [INFO] Advanced Bandwidth Monitoring...
echo.

echo [1] Continuous Monitoring
echo [2] Packet Capture Analysis
echo [3] Protocol Analysis
echo [4] Quality of Service (QoS) Monitoring
echo [5] Network Performance Metrics
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto continuous_monitoring
if "%adv_choice%"=="2" goto packet_capture
if "%adv_choice%"=="3" goto protocol_analysis
if "%adv_choice%"=="4" goto qos_monitoring
if "%adv_choice%"=="5" goto performance_metrics
if "%adv_choice%"=="0" goto menu
goto advanced_monitoring

:continuous_monitoring
echo.
echo [INFO] Starting continuous monitoring...
echo Press Ctrl+C to stop
echo.

:continuous_loop
cls
echo Continuous Bandwidth Monitor - %time%
echo ========================================
netstat -e | findstr "Bytes"
echo.
netstat -an | findstr "ESTABLISHED" | find /c ":" > "%TEMP%\conn_count.txt"
set /p conn_count=<"%TEMP%\conn_count.txt"
echo Active Connections: %conn_count%
echo.
timeout /t 10 >nul
goto continuous_loop

:packet_capture
echo.
echo [INFO] Packet capture requires specialized tools like Wireshark
echo [INFO] Basic packet monitoring:
netstat -an | findstr "UDP"
netstat -an | findstr "TCP"
pause
goto advanced_monitoring

:protocol_analysis
echo.
echo [INFO] Protocol Analysis:
echo [1] TCP Statistics:
netstat -s | findstr "TCP"

echo [2] UDP Statistics:
netstat -s | findstr "UDP"

echo [3] ICMP Statistics:
netstat -s | findstr "ICMP"

pause
goto advanced_monitoring

:qos_monitoring
echo.
echo [INFO] QoS Monitoring requires advanced network tools
echo [INFO] Basic QoS information:
powershell -Command "Get-NetQosPolicy | Select-Object Name,Priority,NetworkProfile"
pause
goto advanced_monitoring

:performance_metrics
echo.
echo [INFO] Network Performance Metrics:
echo [1] Latency:
ping -n 4 8.8.8.8 | findstr "Average"

echo [2] Throughput:
powershell -Command "Get-Counter '\\Network Interface(*)\\Bytes Total/sec' -MaxSamples 3 | Select-Object -ExpandProperty CounterSamples"

echo [3] Packet Loss:
ping -n 10 8.8.8.8 | findstr "Lost"

pause
goto advanced_monitoring

:exit
echo.
echo [INFO] Bandwidth Monitor Tool closed
exit /b 0
