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

If mode="reg" Then

	m_lev = Request("m_lev")
	m_sort = InsertText(Request("m_sort"))
	m_memo = InsertText(Request("m_memo"))

	'등급명 중복 체크
	Set RsL = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT COUNT(*) FROM tbl_member_level WHERE m_sort='" & m_sort & "' "
	RsL.Open Sql, Dbcon, 1
	If RsL(0)>0 Then
		Response.Write "<script>alert('이미 존재하는 등급명입니다. 다른 이름으로 변경 해 주세요.'); history.back();</script>"
		Response.End
	End If
	RsL.Close
	Set RsL = Nothing


	Sql = "INSERT INTO tbl_member_level("
	Sql = Sql & "m_lev, "
	Sql = Sql & "m_sort, "
	Sql = Sql & "m_memo) VALUES("
	Sql = Sql & 	"'" & m_lev & "', "
	Sql = Sql & 	"N'" & m_sort & "', "
	Sql = Sql & 	"N'" & m_memo & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.'); location.href='member-level.asp';</script>"


ElseIf mode="mod" Then

	m_lev = Request("m_lev")
	m_sort = InsertText(Request("m_sort"))
	m_memo = InsertText(Request("m_memo"))

	'등급명 중복 체크
	Set RsL = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT COUNT(*) FROM tbl_member_level WHERE m_sort='" & m_sort & "' "
	RsL.Open Sql, Dbcon, 1
	If RsL(0)>1 Then
		Response.Write "<script>alert('이미 존재하는 등급명입니다. 다른 이름으로 변경 해 주세요.'); history.back();</script>"
		Response.End
	End If
	RsL.Close
	Set RsL = Nothing

	Sql = "UPDATE tbl_member_level SET "
	Sql = Sql & "m_lev='" & m_lev & "', "
	Sql = Sql & "m_sort=N'" & m_sort & "', "
	Sql = Sql & "m_memo=N'" & m_memo & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='member-level.asp';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_member_level WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='member-level.asp';</script>"


ElseIf mode="df" Then

	Sql = "UPDATE tbl_member_level SET m_default='0'; " & Chr(10) & Chr(13)
	Sql = Sql & "UPDATE tbl_member_level SET m_default='1' WHERE idx='" & idx & "'; "
	Dbcon.Execute Sql
	Response.Redirect "member-level.asp"

End If
%>