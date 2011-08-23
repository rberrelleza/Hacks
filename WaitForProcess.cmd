@echo off
set loops=0
set process=%1

:WaitForProcessToStart
if /i %loops% gtr 10 (
  echo Process didn't started on time
  exit /b 1
)

set /a loops=loops+1
echo Waiting for %process% to start
tasklist | findstr %process% > nul
if "%ERRORLEVEL%"=="0" goto :ProcessStarted

REM Wait for 1 second between iterations
ping 1.1.1.1 -n 1 -w 5000 > nul
goto :WaitForProcessToStart

:ProcessStarted
echo Process started, waiting for 20 seconds
ping 1.1.1.1 -n 1 -w 20000 > nul
exit /b 0