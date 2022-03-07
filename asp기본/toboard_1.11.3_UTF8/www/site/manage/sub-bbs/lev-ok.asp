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
p_lev = Request("p_lev")
idx = Request("idx")
Sql = "UPDATE tbl_board_data SET num='" & p_lev & "', p_num='" & p_lev & "' WHERE idx='" & idx & "'"
Dbcon.Execute Sql
'Response.write sql

Response.Write "<script>alert('수정 완료'); location.href='" & Request.Servervariables("HTTP_REFERER") & "';</script>"

%>