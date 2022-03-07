<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
Function SaveToBase64 (base64String)
    Set Doc = Server.CreateObject("MSXML2.ServerXMLHTTP.6.0")
    Set nodeB64 = Doc.CreateElement("b64")
    nodeB64.DataType = "bin.base64"
    nodeB64.Text = Mid(base64String, InStr(base64String, ",") + 1)

    set bStream = server.CreateObject("ADODB.stream")
    bStream.type =  1
    call bStream.Open()
    call bStream.Write( nodeB64.NodeTypedValue )
    call bStream.SaveToFile(Server.MapPath("/upload/sign/1.png"), 2)
    call bStream.close()
    set bStream = nothing
end Function

Function BytesToStr(bytes)
    Set Stream = Server.CreateObject("Adodb.Stream")
		Stream.Type = 1 'adTypeBinary
		call Stream.Open
		Stream.Write bytes
		Stream.Position = 0
		Stream.Type = 2 'adTypeText
		Stream.Charset = "iso-8859-1"
		BytesToStr = Stream.ReadText
		call Stream.Close
    Set Stream = Nothing
End Function

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
	lngBytesCount = Request.TotalBytes
	'base64String =Request("output")

	SaveToBase64(BytesToStr(Request.BinaryRead(lngBytesCount)))
End If
%>