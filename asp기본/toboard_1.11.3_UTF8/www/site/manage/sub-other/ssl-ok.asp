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
	Sql = Sql & "ssl_chk='" & Request("ssl_chk") & "', "
	Sql = Sql & "ssl_port='" & Request("ssl_port") & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='ssl.asp';</script>"

End If
%>