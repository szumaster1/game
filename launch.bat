@echo off
title server logs

set _JAVA_OPTIONS=

netstat -an | findstr "0.0.0.0:43595" > NUL
if %ERRORLEVEL% equ 0 ( 
  echo "Port 43595 is in use."
  pause
  exit
)

pushd %~dp0\game
  start /b %~dp0\jre\bin\java.exe -Xmx4G -Xmx4G -jar server.jar

:waitserver
  netstat -an | findstr "0.0.0.0:43595" > NUL
  if %ERRORLEVEL% equ 1 ( 
    echo Loading, please wait...
    timeout 2 > NUL
    goto waitserver
)
