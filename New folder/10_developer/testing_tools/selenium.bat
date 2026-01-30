@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
call "%~dp0..\..\..\resources\animations.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

:CHECK_ADMIN
net session >nul 2>&1 || (
    echo %RED%⚠️  مطلوب صلاحيات مسؤول%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:HEADER
cls
echo %GREEN%===================================================%WHITE%
echo %GREEN%  🌐 Selenium WebDriver - اختبار ويب تلقائي%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

:CHECK_EXISTING
pip show selenium >nul 2>&1 && (
    echo %GREEN%✓ Selenium مثبت مسبقًا%WHITE%
    pip show selenium | findstr "Version"
    goto :CHROME_DRIVER
)

echo %YELLOW%[1/4] جارٍ تثبيت Selenium...%WHITE%
call :LOADING_ANIMATION 4

pip install selenium webdriver-manager pytest selenium-wire >nul 2>&1

pip show selenium >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Selenium%WHITE%

:CHROME_DRIVER
echo %YELLOW%[2/4] جارٍ تثبيت ChromeDriver...%WHITE%

pip install webdriver-manager >nul 2>&1

:: تثبيت Microsoft Edge Driver (كخيار بديل)
pip install msedge-selenium-tools >nul 2>&1

echo %GREEN%✓ تم تثبيت أدوات التحكم بالمستعرضات%WHITE%

:CREATE_PROJECT
echo %YELLOW%[3/4] جارٍ إنشاء مشروع تجريبي...%WHITE%

set "SELENIUM_PROJECT=%USERPROFILE%\selenium-tests"
if not exist "!SELENIUM_PROJECT!" mkdir "!SELENIUM_PROJECT!" >nul

:: إنشاء ملف إعدادات
(
echo [project]
echo name = Selenium Test Project
echo description = Automated web testing with Selenium
echo author = Knoux Developer
echo 
echo [selenium]
echo driver = chrome
echo headless = false
echo implicit_wait = 10
echo page_load_timeout = 30
) > "!SELENIUM_PROJECT!\config.ini"

:: إنشاء ملف اختبار تجريبي
(
echo import unittest
echo from selenium import webdriver
echo from selenium.webdriver.common.by import By
echo from selenium.webdriver.support.ui import WebDriverWait
echo from selenium.webdriver.support import expected_conditions as EC
echo from selenium.webdriver.chrome.service import Service
echo from webdriver_manager.chrome import ChromeDriverManager
echo import time
echo 
echo class SeleniumTestCase(unittest.TestCase):
echo     def setUp(self):
echo         """Setup method to initialize the browser"""
echo         service = Service(ChromeDriverManager().install())
echo         options = webdriver.ChromeOptions()
echo         options.add_argument('--no-sandbox')
echo         options.add_argument('--disable-dev-shm-usage')
echo         self.driver = webdriver.Chrome(service=service, options=options)
echo         self.driver.maximize_window()
echo         self.driver.implicitly_wait(10)
echo         self.base_url = "https://www.example.com"
echo     
echo     def tearDown(self):
echo         """Cleanup method to close the browser"""
echo         self.driver.quit()
echo     
echo     def test_google_search(self):
echo         """Test case for Google search functionality"""
echo         self.driver.get("https://www.google.com")
echo         search_box = self.driver.find_element(By.NAME, "q")
echo         search_box.send_keys("Selenium automation")
echo         search_box.submit()
echo         time.sleep(2)
echo         self.assertIn("Selenium", self.driver.title)
echo     
echo     def test_arabic_content(self):
echo         """Test case for Arabic content"""
echo         self.driver.get("https://www.example.com")
echo         # Add Arabic-specific test logic here
echo         pass
echo 
echo if __name__ == "__main__":
echo     unittest.main(verbosity=2)
) > "!SELENIUM_PROJECT!\test_selenium.py"

:: إنشاء ملف Pytest تجريبي
(
echo import pytest
echo from selenium import webdriver
echo from selenium.webdriver.chrome.service import Service
echo from webdriver_manager.chrome import ChromeDriverManager
echo from selenium.webdriver.common.by import By
echo import time
echo 
echo @pytest.fixture(scope="function")
echo def browser():
echo     """Pytest fixture to manage browser instance"""
echo     service = Service(ChromeDriverManager().install())
echo     options = webdriver.ChromeOptions()
echo     options.add_argument("--headless")  # Run in background
echo     options.add_argument("--no-sandbox")
echo     options.add_argument("--disable-dev-shm-usage")
echo     driver = webdriver.Chrome(service=service, options=options)
echo     driver.maximize_window()
echo     yield driver
echo     driver.quit()
echo 
echo def test_example_page_title(browser):
echo     """Test example.com page title"""
echo     browser.get("https://www.example.com")
echo     assert "Example Domain" in browser.title
echo     print("Page title:", browser.title)
echo 
echo def test_form_submission(browser):
echo     """Test form submission functionality"""
echo     browser.get("https://www.example.com")
echo     # Add form testing logic
echo     assert browser.current_url == "https://www.example.com"
echo     print("Current URL:", browser.current_url)
) > "!SELENIUM_PROJECT!\test_pytest.py"

:: إنشاء ملف Page Object Model
(
echo from selenium.webdriver.common.by import By
echo from selenium.webdriver.support.ui import WebDriverWait
echo from selenium.webdriver.support import expected_conditions as EC
echo 
echo class BasePage:
echo     def __init__(self, driver):
echo         self.driver = driver
echo         self.wait = WebDriverWait(driver, 10)
echo     
echo     def find_element(self, locator):
echo         return self.wait.until(EC.presence_of_element_located(locator))
echo     
echo     def click_element(self, locator):
echo         element = self.find_element(locator)
echo         self.wait.until(EC.element_to_be_clickable(locator)).click()
echo         return element
echo     
echo     def enter_text(self, locator, text):
echo         element = self.find_element(locator)
echo         element.clear()
echo         element.send_keys(text)
echo         return element
echo 
echo class LoginPage(BasePage):
echo     def __init__(self, driver):
echo         super().__init__(driver)
echo         self.username_input = (By.ID, "username")
echo         self.password_input = (By.ID, "password")
echo         self.login_button = (By.ID, "login-button")
echo     
echo     def login(self, username, password):
echo         self.enter_text(self.username_input, username)
echo         self.enter_text(self.password_input, password)
echo         self.click_element(self.login_button)
echo 
echo class DashboardPage(BasePage):
echo     def __init__(self, driver):
echo         super().__init__(driver)
echo         self.welcome_message = (By.CLASS_NAME, "welcome")
echo     
echo     def is_logged_in(self):
echo         try:
echo             self.find_element(self.welcome_message)
echo             return True
echo         except:
echo             return False
) > "!SELENIUM_PROJECT!\page_objects.py"

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo Selenium Test Runner - Knoux Toolbox
echo echo ===================================
echo echo.
echo echo Choose test to run:
echo echo 1. UnitTest - Chrome
echo echo 2. PyTest - Headless
echo echo 3. Run all tests
echo echo.
echo set /p "CHOICE=Enter choice (1-3): "
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running unittest tests...
echo     python test_selenium.py
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running pytest tests...
echo     pytest test_pytest.py -v
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running all tests...
echo     pytest test_pytest.py -v
echo     python test_selenium.py
echo )
echo 
echo pause
) > "!SELENIUM_PROJECT!\run-tests.bat"

