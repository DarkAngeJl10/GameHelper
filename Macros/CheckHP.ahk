#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Debug, %config%, CheckHP, Debug
IniRead, The_VersionName, %config%, CheckHP, Version
IniRead, CheckforUpdates, %config%, CheckHP, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (Debug == "ERROR" or Debug == "")
{
	Debug := 0
	IniWrite, %Debug%, %config%, CheckHP, Debug
}
if (The_VersionName == "ERROR" or The_VersionName == "")
{
	IniWrite, 0, %config%, CheckHP, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	IniWrite, 1, %config%, CheckHP, CheckforUpdates
}

if (CheckforUpdates != 0)
	{
	CheckHPVersion := CheckVersion("CheckHP")
	if (CheckHPVersion != "") 
		{
		if (The_VersionName != CheckHPVersion) 
			{
			Msgbox, 4, Update, Found a new version: %CheckHPVersion%`n`nWant to update?
			IfMsgBox Yes
				{
				filedelete, CheckHP.ahk
				IniWrite, %CheckHPVersion%, %config%, CheckHP, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/Macros/CheckHP.ahk, CheckHP.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("CheckHP.ahk") ) 
					{
					msgbox, CheckHP.ahk Download failed!
					ExitApp
					}
				Msgbox, Updating to latest version: %CheckHPVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run CheckHP.ahk
				}
			}
		}
	}

Gui,Color,Lime
Gui, -Caption +Toolwindow +AlwaysOnTop +LastFound
WinSet, Region, 0-0 W70 H70 E


Suspend On
GroupAdd POE, % "Path of Exile"
WinActive()
Return

WinActive() {
	Suspend Off
	Gui,Show, X87 Y980 W70 H70 NA
	WinGetTitle, winTitle, A
	WinGet, winProcessName, ProcessName, A
	sleep, 10
	WinWaitNotActive ahk_group POE
	{
		WinNotActive()
	}
}

WinNotActive() {
	Gui, Hide
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}

numpad1::
end::
	X = 115
	Y = 940
	PixelGetColor, color1, %X%, %Y%
	Loop,
		{
		IniRead, Debug, %config%, CheckHP, Debug
			{
			ifWinActive ahk_group POE
				{
				Gui, Hide
				Sleep, 50
				}
			Else
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			}
			
		PixelGetColor, color, %X%, %Y%
			if (Debug = 1)
			{
				if (color != color1)
				{
				ifWinNotActive ahk_group POE
					{
					Gui,Color,Lime
					Break
					}
				FileAppend, %color% `n, CheckHPDebug.ini
				sleep, 300
				}
			}
			if (color = 0x020102 or color = 0x020100 or color = 0x000000 or color = 0x060606)
			{
				
			}
			if (color != color1)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			Send {1}
			}
		}
		return
		
;F9::
		X = 115
		Y = 940
	;	Mousemove, %X%, %Y%
	;	MouseGetPos, MouseX, MouseY
		PixelGetColor, color, %X%, %Y%
		clipboard := color
	;	msgbox %color% , %X%, %Y%
	return
 
 
 

numpad4:: 
home::
	Reload