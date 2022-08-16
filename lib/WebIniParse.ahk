CheckVersion(Name)
{
	Endpoint := "https://raw.githubusercontent.com/DarkAngeJl10/GameHelper/main/version.ini"
	LatestAPI := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	LatestAPI.Open("GET", Endpoint, False)
	LatestAPI.Send()
	Text := LatestAPI.ResponseText
	Loop, parse, Text, `n`r
	{
		if(InStr(A_LoopField, Name))
		{
			Index = %A_Index%
			Index++
			Debug = %A_LoopField%
			Loop, parse, Text, `n`r
			{
				if (A_Index = Index)
				{
					version = %A_LoopField%
					version := StrReplace(version, "version=", "")
					return version
				}
			}
		}
	}
}