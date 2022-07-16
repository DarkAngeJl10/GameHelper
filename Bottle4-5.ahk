#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, Bottle 4-5, Version
IniRead, CheckforUpdates, %config%, Bottle 4-5, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	The_VersionName := 0
	IniWrite, %The_VersionName%, %config%, Bottle 4-5, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	CheckforUpdates := 1
	IniWrite, %CheckforUpdates%, %config%, Bottle 4-5, CheckforUpdates
}

if (CheckforUpdates != 0) {
	Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.ini"
	LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	LatestAPI.Open("GET", Endpoint, False)
	LatestAPI.Send()
	The_LatestVersion := WebIniParse(LatestAPI.ResponseText, "Bottle 3-5")
	
	if (The_LatestVersion != "") 
	{
		if (The_VersionName != The_LatestVersion) 
		{
			Msgbox, 4, Update, Found a new version: %The_LatestVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Bottle 4-5.ahk
				IniWrite, %The_LatestVersion%, %config%, Bottle 4-5, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle4-5.ahk, Bottle 4-5.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Bottle 4-5.ahk") ) 
				{
					msgbox, Bottle 4-5.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %The_LatestVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Bottle 4-5.ahk
			}
		}
	}
}


Suspend On
GroupAdd POE, % "Path of Exile"
WinNotActive()
Return

WinActive() {
	Suspend Off
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() {
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

Xbutton2::
ifWinNotActive ahk_group POE
  BlockInput On
  SendInput, {4}
  sleep, 20
  SendInput, {5}
  BlockInput Off
return