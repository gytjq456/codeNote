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
s_m_id = Request("s_m_id")
idx = Request("idx")

If mode="reg" Then

	Call SetPoint(s_m_id, InsertText(Request("mp_pm")), InsertText(Request("mp_point")), InsertText(Request("mp_bigo")))

	Response.Write "<script>alert('등록 되었습니다.'); location.href='point.asp?s_m_id=" & s_m_id & "';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_member_point WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Call SetPointSync(s_m_id)

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='point.asp?s_m_id=" & s_m_id & "';</script>"


End If
%>

