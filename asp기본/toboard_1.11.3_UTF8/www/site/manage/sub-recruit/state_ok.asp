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
	mode				= Request("mode")
	state_idx		= Request("state_idx")
	state_value	= Request("state_value")

	sel_idx		= InsertText(Request("sel_idx"))
	sel_state	= InsertText(Request("sel_state"))

	If mode = "sel_p" Then

		ArrId = Split(sel_idx, ", ")

		If sel_idx = "" Then
			Response.Write "<script language='javascript'>alert('변경할 대상이 지정되지 않았습니다.'); history.back();</script>"
			Response.End
		End If

		m_id_txt = "('"
		For Each b In ArrId
			m_id_txt = m_id_txt & b & "', '"
		Next
		m_id_txt = m_id_txt & "')"

		SQL = "UPDATE tbl_resume SET state='" & sel_state & "' WHERE idx IN " & m_id_txt
		DbCon.Execute SQL

	Else

		SQL = "UPDATE tbl_resume SET state='" & state_value & "' WHERE idx='" & state_idx & "'"
		Dbcon.Execute SQL

	End If
	
	Response.Write "<script>alert('" & A & " 처리되었습니다.'); location.href='" & Request.Servervariables("HTTP_REFERER") & "';</script>"
%>