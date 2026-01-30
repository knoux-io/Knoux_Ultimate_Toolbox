@echo off
:: KNOUX Language Configuration System
:: Supports Arabic and English languages
:: Works across all sections and tools

:: Set default language if not set
if "%LANGUAGE%"=="" (
    set LANGUAGE=EN
    set CURRENT_LANG=English
)

:: Language Switch Function
:switch_language
if "%LANGUAGE%"=="EN" (
    set LANGUAGE=AR
    set CURRENT_LANG=العربية
    set TEXT_DIRECTION=RTL
) else (
    set LANGUAGE=EN
    set CURRENT_LANG=English
    set TEXT_DIRECTION=LTR
)
goto :eof

:: Get text based on current language
:get_text
set "TEXT_KEY=%~1"
set "RETURN_TEXT="
if "%LANGUAGE%"=="AR" goto :arabic_text
goto :english_text

:arabic_text
:: Main Menu Texts
if "%TEXT_KEY%"=="MAIN_TITLE" set "RETURN_TEXT=مركز هيمنة الأدوات النفعية لـ KNOUX"
if "%TEXT_KEY%"=="MAIN_SUBTITLE" set "RETURN_TEXT=أدوات متميزة بدون تكلفة"
if "%TEXT_KEY%"=="SELECT_OPTION" set "RETURN_TEXT=اختر الخيار"
if "%TEXT_KEY%"=="BACK_TO_MAIN" set "RETURN_TEXT=العودة للقائمة الرئيسية"
if "%TEXT_KEY%"=="EXIT" set "RETURN_TEXT=خروج"

:: Storage Liberation
if "%TEXT_KEY%"=="STORAGE_LIBERATION" set "RETURN_TEXT=تحرير التخزين"
if "%TEXT_KEY%"="DUPLICATE_DESTROYER" set "RETURN_TEXT=مدمر الملفات المكررة"
if "%TEXT_KEY%"="LARGE_FILE_HUNTER" set "RETURN_TEXT=صائد الملفات الكبيرة"
if "%TEXT_KEY%"="FOLDER_ANALYZER" set "RETURN_TEXT=محلل المجلدات"
if "%TEXT_KEY%"="EMPTY_FOLDER_REMOVER" set "RETURN_TEXT=مزيل المجلدات الفارغة"
if "%TEXT_KEY%"="TEMP_FILE_CLEANER" set "RETURN_TEXT=منظف الملفات المؤقتة"
if "%TEXT_KEY%"="DUPLICATE_PHOTO_FINDER" set "RETURN_TEXT=باحث الصور المكررة"
if "%TEXT_KEY%"="VIDEO_DUPLICATE_DETECTOR" set "RETURN_TEXT=كاشف الفيديوهات المكررة"
if "%TEXT_KEY%"="CLOUD_STORAGE_ANALYZER" set "RETURN_TEXT=محلل التخزين السحابي"
if "%TEXT_KEY%"="ARCHIVE_OPTIMIZER" set "RETURN_TEXT=محسن الأرشيف"
if "%TEXT_KEY%"="STORAGE_FORECASTER" set "RETURN_TEXT=متنبئ التخزين"

:: Media Mastery
if "%TEXT_KEY%"=="MEDIA_MASTERY" set "RETURN_TEXT=إتقان الوسائط"
if "%TEXT_KEY%"="VIDEO_CONVERTER" set "RETURN_TEXT=محول الفيديو"
if "%TEXT_KEY%"="AUDIO_CONVERTER" set "RETURN_TEXT=محول الصوتيات"
if "%TEXT_KEY%"="VIDEO_EDITOR" set "RETURN_TEXT=محرر الفيديو"
if "%TEXT_KEY%"="AUDIO_EDITOR" set "RETURN_TEXT=محرر الصوتيات"
if "%TEXT_KEY%"="IMAGE_CONVERTER" set "RETURN_TEXT=محول الصور"
if "%TEXT_KEY%"="SCREEN_RECORDER" set "RETURN_TEXT=مسجل الشاشة"
if "%TEXT_KEY%"="MEDIA_PLAYER" set "RETURN_TEXT=مشغل الوسائط"
if "%TEXT_KEY%"="GIF_CREATOR" set "RETURN_TEXT=منشئ GIF"
if "%TEXT_KEY%"="MEDIA_METADATA" set "RETURN_TEXT=بيانات وصفية للوسائط"
if "%TEXT_KEY%"="MEDIA_ORGANIZER" set "RETURN_TEXT=منظم الوسائط"

