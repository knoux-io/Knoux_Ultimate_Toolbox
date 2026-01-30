@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🔪 قاتل المنافذ - تحرير المنافذ المحجوزة%WHITE%
echo %RED%===================================================%WHITE%
echo.

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] عرض جميع المنافذ النشطة
echo   [2] البحث عن عملية على منفذ محدد
echo   [3] قتل عملية على منفذ محدد
echo   [4] قتل جميع عمليات Node.js (لتحرير المنافذ الشائعة)
echo   [5] تحليل تعارض المنافذ الشائعة (3000, 8080, 5000, 80)
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :LIST_PORTS
if "!CHOICE!"=="2" goto :FIND_PORT
if "!CHOICE!"=="3" goto :KILL_PORT
if "!CHOICE!"=="4" goto :KILL_NODE
if "!CHOICE!"=="5" goto :ANALYZE_CONFLICTS
goto :MENU

:LIST_PORTS
echo %CYAN%المنافذ النشطة حاليًا:%WHITE%
netstat -ano | findstr "LISTENING" | sort
pause
goto :MENU

:FIND_PORT
set /p "PORT=رقم المنفذ: "
echo %CYAN%العمليات على المنفذ !PORT!:%WHITE%
netstat -ano | findstr ":!PORT! " | findstr "LISTENING"
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":!PORT! " ^| findstr "LISTENING"') do (
    tasklist /fi "PID eq %%a" /fo table | findstr "%%a"
)
pause
goto :MENU

:KILL_PORT
set /p "PORT=رقم المنفذ للتحرير: "
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":!PORT! " ^| findstr "LISTENING"') do (
    tasklist /fi "PID eq %%a" /fo table | findstr "%%a"
    set /p "CONFIRM=قتل هذه العملية؟ (y/n): "
    if /i "!CONFIRM!"=="y" (
        taskkill /f /pid %%a && (
            echo %GREEN%✓ تم تحرير المنفذ !PORT!%WHITE%
        ) || (
            echo %RED%✗ فشل القتل - قد تحتاج صلاحيات مسؤول%WHITE%
        )
    )
)
goto :MENU

:KILL_NODE
echo %YELLOW%جارٍ قتل جميع عمليات Node.js...%WHITE%
taskkill /f /im node.exe >nul 2>&1 && (
    echo %GREEN%✓ تم القتل بنجاح%WHITE%
) || (
    echo %YELLOW%لا توجد عمليات Node.js نشطة%WHITE%
)
goto :MENU

:ANALYZE_CONFLICTS
echo %CYAN%تحليل المنافذ الشائعة:%WHITE%
for %%p in (80 443 3000 5000 8000 8080 8888) do (
    netstat -ano | findstr ":%%p " >nul && (
        echo المنفذ %%p: مشغول
        for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%%p " ^| findstr "LISTENING"') do tasklist /fi "PID eq %%a" /nh /fo csv | findstr /v "INFO"
    ) || (
        echo المنفذ %%p: حر
    )
)
pause
goto :MENU
