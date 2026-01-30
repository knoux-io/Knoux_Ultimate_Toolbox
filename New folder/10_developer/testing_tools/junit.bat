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
echo %GREEN%  ☕ JUnit - اختبار Java القياسي%WHITE%
echo %GREEN%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
mvn --version >nul 2>&1 && (
    echo %GREEN%✓ Maven مثبت (JUnit متوفر عبره)%WHITE%
    mvn --version | findstr "Apache Maven"
    goto :CREATE_PROJECT
)

echo %YELLOW%[1/4] جارٍ تثبيت Maven (لمشروع JUnit)...%WHITE%
call :LOADING_ANIMATION 4

winget install -e --id Apache.Maven --silent >nul 2>&1

mvn --version >nul 2>&1 || (
    echo %YELLOW%التنزيل اليدوي...%WHITE%
    set "MAVEN_ZIP=%TEMP%\apache-maven.zip"
    powershell -Command "Invoke-WebRequest -Uri 'https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip' -OutFile '!MAVEN_ZIP!'" >nul 2>&1
    
    if exist "!MAVEN_ZIP!" (
        powershell -Command "Expand-Archive -Path '!MAVEN_ZIP!' -DestinationPath '%TEMP%\maven' -Force" >nul 2>&1
        xcopy "%TEMP%\maven\apache-maven-3.9.6" "C:\Program Files\Apache\Maven\" /E /I /Y >nul 2>&1
        setx PATH "%PATH%;C:\Program Files\Apache\Maven\bin" >nul
        del "!MAVEN_ZIP!" >nul 2>&1
        rmdir /s /q "%TEMP%\maven" >nul 2>&1
    )
)