:: File Intelligence
if "%TEXT_KEY%"=="FILE_INTELLIGENCE" set "RETURN_TEXT=ذكاء الملفات"
if "%TEXT_KEY%"="SMART_SEARCH" set "RETURN_TEXT=البحث الذكي"
if "%TEXT_KEY%"="FILE_ANALYZER" set "RETURN_TEXT=محلل الملفات"
if "%TEXT_KEY%"="BATCH_RENAMER" set "RETURN_TEXT=إعادة تسمية دفعية"
if "%TEXT_KEY%"="FILE_CONVERTER" set "RETURN_TEXT=محول الملفات"
if "%TEXT_KEY%"="FILE_COMPARE" set "RETURN_TEXT=مقارنة الملفات"
if "%TEXT_KEY%"="CHECKSUM_VERIFIER" set "RETURN_TEXT=مدقق التحقق"
if "%TEXT_KEY%"="FILE_SPLITTER" set "RETURN_TEXT=قسام الملفات"
if "%TEXT_KEY%"="ATTRIBUTE_EDITOR" set "RETURN_TEXT=محرر الخصائص"
if "%TEXT_KEY%"="ASSOCIATION_MANAGER" set "RETURN_TEXT=مدير الارتباطات"
if "%TEXT_KEY%"="FILE_HISTORY" set "RETURN_TEXT=تاريخ الملفات"

:: Image Excellence
if "%TEXT_KEY%"=="IMAGE_EXCELLENCE" set "RETURN_TEXT=تميز الصور"
if "%TEXT_KEY%"="IMAGE_EDITOR" set "RETURN_TEXT=محرر الصور"
if "%TEXT_KEY%"="BATCH_PROCESSOR" set "RETURN_TEXT=معالج دفعي"
if "%TEXT_KEY%"="IMAGE_CONVERTER" set "RETURN_TEXT=محول الصور"
if "%TEXT_KEY%"="PHOTO_ENHANCER" set "RETURN_TEXT=محسن الصور"
if "%TEXT_KEY%"="WATERMARK_TOOL" set "RETURN_TEXT=أداة العلامة المائية"
if "%TEXT_KEY%"="IMAGE_RESIZER" set "RETURN_TEXT=مغير حجم الصور"
if "%TEXT_KEY%"="FORMAT_CONVERTER" set "RETURN_TEXT=محول التنسيق"
if "%TEXT_KEY%"="COLOR_CORRECTOR" set "RETURN_TEXT=مصحح الألوان"
if "%TEXT_KEY%"="IMAGE_COMPRESSOR" set "RETURN_TEXT=ضاغط الصور"
if "%TEXT_KEY%"="GALLERY_CREATOR" set "RETURN_TEXT=منشئ المعرض"

:: Document Power
if "%TEXT_KEY%"=="DOCUMENT_POWER" set "RETURN_TEXT=قوة المستندات"
if "%TEXT_KEY%"="PDF_EDITOR" set "RETURN_TEXT=محرر PDF"
if "%TEXT_KEY%"="WORD_PROCESSOR" set "RETURN_TEXT=معالج النصوص"
if "%TEXT_KEY%"="SPREADSHEET_EDITOR" set "RETURN_TEXT=محرر الجداول"
if "%TEXT_KEY%"="PRESENTATION_TOOL" set "RETURN_TEXT=أداة العروض التقديمية"
if "%TEXT_KEY%"="DOCUMENT_MERGER" set "RETURN_TEXT=دمج المستندات"
if "%TEXT_KEY%"="PDF_CONVERTER" set "RETURN_TEXT=محول PDF"
if "%TEXT_KEY%"="DOCUMENT_SPLITTER" set "RETURN_TEXT=قسام المستندات"
if "%TEXT_KEY%"="OCR_TOOL" set "RETURN_TEXT=أداة OCR"
if "%TEXT_KEY%"="DOCUMENT_ENCRYPTOR" set "RETURN_TEXT=مشفر المستندات"
if "%TEXT_KEY%"="FORM_CREATOR" set "RETURN_TEXT=منشئ النماذج"

