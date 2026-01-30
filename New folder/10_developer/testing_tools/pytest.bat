@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %CYAN%===================================================%WHITE%
echo %CYAN%  🐍 PyTest - اختبار Python احترافي%WHITE%
echo %CYAN%===================================================%WHITE%
echo.

python --version >nul 2>&1 || (
    echo %RED%✗ Python غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\python_312.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
pip show pytest >nul 2>&1 && (
    echo %GREEN%✓ PyTest مثبت مسبقًا%WHITE%
    pip show pytest | findstr "Version"
    goto :CREATE_PROJECT
)

echo %YELLOW%جارٍ تثبيت PyTest...%WHITE%

pip install pytest pytest-cov pytest-mock pytest-asyncio pytest-html pytest-xdist >nul 2>&1

pip show pytest >nul 2>&1 || (
    echo %RED%✗ فشل التثبيت%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت PyTest%WHITE%

:CREATE_PROJECT
echo %YELLOW%جارٍ إنشاء مشروع تجريبي...%WHITE%

set "PYTEST_PROJECT=%USERPROFILE%\pytest-tests"
if not exist "!PYTEST_PROJECT!" mkdir "!PYTEST_PROJECT!" >nul
cd /d "!PYTEST_PROJECT!"

:: إنشاء ملف إعدادات PyTest
(
echo [tool:pytest]
echo testpaths = tests
echo python_files = test_*.py *_test.py
echo python_classes = Test*
echo python_functions = test_*
echo addopts = 
echo     -v
echo     --tb=short
echo     --strict-markers
echo     --disable-warnings
echo     --cov=src
echo     --cov-report=html
echo     --cov-report=term-missing
echo     --cov-fail-under=80
echo markers =
echo     slow: marks tests as slow (deselect with '-m "not slow"')
echo     integration: marks tests as integration tests
echo     unit: marks tests as unit tests
echo     api: marks tests as API tests
echo     smoke: marks tests as smoke tests
) > pytest.ini

:: إنشاء ملف متطلبات
(
echo pytest==7.4.3
echo pytest-cov==4.1.0
echo pytest-mock==3.12.0
echo pytest-asyncio==0.21.1
echo pytest-html==4.1.1
echo pytest-xdist==3.3.1
echo requests==2.31.0
echo fastapi==0.104.1
echo httpx==0.25.2
) > requirements.txt

:: إنشاء مجلدات المشروع
mkdir src src\utils src\services tests tests\unit tests\integration tests\api >nul 2>&1

:: إنشاء وحدة تجريبية
(
echo """
echo Math utility functions for testing
echo """
echo 
echo 
echo def add(a: float, b: float) -> float:
echo     """Add two numbers together.
echo     
echo     Args:
echo         a: First number
echo         b: Second number
echo         
echo     Returns:
echo         Sum of a and b
echo         
echo     Raises:
echo         TypeError: If inputs are not numbers
echo     """
echo     if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
echo         raise TypeError("Both inputs must be numbers")
echo     return a + b
echo 
echo 
echo def subtract(a: float, b: float) -> float:
echo     """Subtract two numbers.
echo     
echo     Args:
echo         a: First number
echo         b: Second number
echo         
echo     Returns:
echo         Difference of a and b
echo         
echo     Raises:
echo         TypeError: If inputs are not numbers
echo     """
echo     if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
echo         raise TypeError("Both inputs must be numbers")
echo     return a - b
echo 
echo 
echo def multiply(a: float, b: float) -> float:
echo     """Multiply two numbers.
echo     
echo     Args:
echo         a: First number
echo         b: Second number
echo         
echo     Returns:
echo         Product of a and b
echo         
echo     Raises:
echo         TypeError: If inputs are not numbers
echo     """
echo     if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
echo         raise TypeError("Both inputs must be numbers")
echo     return a * b
echo 
echo 
echo def divide(a: float, b: float) -> float:
echo     """Divide two numbers.
echo     
echo     Args:
echo         a: First number
echo         b: Second number
echo         
echo     Returns:
echo         Quotient of a and b
echo         
echo     Raises:
echo         TypeError: If inputs are not numbers
echo         ZeroDivisionError: If b is zero
echo     """
echo     if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
echo         raise TypeError("Both inputs must be numbers")
echo     if b == 0:
echo         raise ZeroDivisionError("Cannot divide by zero")
echo     return a / b
echo 
echo 
echo def is_prime(n: int) -> bool:
echo     """Check if a number is prime.
echo     
echo     Args:
echo         n: Number to check
echo         
echo     Returns:
echo         True if n is prime, False otherwise
echo     """
echo     if n <= 1:
echo         return False
echo     if n <= 3:
echo         return True
echo     if n % 2 == 0 or n % 3 == 0:
echo         return False
echo     i = 5
echo     while i * i <= n:
echo         if n % i == 0 or n % (i + 2) == 0:
echo             return False
echo         i += 6
echo     return True
) > src\utils\math.py

:: إنشاء اختبار وحدة
(
echo """
echo Unit tests for math utility functions
echo """
echo 
echo import pytest
echo from src.utils.math import add, subtract, multiply, divide, is_prime
echo 
echo 
echo class TestMathFunctions:
echo     """Test class for math utility functions"""
echo     
echo     def test_add_positive_numbers(self):
echo         """Test adding two positive numbers"""
echo         assert add(2, 3) == 5
echo         assert add(10, 20) == 30
echo 
echo     def test_add_negative_numbers(self):
echo         """Test adding two negative numbers"""
echo         assert add(-2, -3) == -5
echo         assert add(-10, -20) == -30
echo 
echo     def test_add_mixed_numbers(self):
echo         """Test adding positive and negative numbers"""
echo         assert add(5, -3) == 2
echo         assert add(-5, 3) == -2
echo 
echo     def test_add_zero(self):
echo         """Test adding zero"""
echo         assert add(0, 5) == 5
echo         assert add(5, 0) == 5
echo         assert add(0, 0) == 0
echo 
echo     def test_add_type_error(self):
echo         """Test that add raises TypeError for non-numeric inputs"""
echo         with pytest.raises(TypeError, match="Both inputs must be numbers"):
echo             add("2", 3)
echo         with pytest.raises(TypeError, match="Both inputs must be numbers"):
echo             add(2, "3")
echo         with pytest.raises(TypeError, match="Both inputs must be numbers"):
echo             add(None, 3)
echo 
echo     def test_subtract_positive_numbers(self):
echo         """Test subtracting two positive numbers"""
echo         assert subtract(5, 3) == 2
echo         assert subtract(20, 10) == 10
echo 
echo     def test_subtract_negative_result(self):
echo         """Test subtraction that results in negative numbers"""
echo         assert subtract(3, 5) == -2
echo         assert subtract(10, 20) == -10
echo 
echo     def test_multiply_numbers(self):
echo         """Test multiplying two numbers"""
echo         assert multiply(4, 3) == 12
echo         assert multiply(5, 0) == 0
echo         assert multiply(0, 5) == 0
echo         assert multiply(-2, 3) == -6
echo         assert multiply(-2, -3) == 6
echo 
echo     def test_divide_numbers(self):
echo         """Test dividing two numbers"""
echo         assert divide(12, 3) == 4
echo         assert divide(10, 2) == 5
echo         assert divide(7, 2) == 3.5
echo 
echo     def test_divide_by_zero(self):
echo         """Test that divide raises ZeroDivisionError for zero divisor"""
echo         with pytest.raises(ZeroDivisionError, match="Cannot divide by zero"):
echo             divide(10, 0)
echo         with pytest.raises(ZeroDivisionError, match="Cannot divide by zero"):
echo             divide(0, 0)
echo 
echo     def test_is_prime_small_numbers(self):
echo         """Test is_prime with small numbers"""
echo         assert is_prime(2) is True
echo         assert is_prime(3) is True
echo         assert is_prime(5) is True
echo         assert is_prime(7) is True
echo         assert is_prime(11) is True
echo 
echo     def test_is_prime_non_prime_numbers(self):
echo         """Test is_prime with non-prime numbers"""
echo         assert is_prime(1) is False
echo         assert is_prime(4) is False
echo         assert is_prime(6) is False
echo         assert is_prime(8) is False
echo         assert is_prime(9) is False
echo         assert is_prime(10) is False
echo 
echo     def test_is_prime_large_numbers(self):
echo         """Test is_prime with larger numbers"""
echo         assert is_prime(13) is True
echo         assert is_prime(17) is True
echo         assert is_prime(19) is True
echo         assert is_prime(23) is True
echo         assert is_prime(29) is True
echo 
echo 
echo @pytest.mark.parametrize("a,b,expected", [
echo     (1, 2, 3),
echo     (-1, -2, -3),
echo     (0, 5, 5),
echo     (10, -5, 5),
echo     (3.5, 2.5, 6.0),
echo ])
echo def test_add_parametrized(a, b, expected):
echo     """Parametrized test for add function"""
echo     assert add(a, b) == expected
echo 
echo 
echo @pytest.mark.parametrize("n,expected", [
echo     (2, True),
echo     (3, True),
echo     (4, False),
echo     (5, True),
echo     (6, False),
echo     (7, True),
echo     (8, False),
echo     (9, False),
echo     (10, False),
echo ])
echo def test_is_prime_parametrized(n, expected):
echo     """Parametrized test for is_prime function"""
echo     assert is_prime(n) is expected
) > tests\unit\test_math.py

:: إنشاء اختبار تكامل
(
echo """
echo Integration tests for the math module
echo """
echo 
echo import pytest
echo from src.utils.math import add, multiply, is_prime
echo 
echo 
echo @pytest.mark.integration
echo class TestMathIntegration:
echo     """Integration tests for math utilities"""
echo     
echo     def test_combined_operations(self):
echo         """Test combining multiple math operations"""
echo         # Test: (2 + 3) * 4 = 20
echo         result = multiply(add(2, 3), 4)
echo         assert result == 20
echo         
echo         # Test: (10 - 3) + 5 = 12
echo         result = add(subtract := __import__('src.utils.math', fromlist=['subtract']).subtract(10, 3), 5)
echo         assert result == 12
echo 
echo     def test_prime_number_sequence(self):
echo         """Test generating a sequence of prime numbers"""
echo         primes = [n for n in range(2, 20) if is_prime(n)]
echo         expected_primes = [2, 3, 5, 7, 11, 13, 17, 19]
echo         assert primes == expected_primes
echo 
echo     def test_performance_with_large_numbers(self):
echo         """Test performance with larger numbers"""
echo         import time
echo         
echo         # Test prime checking with a larger number
echo         start_time = time.time()
echo         result = is_prime(7919)  # Known prime
echo         end_time = time.time()
echo         
echo         assert result is True
echo         assert end_time - start_time < 1.0  # Should complete in under 1 second
echo 
echo     @pytest.mark.slow
echo     def test_very_large_prime(self):
echo         """Test with a very large prime number (marked as slow)"""
echo         # This is a known large prime
echo         large_prime = 104729
echo         assert is_prime(large_prime) is True
) > tests\integration\test_math_integration.py

:: إنشاء اختبار API
(
echo """
echo API testing with PyTest
echo """
echo 
echo import pytest
echo import requests
echo from unittest.mock import Mock, patch
echo 
echo 
echo @pytest.mark.api
echo class TestAPIIntegration:
echo     """API integration tests"""
echo     
echo     @pytest.fixture
echo     def mock_api_response(self):
echo         """Fixture for mock API response"""
echo         return {
echo             "id": 1,
echo             "name": "Test User",
echo             "email": "test@example.com",
echo             "status": "active"
echo         }
echo 
echo     def test_mock_api_call(self, mock_api_response):
echo         """Test with mocked API response"""
echo         with patch('requests.get') as mock_get:
echo             mock_get.return_value.json.return_value = mock_api_response
echo             mock_get.return_value.status_code = 200
echo             
echo             response = requests.get('https://api.example.com/users/1')
echo             data = response.json()
echo             
echo             assert data['id'] == 1
echo             assert data['name'] == 'Test User'
echo             assert data['email'] == 'test@example.com'
echo             assert mock_get.called_once_with('https://api.example.com/users/1')
echo 
echo     @pytest.mark.asyncio
echo     async def test_async_api_call(self):
echo         """Test async API call"""
echo         import httpx
echo         
echo         async with httpx.AsyncClient() as client:
echo             # This is a mock test - in real scenario, you'd hit actual API
echo             with patch.object(client, 'get') as mock_get:
echo                 mock_get.return_value.json.return_value = {"status": "ok"}
echo                 mock_get.return_value.status_code = 200
echo                 
echo                 response = await client.get('https://api.example.com/health')
echo                 data = response.json()
echo                 
echo                 assert data['status'] == 'ok'
) > tests\api\test_api.py

:: إنشاء اختبار مزيف
(
echo """
echo Tests for mocking and fixtures
echo """
echo 
echo import pytest
echo from unittest.mock import Mock, patch, MagicMock
echo from src.utils.math import add, multiply
echo 
echo 
echo class TestMocking:
echo     """Test class for mocking examples"""
echo     
echo     @pytest.fixture
echo     def mock_calculator(self):
echo         """Fixture that creates a mock calculator"""
echo         mock_calc = Mock()
echo         mock_calc.add.return_value = 10
echo         mock_calc.multiply.return_value = 20
echo         return mock_calc
echo 
echo     def test_mock_calculator(self, mock_calculator):
echo         """Test using mock calculator fixture"""
echo         result1 = mock_calculator.add(2, 3)
echo         result2 = mock_calculator.multiply(4, 5)
echo         
echo         assert result1 == 10
echo         assert result2 == 20
echo         mock_calculator.add.assert_called_once_with(2, 3)
echo         mock_calculator.multiply.assert_called_once_with(4, 5)
echo 
echo     @patch('src.utils.math.add')
echo     def test_patched_add(self, mock_add):
echo         """Test with patched add function"""
echo         mock_add.return_value = 100
echo         
echo         result = add(2, 3)
echo         
echo         assert result == 100
echo         mock_add.assert_called_once_with(2, 3)
echo 
echo     def test_magic_mock(self):
echo         """Test using MagicMock"""
echo         magic_calc = MagicMock()
echo         magic_calc.add.return_value = 50
echo         
echo         result = magic_calc.add(10, 20)
echo         
echo         assert result == 50
echo         magic_calc.add.assert_called_once_with(10, 20)
echo         
echo         # MagicMock allows any attribute access
echo         magic_calc.some_nonexistent_method.return_value = "test"
echo         assert magic_calc.some_nonexistent_method() == "test"
echo 
echo     @pytest.fixture
echo     def sample_data(self):
echo         """Fixture providing sample test data"""
echo         return [
echo             {"id": 1, "name": "Alice", "score": 85},
echo             {"id": 2, "name": "Bob", "score": 92},
echo             {"id": 3, "name": "Charlie", "score": 78}
echo         ]
echo 
echo     def test_data_processing(self, sample_data):
echo         """Test data processing with sample data fixture"""
echo         # Calculate average score
echo         total_score = sum(item['score'] for item in sample_data)
echo         average_score = total_score / len(sample_data)
echo         
echo         assert average_score == pytest.approx(85.0, rel=1e-2)
echo         assert len(sample_data) == 3
echo         assert all(item['score'] >= 0 for item in sample_data)
) > tests\unit\test_mocking.py

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo PyTest Test Runner - Knoux Toolbox
echo echo ================================
echo echo.
echo echo Choose test option:
echo echo 1. Run all tests
echo echo 2. Run with coverage
echo echo 3. Run specific markers
echo echo 4. Run in parallel
echo echo 5. Generate HTML report
echo echo 6. Run with verbose output
echo echo.
echo set /p "CHOICE=Enter choice (1-6): "
echo 
echo cd /d "!PYTEST_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Running all tests...
echo     pytest
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running tests with coverage...
echo     pytest --cov=src --cov-report=html
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running unit tests only...
echo     pytest -m unit
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running tests in parallel...
echo     pytest -n auto
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Generating HTML report...
echo     pytest --html=report.html --self-contained-html
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Running with verbose output...
echo     pytest -v -s
echo )
echo 
echo pause
) > run-pytest.bat

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ PyTest!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!PYTEST_PROJECT!%WHITE%
echo   تشغيل: %GRAY%pytest%WHITE%
echo   تغطية: %GRAY%pytest --cov=src --cov-report=html%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة وتكامل
echo   ✓ Fixtures و Parametrization
echo   ✓ Mocking و Patching
echo   ✓ تغطية الكود التلقائية
echo   ✓ اختبارات غير متزامنة
echo   ✓ تقارير HTML مفصلة
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!PYTEST_PROJECT!"
echo   2. pytest ← لتشغيل الاختبارات
echo   3. pytest -v ← للمخرجات المفصلة
echo   4. pytest --cov=src ← لتغطية الكود

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed PyTest with comprehensive test suite >> "!LOG_FILE!"

timeout /t 8 >nul
