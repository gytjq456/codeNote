<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<%
mode = Request("mode")
bid = Request("bid")
idx = Request("idx")
num = Request("num")

'위로 이동
If mode="up" Then 

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 idx, num FROM tbl_board_data WHERE board_idx='" & bid & "' AND num>" & num & " AND notice='0' "
	Sql = Sql & " ORDER BY num ASC"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		tg_idx = Rs("idx")
		tg_num = Rs("num")
		Sql = "UPDATE tbl_board_data SET num='" & num & "', p_num='" & num & "' WHERE idx='" & tg_idx & "';" & Chr(13) & Chr(10)
		Sql = Sql & "UPDATE tbl_board_data SET num='" & tg_num & "', p_num='" & tg_num & "' WHERE idx='" & idx & "' AND notice='0' "
		Dbcon.Execute Sql
	End If

	Response.Redirect Request.Servervariables("HTTP_REFERER")


'아래로 이동
ElseIf mode="down" Then 

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 idx, num FROM tbl_board_data WHERE board_idx='" & bid & "' AND num<" & num & " AND notice='0' "
	Sql = Sql & " ORDER BY num DESC"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		tg_idx = Rs("idx")
		tg_num = Rs("num")
		Sql = "UPDATE tbl_board_data SET num='" & num & "', p_num='" & num & "' WHERE idx='" & tg_idx & "';" & Chr(13) & Chr(10)
		Sql = Sql & "UPDATE tbl_board_data SET num='" & tg_num & "', p_num='" & tg_num & "' WHERE idx='" & idx & "' AND notice='0' "
		Dbcon.Execute Sql
	End If

	Response.Redirect Request.Servervariables("HTTP_REFERER")

End If
%>