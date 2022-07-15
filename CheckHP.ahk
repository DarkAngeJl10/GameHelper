#SingleInstance Force
config = %A_WorkingDir%\Data\Settings.ini

IniRead, The_VersionName, %config%, CheckHP, VersionCheckHP
IniRead, CheckforUpdates, %config%, CheckHP, CheckforUpdates

IfNotExist,  %A_WorkingDir%\Data
{
	FileCreateDir,  %A_WorkingDir%\Data
}

if (The_VersionName == "ERROR" or The_VersionName == "")
{
	The_VersionName := 0
	IniWrite, %The_VersionName%, %config%, CheckHP, VersionCheckHP
}
if (CheckforUpdates == "ERROR" or CheckforUpdates == "")
{
	CheckforUpdates := 1
	IniWrite, %CheckforUpdates%, %config%, CheckHP, CheckforUpdates
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
				filedelete, CheckHP.ahk
				IniWrite, %The_LatestVersion%, %config%, CheckHP, VersionCheckHP
				UrlDownloadToFile, https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/CheckHP.ahk, CheckHP.ahk
				Sleep, 1000
				if(ErrorLevel || !FileExist("CheckHP.ahk") ) 
				{
					msgbox, CheckHP.ahk Download failed!
					ExitApp
				}
				Msgbox, Updating to latest version: %The_LatestVersion%`n`nCheck your ...\Data\Settings.ini if you do not want to update automatically.
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

t := 0

;\::
	t += 1
	if (t > 1)
		{
		t := 0
		}
	return


numpad1::
end::
	X = 115
	Y = 940
	PixelGetColor, color1, %X%, %Y%
	Loop,
		{
		
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
			if (t = 1)
			{
			if not (color = color1)
				{
				ifWinNotActive ahk_group POE
					{
					Gui,Color,Lime
					Break
					}
				FileAppend, %color% `n, CheckHPDebug.txt
				sleep, 300
				}
			}
		
			else if (color = 0x020102)
			{}
			
			else if (color = 0x020100)
			{}
			
			else if (color = 0x000000)
			{}
			
			else if (color = 0x060606)
			{}
			
			else if not (color = color1)
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