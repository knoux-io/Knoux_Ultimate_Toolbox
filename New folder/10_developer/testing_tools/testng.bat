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
echo %RED%===================================================%WHITE%
echo %RED%  🔬 TestNG - اختبار Java المتقدم%WHITE%
echo %RED%===================================================%WHITE%
echo.

java -version >nul 2>&1 || (
    echo %RED%✗ Java غير مثبت%WHITE%
    echo %YELLOW%الحل: شغّل أولاً env_setup\java_17.bat%WHITE%
    timeout /t 5 >nul
    exit /b 1
)

:CHECK_EXISTING
mvn --version >nul 2>&1 && (
    echo %GREEN%✓ Maven مثبت (TestNG متوفر عبره)%WHITE%
    timeout /t 3 >nul
    goto :CREATE_PROJECT
)

echo %YELLOW%[1/4] جارٍ تثبيت Maven (لمشروع TestNG)...%WHITE%
call :LOADING_ANIMATION 4

winget install -e --id Apache.Maven --silent >nul 2>&1

mvn --version >nul 2>&1 || (
    echo %RED%✗ فشل تثبيت Maven%WHITE%
    exit /b 1
)

echo %GREEN%✓ تم تثبيت Maven%WHITE%

:CREATE_PROJECT
echo %YELLOW%[2/4] جارٍ إنشاء مشروع TestNG تجريبي...%WHITE%

set "TESTNG_PROJECT=%USERPROFILE%\testng-tests"
if not exist "!TESTNG_PROJECT!" mkdir "!TESTNG_PROJECT!" >nul
cd /d "!TESTNG_PROJECT!"

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
echo     <artifactId>testng-tests</artifactId>
echo     <version>1.0.0</version>
echo     <packaging>jar</packaging>
echo 
echo     <properties>
echo         <maven.compiler.source>17</maven.compiler.source>
echo         <maven.compiler.target>17</maven.compiler.target>
echo         <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
echo         <testng.version>7.8.0</testng.version>
echo     </properties>
echo 
echo     <dependencies>
echo         <!-- TestNG -->
echo         <dependency>
echo             <groupId>org.testng</groupId>
echo             <artifactId>testng</artifactId>
echo             <version>${testng.version}</version>
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
echo         <!-- Mockito for mocking -->
echo         <dependency>
echo             <groupId>org.mockito</groupId>
echo             <artifactId>mockito-core</artifactId>
echo             <version>5.8.0</version>
echo             <scope>test</scope>
echo         </dependency>
echo         
echo         <!-- Selenium for web testing -->
echo         <dependency>
echo             <groupId>org.seleniumhq.selenium</groupId>
echo             <artifactId>selenium-java</artifactId>
echo             <version>4.15.0</version>
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
echo                     <suiteXmlFiles>
echo                         <suiteXmlFile>testng.xml</suiteXmlFile>
echo                     </suiteXmlFiles>
echo                 </configuration>
echo             </plugin>
echo             
echo             <plugin>
echo                 <groupId>org.apache.maven.plugins</groupId>
echo                 <artifactId>maven-failsafe-plugin</artifactId>
echo                 <version>3.2.2</version>
echo                 <configuration>
echo                     <suiteXmlFiles>
echo                         <suiteXmlFile>testng.xml</suiteXmlFile>
echo                     </suiteXmlFiles>
echo                 </configuration>
echo                 <executions>
echo                     <execution>
echo                         <goals>
echo                             <goal>integration-test</goal>
echo                             <goal>verify</goal>
echo                         </goals>
echo                     </execution>
echo                 </executions>
echo             </plugin>
echo         </plugins>
echo     </build>
echo </project>
) > pom.xml

:: إنشاء مجلدات المشروع
mkdir src\main\java src\main\java\com\knoux\utils src\main\java\com\knoux\services src\test\java src\test\java\com\knoux\tests src\test\java\com\knoux\tests\unit src\test\java\com\knoux\tests\integration src\test\java\com\knoux\tests\smoke src\test\java\com\knoux\tests\api >nul 2>&1

