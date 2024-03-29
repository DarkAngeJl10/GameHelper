﻿#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
IniRead, HotkeyBottle, %config%, Bottle, Key
IniRead, The_VersionName, %config%, Bottle, Version
IniRead, CheckforUpdates, %config%, Bottle, CheckforUpdates


if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, Bottle, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, Bottle, CheckforUpdates
}

IniRead, HotkeyBottle, %config%, Bottle, Key
if (HotkeyBottle != "")
{
	Hotkey, %HotkeyBottle%, Start
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
				filedelete, Macros\Bottle.ahk
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/Bottle.ahk, Macros\Bottle.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("Macros\Bottle.ahk") ) 
				{
					msgbox, Bottle.ahk Download failed!
					ExitApp
				}
				IniWrite, %BottleVersion%, %config%, Bottle, Version
				Msgbox, Updating to latest version: %BottleVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run Macros\Bottle.ahk
			}
		}
	}
}

Process, Wait, PathOfExile_x64.exe, 0
PoEPID := ErrorLevel
if not PoEPID
{
	Process, Wait, PathOfExile.exe, 0
	PoEPID := ErrorLevel
	if not PoEPID
	{
		Process, Wait, PathOfExileSteam.exe, 0
		PoEPID := ErrorLevel
		if not PoEPID
		{
			MsgBox Процесс PathOfExile не найден, запустите игру а потом скрипт
			ExitApp
		}
	}
}
GroupAdd, POE, ahk_pid %PoEPID%
WinNotActive()

WinActive() 
{
	Suspend Off
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() 
{
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

Start:
{
	IniRead, Bottle15, %config%, SelectBootle, Bottle1-5
	IniRead, Bottle25, %config%, SelectBootle, Bottle2-5
	IniRead, Bottle35, %config%, SelectBootle, Bottle3-5
	IniRead, Bottle45, %config%, SelectBootle, Bottle4-5
	if (Bottle15 = 1)
	{
		ifWinNotActive ahk_group POE
		{
			Return
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
			Return
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
			Return
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
			Return
		}
		SendInput, {4}
		sleep, 20
		SendInput, {5}
	}
}
Return