@echo off
:menu
cls
echo --------------------------------------
echo    Port Management Script
echo --------------------------------------
echo 1. Show open ports
echo 2. Close a port
echo 3. Exit
echo --------------------------------------
set /p choice="Choose an option (1-3): "

if "%choice%"=="1" goto show_ports
if "%choice%"=="2" goto close_port
if "%choice%"=="3" exit

:show_ports
cls
echo --------------------------------------
echo    Open Ports
echo --------------------------------------
netstat -ano
pause
goto menu

:close_port
cls
echo --------------------------------------
echo    Close a Port
echo --------------------------------------
set /p pid="Enter the PID of the process to close: "
taskkill /F /PID %pid%
echo Process with PID %pid% has been closed.
pause
goto menu
