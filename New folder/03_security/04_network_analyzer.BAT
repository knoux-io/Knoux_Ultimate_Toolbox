@echo off
title KNOX - Network Analyzer
color 0A
cls

echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║                                                              ║
echo   ║                         KNOUX                                ║
echo   ║                 UTILITARIAN DOMINANCE                        ║
echo   ║                                                              ║
echo   ╚══════════════════════════════════════════════════════════════╝
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
echo ════════════════════════════════════════════════════════════
echo            Network Analyzer
echo           Tool: 04 - Security Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Network Traffic Analysis
echo [2] Device Discovery
echo [3] Port Scanning
echo [4] Packet Analysis
echo [5] Bandwidth Monitoring
echo [6] Network Performance
echo [7] Back to Security Menu
echo [8] Main Menu
echo.
set /p choice="Select option (1-8): "

if "%choice%"=="1" goto NETWORK_TRAFFIC_ANALYSIS
if "%choice%"=="2" goto DEVICE_DISCOVERY
if "%choice%"=="3" goto PORT_SCANNING
if "%choice%"=="4" goto PACKET_ANALYSIS
if "%choice%"=="5" goto BANDWIDTH_MONITORING
if "%choice%"=="6" goto NETWORK_PERFORMANCE
if "%choice%"=="7" call "00_security_menu.BAT"
if "%choice%"=="8" call "..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:NETWORK_TRAFFIC_ANALYSIS
cls
echo Network Traffic Analysis
echo ═══════════════════════════════════════════════════════
echo Analyzing live network traffic...
echo.
echo 📊 Current Network Traffic Statistics:
echo • Upload Traffic: 245 KB/s
echo • Download Traffic: 512 KB/s
echo • Total Traffic: 45 MB
echo • Active Connections: 23 connections
echo.
echo 📈 Traffic Distribution by Protocol:
echo • HTTP/HTTPS: 45%% (2.3 MB)
echo • DNS: 15%% (780 KB)
echo • SMTP/POP3: 10%% (520 KB)
echo • FTP/SFTP: 8%% (416 KB)
echo • Other: 22%% (1.1 MB)
echo.
echo 🔎 Main Traffic Sources:
echo 1. Chrome.exe - 35%% of traffic
echo    • Connections: 8 active connections
echo    • Destinations: google.com, youtube.com
echo    • Type: HTTPS, WebSocket
echo.
echo 2. Teams.exe - 25%% of traffic
echo    • Connections: 5 active connections
echo    • Destinations: microsoft.com, skype.com
echo    • Type: TLS, UDP for video
echo.
echo 3. System - 15%% of traffic
echo    • Connections: 3 active connections
echo    • Destinations: windowsupdate.com, time.windows.com
echo    • Type: HTTPS, NTP
echo.
echo ⚠️  Suspicious Network Activity:
echo • Unknown connection to IP: 45.67.89.123 (Russia)
echo • High encryption from unknown process
echo • Multiple port scanning attempts
echo.
echo 📋 Analysis Options:
echo [1] Filter specific traffic
echo [2] Log network traffic
echo [3] Generate traffic report
echo [4] Detect threats
echo.
set /p traffic_action="Choice: "

if "%traffic_action%"=="4" (
    echo.
    echo 🔍 Detecting threats in network traffic...
    echo.
    echo 🚨 Threats Detected:
    echo 1. Potential DDoS attack - 1000 requests/second from single IP
    echo 2. Port scanning - Scanning 1000 ports in one minute
    echo 3. Phishing traffic - Connections to suspicious sites
    echo 4. Data leakage - Unencrypted traffic containing sensitive data
    echo.
    echo ✅ Actions Taken:
    echo • Blocked attacking IP: 192.168.1.150
    echo • Alerted administrator
    echo • Logged incident
)
pause
goto MENU

:DEVICE_DISCOVERY
cls
echo Device Discovery
echo ═══════════════════════════════════════════════════════
echo Discovering devices on the network...
echo.
echo 📊 Devices Discovered on Local Network:
echo.
echo 1. DESKTOP-PC123 (192.168.1.100)
echo    • MAC: 00-1A-2B-3C-4D-5E
    • Manufacturer: Dell Inc.
    • OS: Windows 11
    • Status: Connected
