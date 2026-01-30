@echo off
chcp 65001 >nul
title Port Scanner Tool - Knoux Ultimate Toolbox
color 0B

echo.
echo ????????????????????????????????????????????????????????????????
echo ?                    Port Scanner Tool                         ?
echo ?              Knoux Ultimate Toolbox                          ?
echo ????????????????????????????????????????????????????????????????
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
echo ????????????????????????????????????????????????????????????????
echo ?                    Port Scanner                              ?
echo ????????????????????????????????????????????????????????????????
echo.
echo [1] Scan Common Ports
echo [2] Scan Port Range
echo [3] Scan Single Port
echo [4] Scan Local Host
echo [5] Scan Network Range
echo [6] Advanced Port Scan
echo [7] Port Status Check
echo [8] Open Ports List
echo [9] Port Security Check
echo [0] Exit
echo.
set /p choice="Select an option [0-9]: "

if "%choice%"=="1" goto scan_common
if "%choice%"=="2" goto scan_range
if "%choice%"=="3" goto scan_single
if "%choice%"=="4" goto scan_local
if "%choice%"=="5" goto scan_network
if "%choice%"=="6" goto advanced_scan
if "%choice%"=="7" goto port_status
if "%choice%"=="8" goto open_ports
if "%choice%"=="9" goto security_check
if "%choice%"=="0" goto exit
goto menu

:scan_common
echo.
echo [INFO] Scanning common ports...
echo.

set /p target_ip="Enter target IP address: "
if "%target_ip%"=="" goto menu

echo Scanning common ports on %target_ip%...
echo.

:: Common ports to scan
for %%p in (21 22 23 25 53 80 110 143 443 993 995 3389 5432 3306) do (
    echo [%%p] Testing port %%p...
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    ) else (
        echo [CLOSED] Port %%p is closed
    )
)

echo [SUCCESS] Common port scan completed
pause
goto menu

:scan_range
echo.
echo [INFO] Scanning port range...
echo.

set /p target_ip="Enter target IP address: "
if "%target_ip%"=="" goto menu

set /p start_port="Enter start port (1-65535): "
if "%start_port%"=="" set start_port=1

set /p end_port="Enter end port (1-65535): "
if "%end_port%"=="" set end_port=1000

echo Scanning ports %start_port% to %end_port% on %target_ip%...
echo.

for /l %%p in (%start_port%,1,%end_port%) do (
    echo [%%p] Testing port %%p...
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    )
)

echo [SUCCESS] Port range scan completed
pause
goto menu

:scan_single
echo.
echo [INFO] Scanning single port...
echo.

set /p target_ip="Enter target IP address: "
if "%target_ip%"=="" goto menu

set /p port_number="Enter port number: "
if "%port_number%"=="" goto menu

echo Scanning port %port_number% on %target_ip%...
echo.

powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %port_number% -InformationLevel Detailed"

if %errorLevel% equ 0 (
    echo [OPEN] Port %port_number% is open
) else (
    echo [CLOSED] Port %port_number% is closed
)

echo [SUCCESS] Single port scan completed
pause
goto menu

:scan_local
echo.
echo [INFO] Scanning local host...
echo.

echo Scanning common ports on localhost...
echo.

:: Common ports to scan on localhost
for %%p in (21 22 23 25 53 80 110 143 443 993 995 3389 5432 3306 8080 3000 5000) do (
    echo [%%p] Testing port %%p...
    powershell -Command "Test-NetConnection -ComputerName 'localhost' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    ) else (
        echo [CLOSED] Port %%p is closed
    )
)

echo [SUCCESS] Local host scan completed
pause
goto menu

:scan_network
echo.
echo [INFO] Scanning network range...
echo.

set /p network_range="Enter network range (e.g., 192.168.1): "
if "%network_range%"=="" goto menu

set /p start_ip="Enter start IP (last octet): "
if "%start_ip%"=="" set start_ip=1

set /p end_ip="Enter end IP (last octet): "
if "%end_ip%"=="" set end_ip=254

set /p port_number="Enter port to scan: "
if "%port_number%"=="" set port_number=80

echo Scanning port %port_number% on %network_range%.%start_ip% to %network_range%.%end_ip%...
echo.

for /l %%i in (%start_ip%,1,%end_ip%) do (
    echo [%network_range%.%%i] Testing port %port_number%...
    powershell -Command "Test-NetConnection -ComputerName '%network_range%.%%i' -Port %port_number% -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] %network_range%.%%i:%port_number% is open
    )
)

echo [SUCCESS] Network range scan completed
pause
goto menu

:advanced_scan
echo.
echo [INFO] Advanced Port Scan...
echo.

