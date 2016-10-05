-- Start the script (double click)
on run
	my main()
end run

on main()
	try
		-- Change the variable dropboxtoken to your Drobpox Token:
		set dropboxtoken to "yourtokennumberhere"
		
		--create temporary folder to hold screenshots
		set tempfolder to "private/tmp/sstomitp/"
		set ssfolder to do shell script ("mkdir -p " & tempfolder)
		
		# get the serial number of the machine
		set strSerialNumber to do shell script "system_profiler SPHardwareDataType | awk '/Serial Number/ { print $4 }'"
		
		#get the date
		set strDate to do shell script "date \"+%Y-%m-%d--%H.%M.%S\""
		
		#create the final file name
		set the_named_file to "ScreenShot--" & strDate & "-" & strSerialNumber & ".png"
		
		do shell script "screencapture -C " & tempfolder & quoted form of the_named_file & " " & tempfolder & quoted form of the_named_file & "-1.png"
		set thesstosend to tempfolder & the_named_file
		--set thesstosend2 to tempfolder & the_named_file & "-1.png" as POSIX file
		--tell application "Finder" to open thesstosend
		--tell application "Finder" to open thesstosend2
		
		set thesstosend to "'" & "@" & thesstosend & "'"
		--return thesstosend
		
		set slash to "\\"
		
		set shell_upload to "curl -X POST https://content.dropboxapi.com/2/files/upload " & slash & "
  --header 'Authorization: Bearer " & dropboxtoken & "' " & slash & "
  --header 'Content-Type: application/octet-stream' " & slash & "
  --header 'Dropbox-API-Arg: {\"path\":\"/ScreenShots/" & the_named_file & "\",\"mode\":{\".tag\":\"add\"},\"autorename\":true,\"mute\":false}' " & slash & "
 --data-binary " & thesstosend
		
		--Upload to Dropbox
		do shell script shell_upload
		
	on error ErrorMsg number ErrorNum
		my DisplayErrorMsg(ErrorMsg, ErrorNum)
	end try
end main

# DisplayErrorMsg(ErrorMsg, ErrorNum)
# Displays to user an Error Message and Error Number passed to function

on DisplayErrorMsg(ErrorMsg, ErrorNum)
	set Msg to "Sorry, an error occured:" & return & return & ErrorMsg & " (" & ErrorNum & ")"
	tell me
		activate
		display dialog Msg buttons {"OK"} default button 1 with icon stop with title MyTitle
	end tell
end DisplayErrorMsg