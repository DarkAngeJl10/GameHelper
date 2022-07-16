#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, Control, Version

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.ini"
LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
LatestAPI.Open("GET", Endpoint, False)
LatestAPI.Send()
The_LatestVersion := WebIniParse(LatestAPI.ResponseText, "Control")
if (The_LatestVersion != "") 
{
	if (The_VersionName != The_LatestVersion) 
	{
		Msgbox, 4, Update, Found a new version: %The_LatestVersion%`n`nWant to update?
		IfMsgBox Yes
		{
			IniWrite, %The_LatestVersion%, %config%, Control, Version
			filedelete, Control.ahk
			sleep, 1000
			UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Control.ahk, Control.ahk
			Sleep 1000
			if(ErrorLevel || !FileExist("Control.ahk") ) 
			{
				msgbox, Control.ahk Download failed!
				ExitApp
			}
			Msgbox, Updating to latest version: %The_LatestVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
			ExitApp
		}
	}
}