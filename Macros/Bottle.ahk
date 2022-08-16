#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
IniRead, The_VersionName, %config%, Bottle 1-5, Version
IniRead, CheckforUpdates, %config%, Bottle 1-5, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Bottle 1-5, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Bottle 1-5, CheckforUpdates
}

if (CheckforUpdates != 0)
	{
	BottleVersion := CheckVersion("Bottle")
	if (BottleVersion != "") 
	{
		if (The_VersionName != BottleVersion) 
		{
			Msgbox, 4, Update, Found a new version: %BottleVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, Bottle.ahk
				IniWrite, %BottleVersion%, %config%, Bottle, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Bottle.ahk, Bottle.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Bottle.ahk") ) 
				{
					msgbox, Bottle 1-5.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %BottleVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Bottle.ahk
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

XButton1::
IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
	{
	if (Bottle15 = 1)
		{
		ifWinNotActive ahk_group POE
			{
			return
			}
		SendInput, {1}
		sleep, 20
		SendInput, {2}
		sleep, 20
		SendInput, {3}
		sleep, 20
		SendInput, {4}
		sleep, 20
		SendInput, {5}
		}
	if (Bottle25 = 1)
		{
		ifWinNotActive ahk_group POE
			{
			return
			}
		SendInput, {2}
		sleep, 20
		SendInput, {3}
		sleep, 20
		SendInput, {4}
		sleep, 20
		SendInput, {5}
		}
	if (Bottle35 = 1)
		{
		ifWinNotActive ahk_group POE
			{
			return
			}
		SendInput, {3}
		sleep, 20
		SendInput, {4}
		sleep, 20
		SendInput, {5}
		}
	if (Bottle45 = 1)
		{
		ifWinNotActive ahk_group POE
			{
			return
			}
		SendInput, {4}
		sleep, 20
		SendInput, {5}
		}
	}
return