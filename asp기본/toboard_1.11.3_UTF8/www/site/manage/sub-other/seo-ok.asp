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
idx = Request("idx")

If mode="mod" Then

	Sql = "UPDATE tbl_site_config SET "
	Sql = Sql & "meta_keywords=N'" & InsertText(Request("meta_keywords")) & "', "
	Sql = Sql & "meta_description=N'" & InsertText(Request("meta_description")) & "', "
	Sql = Sql & "meta_author=N'" & InsertText(Request("meta_author")) & "', "
	Sql = Sql & "meta_subject=N'" & InsertText(Request("meta_subject")) & "', "
	Sql = Sql & "meta_copyright=N'" & InsertText(Request("meta_copyright")) & "', "
	Sql = Sql & "meta_content_language=N'" & InsertText(Request("meta_content_language")) & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.'); location.href='seo.asp';</script>"


ElseIf mode="page-reg" Then

	m_path = InsertText(Request("m_path"))
	m_title = InsertText(Request("m_title"))
	m_keywords = InsertText(Request("m_keywords"))
	m_description = InsertText(Request("m_description"))

	Sql = "INSERT INTO tbl_site_seopage("
	Sql = Sql & "m_path, "
	Sql = Sql & "m_title, "
	Sql = Sql & "m_keywords, "
	Sql = Sql & "m_description) VALUES("
	Sql = Sql & 	"'" & m_path & "', "
	Sql = Sql & 	"N'" & m_title & "', "
	Sql = Sql & 	"N'" & m_keywords & "', "
	Sql = Sql & 	"N'" & m_description & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.'); location.href='seo.asp';</script>"


ElseIf mode="page-mod" Then

	m_path = InsertText(Request("m_path"))
	m_title = InsertText(Request("m_title"))
	m_keywords = InsertText(Request("m_keywords"))
	m_description = InsertText(Request("m_description"))

	Sql = "UPDATE tbl_site_seopage SET "
	Sql = Sql & "m_path=N'" & m_path & "', "
	Sql = Sql & "m_title=N'" & m_title & "', "
	Sql = Sql & "m_keywords=N'" & m_keywords & "', "
	Sql = Sql & "m_description=N'" & m_description & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='seo.asp';</script>"


ElseIf mode="page-del" Then

	Sql = "DELETE FROM tbl_site_seopage WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='seo.asp';</script>"


End If
%>