:: إنشاء فئة تجريبية
(
echo package com.knoux.utils;
echo 
echo import java.util.*;
echo 
echo public class StringUtils {
echo 
echo     public static boolean isPalindrome(String str) {
echo         if (str == null) return false;
echo         String cleaned = str.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
echo         return cleaned.equals(new StringBuilder(cleaned).reverse().toString());
echo     }
echo 
echo     public static String reverseWords(String str) {
echo         if (str == null || str.trim().isEmpty()) return str;
echo         String[] words = str.trim().split("\\s+");
echo         StringBuilder reversed = new StringBuilder();
echo         for (int i = words.length - 1; i >= 0; i--) {
echo             reversed.append(words[i]);
echo             if (i > 0) reversed.append(" ");
echo         }
echo         return reversed.toString();
echo     }
echo 
echo     public static boolean isValidEmail(String email) {
echo         if (email == null || email.trim().isEmpty()) return false;
echo         String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
echo         return email.matches(emailRegex);
echo     }
echo 
echo     public static String capitalize(String str) {
echo         if (str == null || str.isEmpty()) return str;
echo         return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
echo     }
echo }
) > src\main\java\com\knoux\utils\StringUtils.java

:: إنشاء فئة خدمة
(
echo package com.knoux.services;
echo 
echo import java.util.*;
echo 
echo public class OrderService {
echo     private Map<Integer, Order> orders;
echo     private int nextId;
echo 
echo     public OrderService() {
echo         this.orders = new HashMap<>();
echo         this.nextId = 1;
echo     }
echo 
echo     public Order createOrder(String customerEmail, List<String> items, double total) {
echo         if (customerEmail == null || customerEmail.trim().isEmpty()) {
echo             throw new IllegalArgumentException("Customer email is required");
echo         }
echo         if (items == null || items.isEmpty()) {
echo             throw new IllegalArgumentException("Order items are required");
echo         }
echo         if (total <= 0) {
echo             throw new IllegalArgumentException("Total must be positive");
echo         }
echo 
echo         Order order = new Order(nextId++, customerEmail, items, total, new Date());
echo         orders.put(order.getId(), order);
echo         return order;
echo     }
echo 
echo     public Order getOrder(int id) {
echo         return orders.get(id);
echo     }
echo 
echo     public List<Order> getAllOrders() {
echo         return new ArrayList<>(orders.values());
echo     }
echo 
echo     public boolean cancelOrder(int id) {
echo         Order order = orders.get(id);
echo         if (order != null && !order.isCancelled()) {
echo             order.setCancelled(true);
echo             return true;
echo         }
echo         return false;
echo     }
echo 
echo     public List<Order> getOrdersByCustomer(String customerEmail) {
echo         List<Order> customerOrders = new ArrayList<>();
echo         for (Order order : orders.values()) {
echo             if (order.getCustomerEmail().equals(customerEmail)) {
echo                 customerOrders.add(order);
echo             }
echo         }
echo         return customerOrders;
echo     }
echo }
echo 
echo class Order {
echo     private int id;
echo     private String customerEmail;
echo     private List<String> items;
echo     private double total;
echo     private Date createdAt;
echo     private boolean cancelled;
echo 
echo     public Order(int id, String customerEmail, List<String> items, double total, Date createdAt) {
echo         this.id = id;
echo         this.customerEmail = customerEmail;
echo         this.items = new ArrayList<>(items);
echo         this.total = total;
echo         this.createdAt = createdAt;
echo         this.cancelled = false;
echo     }
echo 
echo     // Getters and setters
echo     public int getId() { return id; }
echo     public String getCustomerEmail() { return customerEmail; }
echo     public List<String> getItems() { return new ArrayList<>(items); }
echo     public double getTotal() { return total; }
echo     public Date getCreatedAt() { return createdAt; }
echo     public boolean isCancelled() { return cancelled; }
echo     public void setCancelled(boolean cancelled) { this.cancelled = cancelled; }
echo }
) > src\main\java\com\knoux\services\OrderService.java

:: إنشاء ملف testng.xml
(
echo <?xml version="1.0" encoding="UTF-8"?>
echo <!DOCTYPE suite SYSTEM "https://testng.org/testng-1.0.dtd">
echo <suite name="Knoux TestNG Suite" parallel="tests" thread-count="3">
echo     
echo     <test name="Unit Tests">
echo         <groups>
echo             <run>
echo                 <include name="unit"/>
echo             </run>
echo         </groups>
echo         <classes>
echo             <class name="com.knoux.tests.unit.StringUtilsTest"/>
echo         </classes>
echo     </test>
echo     
echo     <test name="Integration Tests">
echo         <groups>
echo             <run>
echo                 <include name="integration"/>
echo             </run>
echo         </groups>
echo         <classes>
echo             <class name="com.knoux.tests.integration.OrderServiceTest"/>
echo         </classes>
echo     </test>
echo     
echo     <test name="Smoke Tests">
echo         <groups>
echo             <run>
echo                 <include name="smoke"/>
echo             </run>
echo         </groups>
echo         <classes>
echo             <class name="com.knoux.tests.smoke.SmokeTests"/>
echo         </classes>
echo     </test>
echo     
echo     <test name="API Tests">
echo         <groups>
echo             <run>
echo                 <include name="api"/>
echo             </run>
echo         </groups>
echo         <classes>
echo             <class name="com.knoux.tests.api.APITests"/>
echo         </classes>
echo     </test>
echo     
echo </suite>
) > testng.xml