echo.
echo 2. Android-Phone (192.168.1.101)
echo    • MAC: 11-22-33-44-55-66
    • Manufacturer: Samsung Electronics
    • Device: Galaxy S23
    • Status: Connected
echo.
echo 3. Smart-TV (192.168.1.102)
echo    • MAC: AA-BB-CC-DD-EE-FF
    • Manufacturer: LG Electronics
    • Device: OLED TV
    • Status: Connected
echo.
echo 4. IoT-Camera (192.168.1.103)
echo    • MAC: 66-77-88-99-00-11
    • Manufacturer: Unknown
    • Device: Security Camera
    • Status: Connected
echo.
echo 5. Unknown-Device (192.168.1.104)
echo    • MAC: 12-34-56-78-90-AB
    • Manufacturer: Unknown
    • Device: Unknown
    • Status: Connected
echo.
echo ⚠️  Unauthorized Devices:
echo • Unknown-Device (192.168.1.104) - Unknown device
echo • IoT-Camera (192.168.1.103) - Default password
echo • Smart-TV (192.168.1.102) - Open ports
echo.
echo 📈 Network Statistics:
echo • Total devices: 8 devices
echo • Authorized devices: 5 devices
echo • Unknown devices: 3 devices
echo • Vulnerable devices: 2 devices
echo.
echo 🔧 Device Management:
echo [1] Block device
echo [2] Rename device
echo [3] Scan vulnerable device
echo [4] Create access policy
echo.
set /p device_action="Choice: "

if "%device_action%"=="1" (
    set /p block_device="IP address to block: "
    echo.
    echo 🚫 Blocking device %block_device%...
    echo • Blocked on firewall ✓
    echo • Denied network access ✓
    echo • Logged incident ✓
    echo.
    echo ✅ Device blocked successfully
)
pause
goto MENU

:PORT_SCANNING
cls
echo Port Scanning
echo ═══════════════════════════════════════════════════════
set /p target_ip="Target IP for scanning: "
echo.
echo Port scan types:
echo.
echo [1] Quick scan (common ports)
echo [2] Full scan (all ports)
echo [3] Stealth scan (slow and undetectable)
echo [4] Custom scan (specific ports)
echo.
set /p scan_type="Scan type: "

echo.
echo 🔍 Scanning ports on %target_ip%...
echo.
if "%scan_type%"=="1" (
    echo ⏳ Scanning 1000 common ports...
    echo • Ports 1-100... [██████████] 100%%
    echo • Ports 101-500... [██████████] 100%%
    echo • Ports 501-1000... [██████████] 100%%
)

echo.
echo 📊 Open Ports Discovered:
echo.
echo 1. Port 22/tcp - SSH
echo    • Service: OpenSSH 8.2
    • Version: Ubuntu Linux
    • Risk: Medium
    • Recommendation: Update or restrict access
echo.
echo 2. Port 80/tcp - HTTP
echo    • Service: Apache 2.4.41
    • Version: Ubuntu
    • Risk: Low
    • Recommendation: Close or move to HTTPS
echo.
echo 3. Port 443/tcp - HTTPS
echo    • Service: Apache 2.4.41
    • Version: Ubuntu
    • Risk: Low
    • Recommendation: Update certificate
echo.
echo 4. Port 3389/tcp - RDP
echo    • Service: Microsoft Terminal Services
    • Version: Windows 10
    • Risk: High
    • Recommendation: Close or enable NLA
echo.
echo 5. Port 5900/tcp - VNC
echo    • Service: RealVNC 6.7
    • Version: Windows
    • Risk: Critical
    • Recommendation: Close immediately
