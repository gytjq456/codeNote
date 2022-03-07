<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/aes.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<%
mode = Request("mode")
m_id = LCase(Request("m_id"))
m_pw = LCase(Request("m_pw"))

'로그인
If mode="in" Then
	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' AND m_lev<10"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF then
		Response.Write "<script>alert('아이디와 비밀번호가 올바르지 않습니다.');history.back();</script>"
		Response.End
	End If

	Response.Cookies("W_ID")=m_id
	Response.Cookies("W_NAME")=Rs("m_name")
	Response.Cookies("W_PW")=m_pw
	Response.Cookies("W_EMAIL")=Rs("m_email")
	Response.Cookies("W_LEVEL")=Rs("m_lev")

	Sql = "UPDATE tbl_member SET m_logcount=m_logcount+1 WHERE m_id='" & m_id & "'"
	Dbcon.Execute Sql
	Response.Redirect "/site/manage/main.asp"


	Rs.Close
	Set Rs = Nothing


'로그아웃
ElseIf mode="out" Then

	Response.Cookies("W_ID")=""
	Response.Cookies("W_NAME")=""
	Response.Cookies("W_PW")=""
	Response.Cookies("W_EMAIL")=""
	Response.Cookies("W_LEVEL")=""
	
	Response.Redirect "/site/manage/"


'아이디/패스워드 찾기
ElseIf mode="idpw" Then

	'임시비번생성
	m_newpass = Replace(Right(timer(), 5), ".", "")

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT TOP 1 m_id, m_email FROM tbl_member WHERE m_lev='2' AND m_email!='' ORDER BY idx DESC "
	Rs.Open Sql, Dbcon, 1

	If Rs.EOF=False Then
		m_id = Rs("m_id")
		m_email = Rs("m_email")

		mailTitle = "사이트 관리자 아이디와 임시 비밀번호를 알려드립니다."
		mailContent = "안녕하세요. 사이트 관리자님.<br />"
		mailContent = mailContent & "관리자 아이디는 <b>" & m_id & "</b>, 임시 비밀번호는 <b>" & m_newpass & "</b> 입니다.<br />"
		mailContent = mailContent & "비밀번호를 변경하셔서 보안에 신경 써 주시기 바랍니다. <br />감사합니다. "
		mailContent = MailSkin(mailContent)

		MailSendReturnValue = eMailCDOSend (mailContent, mailTitle, m_email, m_email, "", "")

		Sql = "UPDATE tbl_member SET m_pw='" & AESEncrypt(m_newpass, "webmoa") & "' WHERE m_id='" & m_id & "' "
		Dbcon.Execute Sql

		Response.Write "<script>alert('계정정보가 " & m_email & " 메일로 발송되었습니다.'); location.href='/site/manage/';</script>"
		Response.End
	Else
		Response.Write "<script>alert('회원이 존재하지 않습니다.'); history.back();</script>"
		Response.End
	End If

	Rs.Close
	Set Rs = Nothing


End If
%>