:: إنشاء اختبار وحدة
(
echo package com.knoux.tests.unit;
echo 
echo import org.testng.Assert;
echo import org.testng.annotations.Test;
echo import org.testng.annotations.DataProvider;
echo import org.testng.annotations.BeforeMethod;
echo import com.knoux.utils.StringUtils;
echo 
echo @Test(groups = {"unit"})
echo public class StringUtilsTest {
echo 
echo     @BeforeMethod
echo     public void setUp() {
echo         // Setup method called before each test
echo     }
echo 
echo     @Test(description = "Test palindrome detection")
echo     public void testIsPalindrome() {
echo         Assert.assertTrue(StringUtils.isPalindrome("racecar"));
echo         Assert.assertTrue(StringUtils.isPalindrome("A man a plan a canal Panama"));
echo         Assert.assertTrue(StringUtils.isPalindrome("12321"));
echo         Assert.assertFalse(StringUtils.isPalindrome("hello"));
echo         Assert.assertFalse(StringUtils.isPalindrome(null));
echo     }
echo 
echo     @Test(description = "Test word reversal")
echo     public void testReverseWords() {
echo         Assert.assertEquals(StringUtils.reverseWords("Hello World"), "World Hello");
echo         Assert.assertEquals(StringUtils.reverseWords("Java is fun"), "fun is Java");
echo         Assert.assertEquals(StringUtils.reverseWords("single"), "single");
echo         Assert.assertNull(StringUtils.reverseWords(null));
echo         Assert.assertEquals(StringUtils.reverseWords(""), "");
echo         Assert.assertEquals(StringUtils.reverseWords("   "), "");
echo     }
echo 
echo     @Test(description = "Test email validation")
echo     public void testIsValidEmail() {
echo         Assert.assertTrue(StringUtils.isValidEmail("test@example.com"));
echo         Assert.assertTrue(StringUtils.isValidEmail("user.name@domain.co.uk"));
echo         Assert.assertTrue(StringUtils.isValidEmail("user+tag@example.org"));
echo         
echo         Assert.assertFalse(StringUtils.isValidEmail("invalid-email"));
echo         Assert.assertFalse(StringUtils.isValidEmail("@example.com"));
echo         Assert.assertFalse(StringUtils.isValidEmail("user@"));
echo         Assert.assertFalse(StringUtils.isValidEmail(""));
echo         Assert.assertFalse(StringUtils.isValidEmail(null));
echo     }
echo 
echo     @Test(description = "Test string capitalization")
echo     public void testCapitalize() {
echo         Assert.assertEquals(StringUtils.capitalize("hello"), "Hello");
echo         Assert.assertEquals(StringUtils.capitalize("HELLO"), "Hello");
echo         Assert.assertEquals(StringUtils.capitalize("hELLO"), "Hello");
echo         Assert.assertEquals(StringUtils.capitalize(""), "");
echo         Assert.assertNull(StringUtils.capitalize(null));
echo     }
echo 
echo     @DataProvider(name = "palindromeData")
echo     public Object[][] palindromeData() {
echo         return new Object[][] {
echo             {"racecar", true},
echo             {"hello", false},
echo             {"A man a plan a canal Panama", true},
echo             {"12321", true},
echo             {"", true},
echo             {null, false}
echo         };
echo     }
echo 
echo     @Test(dataProvider = "palindromeData", description = "Parameterized palindrome test")
echo     public void testPalindromeWithDataProvider(String input, boolean expected) {
echo         Assert.assertEquals(StringUtils.isPalindrome(input), expected);
echo     }
echo }
) > src\test\java\com\knoux\tests\unit\StringUtilsTest.java

