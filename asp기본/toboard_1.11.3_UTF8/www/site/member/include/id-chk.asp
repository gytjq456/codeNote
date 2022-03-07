<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
m_lang = Request("m_lang")
m_id = Request("m_id")

If IdDuplChk(m_id)=False Then
	Response.Write "<script>alert('"
	If b_lang="en" Then
		Response.Write "This ID is currently in use. Please enter another ID."
	Else
		Response.Write "현재 사용중인 아이디입니다.\n다른 아이디를 입력하세요."
	End If
	Response.Write "'); parent.document.regform.idchk.value='0';</script>"
Else
	Response.Write "<script>alert('"
	If m_lang="en" Then
		Response.Write "Available ID"
	Else
		Response.Write "사용가능한 아이디입니다."
	End If
	Response.Write "'); parent.document.regform.idchk.value='1';</script>"
End If
%>