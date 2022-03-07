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
	Sql = Sql & "nb_id='" & Request("nb_id") & "', "
	Sql = Sql & "nb_apikey='" & Request("nb_apikey") & "', "
	Sql = Sql & "nb_apiurl='" & Request("nb_apiurl") & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='naver-blog.asp';</script>"

End If
%>