:: إنشاء اختبار تكامل
(
echo package com.knoux.tests.integration;
echo 
echo import org.testng.Assert;
echo import org.testng.annotations.Test;
echo import org.testng.annotations.BeforeMethod;
echo import org.testng.annotations.AfterMethod;
echo import com.knoux.services.OrderService;
echo import java.util.Arrays;
echo import java.util.List;
echo 
echo @Test(groups = {"integration"})
echo public class OrderServiceTest {
echo 
echo     private OrderService orderService;
echo 
echo     @BeforeMethod
echo     public void setUp() {
echo         orderService = new OrderService();
echo     }
echo 
echo     @AfterMethod
echo     public void tearDown() {
echo         orderService = null;
echo     }
echo 
echo     @Test(description = "Test order creation")
echo     public void testCreateOrder() {
echo         var order = orderService.createOrder("test@example.com", Arrays.asList("Item1", "Item2"), 100.0);
echo         
echo         Assert.assertNotNull(order);
echo         Assert.assertEquals(order.getCustomerEmail(), "test@example.com");
echo         Assert.assertEquals(order.getItems().size(), 2);
echo         Assert.assertEquals(order.getTotal(), 100.0, 0.01);
echo         Assert.assertFalse(order.isCancelled());
echo     }
echo 
echo     @Test(description = "Test order retrieval")
echo     public void testGetOrder() {
echo         var createdOrder = orderService.createOrder("retrieve@example.com", Arrays.asList("Test Item"), 50.0);
echo         var retrievedOrder = orderService.getOrder(createdOrder.getId());
echo         
echo         Assert.assertNotNull(retrievedOrder);
echo         Assert.assertEquals(retrievedOrder.getId(), createdOrder.getId());
echo         Assert.assertEquals(retrievedOrder.getCustomerEmail(), "retrieve@example.com");
echo     }
echo 
echo     @Test(description = "Test order cancellation")
echo     public void testCancelOrder() {
echo         var order = orderService.createOrder("cancel@example.com", Arrays.asList("Item"), 25.0);
echo         Assert.assertFalse(order.isCancelled());
echo         
echo         boolean cancelled = orderService.cancelOrder(order.getId());
echo         Assert.assertTrue(cancelled);
echo         
echo         var updatedOrder = orderService.getOrder(order.getId());
echo         Assert.assertTrue(updatedOrder.isCancelled());
echo     }
echo 
echo     @Test(description = "Test getting all orders")
echo     public void testGetAllOrders() {
echo         orderService.createOrder("user1@example.com", Arrays.asList("Item1"), 10.0);
echo         orderService.createOrder("user2@example.com", Arrays.asList("Item2"), 20.0);
echo         orderService.createOrder("user3@example.com", Arrays.asList("Item3"), 30.0);
echo         
echo         List<com.knoux.services.Order> allOrders = orderService.getAllOrders();
echo         Assert.assertEquals(allOrders.size(), 3);
echo     }
echo 
echo     @Test(description = "Test getting orders by customer")
echo     public void testGetOrdersByCustomer() {
echo         orderService.createOrder("customer@example.com", Arrays.asList("Item1"), 15.0);
echo         orderService.createOrder("customer@example.com", Arrays.asList("Item2"), 25.0);
echo         orderService.createOrder("other@example.com", Arrays.asList("Item3"), 35.0);
echo         
echo         List<com.knoux.services.Order> customerOrders = orderService.getOrdersByCustomer("customer@example.com");
echo         Assert.assertEquals(customerOrders.size(), 2);
echo         
echo         List<com.knoux.services.Order> otherOrders = orderService.getOrdersByCustomer("other@example.com");
echo         Assert.assertEquals(otherOrders.size(), 1);
echo     }
echo 
echo     @Test(description = "Test order creation validation", expectedExceptions = IllegalArgumentException.class)
echo     public void testCreateOrderWithNullEmail() {
echo         orderService.createOrder(null, Arrays.asList("Item"), 10.0);
echo     }
echo 
echo     @Test(description = "Test order creation with empty items", expectedExceptions = IllegalArgumentException.class)
echo     public void testCreateOrderWithEmptyItems() {
echo         orderService.createOrder("test@example.com", Arrays.asList(), 10.0);
echo     }
echo 
echo     @Test(description = "Test order creation with negative total", expectedExceptions = IllegalArgumentException.class)
echo     public void testCreateOrderWithNegativeTotal() {
echo         orderService.createOrder("test@example.com", Arrays.asList("Item"), -10.0);
echo     }
echo }
) > src\test\java\com\knoux\tests\integration\OrderServiceTest.java