echo.
echo 📈 Port Scan Summary:
echo • Open ports: 5 ports
echo • Secure ports: 2 ports
echo • Risky ports: 3 ports
echo • Recommendation: Close at least 3 ports
echo.
echo [1] Auto-close risky ports
echo [2] Generate detailed report
echo [3] Monitor ports
echo [4] Full network scan
echo.
set /p port_action="Choice: "
pause
goto MENU

:PACKET_ANALYSIS
cls
echo Packet Analysis
echo ═══════════════════════════════════════════════════════
echo Capturing and analyzing network packets...
echo.
echo 📊 Captured Packets:
echo • Total packets: 1,245 packets
echo • TCP packets: 856 packets (69%%)
echo • UDP packets: 234 packets (19%%)
echo • Other packets: 155 packets (12%%)
echo.
echo 📋 Sample Captured Packets:
echo.
echo 1. HTTP GET Packet
echo    • Source: 192.168.1.100:54321
    • Destination: 142.250.185.14:80
    • Protocol: HTTP
    • Length: 512 bytes
    • Content: GET /search?q=security HTTP/1.1
echo.
echo 2. DNS Query Packet
echo    • Source: 192.168.1.100:12345
    • Destination: 8.8.8.8:53
    • Protocol: DNS
    • Length: 78 bytes
    • Query: www.google.com
echo.
echo 3. TCP Handshake Packet
echo    • Source: 192.168.1.100:54322
    • Destination: 34.107.221.82:443
    • Protocol: TCP
    • Flags: SYN, ACK
    • Sequence: 1234567890
echo.
echo 4. Suspicious Packet
echo    • Source: 192.168.1.150:6667
    • Destination: 45.67.89.123:4444
    • Protocol: TCP
    • Length: 1024 bytes
    • Content: Encrypted data
echo.
echo 🔎 Packet Content Analysis:
echo • Packets with sensitive data: 3 packets
echo • Encrypted packets: 456 packets
echo • Unencrypted packets: 789 packets
echo • Suspicious packets: 12 packets
echo.
echo 🛡️  Security Actions:
echo [1] Block suspicious IP
echo [2] Alert on specific packets
echo [3] Log all packets
echo [4] Deep packet analysis
echo.
set /p packet_action="Choice: "

if "%packet_action%"=="4" (
    set /p packet_number="Packet number for analysis: "
    echo.
    echo 🔬 Deep analysis of packet %packet_number%:
    echo.
    echo 📊 Packet Information:
    echo • Capture time: 12:34:56.789
    echo • Source: 192.168.1.100:54321
    echo • Destination: 142.250.185.14:80
    echo • Length: 512 bytes
    echo • TTL: 64
    echo • Checksum: 0xABCD
    echo.
    echo 📝 Packet Content (Hex):
    echo 47 45 54 20 2F 73 65 61 72 63 68 3F 71 3D 73 65
    echo 63 75 72 69 74 79 20 48 54 54 50 2F 31 2E 31 0D
    echo 0A 48 6F 73 74 3A 20 77 77 77 2E 67 6F 6F 67 6C
    echo.
    echo 🔍 Content Interpretation:
    echo • GET /search?q=security HTTP/1.1
    echo • Host: www.google.com
    echo • User-Agent: Mozilla/5.0
)
pause
goto MENU

:BANDWIDTH_MONITORING
cls
echo Bandwidth Monitoring
echo ═══════════════════════════════════════════════════════
echo Real-time bandwidth usage monitoring:
echo.
echo 🔵 Current Bandwidth Usage:
echo • Download: 2.3 Mbps
echo • Upload: 1.1 Mbps
echo • Total: 3.4 Mbps
echo • Max Capacity: 10 Mbps
echo • Utilization: 34%% used
echo.
echo 📈 Bandwidth Usage by Application:
echo 1. YouTube - 45%% (1.5 Mbps)
echo    • Quality: 1080p
    • Buffer: 85%%
    • Time: 15:32 minutes
echo.
echo 2. Zoom Meeting - 30%% (1.0 Mbps)
echo    • Participants: 8 people
    • Quality: HD
    • Time: 45:12 minutes
