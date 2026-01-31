@echo off
setlocal enabledelayedexpansion
:invalid_selection
chcp 65001 > nul
title Tool By - Nuknov
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
echo 		 [92m███╗   ██╗██╗   ██╗██╗  ██╗███╗   ██╗ ██████╗ ██╗   ██╗[0m
echo 		 [92m████╗  ██║██║   ██║██║ ██╔╝████╗  ██║██╔═══██╗██║   ██║[0m
echo		         [92m██╔██╗ ██║██║   ██║█████╔╝ ██╔██╗ ██║██║   ██║██║   ██║[0m
echo 		 [92m██║╚██╗██║██║   ██║██╔═██╗ ██║╚██╗██║██║   ██║██║   ██║[0m
echo 		 [92m██║ ╚████║╚██████╔╝██║  ██╗██║ ╚████║╚██████╔╝╚██████╔╝[0m
echo 		 [92m╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ [0m
echo.
echo.

echo [92m=======================================================================[0m
echo [93m                              MAIN MENU                                [0m
echo [92m=======================================================================[0m
echo.
echo [96m [ 1 ][0m  Chrome History Harvester (Not Decrypted)
echo [96m [ 2 ][0m  Wi-Fi Password Gainer
echo [96m [ 3 ][0m  Decrypt To Encrypt
echo [96m [ 4 ][0m  Windows LOCKER
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

if "%option%" == "3" (
cd Scrap
cd dist
call Scraping_Extracting.exe
cd..
cd ..
pause
)


if "%option%" == "4" (
cd USERLOCK
call TEST.bat
pause
cd ..
goto banner
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
