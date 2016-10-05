-- Change the variable dropboxtoken to your Drobpox Token:
set dropboxtoken to "yourtokennumberhere"

--create temporary folder to hold screenshots
set tempfolder to "private/tmp/sstomitp/"
set ssfolder to do shell script ("mkdir -p " & tempfolder)

set the_named_file to "ScreenShot--" & (do shell script "date \"+%Y-%m-%d--%H.%M.%S\"") & ".png"
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
