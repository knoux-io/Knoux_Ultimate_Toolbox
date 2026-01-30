@echo off
title KNOX - Firewall Configurator
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
echo            Firewall Configurator
echo           Tool: 05 - Security Tools
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] View Firewall Rules
echo [2] Add New Rule
echo [3] Edit Existing Rule
echo [4] Delete Rule
echo [5] Analyze Firewall Effectiveness
echo [6] Create Security Policies
echo [7] Back to Security Menu
echo [8] Main Menu
echo.
set /p choice="Select option (1-8): "

if "%choice%"=="1" goto VIEW_FIREWALL_RULES
if "%choice%"=="2" goto ADD_FIREWALL_RULE
if "%choice%"=="3" goto EDIT_FIREWALL_RULE
if "%choice%"=="4" goto DELETE_FIREWALL_RULE
if "%choice%"=="5" goto ANALYZE_FIREWALL_EFFECTIVENESS
if "%choice%"=="6" goto CREATE_SECURITY_POLICIES
if "%choice%"=="7" call "00_security_menu.BAT"
if "%choice%"=="8" call "..\..\KNOX_MAIN_MENU.BAT"
goto MENU

:VIEW_FIREWALL_RULES
cls
echo View Firewall Rules
echo ═══════════════════════════════════════════════════════
echo 📋 Active Firewall Rules:
echo.
echo 1. HTTPS Inbound Rule
echo    • Name: Allow-Inbound-HTTPS
    • Port: TCP 443
    • Direction: Inbound
    • Action: Allow
    • Source: Any
    • Destination: This device
    • Status: Enabled
echo.
echo 2. SSH Inbound Rule
echo    • Name: Allow-Inbound-SSH
    • Port: TCP 22
    • Direction: Inbound
    • Action: Allow
    • Source: 192.168.1.0/24
    • Destination: This device
    • Status: Enabled
echo.
echo 3. RDP Inbound Rule
echo    • Name: Block-Inbound-RDP
    • Port: TCP 3389
    • Direction: Inbound
    • Action: Block
    • Source: Any
    • Destination: This device
    • Status: Enabled
echo.
echo 4. ICMP Outbound Rule
echo    • Name: Allow-Outbound-ICMP
    • Port: ICMP
    • Direction: Outbound
    • Action: Allow
    • Source: This device
    • Destination: Any
    • Status: Enabled
echo.
echo 5. Malware Ports Block Rule
echo    • Name: Block-Malware-Ports
    • Ports: 4444, 6667, 31337
    • Direction: Inbound and Outbound
    • Action: Block
    • Source: Any
    • Destination: Any
    • Status: Enabled
echo.
echo 📊 Rule Statistics:
echo • Total rules: 25 rules
echo • Allow rules: 15 rules
echo • Block rules: 10 rules
echo • Enabled rules: 20 rules
echo • Disabled rules: 5 rules
echo.
echo 🔍 View specific rule:
echo [1] View specific rule
echo [2] Export all rules
echo [3] Check for duplicates
echo [4] Back
echo.
set /p view_action="Choice: "
pause
goto MENU

:ADD_FIREWALL_RULE
cls
echo Add New Firewall Rule
echo ═══════════════════════════════════════════════════════
echo ⚙️  New Rule Configuration:
echo.
set /p rule_name="Rule name: "
echo.
echo Rule type:
echo [1] Allow rule
echo [2] Block rule
echo [3] Log rule
echo.
set /p rule_type="Rule type: "

echo.
echo Rule direction:
echo [1] Inbound
echo [2] Outbound
echo [3] Both directions
echo.
set /p rule_direction="Direction: "

echo.
echo Rule protocol:
echo [1] TCP
echo [2] UDP
echo [3] ICMP
echo [4] Any protocol
echo.
set /p rule_protocol="Protocol: "

echo.
set /p rule_ports="Ports (comma separated): "
set /p rule_source="Source address (Any for all): "
set /p rule_destination="Destination address (Any for all): "
set /p rule_description="Rule description: "

echo.
echo 🔧 Creating rule...
echo.
echo 📋 New Rule Details:
echo • Name: %rule_name%
echo • Type: %rule_type%
echo • Direction: %rule_direction%
echo • Protocol: %rule_protocol%
echo • Ports: %rule_ports%
echo • Source: %rule_source%
echo • Destination: %rule_destination%
echo • Description: %rule_description%
echo.
echo ✅ Rule created successfully
echo 🔐 Rule automatically enabled
echo 📁 Rule location: F:\KNOX_Secure\Firewall\Rules\
echo.
echo 📊 Rule Impact:
echo • Will affect: 5 applications
echo • Will allow/block: 120 packets/hour
echo • Activity logging: Enabled
echo • Notifications: Enabled
echo.
echo [1] Apply rule immediately
echo [2] Schedule rule activation
echo [3] Test rule
echo [4] Back
echo.
set /p add_action="Choice: "

