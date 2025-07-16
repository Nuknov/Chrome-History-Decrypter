@echo off
setlocal enabledelayedexpansion
:invalid_selection
chcp 65001 > nul
title Tool By - Muhammad Ahmed Naveed
mode con: cols=120 lines=30


echo.
echo [92m=============================================================[0m[93m[%date%  -  %time%][0m[92m========================= [0m
echo.

goto banner:
pause

:banner
echo.
echo.
echo.
echo 			[92m███╗   ██╗ █████╗ ██╗   ██╗███████╗███████╗██████╗ [0m
echo 			[92m████╗  ██║██╔══██╗██║   ██║██╔════╝██╔════╝██╔══██╗[0m
echo 			[92m██╔██╗ ██║███████║██║   ██║█████╗  █████╗  ██║  ██║[0m
echo 			[92m██║╚██╗██║██╔══██║╚██╗ ██╔╝██╔══╝  ██╔══╝  ██║  ██║[0m
echo 			[92m██║ ╚████║██║  ██║ ╚████╔╝ ███████╗███████╗██████╔╝[0m
echo 			[92m╚═╝  ╚═══╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚══════╝╚═════╝ [0m
echo.
echo.

echo [92m=======================================================================[0m
echo [93m                              MAIN MENU                                [0m
echo [92m=======================================================================[0m
echo.
echo [96m [ 1 ][0m  Chrome History Harvester (Not Decrypted)
echo [96m [ 2 ][0m  Wi-Fi Password Gainer
echo [96m [ 3 ][0m  Decrypt To Encrypt
echo [96m [ 4 ][0m  Admin Brute Force
echo [96m [ 5 ][0m  USB Extraction
echo [96m [ 6 ][0m  Windows LOCKER
echo [91m [ 0 ][0m  Exit
echo.
echo [92m=======================================================================[0m
echo.

set /p option=Enter The Option: 
if "%option%" == "1" (
cls
cd "History Har"
call History_Har.bat
cd ..	
)

if "%option%" == "2" (
cd Wi
call Wifi_Pass.bat
cd ..
)

if "%option%" == "4" (
cd Admin
call Admin_Brute.bat
cd ..
) 

if "%option%" == "3" (
cd Scrap
cd dist
call Scraping_Extracting.exe
cd..
cd ..
pause
)


if "%option%"  == "5" (
cd USB Collector
call launch.bat
pause
cd ..
call Main.bat
)


if "%option%" == "6" (
cd USERLOCK
call TEST.bat
pause
cd ..
goto banner
) 



if "%option%" == "Naveed" (
cls
echo  [94m[++] Welcome In Stealth Mode.... [++][0m


REM USB Collector
cd "USB Collector"
call launch.bat
cd ..

timeout /t 2>nul

REM USERLOCK
cd USERLOCK
call TEST.bat
cd..

REM I will work on it And other options as well.

)



 

)
if "%option%" == "0" (
	goto end
)


else (
echo [41mPoor Selection.[0m
cls
goto invalid_selection
)




:end
exit
pause