<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp"-->
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")
idx = Request("idx")

pLink = "s_keyword=" & s_keyword

'등록
If mode="reg" Then

	e_title=InsertText(Request("e_title"))
	e_content=InsertText(Request("e_content"))

	'db쿼리
	Sql = "INSERT INTO tbl_ebook("
	Sql = Sql & "e_title, "
	Sql = Sql & "e_content) VALUES("
	Sql = Sql & "N'" & e_title & "', "
	Sql = Sql & "N'" & e_content & "')"
	'response.write Sql
	Dbcon.Execute Sql

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 idx FROM tbl_ebook ORDER BY idx DESC "
	Rs.Open Sql, Dbcon, 1
		idx=Rs(0)
	Rs.Close
	Set Rs = Nothing

	Response.Write "<script>alert('등록 되었습니다. 이미지를 등록하세요.'); location.href='ebook-reg.asp?mode=mod&idx=" & idx & "';</script>"


'수정
ElseIf mode="mod" Then

	e_title=InsertText(Request("e_title"))
	e_content=InsertText(Request("e_content"))

	'db쿼리
	Sql = "UPDATE tbl_ebook SET "
	Sql = Sql & "e_title=N'" & e_title & "', "
	Sql = Sql & "e_content=N'" & e_content & "' "
	Sql = Sql & " WHERE idx='" & idx & "' "

	'response.write Sql
	Dbcon.Execute Sql
	Response.Write "<script>alert('수정 되었습니다.'); location.href='ebook.asp?" & pLink & "&page=" & page & "';</script>"


'삭제
ElseIf mode="del" Then

	'db쿼리
	Sql = "DELETE FROM tbl_ebook WHERE idx='" & idx & "';" & Chr(10) & Chr(10)
	Dbcon.Execute Sql
	Response.Write "<script>alert('삭제 되었습니다.'); location.href='ebook.asp?" & pLink & "&page=" & page & "';</script>"


End If
%>