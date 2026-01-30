@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
call "%~dp0..\..\..\resources\colors.bat"
set "LOG_FILE=%~dp0..\..\..\logs\operations.log"
set "TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,2%:%TIME:~3,2%:%TIME:~6,2%"

cls
echo %PURPLE%===================================================%WHITE%
echo %PURPLE%  🟣 GraphQL Playground - بيئة تطوير GraphQL%WHITE%
echo %PURPLE%===================================================%WHITE%
echo.

node -v >nul 2>&1 || (
    echo %RED%✗ Node.js غير مثبت%WHITE%
    timeout /t 3 >nul
    exit /b 1
)

:MENU
echo %CYAN%الخيارات:%WHITE%
echo   [1] تثبيت GraphQL Playground عالميًا
echo   [2] إنشاء مشروع GraphQL تجريبي
echo   [3] تثبيت VS Code Extension (GraphQL)
echo   [4] تثبيت Altair GraphQL Client
echo   [0] الخروج
echo.
set /p "CHOICE=اختر: "

if "!CHOICE!"=="0" exit /b 0
if "!CHOICE!"=="1" goto :INSTALL_PLAYGROUND
if "!CHOICE!"=="2" goto :CREATE_DEMO
if "!CHOICE!"=="3" goto :INSTALL_EXTENSION
if "!CHOICE!"=="4" goto :INSTALL_ALT
goto :MENU

:INSTALL_PLAYGROUND
echo %YELLOW%جارٍ تثبيت GraphQL Playground...%WHITE%
npm install -g graphql-playground-cli >nul 2>&1

if errorlevel 1 (
    echo %YELLOW%التنزيل من GitHub...%WHITE%
    npm install -g graphql-playground-electron >nul 2>&1
    if errorlevel 1 (
        echo %RED%✗ فشل التثبيت%WHITE%
        goto :MENU
    )
)

echo %GREEN%✓ تم التثبيت%WHITE%
echo %YELLOW%الاستخدام:%WHITE% graphql-playground-cli --endpoint=http://localhost:4000/graphql
goto :MENU

:CREATE_DEMO
set "GRAPHQL_PROJECT=%USERPROFILE%\graphql-demo"
if not exist "!GRAPHQL_PROJECT!" mkdir "!GRAPHQL_PROJECT!" >nul
cd /d "!GRAPHQL_PROJECT!"

(
echo {
echo   "name": "graphql-demo",
echo   "version": "1.0.0",
echo   "scripts": {
echo     "start": "nodemon server.js",
echo     "dev": "nodemon server.js"
echo   },
echo   "dependencies": {
echo     "apollo-server-express": "^3.12.0",
echo     "graphql": "^16.6.0",
echo     "express": "^4.18.2"
echo   },
echo   "devDependencies": {
echo     "nodemon": "^2.0.20"
echo   }
echo }
) > package.json

(
echo const { ApolloServer } = require('apollo-server-express');
echo const { readFileSync } = require('fs');
echo const express = require('express');
echo 
echo // Schema
echo const typeDefs = `
echo   type Query {
echo     hello: String
echo     users: [User]
echo   }
echo   
echo   type User {
echo     id: ID!
echo     name: String!
echo     email: String!
echo   }
echo `;
echo 
echo // Resolvers
echo const resolvers = {
echo   Query: {
echo     hello: () => 'مرحباً بك في GraphQL!',
echo     users: () => [
echo       { id: '1', name: 'محمد', email: 'mohammed@example.com' },
echo       { id: '2', name: 'فاطمة', email: 'fatima@example.com' }
echo     ]
echo   }
echo };
echo 
echo async function startServer() {
echo   const app = express();
echo   const server = new ApolloServer({ typeDefs, resolvers });
echo   await server.start();
echo   server.applyMiddleware({ app, path: '/graphql' });
echo   
echo   app.listen({ port: 4000 }, () =>
echo     console.log('🚀 Server ready at http://localhost:4000/graphql')
echo   );
echo }
echo 
echo startServer();
) > server.js

npm install >nul 2>&1

echo %GREEN%✓ تم إنشاء مشروع GraphQL تجريبي%WHITE%
echo %CYAN%التشغيل:%WHITE% cd "!GRAPHQL_PROJECT!" && npm start
echo %CYAN%الوصول:%WHITE% http://localhost:4000/graphql
goto :MENU

:INSTALL_EXTENSION
where code >nul 2>&1 || (
    echo %RED%✗ VS Code غير مثبت%WHITE%
    goto :MENU
)

echo %YELLOW%جارٍ تثبيت GraphQL Extension...%WHITE%
code --install-extension GraphQL.vscode-graphql >nul 2>&1
echo %GREEN%✓ تم التثبيت%WHITE%
goto :MENU

:INSTALL_ALT
echo %YELLOW%جارٍ تثبيت Altair GraphQL Client...%WHITE%
winget install -e --id AltairGraphQL.Altair --silent >nul 2>&1
echo %GREEN%✓ تم التثبيت%WHITE%
goto :MENU