:: System Optimization
if "%TEXT_KEY%"=="SYSTEM_OPTIMIZATION" set "RETURN_TEXT=تحسين النظام"
if "%TEXT_KEY%"="REGISTRY_CLEANER" set "RETURN_TEXT=منظف السجل"
if "%TEXT_KEY%"="DISK_CLEANER" set "RETURN_TEXT=منظف القرص"
if "%TEXT_KEY%"="MEMORY_OPTIMIZER" set "RETURN_TEXT=محسن الذاكرة"
if "%TEXT_KEY%"="STARTUP_MANAGER" set "RETURN_TEXT=مدير بدء التشغيل"
if "%TEXT_KEY%"="SERVICE_MANAGER" set "RETURN_TEXT=مدير الخدمات"
if "%TEXT_KEY%"="DRIVER_UPDATER" set "RETURN_TEXT=محدث التعريفات"
if "%TEXT_KEY%"="SYSTEM_TWEAKER" set "RETURN_TEXT=مضبط النظام"
if "%TEXT_KEY%"="PERFORMANCE_BOOSTER" set "RETURN_TEXT=معزز الأداء"
if "%TEXT_KEY%"="TEMP_CLEANER" set "RETURN_TEXT=منظف المؤقت"

:: Data Recovery
if "%TEXT_KEY%"=="DATA_RECOVERY" set "RETURN_TEXT=استعادة البيانات"
if "%TEXT_KEY%"="FILE_RECOVERY" set "RETURN_TEXT=استعادة الملفات"
if "%TEXT_KEY%"="PHOTO_RECOVERY" set "RETURN_TEXT=استعادة الصور"
if "%TEXT_KEY%"="VIDEO_RECOVERY" set "RETURN_TEXT=استعادة الفيديو"
if "%TEXT_KEY%"="DOCUMENT_RECOVERY" set "RETURN_TEXT=استعادة المستندات"
if "%TEXT_KEY%"="PARTITION_RECOVERY" set "RETURN_TEXT=استعادة الأقسام"
if "%TEXT_KEY%"="DEEP_SCAN" set "RETURN_TEXT=مسح عميق"
if "%TEXT_KEY%"="QUICK_RECOVERY" set "RETURN_TEXT=استعادة سريعة"
if "%TEXT_KEY%"="RAW_RECOVERY" set "RETURN_TEXT=استعادة RAW"
if "%TEXT_KEY%"="BOOT_RECOVERY" set "RETURN_TEXT=استعادة الإقلاع"

:: Privacy Cleaner
if "%TEXT_KEY%"=="PRIVACY_CLEANER" set "RETURN_TEXT=منظف الخصوصية"
if "%TEXT_KEY%"="TRACKS_CLEANER" set "RETURN_TEXT=منظف الآثار"
if "%TEXT_KEY%"="HISTORY_CLEANER" set "RETURN_TEXT=منظف التاريخ"
if "%TEXT_KEY%"="CACHE_CLEANER" set "RETURN_TEXT=منظف المخبأ"
if "%TEXT_KEY%"="COOKIE_CLEANER" set "RETURN_TEXT=منظف الكوكيز"
if "%TEXT_KEY%"="TEMP_CLEANER" set "RETURN_TEXT=منظف المؤقت"
if "%TEXT_KEY%"="REGISTRY_CLEANER" set "RETURN_TEXT=منظف السجل"
if "%TEXT_KEY%"="BROWSER_CLEANER" set "RETURN_TEXT=منظف المتصفح"
if "%TEXT_KEY%"="SYSTEM_CLEANER" set "RETURN_TEXT=منظف النظام"

:: Network Utilities
if "%TEXT_KEY%"=="NETWORK_UTILITIES" set "RETURN_TEXT=أدوات الشبكة"
if "%TEXT_KEY%"="NETWORK_SCANNER" set "RETURN_TEXT=ماسح الشبكة"
if "%TEXT_KEY%"="PORT_SCANNER" set "RETURN_TEXT=ماسح المنافذ"
if "%TEXT_KEY%"="SPEED_TEST" set "RETURN_TEXT=اختبار السرعة"
if "%TEXT_KEY%"="NETWORK_MONITOR" set "RETURN_TEXT=مراقب الشبكة"
if "%TEXT_KEY%"="WIFI_ANALYZER" set "RETURN_TEXT=محلل WiFi"
if "%TEXT_KEY%"="IP_SCANNER" set "RETURN_TEXT=ماسح IP"
if "%TEXT_KEY%"="BANDWIDTH_MONITOR" set "RETURN_TEXT=مراقب النطاق الترددي"
if "%TEXT_KEY%"="NETWORK_DIAGNOSTIC" set "RETURN_TEXT=تشخيص الشبكة"
if "%TEXT_KEY%"="ROUTER_MANAGER" set "RETURN_TEXT=مدير الراوتر"

