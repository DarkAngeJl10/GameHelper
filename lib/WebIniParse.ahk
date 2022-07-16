WebIniParse(Text, Name)
{
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