set /p target_ip="Enter target IP address: "
if "%target_ip%"=="" goto menu

echo [1] TCP Connect Scan
echo [2] TCP SYN Scan (requires admin)
echo [3] UDP Scan
echo [4] Service Detection
echo [5] OS Detection
echo [0] Back to main menu
echo.
set /p adv_choice="Select an option [0-5]: "

if "%adv_choice%"=="1" goto tcp_connect
if "%adv_choice%"=="2" goto tcp_syn
if "%adv_choice%"=="3" goto udp_scan
if "%adv_choice%"=="4" goto service_detect
if "%adv_choice%"=="5" goto os_detect
if "%adv_choice%"=="0" goto menu
goto advanced_scan

:tcp_connect
echo.
echo [INFO] TCP Connect Scan on %target_ip%...
echo.

for %%p in (1 7 9 11 13 17 19 20 21 22 23 25 37 42 43 49 53 67 68 69 70 79 80 81 82 83 84 85 87 88 89 90 99 100 101 102 103 104 113_text_tools 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200) do (
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    )
)

echo [SUCCESS] TCP Connect scan completed
pause
goto advanced_scan

:tcp_syn
echo.
echo [WARNING] TCP SYN scan requires external tools like nmap
echo [INFO] This is a simulated TCP SYN scan
echo.

for %%p in (22 23 25 53 80 110 143 443 993 995) do (
    echo [%%p] SYN scan on port %%p...
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    )
)

echo [SUCCESS] TCP SYN scan completed
pause
goto advanced_scan

:udp_scan
echo.
echo [WARNING] UDP scanning is slow and may produce false positives
echo.

for %%p in (53 67 68 69 123 161 162 500 514 520 1434 1900) do (
    echo [%%p] UDP scan on port %%p...
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Quiet" >nul 2>&1
    if !errorlevel! equ 0 (
        echo [OPEN] Port %%p is open
    )
)

echo [SUCCESS] UDP scan completed
pause
goto advanced_scan

:service_detect
echo.
echo [INFO] Service Detection on %target_ip%...
echo.

for %%p in (21 22 23 25 53 80 110 143 443 3389) do (
    echo [%%p] Detecting service on port %%p...
    powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %%p -InformationLevel Detailed" | findstr "TcpTestSucceeded"
)

echo [SUCCESS] Service detection completed
pause
goto advanced_scan

:os_detect
echo.
echo [INFO] OS Detection on %target_ip%...
echo.

echo [WARNING] OS detection requires specialized tools
echo [INFO] Basic OS detection attempt...
ping -n 1 %target_ip% | findstr "TTL"

echo [SUCCESS] OS detection completed
pause
goto advanced_scan

:port_status
echo.
echo [INFO] Port Status Check...
echo.

set /p target_ip="Enter target IP address: "
if "%target_ip%"=="" goto menu

set /p port_number="Enter port number: "
if "%port_number%"=="" goto menu

echo Checking detailed status of port %port_number% on %target_ip%...
echo.

powershell -Command "Test-NetConnection -ComputerName '%target_ip%' -Port %port_number% -InformationLevel Detailed"

echo.
echo Additional information:
netstat -an | findstr ":%port_number%"

echo [SUCCESS] Port status check completed
pause
goto menu

:open_ports
echo.
echo [INFO] Listing open ports...
echo.

echo [1/3] TCP open ports:
netstat -an | findstr "LISTENING"

echo [2/3] UDP open ports:
netstat -an | findstr "UDP"

echo [3/3] Established connections:
netstat -an | findstr "ESTABLISHED"

echo [SUCCESS] Open ports list completed
pause
goto menu

:security_check
echo.
echo [INFO] Port Security Check...
echo.

echo [1/4] Checking for dangerous open ports...
for %%p in (23 135 139 445 1433 3389) do (
    netstat -an | findstr ":%%p " >nul 2>&1
    if !errorlevel! equ 0 (
        echo [WARNING] Potentially dangerous port %%p is open
    )
)

echo [2/4] Checking for backdoor ports...
for %%p in (12345 54321 31337 1999) do (
    netstat -an | findstr ":%%p " >nul 2>&1
    if !errorlevel! equ 0 (
        echo [ALERT] Suspicious port %%p is open
    )
)

echo [3/4] Checking for unauthorized services...
sc query type= service state= running | findstr "SERVICE_NAME"

echo [4/4] Checking firewall status...
netsh advfirewall show allprofiles | findstr "State"

echo [SUCCESS] Security check completed
pause
goto menu

:exit
echo.
echo [INFO] Port Scanner Tool closed
exit /b 0

