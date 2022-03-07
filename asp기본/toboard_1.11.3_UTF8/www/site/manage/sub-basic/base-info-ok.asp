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
	Sql = Sql & "sc_email=N'" & InsertText(Request("sc_email")) & "', "
	Sql = Sql & "sc_tel=N'" & InsertText(Request("sc_tel")) & "', "
	Sql = Sql & "sc_regno1=N'" & InsertText(Request("sc_regno1")) & "', "
	Sql = Sql & "sc_regno2=N'" & InsertText(Request("sc_regno2")) & "', "
	Sql = Sql & "sc_regno3=N'" & InsertText(Request("sc_regno3")) & "', "
	Sql = Sql & "sc_address=N'" & InsertText(Request("sc_address")) & "', "
	Sql = Sql & "sc_addtext1=N'" & InsertText(Request("sc_addtext1")) & "', "
	Sql = Sql & "sc_addtext2=N'" & InsertText(Request("sc_addtext2")) & "', "
	Sql = Sql & "sc_addtext3=N'" & InsertText(Request("sc_addtext3")) & "', "
	Sql = Sql & "sc_addtext4=N'" & InsertText(Request("sc_addtext4")) & "', "
	Sql = Sql & "sc_addtext5=N'" & InsertText(Request("sc_addtext5")) & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='base-info.asp';</script>"

End If
%>