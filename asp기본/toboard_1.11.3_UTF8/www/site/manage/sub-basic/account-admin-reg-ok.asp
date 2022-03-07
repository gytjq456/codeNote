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

If mode="reg" Then

	m_id = InsertText(Request("m_id"))
	m_pw = InsertText(Request("m_pw"))
	m_name = InsertText(Request("m_name"))
	m_email = InsertText(Request("m_email"))
	m_lev = Request("m_lev")
	m_sort = Request("m_sort")
	m_cell1 = Request("m_cell1")
	m_cell2 = Request("m_cell2")
	m_cell3 = Request("m_cell3")
	a_auth = Request("a_auth")

	'아이디 중복체크
	If IdDuplChk(m_id)=False Then
		Response.Write"<script>alert('현재 사용중인 아이디입니다.\n다른 아이디를 입력하세요.'); history.back();</script>"
		Response.End
	End If

	Sql = "INSERT INTO tbl_member("
	Sql = Sql & "m_lev, "
	Sql = Sql & "m_sort, "
	Sql = Sql & "m_id, "
	Sql = Sql & "m_name, "
	Sql = Sql & "m_pw, "
	Sql = Sql & "m_email, "
	Sql = Sql & "m_cell1, "
	Sql = Sql & "m_cell2, "
	Sql = Sql & "m_cell3, "
	Sql = Sql & "a_auth) VALUES('"
	Sql = Sql & m_lev & "', '"
	Sql = Sql & m_sort & "', '"
	Sql = Sql & m_id & "', '"
	Sql = Sql & m_name & "', '"
	Sql = Sql & AESEncrypt(m_pw, "webmoa") & "', '"
	'Sql = Sql & "dbo.fnGetStringToSha512('" & m_pw & "'), '"
	Sql = Sql & m_email & "', '"
	Sql = Sql & m_cell1 & "', '"
	Sql = Sql & m_cell2 & "', '"
	Sql = Sql & m_cell3 & "', '"
	Sql = Sql & a_auth & "')"
	'Response.write sql
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.');location.href='account-admin.asp';</script>"


ElseIf mode="mod" Then 

	m_id = InsertText(Request("m_id"))
	m_pw = InsertText(Request("m_pw"))
	m_name = InsertText(Request("m_name"))
	m_email = InsertText(Request("m_email"))
	m_lev = Request("m_lev")
	m_sort = Request("m_sort")
	m_cell1 = Request("m_cell1")
	m_cell2 = Request("m_cell2")
	m_cell3 = Request("m_cell3")
	a_auth = Request("a_auth")

	Sql = "UPDATE tbl_member SET "
	Sql = Sql & "m_lev='" & m_lev & "', "
	Sql = Sql & "m_sort='" & m_sort & "', "
	Sql = Sql & "m_name='" & m_name & "', "
	If m_pw<>"" Then Sql = Sql & "m_pw='" & AESEncrypt(m_pw, "webmoa") & "', "
	'If m_pw<>"" Then Sql = Sql & "m_pw=dbo.fnGetStringToSha512('" & m_pw & "'), "
	Sql = Sql & "m_email='" & m_email & "', "
	Sql = Sql & "m_cell1='" & m_cell1 & "', "
	Sql = Sql & "m_cell2='" & m_cell2 & "', "
	Sql = Sql & "m_cell3='" & m_cell3 & "', "
	Sql = Sql & "a_auth='" & a_auth & "', "
	Sql = Sql & "moddate=getdate() WHERE m_id='" & m_id & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='account-admin.asp';</script>"


ElseIf mode="del" Then 

	m_id = InsertText(Request("m_id"))

	Sql = "DELETE FROM tbl_member "
	Sql = Sql & " WHERE m_id='" & m_id & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제되었습니다.');location.href='account-admin.asp';</script>"

End If
%>