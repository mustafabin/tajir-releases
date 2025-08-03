@echo off
set "params=%*"
cd /d "%~dp0" && ( 
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

@echo off
REM Unzip VitaPay.zip using tar
echo Extracting VitaPay.zip...
tar -xf %~dp0VitaPay.zip -C %~dp0
if %errorlevel% neq 0 (
    echo Extraction failed!
    exit /b %errorlevel%
)

REM Install dsiEMVUS-Install.exe
if exist "%~dp0dsiEMVUS-Install.exe" (
    echo Installing dsiEMVUS-Install.exe...
    start /wait "" "%~dp0dsiEMVUS-Install.exe"
    if %errorlevel% neq 0 (
        echo dsiEMVUS-Install.exe installation failed!
        exit /b %errorlevel%
    )
) else (
    echo dsiEMVUS-Install.exe not found!
    exit /b 1
)

REM Install dsiEMVUS-Install.exe
if exist "%~dp0NETePay-Director-Manager-Install.exe" (
    echo Installing dsiEMVUS-Install.exe...
    start /wait "" "%~dp0NETePay-Director-Manager-Install.exe"
    if %errorlevel% neq 0 (
        echo NETePay-Director-Manager-Install.exe installation failed!
        exit /b %errorlevel%
    )
) else (
    echo dsiEMVUS-Install.exe not found!
    exit /b 1
)
REM Install VitaPay service
sc.exe create VitaPay binPath= "%~dp0VitaPay.exe" start= auto

REM Check if the service was installed successfully
if %errorlevel% neq 0 (
    echo Service creation failed!
    exit /b %errorlevel%
)

echo VitaPay service installed and started successfully!
