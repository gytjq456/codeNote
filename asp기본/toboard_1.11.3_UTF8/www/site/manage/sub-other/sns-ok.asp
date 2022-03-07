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

	Sql = "UPDATE tbl_sns_config SET "
	Sql = Sql & "f_id='" & Request("f_id") & "', "
	Sql = Sql & "f_pw='" & Request("f_pw") & "', "
	Sql = Sql & "f_call='" & Request("f_call") & "', "
	Sql = Sql & "f_url='" & Request("f_url") & "', "
	Sql = Sql & "t_id='" & Request("t_id") & "', "
	Sql = Sql & "t_pw='" & Request("t_pw") & "', "
	Sql = Sql & "t_call='" & Request("t_call") & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='sns.asp';</script>"

End If
%>