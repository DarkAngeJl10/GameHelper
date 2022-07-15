#SingleInstance Force

Gui,Color,lime
Gui, -Caption +Toolwindow +AlwaysOnTop +LastFound
WinSet, Region, 0-0 W235 H12 



Suspend On
GroupAdd POE, % "Path of Exile"
WinNotActive()
Return

WinActive() {
	Suspend Off
	Gui,Show, X302 Y962 W235 H12 NA
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
	SetTimer, VaalBootleAndSkills, 	Off
	Suspend on
	WinWaitActive ahk_group POE
	{
		WinActive()
	}
}
XButton2::
	;send,{numpad1}
	send,{numpad2}
	return

numpad1::
VaalBootleAndSkills:
	{
	ifWinNotActive ahk_group POE
		{
		Return
		}	
		
	Send, {1}
	sleep, 150
	Send, {e}
	sleep, 150
	Send, {r}
	sleep, 150
	Send, {t}
	sleep, 150

	SetTimer, VaalBootleAndSkills, 14200
	}
	return
	
$capslock::
	ifWinNotActive ahk_group POE
		{
		Return
		}
	Send, {r}
	Send, {r}
	sleep, 50
	Send, {t}
	sleep, 50
	return

numpad2::
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
				}
			}
			
		sleep, 100
		
		PixelSearch, Px1, Py1, 314, 1065, 344, 1075, 0x99D7F9, 0, Fast
		PixelSearch, Px1, Py1, 314, 1065, 344, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color1, %Px1%, %Py1%
		if not (color1 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				Break
				}
			sleep, 50
			Send {1}
			}
		PixelSearch, Px2, Py2, 355, 1065, 395, 1075, 0x99D7F9, 0, Fast
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
		PixelSearch, Px3, Py3, 403, 1065, 440, 1075, 0x99D7F9, 0, Fast
		PixelGetColor, color3, %Px3%, %Py3%
		if not (color3 = 0x99D7F9)
			{
			ifWinNotActive ahk_group POE
				{
				Gui,Color,Lime
				return
				}
			sleep, 50
			Send {3}
			}
		PixelSearch, Px4, Py4, 452, 1065, 490, 1075, 0x99D7F9, 0, Fast
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
		PixelSearch, Px5, Py5, 500, 1065, 540, 1075, 0x99D7F9, 0, Fast
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
		
;F8::
		X = 309
		Y = 117
	;	Mousemove, %X%, %Y%
	;	MouseGetPos, MouseX, MouseY
		PixelGetColor, color, %X%, %Y%
	;	PixelGetColor, color, %MouseX%, %MouseY%
		clipboard := color
	;	msgbox %color% , %MouseX%, %MouseY%
	return

numpad5::
XButton1::
	SetTimer, VaalBootleAndSkills, 	Off
	Reload