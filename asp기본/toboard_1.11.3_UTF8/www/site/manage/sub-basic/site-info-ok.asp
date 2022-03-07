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

If mode="mod" Then 

	Sql = "UPDATE tbl_site_config SET "
	Sql = Sql & "sc_name=N'" & InsertText(Request("sc_name")) & "', "
	Sql = Sql & "sc_lang=N'" & InsertText(Request("sc_lang")) & "', "
	Sql = Sql & "sc_url='" & InsertText(Request("sc_url")) & "', "
	Sql = Sql & "sc_email='" & InsertText(Request("sc_email")) & "', "
	Sql = Sql & "sc_tel='" & Replace(Request("sc_tel"), "-", "") & "', "
	Sql = Sql & "sc_agree1=N'" & InsertText(Request("sc_agree1")) & "', "
	Sql = Sql & "sc_agree2=N'" & InsertText(Request("sc_agree2")) & "', "
	Sql = Sql & "sc_analy='" & Replace(Request("sc_analy"), "'", "''") & "'; "

	Sql = Sql & "UPDATE tbl_member SET "
	Sql = Sql & "a_auth='" & Request("a_auth") & "' "
	Sql = Sql & " WHERE m_lev='2' AND idx='2'; "
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='site-info.asp';</script>"

End If
%>