:: Creative Tools
if "%TEXT_KEY%"=="CREATIVE_TOOLS" set "RETURN_TEXT=أدوات إبداعية"
if "%TEXT_KEY%"="LOGO_CREATOR" set "RETURN_TEXT=منشئ الشعارات"
if "%TEXT_KEY%"="BANNER_MAKER" set "RETURN_TEXT=صانع البنرات"
if "%TEXT_KEY%"="ICON_EDITOR" set "RETURN_TEXT=محرر الأيقونات"
if "%TEXT_KEY%"="FONT_CREATOR" set "RETURN_TEXT=منشئ الخطوط"
if "%TEXT_KEY%"="COLOR_PALETTE" set "RETURN_TEXT=لوحة الألوان"
if "%TEXT_KEY%"="TEMPLATE_DESIGNER" set "RETURN_TEXT=مصمم القوالب"
if "%TEXT_KEY%"="SCREENSHOT_TOOL" set "RETURN_TEXT=أداة لقطات الشاشة"
if "%TEXT_KEY%"="ANIMATION_CREATOR" set "RETURN_TEXT=منشئ الرسوم المتحركة"
if "%TEXT_KEY%"="MUSIC_CREATOR" set "RETURN_TEXT=منشئ الموسيقى"

:: Common Messages
if "%TEXT_KEY%"=="ADMIN_REQUIRED" set "RETURN_TEXT=يتطلب صلاحيات المسؤول"
if "%TEXT_KEY%"=="PRESS_ANY_KEY" set "RETURN_TEXT=اضغط أي مفتاح للمتابعة"
if "%TEXT_KEY%"="ERROR" set "RETURN_TEXT=خطأ"
if "%TEXT_KEY%"="SUCCESS" set "RETURN_TEXT=نجح"
if "%TEXT_KEY%"="PROCESSING" set "RETURN_TEXT=جاري المعالجة"
if "%TEXT_KEY%"="COMPLETE" set "RETURN_TEXT=مكتمل"
if "%TEXT_KEY%"="CANCELLED" set "RETURN_TEXT=ملغي"
if "%TEXT_KEY%"="SAVED" set "RETURN_TEXT=تم الحفظ"
if "%TEXT_KEY%"="DELETED" set "RETURN_TEXT=تم الحذف"
if "%TEXT_KEY%"="UPDATED" set "RETURN_TEXT=تم التحديث"
goto :end_get_text

:english_text
:: Main Menu Texts
if "%TEXT_KEY%"=="MAIN_TITLE" set "RETURN_TEXT=KNOUX Utilitarian Dominance Center"
if "%TEXT_KEY%"=="MAIN_SUBTITLE" set "RETURN_TEXT=Premium Tools, Zero Cost"
if "%TEXT_KEY%"=="SELECT_OPTION" set "RETURN_TEXT=Select option"
if "%TEXT_KEY%"=="BACK_TO_MAIN" set "RETURN_TEXT=Back to Main Menu"
if "%TEXT_KEY%"=="EXIT" set "RETURN_TEXT=Exit"

:: Storage Liberation
if "%TEXT_KEY%"=="STORAGE_LIBERATION" set "RETURN_TEXT=Storage Liberation"
if "%TEXT_KEY%"="DUPLICATE_DESTROYER" set "RETURN_TEXT=Duplicate File Destroyer"
if "%TEXT_KEY%"="LARGE_FILE_HUNTER" set "RETURN_TEXT=Large File Hunter"
if "%TEXT_KEY%"="FOLDER_ANALYZER" set "RETURN_TEXT=Folder Analyzer"
if "%TEXT_KEY%"="EMPTY_FOLDER_REMOVER" set "RETURN_TEXT=Empty Folder Remover"
if "%TEXT_KEY%"="TEMP_FILE_CLEANER" set "RETURN_TEXT=Temp File Cleanser"
if "%TEXT_KEY%"="DUPLICATE_PHOTO_FINDER" set "RETURN_TEXT=Duplicate Photo Finder"
if "%TEXT_KEY%"="VIDEO_DUPLICATE_DETECTOR" set "RETURN_TEXT=Video Duplicate Detector"
if "%TEXT_KEY%"="CLOUD_STORAGE_ANALYZER" set "RETURN_TEXT=Cloud Storage Analyzer"
if "%TEXT_KEY%"="ARCHIVE_OPTIMIZER" set "RETURN_TEXT=Archive Optimizer"
if "%TEXT_KEY%"="STORAGE_FORECASTER" set "RETURN_TEXT=Storage Forecaster"

