<%@CodePage = 65001%>
<% Response.CharSet = "utf-8" %>
<%
'파일다운로드
upfolder = "/upload/prod/"
fileName = Request("file")

Response.ContentType = "application/unknown"
Response.AddHeader "Content-Disposition","attachment; filename=" & Server.URLPathEncode(fileName)

Set ObjStream = Server.CreateObject("ADODB.Stream")
	ObjStream.Open
	ObjStream.Type = 1
	downpath = Server.MapPath(upfolder)
	downfile = downpath & "\" & fileName
	ObjStream.LoadFromFile downfile
	Response.BinaryWrite ObjStream.Read 
Set ObjStream = Nothing

%> 
