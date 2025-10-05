@echo off
set "params=%*"
cd /d "%~dp0" && ( 
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)


REM Install VitaPay service
sc.exe create VitaPay binPath= "%~dp0VitaPay.exe" start= auto

REM Check if the service was installed successfully
if %errorlevel% neq 0 (
    echo Service creation failed!
    exit /b %errorlevel%
)

echo VitaPay service installed and started successfully!
