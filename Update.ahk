#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, Update, Version
IniRead, CheckforUpdates, %config%, Update, CheckforUpdates
IniRead, The_VersionControl, %config%, Control, Version
IniRead, CheckforUpdatesControl, %config%, Control, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Update, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Update, CheckforUpdates
}

if (The_VersionControl == "ERROR" or The_VersionControl == "")
{
	IniWrite, 0, %config%, Control, Version
}

if (CheckforUpdatesControl == "ERROR" or CheckforUpdatesControl == "")
{
	IniWrite, 1, %config%, Control, CheckforUpdates
}

if (CheckforUpdates != 0)
{
	UpdateVersion := CheckVersion("Update")
	if (UpdateVersion != "") 
	{
		if (The_VersionName != UpdateVersion) 
		{
			Msgbox, 4, Update, Found a new version: %UpdateVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Update.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Update.ahk, Update.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Update.ahk") ) 
				{
					msgbox, Updaste.ahk Download failed!
					ExitApp
				}
				IniWrite, %UpdateVersion%, %config%, Update, Version
				Msgbox, Updating to latest version: %UpdateVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Update.ahk
			}
		}
	}
}


if (CheckforUpdatesControl != 0)
{
	ControlVersion := CheckVersion("Control")
	if (ControlVersion != "") 
	{
		if (The_VersionControl != ControlVersion) 
		{
			Msgbox, 4, Update, Found a new version: %ControlVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Control.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Control.ahk, Control.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Control.ahk") ) 
				{
					msgbox, Control.ahk Download failed!
					ExitApp
				}
				IniWrite, %ControlVersion%, %config%, Control, Version
				Msgbox, Updating to latest version: %ControlVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
			}
		}
	}
}