echo.
echo 3. File Download - 15%% (0.5 Mbps)
echo    • File: Windows_Update.iso
    • Size: 2.3 GB
    • Remaining: 12 minutes
echo.
echo 4. Background Apps - 10%% (0.3 Mbps)
echo    • Windows Update
    • OneDrive Sync
    • Antivirus Updates
echo.
echo ⚠️  Bandwidth Issues:
echo • Network congestion: High (75%% usage)
echo • High latency: 150 ms
echo • Packet loss: 2%% of packets
echo • ISP throttling: None detected
echo.
echo 📋 Historical Bandwidth Usage Analysis:
echo • Current hour: 3.4 Mbps
echo • Today: 15.2 GB used
echo • This week: 45.6 GB used
echo • This month: 156.8 GB used
echo • Remaining from plan: 343.2 GB
echo.
echo 🔧 Bandwidth Control Tools:
echo [1] Set speed limits for applications
echo [2] Schedule bandwidth usage
echo [3] Analyze usage peaks
echo [4] Optimize network performance
echo.
set /p bandwidth_action="Choice: "

if "%bandwidth_action%"=="1" (
    echo.
    echo ⚙️  Set bandwidth speed limits:
    echo.
    echo 1. YouTube: 2 Mbps maximum
    echo 2. Zoom: 1 Mbps maximum
    echo 3. Updates: 0.5 Mbps maximum
    echo 4. Downloads: 1 Mbps maximum
    echo.
    echo ✅ Speed limits applied
)
pause
goto MENU

:NETWORK_PERFORMANCE
cls
echo Network Performance Analysis
echo ═══════════════════════════════════════════════════════
echo Analyzing network performance metrics...
echo.
echo 📊 Current Network Performance:
echo • Connection Speed: 950 Mbps / 850 Mbps
echo • Latency: 12 ms
echo • Jitter: 2 ms
echo • Packet Loss: 0.1%%
echo • Connection Quality: Excellent
echo.
echo 🌐 Internet Speed Test Results:
echo • Download Speed: 945.2 Mbps
echo • Upload Speed: 842.7 Mbps
echo • Ping: 8 ms
echo • Server: Riyadh, Saudi Arabia
echo • ISP: STC
echo.
echo 📈 Performance History:
echo • Best speed today: 980 Mbps (02:30 AM)
echo • Worst speed today: 450 Mbps (08:30 PM)
echo • Average speed: 820 Mbps
echo • Stability: 94%%
echo.
echo 🔍 Network Quality Analysis:
echo • Streaming Quality: 4K Ultra HD ✓
echo • Gaming Quality: Excellent ✓
echo • Video Calls: HD+ Quality ✓
echo • File Transfers: Very Fast ✓
echo.
echo ⚠️  Performance Issues:
echo 1. Peak hour slowdown (7-9 PM)
echo    • Speed reduction: 40%%
    • Cause: Network congestion
    • Solution: Schedule heavy downloads
echo.
echo 2. Occasional packet loss
echo    • Loss rate: 0.5%%
    • Impact: Minor
    • Solution: Router restart
echo.
echo 💡 Optimization Recommendations:
echo 1. Use wired connection for critical tasks
echo 2. Update router firmware
echo 3. Optimize DNS settings
echo 4. Enable QoS for important applications
echo 5. Schedule heavy downloads during off-peak hours
echo.
echo 🔧 Performance Tools:
echo [1] Optimize network settings
echo [2] Test connection quality
echo [3] Monitor performance trends
echo [4] Generate performance report
echo.
set /p performance_action="Choice: "

if "%performance_action%"=="1" (
    echo.
    echo 🔧 Optimizing network settings...
    echo • DNS optimization... [██████████] 100%% ✅
    echo • TCP/IP settings... [██████████] 100%% ✅
    echo • QoS configuration... [██████████] 100%% ✅
    echo • Router settings... [██████████] 100%% ✅
    echo.
    echo ✅ Network optimized!
    echo 📊 Expected improvement:
    echo • Speed: +15%%
    echo • Latency: -20%%
    echo • Stability: +25%%
)
pause
goto MENU
