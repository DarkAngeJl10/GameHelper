#SingleInstance Force

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