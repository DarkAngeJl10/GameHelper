#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, Main, Version

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.ini"
LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
LatestAPI.Open("GET", Endpoint, False)
LatestAPI.Send()
The_LatestVersion := WebIniParse(LatestAPI.ResponseText, "Main")
if (The_LatestVersion != "") 
{
	if (The_VersionName != The_LatestVersion) 
	{
		Msgbox, 4, Update, Found a new version: %The_LatestVersion%`n`nWant to update?
		IfMsgBox Yes
		{
			IniWrite, %The_LatestVersion%, %config%, Main, Version
			filedelete, Main.ahk
			sleep, 1000
			UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Main.ahk, Main.ahk
			Sleep 1000
			if(ErrorLevel || !FileExist("Main.ahk") ) 
			{
				msgbox, Download failed!
				ExitApp
			}
			Msgbox, Updating to latest version: %The_LatestVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
			ExitApp
		}
	}
}