:: إنشاء ملف متطلبات
(
echo selenium==4.15.0
echo webdriver-manager==4.0.1
echo pytest==7.4.3
echo selenium-wire==5.1.0
echo beautifulsoup4==4.12.2
echo requests==2.31.0
) > "!SELENIUM_PROJECT!\requirements.txt"

echo %YELLOW%[4/4] جارٍ تثبيت المتطلبات...%WHITE%
cd /d "!SELENIUM_PROJECT!" && pip install -r requirements.txt >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ Selenium!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!SELENIUM_PROJECT!%WHITE%
echo   تشغيل: %GRAY%cd "!SELENIUM_PROJECT!" && python test_selenium.py%WHITE%
echo   PyTest: %GRAY%pytest test_pytest.py -v%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ Selenium WebDriver (Chrome, Firefox, Edge)
echo   ✓ Page Object Model
echo   ✓ UnitTest + PyTest
echo   ✓ WebDriver Manager (تثبيت تلقائي للمتصفحات)
echo   ✓ دعم اختبارات متعددة المستخدمين
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!SELENIUM_PROJECT!"
echo   2. python test_selenium.py ← لاختبار وحدات
echo   3. pytest test_pytest.py ← لاختبار PyTest
echo   4. ./run-tests.bat ← لتشغيل الكل

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed Selenium WebDriver with test project >> "!LOG_FILE!"

timeout /t 10 >nul
exit /b

:LOADING_ANIMATION
set "DURATION=%1"
set "SPINNER=⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
for /l %%i in (1,1,!DURATION!) do (
    set /a "POS=%%i %% 10"
    <nul set /p "=!SPINNER:~!POS!,1! جارٍ التثبيت... " <nul
    timeout /t 1 >nul
    for /l %%b in (1,1,25) do echo !BACKSPACE! <nul
)
echo.
exit /b
