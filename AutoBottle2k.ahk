#SingleInstance Force
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, AutoBottle 2k, Version
IniRead, CheckforUpdates, %config%, AutoBottle 2k, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	The_VersionName := 0
	IniWrite, %The_VersionName%, %config%, AutoBottle 2k, Version
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	CheckforUpdates := 1
	IniWrite, %CheckforUpdates%, %config%, AutoBottle 2k, CheckforUpdates
}

if (CheckforUpdates != 0) {
	Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.json"
	LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	LatestAPI.Open("GET", Endpoint, False)
	LatestAPI.Send()
	The_LatestVersion := LatestAPI.ResponseText
	
	if (The_LatestVersion != "") 
	{
		if (The_VersionName != The_LatestVersion) 
		{
			Msgbox, 4, Update, Found a new version: %The_LatestVersion%`n`nWant to update?
			IfMsgBox Yes
			{
				filedelete, AutoBottle 2k.ahk
				IniWrite, %The_LatestVersion%, %config%, AutoBottle 2k, Version
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/AutoBottle2k.ahk, AutoBottle 2k.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("AutoBottle 2k.ahk") ) 
				{
					msgbox, AutoBottle 2k.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %The_LatestVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
				run AutoBottle 2k.ahk
			}
		}
	}
}

Gui,Color,lime
Gui, -Caption +Toolwindow +AlwaysOnTop +LastFound
Gui,Show, X410 Y1286 W235 H12 NA
WinSet, Region, 0-0 W235 H12 


Suspend On
GroupAdd POE, % "Path of Exile"
WinActive()
Return

WinActive() {
	Suspend Off
	Gui,Show, X410 Y1286 W235 H12 NA
	WinGetTitle, winTitle, A
	WinGet, winProcessName, ProcessName, A
	sleep, 35
	
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


Numpad2::
	Loop,
		{
			{
			ifWinActive ahk_group POE
				{
				Gui, Hide
				Sleep, 100
				}
			Else
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			}
		PixelSearch, Px2, Py2, 477, 1424, 521, 1432, 0x99D7F9, 0, Fast
		PixelGetColor, color2, %Px2%, %Py2%
		if not (color2 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {2}
			}
		PixelSearch, Px3, Py3, 540, 1424, 584, 1432, 0x99D7F9, 0, Fast
		PixelGetColor, color3, %Px3%, %Py3%
		if not (color3 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {3}
			}
		PixelSearch, Px4, Py4, 604, 1424, 648, 1432, 0x99D7F9, 0, Fast
		PixelGetColor, color4, %Px4%, %Py4%
		if not (color4 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {4}
			}
		PixelSearch, Px5, Py5, 665, 1424, 709, 1432, 0x99D7F9, 0, Fast
		PixelGetColor, color5, %Px5%, %Py5%
		if not (color5 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {5}
			}
		}
		return
		
;F10::
	;	X = 155
	;	Y = 939
	;	Mousemove, 354, 1065
		MouseGetPos, MouseX, MouseY
		PixelGetColor, color, %MouseX%, %MouseY%
		msgbox %color% , %MouseX%, %MouseY%
	return
		

Numpad5::
	Reload