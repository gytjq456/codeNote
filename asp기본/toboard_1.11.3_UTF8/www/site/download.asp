<%@CodePage = 65001%>
<% Response.CharSet = "utf-8" %>
<!--#include file="common/dbconn.asp" -->
<!--#include file="common/function.asp" -->
<%
'파일다운로드
fileName = Request("file")
bid = Request("bid")

Response.ContentType = "application/unknown"
Response.AddHeader "Content-Disposition","attachment; filename=" & Server.URLPathEncode(fileName)

Set Rs = Server.CreateObject("ADODB.Recordset")
Sql = "SELECT k_uploadfolder FROM tbl_board_id WHERE idx='" & bid & "'"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	upfolder = Rs(0)
End If
Rs.Close
Set Rs = Nothing

Set ObjStream = Server.CreateObject("ADODB.Stream")
	ObjStream.Open
	ObjStream.Type = 1
	downpath = Server.MapPath(upfolder)
	downfile = downpath & "\" & fileName
	ObjStream.LoadFromFile downfile
	Response.BinaryWrite ObjStream.Read 
Set ObjStream = Nothing

%> 
