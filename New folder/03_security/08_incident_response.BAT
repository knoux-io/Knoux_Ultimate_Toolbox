@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
title Knox Ultimate Toolbox - Incident Response
color 0C
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /03/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           🚨 INCIDENT RESPONSE
echo               Category: 03 Security Tools
echo                 Color: Red #C62828
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] Active Incidents Dashboard
echo [2] Incident Reporting
echo [3] Incident Investigation
echo [4] Containment Procedures
echo [5] Eradication & Recovery
echo [6] Post-Incident Analysis
echo [7] Incident Response Playbook
echo [8] Threat Hunting
echo [9] Back to Security Menu
echo [10] Main Menu
echo.
set /p choice="Select option (1-10): "

if "%choice%"=="1" goto ACTIVE_INCIDENTS
if "%choice%"=="2" goto INCIDENT_REPORTING
if "%choice%"=="3" goto INCIDENT_INVESTIGATION
if "%choice%"=="4" goto CONTAINMENT_PROCEDURES
if "%choice%"=="5" goto ERADICATION_RECOVERY
if "%choice%"=="6" goto POST_INCIDENT_ANALYSIS
if "%choice%"=="7" goto INCIDENT_PLAYBOOK
if "%choice%"=="8" goto THREAT_HUNTING
if "%choice%"=="9" call "%SCRIPT_DIR%00_security_menu.BAT"
if "%choice%"=="10" call "%SCRIPT_DIR%..\KNOX_MAIN_MENU.BAT"
goto MENU

:ACTIVE_INCIDENTS
cls
echo 🚨 Active Incidents Dashboard
echo ═══════════════════════════════════════════════════════
echo Real-time incident monitoring and management
echo.
echo 📊 INCIDENT OVERVIEW:
echo • Total Active Incidents: 3
echo • Critical Incidents: 1
echo • High Incidents: 2
echo • Average Resolution Time: 4.2 hours
echo.
echo 🔴 CRITICAL INCIDENTS (1):
echo [INC-2024-001] Ransomware Attack - File Server
echo Status: Active (Containment Phase)
echo Progress: 60%% complete
echo Duration: 2 hours 15 minutes
echo.
echo 🟡 HIGH INCIDENTS (2):
echo [INC-2024-002] Data Exfiltration Attempt
echo [INC-2024-003] Unauthorized Access Attempt
echo.
echo 📊 INCIDENT METRICS:
echo • Response Time: 8 minutes (Target: 15 minutes)
echo • Containment Time: 45 minutes (Target: 1 hour)
echo • Resolution Rate: 94%% (Target: 95%%)
echo.
echo 🔧 INCIDENT MANAGEMENT:
echo [1] View incident details
echo [2] Update incident status
echo [3] Generate incident report
echo.
set /p incident_option="Choose: "
pause
goto MENU

:INCIDENT_REPORTING
cls
echo 📝 Incident Reporting
echo ═══════════════════════════════════════════════════════
echo Create and manage security incident reports
echo.
echo 📋 Report Types:
echo [1] New Incident Report
echo [2] Security Event Report
echo [3] Phishing Report
echo [4] Data Breach Report
echo.
set /p report_type="Select report type: "

echo.
echo 📝 INCIDENT REPORT FORM:
echo.
echo 🎯 Basic Information:
set /p incident_title="Incident Title: "
set /p incident_date="Date/Time of Incident: "
set /p reporter_name="Reporter Name: "

echo.
echo 📊 Incident Classification:
echo [1] Security Incident
echo [2] Data Breach
echo [3] System Compromise
echo [4] Unauthorized Access
echo [5] Malware/Ransomware
echo.
set /p incident_type="Incident Type: "
set /p severity_level="Severity Level (1-5): "

echo.
echo 📋 Incident Description:
set /p incident_description="Description: "

echo.
echo 🔍 Detection Information:
set /p detection_method="How detected?: "

echo.
echo ✅ Report submitted successfully!
echo • Report ID: INC-2024-%random%
echo • Priority: High
echo • Assigned To: Incident Response Team
echo.
pause
goto MENU

:INCIDENT_INVESTIGATION
cls
echo 🔍 Incident Investigation
echo ═══════════════════════════════════════════════════════
echo Conduct thorough security incident investigations
echo.
echo 📋 Active Investigations:
echo [1] INC-2024-001 - Ransomware Attack
echo [2] INC-2024-002 - Data Exfiltration Attempt
echo [3] New Investigation
echo.
set /p investigation_choice="Select investigation: "