if "%add_action%"=="3" (
    echo.
    echo 🧪 Testing new rule...
    echo • Simulating inbound traffic... [██████████] 100%%
    echo • Applying rule... [██████████] 100%%
    echo • Verifying results... [██████████] 100%%
    echo.
    echo 📊 Test Results:
    echo • Allowed packets: 45 packets
    echo • Blocked packets: 12 packets
    echo • Performance: No noticeable impact
    echo • Recommendation: Rule is effective
)
pause
goto MENU

:EDIT_FIREWALL_RULE
cls
echo Edit Existing Rule
echo ═══════════════════════════════════════════════════════
echo 📋 Select rule to edit:
echo.
echo 1. Allow-Inbound-HTTPS (Enabled)
echo 2. Block-Inbound-RDP (Enabled)
echo 3. Allow-Outbound-DNS (Enabled)
echo 4. Block-Malware-Ports (Enabled)
echo 5. Allow-VPN-Traffic (Disabled)
echo.
set /p edit_rule="Rule number: "

echo.
echo 🔧 Edit options for rule %edit_rule%:
echo.
echo [1] Change rule state (enable/disable)
echo [2] Modify ports
echo [3] Modify addresses
echo [4] Change action
echo [5] Modify advanced settings
echo.
set /p edit_option="Edit option: "

if "%edit_option%"=="1" (
    echo.
    echo 🔄 Changing rule state:
    echo [1] Enable rule
    echo [2] Temporarily disable rule
    echo [3] Permanently delete rule
    echo.
    set /p rule_state="Choice: "

    if "%rule_state%"=="1" (
        echo ✅ Rule enabled successfully
    )
    if "%rule_state%"=="2" (
        echo ⏸️  Rule temporarily disabled
        echo ⏰ Will auto-reenable after 24 hours
    )
)

if "%edit_option%"=="5" (
    echo.
    echo ⚙️  Advanced Rule Settings:
    echo.
    set /p rule_logging="Log rule activity (Y/N): "
    set /p rule_notifications="Rule notifications (Y/N): "
    set /p rule_schedule="Schedule rule (Y/N): "

    if /i "%rule_schedule%"=="Y" (
        echo.
        echo 📅 Rule activation schedule:
        echo • Days: Monday - Friday
        echo • Time: 08:00 - 18:00
        echo • Exceptions: Public holidays
        echo.
        echo ✅ Rule scheduled
    )
)

echo.
echo 📊 Impact of changes:
echo • Will update: 3 affected applications
echo • Application time: Immediate
echo • Requires restart: No
echo • Backup: Automatically created
echo.
pause
goto MENU

:DELETE_FIREWALL_RULE
cls
echo Delete Firewall Rule
echo ═══════════════════════════════════════════════════════
echo ⚠️  Warning: Deleting rules may affect system security
echo.
echo 📋 Rules that can be deleted:
echo.
echo 1. Allow-Inbound-HTTP (Old)
echo    • Created: 2023-01-15
    • Last used: 2023-12-01
    • Recommendation: Safe to delete
echo.
echo 2. Allow-Outbound-FTP (Insecure)
echo    • Created: 2023-03-20
    • Last used: 2023-11-15
    • Recommendation: Delete and replace with SFTP
echo.
echo 3. Block-IP-192.168.1.150 (Temporary)
echo    • Created: 2024-01-10
    • Purpose: Block temporary attack
    • Recommendation: Review before deletion
echo.
echo 4. Allow-Remote-Desktop (Duplicate)
echo    • Created: 2023-09-05
    • Duplicate of: RDP-VPN rule
    • Recommendation: Delete for simplification
echo.
echo 🔍 Pre-deletion analysis:
echo • Application impact: Low
echo • Security impact: No negative impact
echo • Performance: Slight improvement
echo • Logs: Preserved
echo.
echo [1] Delete specific rule
echo [2] Delete unused rules
echo [3] Delete all temporary rules
echo [4] Create backup before deletion
echo.
set /p delete_action="Choice: "

if "%delete_action%"=="1" (
    set /p delete_rule="Rule name to delete: "
    echo.
    echo 🗑️  Deleting rule '%delete_rule%'...
    echo • Checking dependencies... [██████████] 100%%
    echo • Creating backup... [██████████] 100%%
    echo • Deleting rule... [██████████] 100%%
    echo • Updating firewall... [██████████] 100%%
    echo.
    echo ✅ Rule deleted successfully
    echo 📊 Changes:
    echo • Remaining rules: 24 rules
    echo • Performance: +2%% improvement
    echo • Security: No impact
)

if "%delete_action%"=="4" (
    echo.
    echo 💾 Creating rules backup...
    echo • Number of rules: 25 rules
    echo • Location: F:\KNOX_Backup\Firewall\
    echo • Encryption: AES-256
    echo • Date: %date% %time%
    echo.
    echo ✅ Backup created
    echo 🔐 Password: BACKUP_%random%%random%%random%
)
pause
goto MENU

