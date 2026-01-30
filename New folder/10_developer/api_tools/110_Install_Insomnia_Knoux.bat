@echo off
:: =================================================================
:: KNOUX INSOMNIA INSTALLER
:: تثبيت Insomnia REST Client مع مدير البيئات
:: =================================================================
title Knoux - Insomnia Installer

echo ═══════════════════════════════════════════════════════════
echo   KNOUX INSOMNIA + ENVIRONMENT MANAGER
echo   تثبيت Insomnia REST Client مع مدير البيئات
echo ═══════════════════════════════════════════════════════════
echo.

echo [→] جاري تثبيت Insomnia REST Client...
winget install Insomnia.Insomnia --silent --accept-package-agreements

if %errorlevel% neq 0 (
    echo [→] جاري التثبيت اليدوي...
    powershell -Command "Invoke-WebRequest -Uri 'https://updates.insomnia.rest/downloads/windows/latest?app=insomnia&source=website' -OutFile '$env:TEMP\insomnia.exe'"
    start /wait "" "$env:TEMP\insomnia.exe" /S
)

echo [✓] تم تثبيت Insomnia!

:: Create environment manager
echo [→] جاري إنشاء مدير البيئات...
set "INSOMNIA_DIR=%USERPROFILE%\AppData\Roaming\Insomnia"
if not exist "%INSOMNIA_DIR%" mkdir "%INSOMNIA_DIR%"

:: Create development environment
(
    echo {
    echo   "_id": "env_dev",
    echo   "_type": "environment",
    echo   "name": "Development",
    echo   "color": "#00ff00",
    echo   "data": [
    echo     {
    echo       "key": "base_url",
    echo       "value": "http://localhost:3000/api"
    echo     },
    echo     {
    echo       "key": "api_key",
    echo       "value": "dev_api_key_123"
    echo     },
    echo     {
    echo       "key": "timeout",
    echo       "value": "30000"
    echo     }
    echo   ]
    echo }
) > "%INSOMNIA_DIR%\development.json"

:: Create production environment
(
    echo {
    echo   "_id": "env_prod",
    echo   "_type": "environment",
    echo   "name": "Production",
    echo   "color": "#ff0000",
    echo   "data": [
    echo     {
    echo       "key": "base_url",
    echo       "value": "https://api.example.com"
    echo     },
    echo     {
    echo       "key": "api_key",
    echo       "value": "{{ _.prod_api_key }}"
    echo     },
    echo     {
    echo       "key": "timeout",
    echo       "value": "60000"
    echo     }
    echo   ]
    echo }
) > "%INSOMNIA_DIR%\production.json"

:: Create testing environment
(
    echo {
    echo   "_id": "env_test",
    echo   "_type": "environment",
    echo   "name": "Testing",
    echo   "color": "#ffff00",
    echo   "data": [
    echo     {
    echo       "key": "base_url",
    echo       "value": "http://localhost:8000/api"
    echo     },
    echo     {
    echo       "key": "api_key",
    echo       "value": "test_api_key_456"
    echo     },
    echo     {
    echo       "key": "timeout",
    echo       "value": "15000"
    echo     }
    echo   ]
    echo }
) > "%INSOMNIA_DIR%\testing.json"

echo [✓] تم إنشاء بيئات التطوير!

:: Create collection templates
echo [→] جاري إنشاء قوالب المجموعات...
set "COLLECTIONS_DIR=%USERPROFILE%\Knoux_Insomnia_Collections"
if not exist "%COLLECTIONS_DIR%" mkdir "%COLLECTIONS_DIR%"

:: Create REST API collection
(
    echo {
    echo   "_id": "col_rest_api",
    echo   "_type": "workspace",
    echo   "name": "REST API Collection",
    echo   "description": "Basic REST API endpoints collection",
    echo   "resources": [
    echo     {
    echo       "_id": "req_get_users",
    echo       "_type": "request",
    echo       "parentId": "wrk_root",
    echo       "name": "GET Users",
    echo       "url": "{{ base_url }}/users",
    echo       "method": "GET",
    echo       "headers": [
    echo         {
    echo           "name": "Authorization",
    echo           "value": "Bearer {{ api_key }}"
    echo         }
    echo       ]
    echo     },
    echo     {
    echo       "_id": "req_post_user",
    echo       "_type": "request",
    echo       "parentId": "wrk_root",
    echo       "name": "POST User",
    echo       "url": "{{ base_url }}/users",
    echo       "method": "POST",
    echo       "headers": [
    echo         {
    echo           "name": "Content-Type",
    echo           "value": "application/json"
    echo         },
    echo         {
    echo           "name": "Authorization",
    echo           "value": "Bearer {{ api_key }}"
    echo         }
    echo       ],
    echo       "body": {
    echo         "mimeType": "application/json",
    echo         "text": "{\n  \"name\": \"John Doe\",\n  \"email\": \"john@example.com\"\n}"
    echo       }
    echo     }
    echo   ]
    echo }
) > "%COLLECTIONS_DIR%\rest_api.json"

