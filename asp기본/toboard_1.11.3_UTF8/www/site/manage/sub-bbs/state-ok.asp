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
addtext1 = Request("addtext1")
idx = Request("idx")
Sql = "UPDATE tbl_board_data SET addtext1='" & addtext1 & "' WHERE idx='" & idx & "'"
Dbcon.Execute Sql
'Response.write sql

Response.Write "<script>alert('" & addtext1 & " 처리되었습니다.'); location.href='" & Request.Servervariables("HTTP_REFERER") & "';</script>"

%>