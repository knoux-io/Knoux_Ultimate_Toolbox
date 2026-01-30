@echo off 
title KNOX - 14_documentation Module 
color 0A 
cls 
echo. 
echo ╔══════════════════════════════════════════════════════════════╗ 
echo ║                         KNOX                                ║ 
echo ║                 UTILITARIAN DOMINANCE                        ║ 
echo ║                                                              ║ 
echo ╚══════════════════════════════════════════════════════════════╝ 
echo. 
echo وحدة 14_documentation - تحت الإنشاء 
echo. 
echo 🚧 القسم قيد التطوير - سيتم إضافة الأدوات قريباً 
echo. 
echo [0] العودة للقائمة الرئيسية 
echo. 
set /p choice="اختر (0 للعودة): " 
if "%choice%"=="0" call "..\..\00_Knox_New.bat" 
pause 
goto :EOF 
