<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_page WHERE idx='" & idx & "'"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	idx = Rs("idx")
	pg_page1 = Rs("p_page1")
	pg_page2 = Rs("p_page2")
	pg_page3 = Rs("p_page3")
	pg_content = Rs("p_content")
	pg_head_title = Rs("head_title")
	pg_meta_keywords = Rs("meta_keywords")
	pg_meta_description = Rs("meta_description")
Else
	Response.Write "<script>alert('해당 페이지가 존재하지 않습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing
%>