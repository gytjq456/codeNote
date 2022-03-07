<%
Function BASE64_KEY(ByVal Num,ByVal Flag)
	Const Key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	If UCase(FLAG) = "EN" Then 
		BASE64_KEY = Mid(Key,Num+1,1)
	ElseIf UCase(FLAG) = "DE" Then 
		BASE64_KEY = InStr(Key,Num)-1
	End If
End Function


Function BASE64_ENCODE(ByVal eSTR)
	Dim BinStr, Tmp, Padding
	ReDim ArrayStr(Len(eSTR))
	For i = 1 To Len(eStr)
		ArrayStr(i) = Int("&H" & Right("0000" & Hex(Asc(Mid(eStr,i,1))),4))
		Tmp = Empty
		Do While ArrayStr(i) > 0
        Tmp = Tmp & ArrayStr(i) Mod 2
        ArrayStr(i) = Int(ArrayStr(i) / 2)
		Loop

		If Len(Tmp) > 8 Then
			ArrayStr(i) = StrReverse(Tmp)
		Else
			ArrayStr(i) = Right("00000000" & StrReverse(Tmp),8)
		End If
		BinStr = BinStr & ArrayStr(i)
	Next
	Padding = Len(BinStr) Mod 3

	ReDim ArrayStr(Round(Len(BinStr)/6-1+0.49))

	For i = 0 To UBound(ArrayStr)
		ArrayStr(i) = Left(BinStr,6)
		If Len(BinStr) > 6 Then 
			BinStr = Right(BinStr,Len(BinStr)-6)
		End If
	Next

	If Len(ArrayStr(UBound(ArrayStr))) <> 6 Then 
		ArrayStr(UBound(ArrayStr)) = Left(ArrayStr(UBound(ArrayStr)) & "000000",6)
	End If
	
	For i = 0 To UBound(ArrayStr)
		BASE64_ENCODE = BASE64_ENCODE & BASE64_KEY(BinToDec(ArrayStr(i)),"EN")
	Next

	For i = 1 To Padding
		BASE64_ENCODE =  BASE64_ENCODE & "="
	Next

End Function


'2진수 -> 10진수  
Function BinToDec(strBin)  
    Dim lTot, ctr, nLen : lTot = 0
    nLen = Len(strBin)  
    For ctr = nLen - 1 To 1 Step -1  
        lTot = lTot + (2 * CInt(Mid(strBin, ctr, 1))) ^ (nLen - ctr)  
    Next  
    BinToDec = lTot + CInt(Mid(strBin, nLen, 1))  
End Function   


Function BASE64_DECODE(ByVal eStr)
	Dim tmp, binStr : binStr = Empty
	eStr = Replace(eStr,"=","")
	ReDim ArrayStr(Len(eStr))
	For i = 1 To Len(eStr)
		ArrayStr(i) = Mid(eStr,i,1)
		ArrayStr(i) = BASE64_KEY(ArrayStr(i),"DE")
		tmp = Empty
		Do While ArrayStr(i) > 0
        Tmp = Tmp & ArrayStr(i) Mod 2
        ArrayStr(i) = Int(ArrayStr(i) / 2)
		Loop
		binStr = binStr & Right("000000" & StrReverse(Tmp), 6)
	Next

	ReDim ArrayStr(Round(Len(BinStr)/8-1+0.49))
	For i = 0 To UBound(ArrayStr)
		ArrayStr(i) = Left(BinStr,8)
		If Len(BinStr) > 8 Then 
			BinStr = Right(BinStr,Len(BinStr)-8)
		End If
	Next	

	For I = 0 To UBound(ArrayStr)
		If ArrayStr(i) > 0 Then 
			If Asc(ArrayStr(i)) = 48 Then 
				BASE64_DECODE = BASE64_DECODE & Chr(BinToDec(ArrayStr(i)))
			Else
				BASE64_DECODE = BASE64_DECODE & Chr(BinToDec(ArrayStr(i)&ArrayStr(i+1)))
			i = i + 1
			End If
		End If
	Next
End Function

%>