if "%investigation_choice%"=="1" (
    echo 🔍 INVESTIGATION: RANSOMWARE ATTACK
    echo.
    echo 📊 Investigation Status: 60%% Complete
    echo Start Time: 2024-01-28 14:45:00
    echo.
    echo 🎯 INVESTIGATION TIMELINE:
    echo • 14:30 - Initial detection (EDR alert)
    echo • 14:35 - Incident declared
    echo • 14:50 - Initial assessment completed
    echo • 15:00 - System isolation initiated
    echo • 16:00 - Malware analysis initiated
    echo.
    echo 🔍 EVIDENCE COLLECTED:
    echo ✅ Memory dumps from affected systems
    echo ✅ Disk images of encrypted systems
    echo ✅ Network traffic captures
    echo ✅ Windows Event Logs
    echo.
    echo 🧠 PRELIMINARY FINDINGS:
    echo • Attack Vector: Phishing email
    echo • Malware Family: LockBit 3.0 variant
    echo • Affected Systems: 12 workstations, 1 server
    echo • Encrypted Files: 8,427 files
    echo.
    echo 🎯 NEXT INVESTIGATION STEPS:
    echo 1. Complete cloud service log analysis
    echo 2. Verify backup integrity
    echo 3. Assess data exfiltration risk
    echo 4. Determine recovery timeline
    echo.
)
pause
goto MENU

:CONTAINMENT_PROCEDURES
cls
echo 🛡️ Containment Procedures
echo ═══════════════════════════════════════════════════════
echo Implement incident containment and isolation strategies
echo.
echo 📋 Containment Strategies:
echo [1] Network Containment
echo [2] System Isolation
echo [3] Account Suspension
echo [4] Data Protection
echo.
set /p containment_type="Select containment strategy: "

if "%containment_type%"=="1" (
    echo 🌐 NETWORK CONTAINMENT PROCEDURES
    echo.
    echo 📊 Current Network Status:
    echo • Total Network Segments: 5
    echo • Isolated Segments: 2
    echo • Affected Systems: 12
    echo • Contained Systems: 8
    echo.
    echo 🔒 CONTAINMENT ACTIONS:
    echo ✅ Network Segmentation
    echo • Isolated affected VLAN: VLAN-30
    echo • Blocked lateral movement: SMB ports
    echo • Firewall rules updated: 12 new rules
    echo.
    echo 🔄 Communication Control
    echo • External internet: Restricted for affected systems
    echo • Internal network: Limited access
    echo • Email services: Suspended for affected users
    echo.
    echo ✅ Traffic Monitoring
    echo • Network captures: Active on all segments
    echo • Protocol analysis: Real-time monitoring
    echo • Anomaly detection: Enhanced sensitivity
    echo.
    echo 📊 CONTAINMENT EFFECTIVENESS:
    echo • Lateral Movement: Stopped ✅
    echo • Data Exfiltration: Blocked ✅
    echo • Command & Control: Disrupted ✅
    echo • Malware Propagation: Contained ✅
    echo.
)
pause
goto MENU

:ERADICATION_RECOVERY
cls
echo 🔄 Eradication & Recovery
echo ═══════════════════════════════════════════════════════
echo Remove threats and restore normal operations
echo.
echo 📋 Recovery Options:
echo [1] Malware Eradication
echo [2] System Restoration
echo [3] Data Recovery
echo [4] Security Hardening
echo.
set /p recovery_type="Select recovery option: "

if "%recovery_type%"=="1" (
    echo 🦠 MALWARE ERADICATION PROCEDURES
    echo.
    echo 📊 Eradication Status:
    echo • Systems to Clean: 12
    echo • Systems Cleaned: 8
    echo • Success Rate: 100%%
    echo.
    echo 🔧 ERADICATION METHODS:
    echo ✅ Antivirus Scanning
    echo • Full system scans: 12 systems
    echo • Custom definitions: Applied
    echo • Heuristic analysis: Enabled
    echo.
    echo 🔄 Manual Removal
    echo • Registry cleaning: 8 systems
    echo • File deletion: 15,247 files
    echo • Service removal: 24 services
    echo.
    echo ✅ System Repair
    echo • System file check: 12 systems
    echo • Windows repair: 4 systems
    echo • Driver reinstallation: 6 systems
    echo.
    echo 📊 ERADICATION METRICS:
    echo • Total Files Removed: 15,247
    echo • Registry Entries Cleaned: 342
    echo • Services Removed: 24
    echo • Time to Eradicate: 3.5 hours
    echo.
)
pause
goto MENU

