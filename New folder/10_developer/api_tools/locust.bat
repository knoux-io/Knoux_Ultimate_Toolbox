@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %RED%===================================================%WHITE%
echo %RED%  🦗 Locust - اختبار تحميل مبني على Python%WHITE%
echo %RED%===================================================%WHITE%
echo.

python --version >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\python_312.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
pip show locust >nul 2>&1 && (
    echo %GREEN%✓ Locust مثبت مسبقًا%WHITE%
    pip show locust | findstr "Version"
    goto :CREATE_DEMO
)

echo %YELLOW%جارٍ التثبيت...%WHITE%
pip install locust >nul 2>&1

pip show locust >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم التثبيت بنجاح%WHITE%

:CREATE_DEMO
echo %YELLOW%جارٍ إنشاء مشروع تجريبي...%WHITE%

set "LOCUST_DIR=%USERPROFILE%\locust-tests"
if not exist "!LOCUST_DIR!" mkdir "!LOCUST_DIR!" >nul

:: إنشاء ملف اختبار بسيط
(
echo from locust import HttpUser, task, between
echo import random
echo 
echo class WebsiteUser(HttpUser):
echo     wait_time = between(1, 3)
echo     
echo     @task
echo     def view_homepage(self):
echo         self.client.get("/")
echo     
echo     @task(3)  # 3 times more likely than other tasks
echo     def view_users(self):
echo         user_id = random.randint(1, 10)
echo         self.client.get(f"/users/{user_id}")
echo     
echo     @task
echo     def create_post(self):
echo         self.client.post("/posts", json={
echo             "title": f"Test Post {random.randint(1, 100)}",
echo             "body": "This is a test post for load testing",
echo             "userId": random.randint(1, 10)
echo         })
echo     
echo     @task
echo     def search_content(self):
echo         search_terms = ["python", "api", "testing", "performance"]
echo         term = random.choice(search_terms)
echo         self.client.get(f"/search?q={term}")
) > "!LOCUST_DIR!\simple_test.py"

:: إنشاء ملف اختبار معقد
(
echo from locust import HttpUser, task, between, SequentialTaskSet
echo import json
echo import random
echo 
echo class AdvancedUser(HttpUser):
echo     wait_time = between(0.5, 2)
echo     host = "https://jsonplaceholder.typicode.com"
echo     
echo     def on_start(self):
echo         """Login simulation"""
echo         response = self.client.post("/login", json={
echo             "username": f"user_{random.randint(1, 1000)}",
echo             "password": "password123"
echo         })
echo         if response.status_code == 200:
echo             self.token = response.json().get("token", "")
echo             self.headers = {"Authorization": f"Bearer {self.token}"}
echo         else:
echo             self.headers = {}
echo     
echo     @task(2)
echo     def browse_posts(self):
echo         with self.client.get("/posts", catch_response=True) as response:
echo             if response.status_code != 200:
echo                 response.failure(f"Got wrong response code: {response.status_code}")
echo             else:
echo                 try:
echo                     posts = response.json()
echo                     if len(posts) == 0:
echo                         response.failure("No posts returned")
echo                 except json.JSONDecodeError:
echo                     response.failure("Could not decode response as JSON")
echo     
echo     @task(1)
echo     def create_post(self):
echo         post_data = {
echo             "title": f"Performance Test Post {random.randint(1, 1000)}",
echo             "body": "Created during load testing",
echo             "userId": random.randint(1, 10)
echo         }
echo         response = self.client.post("/posts", json=post_data, headers=self.headers)
echo         if response.status_code == 201:
echo             print(f"Successfully created post")
echo     
echo     @task(1)
echo     def view_user_profile(self):
echo         user_id = random.randint(1, 10)
echo         self.client.get(f"/users/{user_id}")
echo 
echo class UserBehavior(SequentialTaskSet):
echo     tasks = [AdvancedUser.browse_posts, AdvancedUser.create_post, AdvancedUser.view_user_profile]
) > "!LOCUST_DIR!\advanced_test.py"

:: إنشاء ملف إعدادات
(
echo [locust]
echo host = https://jsonplaceholder.typicode.com
echo web-host = 127.0.0.1
echo web-port = 8089
echo headless = false
echo users = 10
echo spawn-rate = 2
echo run-time = 5m
echo 
echo [api]
echo timeout = 30
echo retries = 3
) > "!LOCUST_DIR!\locust.conf"

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Locust Load Testing - Knoux Toolbox
echo echo ==================================
echo echo.
echo echo Starting Locust Web Interface...
echo echo Open your browser to: http://localhost:8089
echo echo.
echo echo Options:
echo echo 1. Simple Test: locust -f simple_test.py
echo echo 2. Advanced Test: locust -f advanced_test.py
echo echo 3. Headless Mode: locust -f simple_test.py --headless -u 10 -r 2 -t 1m
echo echo.
echo echo Starting simple test...
echo locust -f "!LOCUST_DIR!\simple_test.py" --host=https://jsonplaceholder.typicode.com
) > "!LOCUST_DIR!\start-locust.bat"

echo %GREEN%✓ تم إنشاء مشروع Locust تجريبي%WHITE%
echo %CYAN%الموقع:%WHITE% !LOCUST_DIR!

echo.
echo %CYAN%لماذا Locust؟%WHITE%
echo   ✓ مكتوب بلغة Python (سهل التخصيص)
echo   ✓ واجهة ويب تفاعلية
echo   ✓ دعم اختبارات متعددة المستخدمين
echo   ✓ تقارير حية أثناء الاختبار
echo   ✓ دعم WebSocket وHTTP/2
echo.
echo %YELLOW%أوامر شائعة:%WHITE%
echo   locust -f test.py ← واجهة ويب
echo   locust -f test.py --headless -u 10 -r 2 -t 5m ← تشغيل تلقائي
echo   locust -f test.py --host=https://api.example.com ← تحديد الخادم
echo   locust -f test.py --csv=results --csv-full-history ← حفظ النتائج

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Locust with demo test scenarios >> "!LOG_FILE!"

timeout /t 8 >nul