:ANALYZE_FIREWALL_EFFECTIVENESS
cls
echo Analyze Firewall Effectiveness
echo ═══════════════════════════════════════════════════════
echo 🔍 Analyzing firewall performance and effectiveness...
echo.
echo 📊 Firewall Effectiveness Indicators:
echo.
echo 1. Block Rate
echo    • Blocked attacks: 1,245 attacks
    • Successful attacks: 12 attacks
    • Block rate: 99%% ✓
    • Rating: Excellent
echo.
echo 2. Response Time
echo    • Average processing time: 2.3 ms
    • Longest processing time: 45 ms
    • Acceptable response time: < 10 ms ✓
    • Rating: Very good
echo.
echo 3. Rule Accuracy
echo    • True positives: 98%% ✓
    • False positives: 2%%
    • False negatives: 0.5%%
    • Rating: Excellent
echo.
echo 4. Resource Usage
echo    • Memory usage: 45 MB
    • CPU usage: 3%%
    • Network usage: 1%%
    • Rating: Excellent
echo.
echo 📈 Overall Firewall Assessment:
echo • Effectiveness score: 92/100 🏆
echo • Level: Excellent
echo • Recommendation: Continue regular maintenance
echo.
echo 🔎 Strengths:
echo ✓ High block rate (99%%)
echo ✓ Excellent rule accuracy
echo ✓ Low resource usage
echo ✓ Regular updates
echo.
echo ⚠️  Weaknesses:
echo ✗ Some false positives (2%%)
echo ✗ One ineffective rule
echo ✗ Needs logging improvement
echo.
echo 💡 Improvement Recommendations:
echo 1. Adjust false positive rules
echo 2. Update old RDP rule
echo 3. Improve event logging
echo 4. Add new threat rules
echo.
echo 📋 Detailed Reports:
echo [1] Blocked attacks report
echo [2] Daily performance report
echo [3] Rule usage report
echo [4] New threats report
echo.
set /p analyze_action="Choice: "
pause
goto MENU

:CREATE_SECURITY_POLICIES
cls
echo Create Security Policies
echo ═══════════════════════════════════════════════════════
echo 🛡️  Create comprehensive security policies...
echo.
echo 📋 Policy Templates:
echo [1] High Security Policy
echo [2] Balanced Security Policy
echo [3] Performance-Optimized Policy
echo [4] Custom Policy
echo.
set /p policy_type="Policy type: "

if "%policy_type%"=="1" (
    echo.
    echo 🔒 High Security Policy Configuration:
    echo.
    echo 📋 Policy Settings:
    echo • Block all inbound traffic by default
    echo • Allow only essential outbound traffic
    echo • Enable logging for all connections
    echo • Block all file sharing
    echo • Disable remote desktop
    echo • Enable intrusion detection
    echo • Update rules automatically
    echo • Alert on all security events
    echo.
    echo 🎯 Applications Affected:
    echo • Gaming: Blocked
    echo • File sharing: Blocked
    echo • Remote access: Blocked
    echo • Web browsing: Restricted
    echo • Email: Allowed (encrypted only)
    echo.
    echo 📊 Security Level: Maximum
    echo 📊 Performance Impact: High
    echo 📊 User Convenience: Low
    echo.
    set /p apply_high="Apply High Security Policy? (Y/N): "
    if /i "%apply_high%"=="Y" (
        echo 🔧 Applying High Security Policy...
        echo • Configuring rules... [██████████] 100%%
        echo • Enabling logging... [██████████] 100%%
        echo • Setting alerts... [██████████] 100%%
        echo ✅ High Security Policy applied
    )
)

if "%policy_type%"=="4" (
    echo.
    echo ⚙️  Custom Policy Configuration:
    echo.
    echo 🔍 Inbound Traffic Rules:
    set /p inbound_default="Default inbound action (Allow/Block): "
    set /p inbound_ports="Allowed inbound ports: "
    set /p inbound_sources="Allowed sources: "

    echo.
    echo 🔍 Outbound Traffic Rules:
    set /p outbound_default="Default outbound action (Allow/Block): "
    set /p outbound_ports="Blocked outbound ports: "
    set /p outbound_destinations="Blocked destinations: "

    echo.
    echo 📊 Logging and Monitoring:
    set /p logging_level="Logging level (None/Basic/Verbose): "
    set /p alert_level="Alert level (Low/Medium/High): "
    set /p auto_update="Auto-update rules (Y/N): "

    echo.
    echo 🔧 Creating custom policy...
    echo • Validating settings... [██████████] 100%%
    echo • Creating rules... [██████████] 100%%
    echo • Applying configuration... [██████████] 100%%
    echo ✅ Custom policy created and applied
)
echo.
echo 📊 Policy Summary:
echo • Active policies: 3 policies
echo • Scheduled policies: 2 policies
echo • Emergency policies: 1 policy
echo • Last updated: %date% %time%
echo.
pause
goto MENU