:: Media Mastery
if "%TEXT_KEY%"=="MEDIA_MASTERY" set "RETURN_TEXT=Media Mastery"
if "%TEXT_KEY%"="VIDEO_CONVERTER" set "RETURN_TEXT=Video Converter"
if "%TEXT_KEY%"="AUDIO_CONVERTER" set "RETURN_TEXT=Audio Converter"
if "%TEXT_KEY%"="VIDEO_EDITOR" set "RETURN_TEXT=Video Editor"
if "%TEXT_KEY%"="AUDIO_EDITOR" set "RETURN_TEXT=Audio Editor"
if "%TEXT_KEY%"="IMAGE_CONVERTER" set "RETURN_TEXT=Image Converter"
if "%TEXT_KEY%"="SCREEN_RECORDER" set "RETURN_TEXT=Screen Recorder"
if "%TEXT_KEY%"="MEDIA_PLAYER" set "RETURN_TEXT=Media Player"
if "%TEXT_KEY%"="GIF_CREATOR" set "RETURN_TEXT=GIF Creator"
if "%TEXT_KEY%"="MEDIA_METADATA" set "RETURN_TEXT=Media Metadata Editor"
if "%TEXT_KEY%"="MEDIA_ORGANIZER" set "RETURN_TEXT=Media Organizer"

:: File Intelligence
if "%TEXT_KEY%"=="FILE_INTELLIGENCE" set "RETURN_TEXT=File Intelligence"
if "%TEXT_KEY%"="SMART_SEARCH" set "RETURN_TEXT=Smart File Search Engine"
if "%TEXT_KEY%"="FILE_ANALYZER" set "RETURN_TEXT=File Content Analyzer"
if "%TEXT_KEY%"="BATCH_RENAMER" set "RETURN_TEXT=Batch File Renamer"
if "%TEXT_KEY%"="FILE_CONVERTER" set "RETURN_TEXT=File Type Converter Hub"
if "%TEXT_KEY%"="FILE_COMPARE" set "RETURN_TEXT=File Comparison Tool"
if "%TEXT_KEY%"="CHECKSUM_VERIFIER" set "RETURN_TEXT=File Integrity Verifier"
if "%TEXT_KEY%"="FILE_SPLITTER" set "RETURN_TEXT=File Splitter & Merger"
if "%TEXT_KEY%"="ATTRIBUTE_EDITOR" set "RETURN_TEXT=File Attribute Editor"
if "%TEXT_KEY%"="ASSOCIATION_MANAGER" set "RETURN_TEXT=File Association Manager"
if "%TEXT_KEY%"="FILE_HISTORY" set "RETURN_TEXT=File History Tracker"

:: Image Excellence
if "%TEXT_KEY%"=="IMAGE_EXCELLENCE" set "RETURN_TEXT=Image Excellence"
if "%TEXT_KEY%"="IMAGE_EDITOR" set "RETURN_TEXT=Professional Image Editor"
if "%TEXT_KEY%"="BATCH_PROCESSOR" set "RETURN_TEXT=Batch Image Processor"
if "%TEXT_KEY%"="IMAGE_CONVERTER" set "RETURN_TEXT=Advanced Image Converter"
if "%TEXT_KEY%"="PHOTO_ENHANCER" set "RETURN_TEXT=Photo Enhancement Tool"
if "%TEXT_KEY%"="WATERMARK_TOOL" set "RETURN_TEXT=Watermark Creator"
if "%TEXT_KEY%"="IMAGE_RESIZER" set "RETURN_TEXT=Smart Image Resizer"
if "%TEXT_KEY%"="FORMAT_CONVERTER" set "RETURN_TEXT=Format Converter"
if "%TEXT_KEY%"="COLOR_CORRECTOR" set "RETURN_TEXT=Color Correction Tool"
if "%TEXT_KEY%"="IMAGE_COMPRESSOR" set "RETURN_TEXT=Image Compressor"
if "%TEXT_KEY%"="GALLERY_CREATOR" set "RETURN_TEXT=Gallery Creator"

