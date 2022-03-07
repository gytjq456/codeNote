<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->
<%
W_ID = Request.Cookies("W_ID")
p_idx = Request("p_idx")

If W_ID="" Then
	Response.Write "<script>alert('로그인이 필요합니다.'); location.href='" & Request.ServerVariables("HTTP_REFERER") & "'</script>"
	Response.End
End If

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_wish WHERE m_id='" & W_ID & "' AND p_idx='" & p_idx & "' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Sql1 = "INSERT INTO tbl_mall_wish("
	Sql1 = Sql1 & "m_id, "
	Sql1 = Sql1 & "p_idx) VALUES("
	Sql1 = Sql1 & "N'" & W_ID & "', "
	Sql1 = Sql1 & "N'" & p_idx & "')"
	Dbcon.Execute Sql1
	Response.Write "<script>alert('위시 리스트에 추가 되었습니다.');</script>"
Else
	Sql1 = "DELETE FROM tbl_mall_wish WHERE m_id='" & W_ID & "' AND p_idx='" & p_idx & "' "
	Dbcon.Execute Sql1
	Response.Write "<script>alert('위시 리스트에서 삭제 되었습니다.');</script>"
End If
Rs.Close
Set Rs = Nothing


Response.Write "<script>location.href='" & Request.ServerVariables("HTTP_REFERER") & "'</script>"
%>