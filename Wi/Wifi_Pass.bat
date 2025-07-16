@echo off
chcp 65001 >nul

:: Create/Clear the output file
echo  [93m[*] Listing saved Wi-Fi networks with passwords...  [0m
echo.

:: Get all Wi-Fi profile names
for /f "tokens=1,2 delims=:" %%a in ('netsh wlan show profiles ^| findstr "All User Profile"') do (
    set "ssid=%%b"
    call :show_password
)
cd ..
call Main.bat
pause
exit /b

:show_password
:: Remove leading spaces from SSID
set "ssid=%ssid:~1%"
>> wifi_passwords.txt echo SSID: %ssid%

:: Extract key content (password) from profile
for /f "tokens=2 delims=:" %%k in ('netsh wlan show profile name^="%ssid%" key^=clear ^| findstr "Key Content"') do (
    set "password=%%k"
    setlocal enabledelayedexpansion
    >> wifi_passwords.txt echo Password: !password:~1!
    endlocal
)

>> wifi_passwords.txt echo -------------------------------------
echo  [92m [+] WiFi - Pass Credentials Saved.  [0m
exit /b