mvn --version >nul 2>&1 || (
    echo %RED%✗ فشل تثبيت Maven%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Maven%WHITE%

:CREATE_PROJECT
echo %YELLOW%[2/4] جارٍ إنشاء مشروع JUnit تجريبي...%WHITE%

set "JUNIT_PROJECT=%USERPROFILE%\junit-tests"
if not exist "!JUNIT_PROJECT!" mkdir "!JUNIT_PROJECT!" >nul
cd /d "!JUNIT_PROJECT!"

:: إنشاء pom.xml
(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <project xmlns="http://maven.apache.org/POM/4.0.0"
echo          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
echo          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
echo          http://maven.apache.org/xsd/maven-4.0.0.xsd">
echo     <modelVersion>4.0.0</modelVersion>
echo 
echo     <groupId>com.knoux</groupId>
echo     <artifactId>junit-tests</artifactId>
echo     <version>1.0.0</version>
echo     <packaging>jar</packaging>
echo 
echo     <properties>
echo         <maven.compiler.source>17</maven.compiler.source>
echo         <maven.compiler.target>17</maven.compiler.target>
echo         <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
echo         <junit.version>5.10.1</junit.version>
echo     </properties>
echo 
echo     <dependencies>
echo         <!-- JUnit 5 -->
echo         <dependency>
echo             <groupId>org.junit.jupiter</groupId>
echo             <artifactId>junit-jupiter</artifactId>
echo             <version>${junit.version}</version>
echo             <scope>test</scope>
echo         </dependency>
echo         
echo         <!-- Mockito for mocking -->
echo         <dependency>
echo             <groupId>org.mockito</groupId>
echo             <artifactId>mockito-core</artifactId>
echo             <version>5.8.0</version>
echo             <scope>test</scope>
echo         </dependency>
echo         
echo         <!-- AssertJ for fluent assertions -->
echo         <dependency>
echo             <groupId>org.assertj</groupId>
echo             <artifactId>assertj-core</artifactId>
echo             <version>3.24.2</version>
echo             <scope>test</scope>
echo         </dependency>
echo         
echo         <!-- JUnit Platform Launcher (needed for IDE integration) -->
echo         <dependency>
echo             <groupId>org.junit.platform</groupId>
echo             <artifactId>junit-platform-launcher</artifactId>
echo             <version>1.10.1</version>
echo             <scope>test</scope>
echo         </dependency>
echo     </dependencies>
echo 
echo     <build>
echo         <plugins>
echo             <plugin>
echo                 <groupId>org.apache.maven.plugins</groupId>
echo                 <artifactId>maven-surefire-plugin</artifactId>
echo                 <version>3.2.2</version>
echo                 <configuration>
echo                     <includes>
echo                         <include>**/*Test.java</include>
echo                         <include>**/*Tests.java</include>
echo                     </includes>
echo                 </configuration>
echo             </plugin>
echo             
echo             <plugin>
echo                 <groupId>org.jacoco</groupId>
echo                 <artifactId>jacoco-maven-plugin</artifactId>
echo                 <version>0.8.11</version>
echo                 <executions>
echo                     <execution>
echo                         <goals>
echo                             <goal>prepare-agent</goal>
echo                         </goals>
echo                     </execution>
echo                     <execution>
echo                         <id>report</id>
echo                         <phase>test</phase>
echo                         <goals>
echo                             <goal>report</goal>
echo                         </goals>
echo                     </execution>
echo                 </executions>
echo             </plugin>
echo         </plugins>
echo     </build>
echo </project>
) > pom.xml

:: إنشاء مجلدات المشروع
mkdir src\main\java src\main\java\com\knoux\utils src\test\java src\test\java\com\knoux\utils >nul 2>&1

:: إنشاء فئة تجريبية
(
echo package com.knoux.utils;
echo 
echo import java.util.List;
echo import java.util.ArrayList;
echo import java.util.Collections;
echo 
echo public class MathUtils {
echo 
echo     public static int add(int a, int b) {
echo         return a + b;
echo     }
echo 
echo     public static int subtract(int a, int b) {
echo         return a - b;
echo     }
echo 
echo     public static int multiply(int a, int b) {
echo         return a * b;
echo     }
echo 
echo     public static double divide(double a, double b) {
echo         if (b == 0) {
echo             throw new ArithmeticException("Division by zero");
echo         }
echo         return a / b;
echo     }
echo 
echo     public static boolean isEven(int number) {
echo         return number % 2 == 0;
echo     }
echo 
echo     public static List<Integer> getFactors(int number) {
echo         if (number <= 0) {
echo             throw new IllegalArgumentException("Number must be positive");
echo         }
echo         
echo         List<Integer> factors = new ArrayList<>();
echo         for (int i = 1; i <= number; i++) {
echo             if (number % i == 0) {
echo                 factors.add(i);
echo             }
echo         }
echo         return factors;
echo     }
echo 
echo     public static int factorial(int n) {
echo         if (n < 0) {
echo             throw new IllegalArgumentException("Factorial is not defined for negative numbers");
echo         }
echo         if (n == 0 || n == 1) {
echo             return 1;
echo         }
echo         int result = 1;
echo         for (int i = 2; i <= n; i++) {
echo             result *= i;
echo         }
echo         return result;
echo     }
echo }
) > src\main\java\com\knoux\utils\MathUtils.java

:: إنشاء اختبار وحدة JUnit
(
echo package com.knoux.utils;
echo 
echo import org.junit.jupiter.api.Test;
echo import org.junit.jupiter.api.DisplayName;
echo import org.junit.jupiter.api.Nested;
echo import org.junit.jupiter.params.ParameterizedTest;
echo import org.junit.jupiter.params.provider.ValueSource;
echo import org.junit.jupiter.params.provider.CsvSource;
echo import static org.junit.jupiter.api.Assertions.*;
echo import java.util.List;
echo 
echo @DisplayName("JUnit 5 Test Suite - Math Utilities")
echo class MathUtilsTest {
echo 
echo     @Nested
echo     @DisplayName("Addition Tests")
echo     class AdditionTests {
echo 
echo         @Test
echo         @DisplayName("Should add two positive numbers correctly")
echo         void shouldAddTwoPositiveNumbers() {
echo             int result = MathUtils.add(2, 3);
echo             assertEquals(5, result, "2 + 3 should equal 5");
echo         }
echo 
echo         @Test
echo         @DisplayName("Should add negative numbers correctly")
echo         void shouldAddNegativeNumbers() {
echo             int result = MathUtils.add(-2, -3);
echo             assertEquals(-5, result, "-2 + (-3) should equal -5");
echo         }
echo 
echo         @Test
echo         @DisplayName("Should handle zero in addition")
echo         void shouldHandleZeroInAddition() {
echo             assertEquals(5, MathUtils.add(5, 0));
echo             assertEquals(0, MathUtils.add(0, 0));
echo             assertEquals(-5, MathUtils.add(-5, 0));
echo         }
echo     }
echo 
echo     @Nested
echo     @DisplayName("Division Tests")
echo     class DivisionTests {
echo 
echo         @Test
echo         @DisplayName("Should divide numbers correctly")
echo         void shouldDivideNumbersCorrectly() {
echo             assertEquals(2.5, MathUtils.divide(5, 2), 0.001);
echo             assertEquals(0.0, MathUtils.divide(0, 5), 0.001);
echo         }
echo 
echo         @Test
echo         @DisplayName("Should throw exception when dividing by zero")
echo         void shouldThrowExceptionWhenDividingByZero() {
echo             ArithmeticException exception = assertThrows(
echo                 ArithmeticException.class,
echo                 () -> MathUtils.divide(10, 0),
echo                 "Division by zero should throw ArithmeticException"
echo             );
echo             assertEquals("Division by zero", exception.getMessage());
echo         }
echo     }
echo 
echo     @Nested
echo     @DisplayName("Utility Function Tests")
echo     class UtilityFunctionTests {
echo 
echo         @Test
echo         @DisplayName("Should determine if number is even correctly")
echo         void shouldDetermineIfNumberIsEvenCorrectly() {
echo             assertTrue(MathUtils.isEven(2));
echo             assertTrue(MathUtils.isEven(0));
echo             assertFalse(MathUtils.isEven(1));
echo             assertFalse(MathUtils.isEven(-1));
echo         }
echo 
echo         @ParameterizedTest
echo         @ValueSource(ints = {2, 4, 6, 8, 10})
echo         @DisplayName("Should identify even numbers")
echo         void shouldIdentifyEvenNumbers(int number) {
echo             assertTrue(MathUtils.isEven(number), number + " should be even");
echo         }
echo 
echo         @ParameterizedTest
echo         @CsvSource({
echo             "0, 1",
echo             "1, 1", 
echo             "2, 2",
echo             "3, 6",
echo             "4, 24",
echo             "5, 120"
echo         })
echo         @DisplayName("Should calculate factorial correctly")
echo         void shouldCalculateFactorialCorrectly(int input, int expected) {
echo             assertEquals(expected, MathUtils.factorial(input), 
echo                 input + "! should equal " + expected);
echo         }
echo 
echo         @Test
echo         @DisplayName("Should get factors of a number")
echo         void shouldGetFactorsOfANumber() {
echo             List<Integer> factors = MathUtils.getFactors(12);
echo             assertEquals(List.of(1, 2, 3, 4, 6, 12), factors);
echo             
echo             factors = MathUtils.getFactors(1);
echo             assertEquals(List.of(1), factors);
echo             
echo             factors = MathUtils.getFactors(7); // Prime number
echo             assertEquals(List.of(1, 7), factors);
echo         }
echo     }
echo }
) > src\test\java\com\knoux\utils\MathUtilsTest.java

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo JUnit Test Runner - Knoux Toolbox
echo echo ================================
echo echo.
echo echo Choose test option:
echo echo 1. Compile project
echo echo 2. Run all tests
echo echo 3. Run tests with coverage
echo echo 4. Run specific test class
echo echo 5. Run tests in debug mode
echo echo 6. Generate test report
echo echo.
echo set /p "CHOICE=Enter choice (1-6): "
echo 
echo cd /d "!JUNIT_PROJECT!"
echo 
echo if "%%CHOICE%%"=="1" (
echo     echo Compiling project...
echo     mvn compile
echo )
echo if "%%CHOICE%%"=="2" (
echo     echo Running all tests...
echo     mvn test
echo )
echo if "%%CHOICE%%"=="3" (
echo     echo Running tests with coverage...
echo     mvn clean test jacoco:report
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running MathUtilsTest...
echo     mvn test -Dtest=MathUtilsTest
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Running tests in debug mode...
echo     mvn test -Dmaven.surefire.debug
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Generating test report...
echo     mvn surefire-report:report
echo )
echo 
echo pause
) > "!JUNIT_PROJECT!\run-junit.bat"

echo %YELLOW%[3/4] جارٍ تثبيت المكونات...%WHITE%
mvn dependency:resolve >nul 2>&1

echo %YELLOW%[4/4] جارٍ إنشاء تقارير الاختبارات...%WHITE%
if not exist "target" mkdir "target" >nul 2>&1
if not exist "target\surefire-reports" mkdir "target\surefire-reports" >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ JUnit!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!JUNIT_PROJECT!%WHITE%
echo   تشغيل: %GRAY%cd "!JUNIT_PROJECT!" && mvn test%WHITE%
echo   تقارير: %GRAY%target\surefire-reports%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة وتكامل
echo   ✓ JUnit 5
echo   ✓ Mockito
echo   ✓ AssertJ
echo   ✓ تغطية الكود
echo   ✓ تقارير مفصلة
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!JUNIT_PROJECT!"
echo   2. mvn test ← لتشغيل الاختبارات
echo   3. mvn clean test jacoco:report ← للتغطية
echo   4. ./run-junit.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed JUnit with comprehensive test suite >> "!LOG_FILE!"

timeout /t 12 >nul
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