echo [✓] تم إنشاء قوالب المجموعات!

:: Create Insomnia manager
echo [→] جاري إنشاء مدير Insomnia...
(
    echo @echo off
    echo title Knoux Insomnia Manager
    echo echo ════════════════════════════════════════
    echo echo   KNOUX INSOMNIA MANAGER
    echo echo ════════════════════════════════════════
    echo echo.
    echo echo [1] فتح Insomnia
    echo echo [2] استيراد بيئة التطوير
    echo echo [3] استيراد بيئة الإنتاج
    echo echo [4] استيراد بيئة الاختبار
    echo echo [5] استيراد مجموعة REST API
    echo echo [6] إنشاء مجموعة جديدة
    echo echo [7] تصدير المجموعات
    echo echo [8] نسخ احتياطي للإعدادات
    echo echo [9] استعادة الإعدادات
    echo echo [0] خروج
    echo echo.
    echo set /p choice=اختر: 
    echo.
    echo if "%%choice%%"=="1" start "" "C:\Users\%%USERNAME%%\AppData\Local\Insomnia\Insomnia.exe"
    echo if "%%choice%%"=="2" goto :IMPORT_DEV
    echo if "%%choice%%"=="3" goto :IMPORT_PROD
    echo if "%%choice%%"=="4" goto :IMPORT_TEST
    echo if "%%choice%%"=="5" goto :IMPORT_REST
    echo if "%%choice%%"=="6" goto :CREATE_COLLECTION
    echo if "%%choice%%"=="7" goto :EXPORT_COLLECTIONS
    echo if "%%choice%%"=="8" goto :BACKUP_SETTINGS
    echo if "%%choice%%"=="9" goto :RESTORE_SETTINGS
    echo if "%%choice%%"=="0" exit /b
    echo pause
    echo goto MENU
    echo.
    echo :IMPORT_DEV
    echo echo [→] جاري استيراد بيئة التطوير...
    echo copy "%%USERPROFILE%%\AppData\Roaming\Insomnia\development.json" "%%USERPROFILE%%\Desktop\dev_environment.json"
    echo echo [✓] تم نسخ بيئة التطوير إلى سطح المكتب!
    echo echo [→] استيردها يدوياً في Insomnia
    echo pause
    echo goto MENU
    echo.
    echo :CREATE_COLLECTION
    echo set /p collection_name=اسم المجموعة: 
    echo echo [→] جاري إنشاء مجموعة: %%collection_name%%
    echo echo {
    echo   "_id": "col_%%collection_name%%",
    echo   "_type": "workspace",
    echo   "name": "%%collection_name%%",
    echo   "resources": []
    echo } ^> "%%USERPROFILE%%\Desktop\%%collection_name%%.json"
    echo echo [✓] تم إنشاء المجموعة!
    echo pause
    echo goto MENU
) > "%USERPROFILE%\knoux_insomnia_manager.bat"

echo [✓] تم إنشاء مدير Insomnia!
echo [→] المسار: %USERPROFILE%\knoux_insomnia_manager.bat

:: Create desktop shortcut
echo [→] جاري إنشاء اختصار سطح المكتب...
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Insomnia.lnk'); $Shortcut.TargetPath = 'C:\Users\%USERNAME%\AppData\Local\Insomnia\Insomnia.exe'; $Shortcut.Save()"

echo [✓] تم إنشاء اختصار سطح المكتب!
echo [✓] Insomnia جاهز للاستخدام!
echo [→] البيئات المتاحة: Development, Production, Testing
echo [→] القوالب المتاحة: REST API Collection
pause