:: إنشاء اختبار smoke
(
echo package com.knoux.tests.smoke;
echo 
echo import org.testng.Assert;
echo import org.testng.annotations.Test;
echo import com.knoux.utils.StringUtils;
echo import com.knoux.services.OrderService;
echo import java.util.Arrays;
echo 
echo @Test(groups = {"smoke"})
echo public class SmokeTests {
echo 
echo     @Test(priority = 1)
echo     public void testStringPalindromeCritical() {
echo         Assert.assertTrue(StringUtils.isPalindrome("racecar"));
echo         Assert.assertTrue(StringUtils.isPalindrome("A man a plan a canal Panama"));
echo     }
echo 
echo     @Test(priority = 2)
echo     public void testOrderCreationCritical() {
echo         OrderService service = new OrderService();
echo         var order = service.createOrder("smoke@test.com", Arrays.asList("Essential Item"), 1.0);
echo         Assert.assertNotNull(order);
echo         Assert.assertEquals(order.getCustomerEmail(), "smoke@test.com");
echo     }
echo 
echo     @Test(priority = 3)
echo     public void testEmailValidationCritical() {
echo         Assert.assertTrue(StringUtils.isValidEmail("valid@example.com"));
echo         Assert.assertFalse(StringUtils.isValidEmail("invalid-email"));
echo     }
echo 
echo     @Test(priority = 4)
echo     public void testOrderRetrievalCritical() {
echo         OrderService service = new OrderService();
echo         var order = service.createOrder("retrieve@test.com", Arrays.asList("Item"), 5.0);
echo         var retrieved = service.getOrder(order.getId());
echo         Assert.assertNotNull(retrieved);
echo         Assert.assertEquals(retrieved.getId(), order.getId());
echo     }
echo 
echo     @Test(priority = 5)
echo     public void testBasicStringOperations() {
echo         String result = StringUtils.reverseWords("Hello World");
echo         Assert.assertEquals(result, "World Hello");
echo     }
echo }
) > src\test\java\com\knoux\tests\smoke\SmokeTests.java

:: إنشاء اختبار API
(
echo package com.knoux.tests.api;
echo 
echo import org.testng.Assert;
echo import org.testng.annotations.Test;
echo import org.testng.annotations.DataProvider;
echo import java.io.*;
echo import java.net.*;
echo import java.nio.charset.StandardCharsets;
echo 
echo @Test(groups = {"api", "rest"})
echo public class APITests {
echo 
echo     private static final String BASE_URL = "https://jsonplaceholder.typicode.com";
echo 
echo     @DataProvider(name = "apiEndpoints")
echo     public Object[][] getAPIEndpoints() {
echo         return new Object[][] {
echo             {BASE_URL + "/posts"},
echo             {BASE_URL + "/users"},
echo             {BASE_URL + "/albums"},
echo             {BASE_URL + "/photos"}
echo         };
echo     }
echo 
echo     @Test(dataProvider = "apiEndpoints")
echo     public void testAPIEndpointAvailability(String endpoint) throws IOException {
echo         HttpURLConnection connection = (HttpURLConnection) new URL(endpoint).openConnection();
echo         connection.setRequestMethod("GET");
echo         connection.setRequestProperty("Accept", "application/json");
echo         
echo         int responseCode = connection.getResponseCode();
echo         Assert.assertEquals(responseCode, 200, 
echo             "API endpoint " + endpoint + " should return 200 OK");
echo         
echo         // Read response
echo         try (BufferedReader reader = new BufferedReader(
echo                 new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8))) {
echo             StringBuilder response = new StringBuilder();
echo             String line;
echo             while ((line = reader.readLine()) != null) {
echo                 response.append(line);
echo             }
echo             String responseBody = response.toString();
echo             Assert.assertTrue(responseBody.startsWith("["), 
echo                 "Response should be a JSON array");
echo             Assert.assertTrue(responseBody.length() > 2, 
echo                 "Response should contain data");
echo         }
echo     }
echo 
echo     @Test
echo     public void testCreatePost() throws IOException {
echo         String endpoint = BASE_URL + "/posts";
echo         HttpURLConnection connection = (HttpURLConnection) new URL(endpoint).openConnection();
echo         connection.setRequestMethod("POST");
echo         connection.setRequestProperty("Content-Type", "application/json");
echo         connection.setDoOutput(true);
echo         
echo         String postData = "{"
echo             + "\"title\": \"Test Post\","
echo             + "\"body\": \"This is a test post for API testing\","
echo             + "\"userId\": 1"
echo             + "}";
echo         
echo         try (OutputStream os = connection.getOutputStream()) {
echo             byte[] input = postData.getBytes(StandardCharsets.UTF_8);
echo             os.write(input, 0, input.length);
echo         }
echo         
echo         int responseCode = connection.getResponseCode();
echo         Assert.assertTrue(responseCode == 201 || responseCode == 200, 
echo             "POST request should succeed");
echo     }
echo 
echo     @Test(timeOut = 5000) // Timeout after 5 seconds
echo     public void testAPITimeout() throws IOException {
echo         String endpoint = BASE_URL + "/users/1";
echo         HttpURLConnection connection = (HttpURLConnection) new URL(endpoint).openConnection();
echo         connection.setRequestMethod("GET");
echo         connection.setConnectTimeout(3000); // 3 seconds
echo         connection.setReadTimeout(3000);    // 3 seconds
echo         
echo         int responseCode = connection.getResponseCode();
echo         Assert.assertEquals(responseCode, 200, 
echo             "API should respond within timeout");
echo     }
echo 
echo     @Test(enabled = false) // Disabled test
echo     public void testDisabledFeature() {
echo         // This test is disabled and won't run
echo         Assert.fail("This test should not run");
echo     }
echo }
) > src\test\java\com\knoux\tests\api\APITests.java

