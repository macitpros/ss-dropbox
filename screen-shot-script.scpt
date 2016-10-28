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
		set the_named_file to strDate & "-" & strSerialNumber & ".png"
		
		-- Grab the Watchman URL of the Mac
		set the_wm_url to do shell script "awk '/<string>https/{ print $1}' /Library/MonitoringClient/ClientData/UnifiedStatus.plist"
		
		-- Create contents of the webloc file 
		set webloc_contents to "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>URL</key>" & the_wm_url & "
	</dict>
</plist>"
		-- take the screen shot
		do shell script "screencapture -C " & tempfolder & quoted form of the_named_file & " " & tempfolder & quoted form of the_named_file & "-1.png"
		set thesstosend to tempfolder & the_named_file
		
		-- format the screen shot to send for dropbox upload
		set thesstosend to "'" & "@" & thesstosend & "'"
		--return thesstosend
		
		-- create the final name of the webloc file
		set url_named_file to strSerialNumber & ".webloc"
		
		-- create an empty webloc file
		do shell script "touch " & tempfolder & url_named_file
		set webloc_file to (tempfolder) & url_named_file
		
		-- write the webloc file contents to the empty webloc file
		set logFile to open for access webloc_file with write permission
		write webloc_contents to logFile
		close access logFile
		
		-- format the webloc file for dropbox upload
		set webloc_file to "'" & "@" & webloc_file & "'"
		
		set slash to "\\"
		
		-- create the shell script to upload the screen shot to dropbox
		set shell_upload to "curl -X POST https://content.dropboxapi.com/2/files/upload " & slash & "
  --header 'Authorization: Bearer " & dropboxtoken & "' " & slash & "
  --header 'Content-Type: application/octet-stream' " & slash & "
  --header 'Dropbox-API-Arg: {\"path\":\"/ScreenShots/" & strSerialNumber & "/" & the_named_file & "\",\"mode\":{\".tag\":\"add\"},\"autorename\":true,\"mute\":false}' " & slash & "
 --data-binary " & thesstosend
		
		--  create the shell script to upload the webloc file to dropbox
		set shell_webloc_upload to "curl -X POST https://content.dropboxapi.com/2/files/upload " & slash & "
  --header 'Authorization: Bearer " & dropboxtoken & "' " & slash & "
  --header 'Content-Type: application/octet-stream' " & slash & "
  --header 'Dropbox-API-Arg: {\"path\":\"/ScreenShots/" & strSerialNumber & "/" & url_named_file & "\",\"mode\":{\".tag\":\"add\"},\"autorename\":true,\"mute\":false}' " & slash & "
 --data-binary " & webloc_file
		
		
		--Upload to Dropbox
		do shell script shell_upload
		do shell script shell_webloc_upload
		
	on error ErrorMsg number ErrorNum
		my DisplayErrorMsg(ErrorMsg, ErrorNum)
	end try
	
	## Let the client know it's done and if they want to send a message (becomes a small text file)
	-- create the final name of the message file
	set message_named_file to strDate & "-" & strSerialNumber & "_message.txt"
	
	display dialog "The screen shot was captured and sent. Did you want to send a short message too?" buttons {"Yes", "No"}
	if the button returned of the result is "Yes" then
		display dialog "What's your message?" & return & "Think Twitter length message, short and sweet." default answer ""
		set the the_message to the text returned of the result
		-- create an empty message file
		do shell script "touch " & tempfolder & message_named_file
		set message_file to (tempfolder) & message_named_file
		
		-- write the message file contents to the empty message file
		set logFile to open for access message_file with write permission
		write the_message to logFile
		close access logFile
		
		-- format the message file for dropbox upload
		set message_file to "'" & "@" & message_file & "'"
		
		--  create the shell script to upload the message file to dropbox
		set shell_message_upload to "curl -X POST https://content.dropboxapi.com/2/files/upload " & slash & "
  --header 'Authorization: Bearer " & dropboxtoken & "' " & slash & "
  --header 'Content-Type: application/octet-stream' " & slash & "
  --header 'Dropbox-API-Arg: {\"path\":\"/ScreenShots/" & strSerialNumber & "/" & message_named_file & "\",\"mode\":{\".tag\":\"add\"},\"autorename\":true,\"mute\":false}' " & slash & "
 --data-binary " & message_file
		
		--Upload message file to Dropbox
		do shell script shell_message_upload
	end if
	
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
