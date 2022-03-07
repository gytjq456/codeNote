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
m_pw = LCase(Request("m_pw"))

If mode="mod" Then 

	Sql = "UPDATE tbl_member SET "
	Sql = Sql & "m_name='" & Request("m_name") & "', "
	If m_pw<>"" Then Sql = Sql & "m_pw='" & AESEncrypt(m_pw, "webmoa") & "', "
	Sql = Sql & "m_email='" & Request("m_email") & "', "
	Sql = Sql & "moddate=getdate() WHERE m_id='" & Request.Cookies("W_ID") & "'"
	Dbcon.Execute Sql

	Response.Cookies("W_NAME")=Request("m_name")
	Response.Cookies("W_PW")=m_pw
	Response.Cookies("W_EMAIL")=Request("m_email")

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='admin-info.asp';</script>"

End If
%>