:POST_INCIDENT_ANALYSIS
cls
echo 📊 Post-Incident Analysis
echo ═══════════════════════════════════════════════════════
echo Learn from incidents and improve security posture
echo.
echo 📋 Analysis Options:
echo [1] Incident Timeline Analysis
echo [2] Root Cause Analysis
echo [3] Lessons Learned
echo [4] Improvement Recommendations
echo.
set /p analysis_type="Select analysis type: "

if "%analysis_type%"=="1" (
    echo ⏰ INCIDENT TIMELINE ANALYSIS
    echo.
    echo 📅 DETAILED INCIDENT TIMELINE:
    echo • 13:47:15 - User opened malicious attachment
    echo • 14:30:45 - EDR alert generated
    echo • 14:32:15 - Incident declared
    echo • 14:45:00 - Containment initiated
    echo • 15:00:00 - Evidence collection began
    echo • 16:00:00 - Malware analysis started
    echo • 17:00:00 - System restoration began
    echo • 21:30:00 - Business operations normalized
    echo.
    echo 📊 TIMELINE METRICS:
    echo • Time to Detection: 43 minutes
    echo • Time to Response: 1 minute
    echo • Time to Contain: 15 minutes
    echo • Time to Recover: 4.5 hours
    echo • Total Incident Duration: 7.5 hours
    echo.
)
pause
goto MENU

:INCIDENT_PLAYBOOK
cls
echo 📖 Incident Response Playbook
echo ═══════════════════════════════════════════════════════
echo Standard incident response procedures and guidelines
echo.
echo 📋 Playbook Categories:
echo [1] Ransomware Response
echo [2] Data Breach Response
echo [3] Malware Response
echo [4] Phishing Response
echo [5] Unauthorized Access Response
echo [6] DDoS Response
echo [7] Insider Threat Response
echo.
set /p playbook_type="Select playbook: "

if "%playbook_type%"=="1" (
    echo 🦠 RANSOMWARE RESPONSE PLAYBOOK
    echo.
    echo 🎯 PHASE 1: DETECTION & ANALYSIS
    echo 1. Verify ransomware indicators
    echo 2. Assess scope and impact
    echo 3. Identify ransomware family
    echo 4. Determine encryption method
    echo 5. Assess data backup status
    echo.
    echo 🛡️ PHASE 2: CONTAINMENT
    echo 1. Isolate affected systems
    echo 2. Disable network shares
    echo 3. Block lateral movement
    echo 4. Preserve evidence
    echo 5. Document all actions
    echo.
    echo 🔄 PHASE 3: ERADICATION
    echo 1. Remove malware
    echo 2. Clean systems
    echo 3. Patch vulnerabilities
    echo 4. Update security controls
    echo 5. Verify removal
    echo.
    echo 💾 PHASE 4: RECOVERY
    echo 1. Restore from backups
    echo 2. Rebuild systems
    echo 3. Verify data integrity
    echo 4. Restore user access
    echo 5. Monitor for recurrence
    echo.
    echo 📊 PHASE 5: POST-INCIDENT
    echo 1. Conduct analysis
    echo 2. Document lessons learned
    echo 3. Update procedures
    echo 4. Provide training
    echo 5. Improve defenses
    echo.
)
pause
goto MENU

:THREAT_HUNTING
cls
echo 🕵️ Threat Hunting
echo ═══════════════════════════════════════════════════════
echo Proactive threat detection and hunting activities
echo.
echo 📋 Hunting Activities:
echo [1] Network Threat Hunting
echo [2] Endpoint Threat Hunting
echo [3] Cloud Threat Hunting
echo [4] Email Threat Hunting
echo [5] User Behavior Analysis
echo.
set /p hunting_type="Select hunting activity: "

if "%hunting_type%"=="1" (
    echo 🌐 NETWORK THREAT HUNTING
    echo.
    echo 📊 Current Hunting Status:
    echo • Active Hunts: 3
    echo • Completed Hunts: 12
    echo • Threats Found: 2
    echo • False Positives: 5
    echo.
    echo 🔍 HUNTING TECHNIQUES:
    echo 1. Anomaly detection
    echo 2. Pattern analysis
    echo 3. Behavioral analytics
    echo 4. Threat intelligence matching
    echo 5. Machine learning models
    echo.
    echo 🎯 RECENT FINDINGS:
    echo • Suspicious network traffic detected
    echo • Unusual data transfer patterns
    echo • Potential command & control activity
    echo • Abnormal protocol usage
    echo.
    echo 📊 HUNTING METRICS:
    echo • Network segments analyzed: 5
    echo • Data volume processed: 2.5 TB
    echo • Alerts generated: 8
    echo • True positives: 2
    echo • Investigation time: 4 hours
    echo.
)
pause
goto MENU
