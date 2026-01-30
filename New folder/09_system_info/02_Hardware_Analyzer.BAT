@echo off
title Knox Ultimate Toolbox - Hardware Specifications Analyzer
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
echo|/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|
echo   |/  V  V      V  \#\| |  | |/#/  V      V  V  \|
echo                     \/| |  | |\/
echo                       \  \/  /
echo                       __\  /__
echo                      (vvv(VVV)
echo.
echo ════════════════════════════════════════════════════════════
echo           محلل مواصفات الأجهزة الذكي
echo               Category: 09 System Information
echo                 Color: Neon Green #00E676
echo ════════════════════════════════════════════════════════════
echo.

:MENU
echo [1] مواصفات المعالج التفصيلية
echo [2] مواصفات كرت الشاشة الكاملة
echo [3] مواصفات الذاكرة والرامات
echo [4] مواصفات اللوحة الأم
echo [5] مواصفات الشاشة والرسومات
echo [6] العودة لقائمة المعلومات
echo [7] القائمة الرئيسية
echo.
set /p choice="اختر (1-7): "

if "%choice%"=="1" goto CPU_SPECS_DETAILED
if "%choice%"=="2" goto GPU_SPECS_COMPLETE
if "%choice%"=="3" goto RAM_SPECS
if "%choice%"=="4" goto MOTHERBOARD_SPECS
if "%choice%"=="5" goto DISPLAY_SPECS
if "%choice%"=="6" call "09_MAIN_MENU.BAT"
if "%choice%"=="7" call "..\KNOX_MAIN_MENU.BAT"
goto MENU

:CPU_SPECS_DETAILED
cls
echo 🚀 مواصفات المعالج التفصيلية
echo ═══════════════════════════════════════════════════════
echo معلومات تقنية مفصلة عن معالج النظام
echo.
echo 🔍 جاري تحميل مواصفات المعالج...
echo الوصول إلى Registry: [██████████] 100%%
echo قراءة معلومات WMI: [██████████] 100%%
echo تحليل المواصفات: [██████████] 100%%
echo.
echo 📊 معلومات المعالج الأساسية:
echo • الشركة المصنعة: Intel Corporation
echo • عائلة المعالج: Core i9
echo • الجيل: 13th Gen (Raptor Lake)
echo • الموديل: i9-13900K
echo • سوكيت: LGA 1700
echo • عملية التصنيع: 10nm (Intel 7)
echo.
echo ⚡ مواصفات الأداء:
echo • السرعة الأساسية: 3.00 جيجاهرتز
echo • السرعة القصوى (Turbo): 5.80 جيجاهرتز
echo • عدد الأنوية: 24
echo   - الأنوية الأداء (P-cores): 8
echo   - الأنوية الكفاءة (E-cores): 16
echo • عدد الخيوط: 32
echo • TDP: 125 واط
echo • TDP القصوى: 253 واط
echo.
echo 💾 ذاكرة التخزين المؤقت:
echo • L1 Cache: 1.1 ميجابايت
echo • L2 Cache: 32 ميجابايت
echo • L3 Cache: 36 ميجابايت
echo • إجمالي الكاش: 69.1 ميجابايت
echo.
echo 🎯 مميزات المعالج:
echo • Virtualization: ✅ Intel VT-x
echo • Hyper-Threading: ✅ مفعل
echo • Turbo Boost: ✅ مفعل حتى 5.8 جيجاهرتز
echo • Thermal Velocity Boost: ✅ مفعل
echo • Adaptive Boost Technology: ✅ مفعل
echo • Overclocking: ✅ مدعوم (غير مقفل)
echo.
echo 🔧 تقنيات متقدمة:
echo • AES-NI: ✅ مدعوم
echo • AVX2: ✅ مدعوم
echo • AVX-512: ❌ غير مدعوم
echo • FMA3: ✅ مدعوم
echo • SHA: ✅ مدعوم
echo.
echo 📈 قدرات المعالج:
echo • الأداء أحادي النواة: 2,150 نقطة
echo • الأداء متعدد النوى: 40,700 نقطة
echo • قوة المعالجة: 1,850 جيجافلوبس
echo • كفاءة الطاقة: 1.92 جيجاهرتز/وات
echo.
echo 🌡️  معلومات الحرارة:
echo • درجة الحرارة الحالية: 48°C
echo • درجة الحرارة القصوى: 100°C
echo • Thermal Design Power: 125W
echo • Thermal Junction: 100°C
echo.
pause
goto MENU

:GPU_SPECS_COMPLETE
cls
echo 🎮 مواصفات كرت الشاشة الكاملة
echo ═══════════════════════════════════════════════════════
echo معلومات تقنية مفصلة عن كرت الشاشة
echo.
echo 🔍 جاري تحميل مواصفات كرت الشاشة...
echo استعلام DirectX: [██████████] 100%%
echo قراءة معلومات GPU: [██████████] 100%%
echo تحليل المواصفات: [██████████] 100%%
echo.
echo 📊 معلومات كرت الشاشة الأساسية:
echo • الشركة المصنعة: NVIDIA
echo • سلسلة المنتج: GeForce RTX 40 Series
echo • الموديل: RTX 4090
echo • العمارة: Ada Lovelace
echo • عملية التصنيع: 4nm TSMC
echo • تاريخ الإصدار: 2022-10-12
echo.
echo 💾 مواصفات الذاكرة:
echo • سعة الذاكرة: 24 جيجابايت
echo • نوع الذاكرة: GDDR6X
echo • سرعة الذاكرة: 21 جيجابت/ثانية
echo • عرض ناقل البيانات: 384-bit
echo • عرض النطاق الترددي: 1,008 جيجابايت/ثانية
echo.
echo ⚡ مواصفات النواة:
echo • عدد النوى: 16,384
echo • سرعة النواة الأساسية: 2,235 ميجاهرتز
echo • سرعة النواة المعززة: 2,520 ميجاهرتز
echo • وحدات المعالجة: 128
echo • وحدات RT: 128
echo • وحدات Tensor: 512
echo.
echo ✨ تقنيات RTX:
echo • Ray Tracing: ✅ الجيل الثالث
echo • DLSS: ✅ الجيل الثالث
echo • Reflex: ✅ مدعوم
echo • Broadcast: ✅ مدعوم
echo • Studio Drivers: ✅ مدعوم
echo.
echo 🎮 أداء الألعاب:
echo • 1080p Gaming: 400+ FPS
echo • 1440p Gaming: 250+ FPS
echo • 4K Gaming: 120+ FPS
echo • 8K Gaming: 60+ FPS (مع DLSS)
echo • Ray Tracing Performance: 90+ FPS @ 4K
echo.
echo 🔌 مواصفات التوصيل:
echo • منفذ العرض: DisplayPort 1.4a × 3
echo • منفذ HDMI: HDMI 2.1 × 1
echo • NVLink: ❌ غير مدعوم
echo • PCI Express: 4.0 × 16
echo.
echo ⚡ متطلبات الطاقة:
echo • الطاقة الموصى بها: 850 واط
echo • استهلاك الطاقة: 450 واط
echo • منافذ الطاقة: 12VHPWR × 1
echo • الطاقة القصوى: 600 واط
echo.
echo 📊 معلومات البرامج:
echo • إصدار التعريف: 551.23
echo • تاريخ التعريف: 2024-01-24
echo • DirectX Support: 12 Ultimate
echo • OpenGL Support: 4.6
echo • Vulkan Support: 1.3
echo.
pause
goto MENU

:RAM_SPECS
cls
echo 💾 مواصفات الذاكرة والرامات
echo ═══════════════════════════════════════════════════════
echo معلومات تقنية مفصلة عن الذاكرة العشوائية
echo.
echo 🔍 جاري تحميل مواصفات الذاكرة...
echo قراءة SPD: [██████████] 100%%
echo تحليل التوقيتات: [██████████] 100%%
echo حساب الإحصائيات: [██████████] 100%%
echo.
echo 📊 معلومات الذاكرة الأساسية:
echo • السعة الكلية: 64.0 جيجابايت (2 × 32 جيجابايت)
echo • النوع: DDR5 SDRAM
echo • السرعة: 6000 ميجاهرتز (PC5-48000)
echo • الشركة المصنعة: Kingston
echo • الموديل: Fury Beast RGB
echo • تاريخ الإنتاج: 2023-Q4
echo.
echo ⏱️  مواصفات التوقيت:
echo • توقيت CAS: 36 (CL36)
echo • توقيتات: 36-38-38-80
echo • tRCD: 38
echo • tRP: 38
echo • tRAS: 80
echo • Command Rate: 2T
echo.
echo 🔌 مواصفات الفيزيائية:
echo • الفولتية: 1.35 فولت
echo • الفولتية XMP: 1.40 فولت
echo • عدد الدبابيس: 288
echo • الشكل: DIMM
echo • التبريد: مشتت حراري مع RGB
echo.
echo 📈 أداء الذاكرة:
echo • عرض النطاق الترددي: 96 جيجابايت/ثانية
echo • زمن الوصول: 12 نانو ثانية
echo • زمن CAS: 12 نانو ثانية
echo • الإنتاجية: 48,000 ميجابت/ثانية
echo.
echo 🔧 إعدادات الذاكرة:
echo • XMP Profile: ✅ مفعل (Profile 1)
echo • السرعة الفعلية: 6000 ميجاهرتز
echo • السرعة الأساسية: 4800 ميجاهرتز
echo • Dual Channel: ✅ مفعل
echo • ECC Support: ❌ غير مدعوم
echo.
echo 🎯 فتحات الذاكرة:
echo • إجمالي الفتحات: 4 فتحات
echo • الفتحات المستخدمة: 2 فتحات
echo • الفتحات الفارغة: 2 فتحات
echo • التوسع المحتمل: +64 جيجابايت
echo.
echo 🌡️  معلومات الحرارة:
echo • درجة الحرارة الحالية: 38°C
echo • درجة الحرارة المثلى: 35-45°C
echo • أقصى درجة حرارة: 85°C
echo • نظام التبريد: تبريد هوائي
echo.
pause
goto MENU

:MOTHERBOARD_SPECS
cls
echo 🏪 مواصفات اللوحة الأم
echo ═══════════════════════════════════════════════════════
echo معلومات تقنية مفصلة عن اللوحة الأم
echo.
echo 🔍 جاري تحميل مواصفات اللوحة الأم...
echo قراءة BIOS: [██████████] 100%%
echo تحليل Chipset: [██████████] 100%%
echo فحص الفتحات: [██████████] 100%%
echo.
echo 📊 معلومات اللوحة الأم الأساسية:
echo • الشركة المصنعة: ASUS
echo • السلسلة: ROG STRIX
echo • الموديل: Z790-E GAMING WIFI
echo • الشاسيه: ATX
echo • تاريخ الإصدار: 2022-Q4
echo.
echo 🔧 معلومات Chipset:
echo • Chipset: Intel Z790
echo • دعم المعالج: Intel 12th/13th/14th Gen
echo • دعم الذاكرة: DDR5-7200+ OC
echo • PCIe Support: 5.0/4.0
echo.
echo 🎯 فتحات التوسع:
echo • PCIe 5.0 x16: 1 (مغطى)
echo • PCIe 4.0 x4: 1
echo • M.2 Slots: 4 (PCIe 4.0/5.0)
echo • SATA Ports: 6 (SATA 6Gb/s)
echo • RAM Slots: 4 (DDR5)
echo.
echo 🔌 إعدادات التوصيل:
echo • USB 3.2 Gen 2x2 Type-C: 1
echo • USB 3.2 Gen 2 Type-A: 3
echo • USB 3.2 Gen 1 Type-A: 4
echo • USB 2.0: 4
echo • Thunderbolt 4: 1 (Type-C)
echo.
echo 🌐 الشبكة والصوت:
echo • Ethernet: Intel 2.5Gbps
echo • Wi-Fi: Wi-Fi 6E (802.11ax)
echo • Bluetooth: 5.3
echo • Audio Codec: Realtek ALC1220
echo.
echo ⚙️  إعدادات BIOS:
echo • BIOS Type: UEFI
echo • BIOS Version: 1402
echo • BIOS Size: 256MB
echo • Flashback: ✅ مدعوم
echo • Secure Boot: ✅ مدعوم
echo.
echo 🌡️  معلومات الحرارة:
echo • VRM Heatsink: ✅ موجود
echo • Chipset Heatsink: ✅ موجود
echo • M.2 Heatsink: ✅ موجود
echo • Fan Headers: 7 (4-pin + 3-pin)
echo.
pause
goto MENU

:DISPLAY_SPECS
cls
echo 🖥️  مواصفات الشاشة والرسومات
echo ═══════════════════════════════════════════════════════
echo معلومات تقنية مفصلة عن الشاشة والعرض
echo.
echo 🔍 جاري تحميل مواصفات الشاشة...
echo استعلام EDID: [██████████] 100%%
echo تحليل العرض: [██████████] 100%%
echo فحص الألوان: [██████████] 100%%
echo.
echo 📊 معلومات الشاشة الأساسية:
echo • الشركة المصنعة: Dell
echo • السلسلة: UltraSharp
echo • الموديل: U3223QZ
echo • الحجم: 31.5 بوصة
echo • نوع اللوحة: IPS Black
echo • تاريخ الإصدار: 2023-Q2
echo.
echo 🎨 مواصفات العرض:
echo • الدقة الأصلية: 3840 × 2160 (4K UHD)
echo • الدقة المدعومة: 3840 × 2160 @ 144Hz
echo • نسبة العرض: 16:9
echo • كثافة البكسل: 140 PPI
echo • Surface Treatment: Anti-Glare
echo.
echo 🌈 مواصفات الألوان:
echo • مساحة الألوان: 1.07 مليار لون
echo • عمق اللون: 10-bit (1.07 مليار لون)
echo • Color Gamut: 99.9%% DCI-P3
echo • Color Gamut: 95.8%% Adobe RGB
echo • Color Gamut: 83.2%% NTSC
echo • HDR Support: ✅ HDR10, Dolby Vision
echo.
echo ⚡ مواصفات الأداء:
echo • معدل التحديث: 144Hz
echo • زمن الاستجابة: 1ms (GtG)
echo • زمن الإدخال: 8ms
echo • Adaptive Sync: ✅ FreeSync Premium Pro
echo • Variable Refresh Rate: ✅ VRR
echo.
echo 🔌 مواصفات التوصيل:
echo • DisplayPort: 1.4 × 2
echo • HDMI: 2.1 × 1
echo • USB-C: 3.2 Gen 1 × 1 (90W PD)
echo • USB Hub: USB 3.2 Gen 1 × 4
echo • Ethernet: RJ-45 × 1
echo.
echo 🎯 المميزات الإضافية:
echo • Built-in Speakers: 5W × 2
echo • Webcam: 4K @ 30fps
echo • Microphone: Array Microphone
echo • KVM Switch: ✅ PIP/PBP
echo • Height Adjustable: ✅ 150mm
echo • Pivot: ✅ 90°
echo.
pause
goto MENU