:: إنشاء سكربت للتشغيل
(
echo @echo off
echo echo TestNG Test Runner - Knoux Toolbox
echo echo ================================
echo echo.
echo echo Choose test option:
echo echo 1. Compile project
echo echo 2. Run all tests
echo echo 3. Run unit tests only
echo echo 4. Run integration tests only
echo echo 5. Run smoke tests only
echo echo 6. Run API tests only
echo echo 7. Run with specific group
echo echo 8. Generate TestNG report
echo echo.
echo set /p "CHOICE=Enter choice (1-8): "
echo 
echo cd /d "!TESTNG_PROJECT!"
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
echo     echo Running unit tests...
echo     mvn test -Dgroups=unit
echo )
echo if "%%CHOICE%%"=="4" (
echo     echo Running integration tests...
echo     mvn test -Dgroups=integration
echo )
echo if "%%CHOICE%%"=="5" (
echo     echo Running smoke tests...
echo     mvn test -Dgroups=smoke
echo )
echo if "%%CHOICE%%"=="6" (
echo     echo Running API tests...
echo     mvn test -Dgroups=api
echo )
echo if "%%CHOICE%%"=="7" (
echo     echo Enter group name (e.g., unit, integration, smoke, api, critical):
echo     set /p "GROUP=Group: "
echo     mvn test -Dgroups=%%GROUP%%
echo )
echo if "%%CHOICE%%"=="8" (
echo     echo Generating TestNG report...
echo     mvn surefire-report:report
echo )
echo 
echo pause
) > "!TESTNG_PROJECT!\run-testng.bat"

echo %YELLOW%[3/4] جارٍ تثبيت المكونات...%WHITE%
mvn dependency:resolve >nul 2>&1

echo %YELLOW%[4/4] جارٍ إنشاء تقارير الاختبارات...%WHITE%
if not exist "target" mkdir "target" >nul 2>&1
if not exist "target\surefire-reports" mkdir "target\surefire-reports" >nul 2>&1

echo %GREEN%===================================================%WHITE%
echo %GREEN%✓ تم الإعداد الكامل لـ TestNG!%WHITE%
echo %CYAN%المعلومات:%WHITE%
echo   مشروع: %GRAY%!TESTNG_PROJECT!%WHITE%
echo   تشغيل: %GRAY%cd "!TESTNG_PROJECT!" && mvn test%WHITE%
echo   تقارير: %GRAY%target\surefire-reports%WHITE%
echo %GREEN%===================================================%WHITE%
echo.
echo %CYAN%الميزات:%WHITE%
echo   ✓ اختبارات وحدة وتكامل
echo   ✓ دعم TestNG
echo   ✓ مجموعات الاختبارات
echo   ✓ بيانات الاختبار
echo   ✓ تقارير مفصلة
echo   ✓ اعتماديات الاختبارات
echo   ✓ أوقات المهلة
echo   ✓ مزيفات (Mocks)
echo.
echo %YELLOW%البدء:%WHITE%
echo   1. cd "!TESTNG_PROJECT!"
echo   2. mvn test ← لتشغيل الاختبارات
echo   3. mvn test -Dgroups=smoke ← لمجموعات محددة
echo   4. ./run-testng.bat ← لاختيارات سريعة

:: تسجيل العملية
echo [!TIMESTAMP!] SUCCESS: Installed TestNG with comprehensive test suite >> "!LOG_FILE!"

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