:: Document Power
if "%TEXT_KEY%"=="DOCUMENT_POWER" set "RETURN_TEXT=Document Power"
if "%TEXT_KEY%"="PDF_EDITOR" set "RETURN_TEXT=Professional PDF Editor"
if "%TEXT_KEY%"="WORD_PROCESSOR" set "RETURN_TEXT=Advanced Word Processor"
if "%TEXT_KEY%"="SPREADSHEET_EDITOR" set "RETURN_TEXT=Spreadsheet Editor"
if "%TEXT_KEY%"="PRESENTATION_TOOL" set "RETURN_TEXT=Presentation Creator"
if "%TEXT_KEY%"="DOCUMENT_MERGER" set "RETURN_TEXT=Document Merger"
if "%TEXT_KEY%"="PDF_CONVERTER" set "RETURN_TEXT=PDF Converter Suite"
if "%TEXT_KEY%"="DOCUMENT_SPLITTER" set "RETURN_TEXT=Document Splitter"
if "%TEXT_KEY%"="OCR_TOOL" set "RETURN_TEXT=OCR Text Recognition"
if "%TEXT_KEY%"="DOCUMENT_ENCRYPTOR" set "RETURN_TEXT=Document Encryptor"
if "%TEXT_KEY%"="FORM_CREATOR" set "RETURN_TEXT=Form Creator"

:: System Optimization
if "%TEXT_KEY%"=="SYSTEM_OPTIMIZATION" set "RETURN_TEXT=System Optimization"
if "%TEXT_KEY%"="REGISTRY_CLEANER" set "RETURN_TEXT=Registry Cleaner"
if "%TEXT_KEY%"="DISK_CLEANER" set "RETURN_TEXT=Disk Cleaner"
if "%TEXT_KEY%"="MEMORY_OPTIMIZER" set "RETURN_TEXT=Memory Optimizer"
if "%TEXT_KEY%"="STARTUP_MANAGER" set "RETURN_TEXT=Startup Manager"
if "%TEXT_KEY%"="SERVICE_MANAGER" set "RETURN_TEXT=Service Manager"
if "%TEXT_KEY%"="DRIVER_UPDATER" set "RETURN_TEXT=Driver Updater"
if "%TEXT_KEY%"="SYSTEM_TWEAKER" set "RETURN_TEXT=System Tweaker"
if "%TEXT_KEY%"="PERFORMANCE_BOOSTER" set "RETURN_TEXT=Performance Booster"
if "%TEXT_KEY%"="TEMP_CLEANER" set "RETURN_TEXT=Temp Cleaner"

:: Data Recovery
if "%TEXT_KEY%"=="DATA_RECOVERY" set "RETURN_TEXT=Data Recovery"
if "%TEXT_KEY%"="FILE_RECOVERY" set "RETURN_TEXT=File Recovery Tool"
if "%TEXT_KEY%"="PHOTO_RECOVERY" set "RETURN_TEXT=Photo Recovery"
if "%TEXT_KEY%"="VIDEO_RECOVERY" set "RETURN_TEXT=Video Recovery"
if "%TEXT_KEY%"="DOCUMENT_RECOVERY" set "RETURN_TEXT=Document Recovery"
if "%TEXT_KEY%"="PARTITION_RECOVERY" set "RETURN_TEXT=Partition Recovery"
if "%TEXT_KEY%"="DEEP_SCAN" set "RETURN_TEXT=Deep Scan Recovery"
if "%TEXT_KEY%"="QUICK_RECOVERY" set "RETURN_TEXT=Quick Recovery"
if "%TEXT_KEY%"="RAW_RECOVERY" set "RETURN_TEXT=RAW Recovery"
if "%TEXT_KEY%"="BOOT_RECOVERY" set "RETURN_TEXT=Boot Recovery"

