��&cls
@echo off
:: Check if the script is run as Administrator
NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo This script requires Administrator privileges.
    echo Please Wait. Loading...
    goto runAsAdmin
) else (
    goto banner
)

:runAsAdmin
:: Re-launch the batch file as Administrator
set "batchFile=%~f0"
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c ""%batchFile%""", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit

:banner
chcp 65001 >nul
title Solara - Installer
color D
echo.
echo.
echo 				███████╗ ██████╗ ██╗      █████╗ ██████╗  █████╗ 
echo 				██╔════╝██╔═══██╗██║     ██╔══██╗██╔══██╗██╔══██╗
echo 				███████╗██║   ██║██║     ███████║██████╔╝███████║
echo 				╚════██║██║   ██║██║     ██╔══██║██╔══██╗██╔══██║
echo 				███████║╚██████╔╝███████╗██║  ██║██║  ██║██║  ██║
echo 				╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝                                             
echo.
echo 				[1] Install Solara
echo 				[2] Exit
echo.

:: Get user input
set /p choice= Enter your choice: 

if "%choice%"=="1" goto install
if "%choice%"=="2" goto exitScript

echo Invalid option. Please select 1 or 2.
pause
goto banner

:install
echo Installing Solara...
:: Define the SOLERA folder path inside Downloads
set "soleraFolder=%USERPROFILE%\Downloads\SOLERA"

:: Create the folder if it doesn't exist
if not exist "%soleraFolder%" mkdir "%soleraFolder%"

:: Define the download path inside SOLERA folder
set "downloadPath=%soleraFolder%\REPOTrainer_REVAMP.bat"

:: Check if the file already exists
if exist "%downloadPath%" (
    echo File already exists. Replacing it with a fresh version...
    del "%downloadPath%" 2>nul
)

:: Download the file from GitHub
curl -L -o "%downloadPath%" "https://raw.githubusercontent.com/qrexotwy/ZZPAWN/main/REPOTrainer_REVAMP.bat"

:: Check if the download was successful
if exist "%downloadPath%" (
    echo Installation complete! File saved in the downloads folder.
	echo DO NOT UNINSTALL THIS FILE. Solara will not work otherwise.
) else (
    echo Failed to download the file. Please check your internet connection.
)

pause
exit

:exitScript
echo Exiting...
pause
exit