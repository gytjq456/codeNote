<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")
idx = Request("idx")

If mode="reg" Then

	Sql = "INSERT INTO tbl_popup("
	Sql = Sql & "p_title, "
	Sql = Sql & "p_lang, "
	Sql = Sql & "p_left, "
	Sql = Sql & "p_top, "
	Sql = Sql & "p_width, "
	Sql = Sql & "p_height, "
	Sql = Sql & "p_content, "
	Sql = Sql & "p_site, "
	Sql = Sql & "p_hide, "
	Sql = Sql & "p_sdate, "
	Sql = Sql & "p_edate, "
	Sql = Sql & "p_link) VALUES('"
	Sql = Sql & InsertText(Request("p_title")) & "', '"
	Sql = Sql & InsertText(Request("p_lang")) & "', '"
	Sql = Sql & InsertText(Request("p_left")) & "', '"
	Sql = Sql & InsertText(Request("p_top")) & "', '"
	Sql = Sql & InsertText(Request("p_width")) & "', '"
	Sql = Sql & InsertText(Request("p_height")) & "', '"
	Sql = Sql & InsertText(Request("p_content")) & "', '"
	Sql = Sql & InsertText(Request("p_site")) & "', '"
	Sql = Sql & InsertText(Request("p_hide")) & "', '"
	Sql = Sql & InsertText(Request("p_sdate")) & "', '"
	Sql = Sql & InsertText(Request("p_edate")) & "', '"
	Sql = Sql & InsertText(Request("p_link")) & "')"
	'response.write Sql
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.'); location.href='popup.asp';</script>"


ElseIf mode="mod" Then

	Sql = "UPDATE tbl_popup SET "
	Sql = Sql & "p_title='" & InsertText(Request("p_title")) & "', "
	Sql = Sql & "p_lang='" & InsertText(Request("p_lang")) & "', "
	Sql = Sql & "p_left='" & InsertText(Request("p_left")) & "', "
	Sql = Sql & "p_top='" & InsertText(Request("p_top")) & "', "
	Sql = Sql & "p_width='" & InsertText(Request("p_width")) & "', "
	Sql = Sql & "p_height='" & InsertText(Request("p_height")) & "', "
	Sql = Sql & "p_content=N'" & InsertText(Request("p_content")) & "', "
	Sql = Sql & "p_site='" & InsertText(Request("p_site")) & "', "
	Sql = Sql & "p_hide='" & InsertText(Request("p_hide")) & "', "
	Sql = Sql & "p_sdate='" & InsertText(Request("p_sdate")) & "', "
	Sql = Sql & "p_edate='" & InsertText(Request("p_edate")) & "', "
	Sql = Sql & "p_link='" & InsertText(Request("p_link")) & "' "
	Sql = Sql & "WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='popup.asp';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_popup WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='popup.asp';</script>"


End If
%>

