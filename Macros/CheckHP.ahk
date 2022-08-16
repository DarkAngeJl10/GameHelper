#SingleInstance Force
#Include lib\WebIniParse.ahk
config = %A_WorkingDir%\Data\Settings.ini

IniRead, Debug, %config%, CheckHP, Debug
IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
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
WinNotActive()
Return

WinActive() {
	Suspend Off
	Gui,Show, X90 Y1000 W70 H70 NA
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
	IniRead, CheckHP70, %config%, SelectCheckHP, CheckHP70
	IniRead, CheckHP48, %config%, SelectCheckHP, CheckHP48
	IniRead, CheckHP30, %config%, SelectCheckHP, CheckHP30
	
	if (CheckHP70 = 1)
		{
		X := 109
		Y := 924
		}
	
	if (CheckHP48 = 1)
		{
		X := 118
		Y := 980
		}	
	
	if (CheckHP30 = 1)
		{
		X := 118
		Y := 1013
		}
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
		sleep, 100
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
		
;PgUp::							;Отладка всего макроса (по дефолту выключено)
	SwithDebug += 1
	if (SwithDebug = 3)
		{
		SwithDebug -= 2
		}
	if (SwithDebug = 1)
		{
		tooltip, Режим работы Дебаг Координаты, 1825, 1010
		}
	if (SwithDebug = 2)
		{
		tooltip, Режим работы Дебаг Цвет, 1825, 1010
		}
	SetTimer, RemoveToolTip, -10000
	return
	RemoveToolTip:
	tooltip
	return
	
;PgDn::							;Отладка всего макроса (по дефолту выключено)
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	if (SwithDebug = 1)
		{
		clipboard = %MouseX%, %MouseY% 
		}
	if (SwithDebug = 2)
		{
		clipboard := color
		}
	return	
 
 

numpad4:: 
home::
	Reload