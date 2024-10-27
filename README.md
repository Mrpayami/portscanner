# portscanner
## Portscanner netwinos
## Run code in Windows+R run mode and Type port-sc in NetWinOS

### https://netwinos.com
![Screenshot 2024-10-27 202547](https://github.com/user-attachments/assets/f540662a-cfde-4315-a3af-5b4b74d6a857)

This is a Windows Batch script that provides a simple menu interface for managing network ports. Below is a breakdown of its components and functionalities:

### Overview of the Script

1. **Menu Display**:
   - The script starts by presenting a menu with three options: 
     1. Show open ports
     2. Close a port using a PID (Process ID)
     3. Exit

2. **User Input**:
   - The user is prompted to select an option by entering a number (1-3).

3. **Option Handling**:
   - Depending on the user’s choice:
     - **Option 1**: Calls the `show_ports` label to display current open ports.
     - **Option 2**: Calls the `close_port` label to close the process associated with a given PID.
     - **Option 3**: Exits the script.

4. **Showing Open Ports**:
   - When the user selects option 1, the script clears the screen, invokes the `netstat -ano` command, which lists all open ports along with their associated PIDs. After displaying the information, it pauses until the user presses a key.

5. **Closing a Port**:
   - For option 2, the script prompts the user to enter a PID. It then executes the `taskkill /F /PID %pid%` command to forcibly terminate the process associated with the specified PID. After attempting to close the process, it notifies the user and returns to the main menu.

### Recommendations for Improvement

1. **Error Handling**:
   - Consider adding checks to ensure that the user inputs a valid PID.
   - Provide error messages if the `taskkill` command fails (for instance, if the PID does not exist).

2. **Confirmation Before Closing**:
   - It might be a good idea to ask for confirmation before forcibly closing a process to prevent accidental terminations.

3. **Enhanced User Experience**:
   - Including more detailed information about processes (like the process name) when showing open ports can help users make better decisions.

4. **Export Functionality**:
   - An option to export the list of current open ports to a text file may be convenient for auditing or logging purposes.

### Complete Script With Improvements

Here's a modified version with basic error handling and confirmation:

```batch
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
goto menu

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
tasklist | findstr /C:"%pid%" >nul
if errorlevel 1 (
    echo PID %pid% not found. Please check and try again.
    pause
    goto menu
)

set /p confirm="Are you sure you want to close the process with PID %pid%? (Y/N): "
if /I "%confirm%"=="Y" (
    taskkill /F /PID %pid%
    echo Process with PID %pid% has been closed.
) else (
    echo Process closure cancelled.
)
pause
goto menu
```

This enhanced script prevents accidental closing of processes and informs users if the PID they entered does not exist.
