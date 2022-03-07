<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")
idx = Request("idx")

p_cate = InsertText(Request("p_cate"))
p_page1 = InsertText(Request("p_page1"))
p_page2 = InsertText(Request("p_page2"))
p_page3 = InsertText(Request("p_page3"))
p_content = InsertText(Request("p_content"))
p_lev = InsertText(Request("p_lev"))
head_title = InsertText(Request("head_title"))
meta_keywords = InsertText(Request("meta_keywords"))
meta_description = InsertText(Request("meta_description"))

If mode="reg" Then

	Sql = "INSERT INTO tbl_page("
	Sql = Sql & "p_cate, "
	Sql = Sql & "p_page1, "
	Sql = Sql & "p_page2, "
	Sql = Sql & "p_page3, "
	Sql = Sql & "p_content, "
	Sql = Sql & "p_lev, "
	Sql = Sql & "head_title, "
	Sql = Sql & "meta_keywords, "
	Sql = Sql & "meta_description) VALUES("
	Sql = Sql & 	"N'" & p_cate & "', "
	Sql = Sql & 	"N'" & p_page1 & "', "
	Sql = Sql & 	"N'" & p_page2 & "', "
	Sql = Sql & 	"N'" & p_page3 & "', "
	Sql = Sql & 	"N'" & p_content & "', "
	Sql = Sql & 	"N'" & p_lev & "', "
	Sql = Sql & 	"N'" & head_title & "', "
	Sql = Sql & 	"N'" & meta_keywords & "', "
	Sql = Sql & 	"N'" & meta_description & "')"
	Dbcon.Execute Sql

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 idx FROM tbl_page ORDER BY idx DESC"
	Rs.Open Sql, Dbcon, 1
		idx = Rs("idx")
	Rs.Close
	Set Rs = Nothing

	Response.Write "<script>alert('추가 되었습니다.'); location.href='index.asp';</script>"


ElseIf mode="mod" Then

	Sql = "UPDATE tbl_page SET "
	Sql = Sql & "p_cate=N'" & p_cate & "', "
	Sql = Sql & "p_page1=N'" & p_page1 & "', "
	Sql = Sql & "p_page2=N'" & p_page2 & "', "
	Sql = Sql & "p_page3=N'" & p_page3 & "', "
	Sql = Sql & "p_content=N'" & p_content & "', "
	Sql = Sql & "head_title=N'" & head_title & "', "
	Sql = Sql & "meta_keywords=N'" & meta_keywords & "', "
	Sql = Sql & "meta_description=N'" & meta_description & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='page.asp?mode=mod&idx=" & idx & "';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_page "
	Sql = Sql & " WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='index.asp';</script>"


'정렬레벨 수정
ElseIf mode="levmod" Then	

	Sql = "UPDATE tbl_page SET "
	Sql = Sql & "p_lev='" & InsertText(Request("p_lev")) & "' WHERE idx='" & idx & "' "

	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='index.asp';</script>"


End If
%>