:: Privacy Cleaner
if "%TEXT_KEY%"=="PRIVACY_CLEANER" set "RETURN_TEXT=Privacy Cleaner"
if "%TEXT_KEY%"="TRACKS_CLEANER" set "RETURN_TEXT=Tracks Cleaner"
if "%TEXT_KEY%"="HISTORY_CLEANER" set "RETURN_TEXT=History Cleaner"
if "%TEXT_KEY%"="CACHE_CLEANER" set "RETURN_TEXT=Cache Cleaner"
if "%TEXT_KEY%"="COOKIE_CLEANER" set "RETURN_TEXT=Cookie Cleaner"
if "%TEXT_KEY%"="TEMP_CLEANER" set "RETURN_TEXT=Temp Cleaner"
if "%TEXT_KEY%"="REGISTRY_CLEANER" set "RETURN_TEXT=Registry Cleaner"
if "%TEXT_KEY%"="BROWSER_CLEANER" set "RETURN_TEXT=Browser Cleaner"
if "%TEXT_KEY%"="SYSTEM_CLEANER" set "RETURN_TEXT=System Cleaner"

:: Network Utilities
if "%TEXT_KEY%"=="NETWORK_UTILITIES" set "RETURN_TEXT=Network Utilities"
if "%TEXT_KEY%"="NETWORK_SCANNER" set "RETURN_TEXT=Network Scanner"
if "%TEXT_KEY%"="PORT_SCANNER" set "RETURN_TEXT=Port Scanner"
if "%TEXT_KEY%"="SPEED_TEST" set "RETURN_TEXT=Speed Test Tool"
if "%TEXT_KEY%"="NETWORK_MONITOR" set "RETURN_TEXT=Network Monitor"
if "%TEXT_KEY%"="WIFI_ANALYZER" set "RETURN_TEXT=WiFi Analyzer"
if "%TEXT_KEY%"="IP_SCANNER" set "RETURN_TEXT=IP Scanner"
if "%TEXT_KEY%"="BANDWIDTH_MONITOR" set "RETURN_TEXT=Bandwidth Monitor"
if "%TEXT_KEY%"="NETWORK_DIAGNOSTIC" set "RETURN_TEXT=Network Diagnostic"
if "%TEXT_KEY%"="ROUTER_MANAGER" set "RETURN_TEXT=Router Manager"

:: Creative Tools
if "%TEXT_KEY%"=="CREATIVE_TOOLS" set "RETURN_TEXT=Creative Tools"
if "%TEXT_KEY%"="LOGO_CREATOR" set "RETURN_TEXT=Logo Creator"
if "%TEXT_KEY%"="BANNER_MAKER" set "RETURN_TEXT=Banner Maker"
if "%TEXT_KEY%"="ICON_EDITOR" set "RETURN_TEXT=Icon Editor"
if "%TEXT_KEY%"="FONT_CREATOR" set "RETURN_TEXT=Font Creator"
if "%TEXT_KEY%"="COLOR_PALETTE" set "RETURN_TEXT=Color Palette Tool"
if "%TEXT_KEY%"="TEMPLATE_DESIGNER" set "RETURN_TEXT=Template Designer"
if "%TEXT_KEY%"="SCREENSHOT_TOOL" set "RETURN_TEXT=Screenshot Tool"
if "%TEXT_KEY%"="ANIMATION_CREATOR" set "RETURN_TEXT=Animation Creator"
if "%TEXT_KEY%"="MUSIC_CREATOR" set "RETURN_TEXT=Music Creator"

:: Common Messages
if "%TEXT_KEY%"=="ADMIN_REQUIRED" set "RETURN_TEXT=Administrator privileges required"
if "%TEXT_KEY%"=="PRESS_ANY_KEY" set "RETURN_TEXT=Press any key to continue"
if "%TEXT_KEY%"=="ERROR" set "RETURN_TEXT=Error"
if "%TEXT_KEY%"=="SUCCESS" set "RETURN_TEXT=Success"
if "%TEXT_KEY%"=="PROCESSING" set "RETURN_TEXT=Processing"
if "%TEXT_KEY%"=="COMPLETE" set "RETURN_TEXT=Complete"
if "%TEXT_KEY%"=="CANCELLED" set "RETURN_TEXT=Cancelled"
if "%TEXT_KEY%"=="SAVED" set "RETURN_TEXT=Saved"
if "%TEXT_KEY%"=="DELETED" set "RETURN_TEXT=Deleted"
if "%TEXT_KEY%"=="UPDATED" set "RETURN_TEXT=Updated"
goto :end_get_text

:end_get_text
goto :eof
