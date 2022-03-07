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
m_id = Request("m_id")

'삭제
If mode="del_p" Then

	Sql = "DELETE FROM tbl_member WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제되었습니다.'); location.href='member.asp';</script>"
	Response.End

'선택삭제
ElseIf mode="seldel_p" Then

	ArrId = Split(m_id, ", ")

	If m_id="" Then
		Response.Write "<script language='javascript'>alert('삭제할 대상이 지정되지 않았습니다.'); history.back();</script>"
		Response.End
	End If

	m_id_txt = "('"
	For Each b In ArrId
		m_id_txt = m_id_txt & b & "', '"
	Next
	m_id_txt = m_id_txt & "')"

	'회원 DB delete
	Sql = "DELETE FROM tbl_member WHERE m_id IN " & m_id_txt
	'Response.write sql
	DbCon.Execute Sql

	Response.Write "<script>alert('삭제되었습니다.'); location.href='member.asp';</script>"
	Response.End


'등급변경
ElseIf mode="levmod" Then

	s_keyword = Request("s_keyword")
	s_srdate = Request("s_srdate")
	s_erdate = Request("s_erdate")
	s_mailing = Request("s_mailing")
	s_sort = Request("s_sort")
	s_align = Request("s_align")
	page = Request("page")

	pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_mailing=" & s_mailing & "&s_sort=" & s_sort & "&s_align=" & s_align

	m_id = Request("m_id")
	m_levmxd = Request("m_levmxd")
	If m_levmxd<>"" Then
		a_levmxd = Split(m_levmxd, ":")
		m_lev = a_levmxd(0)
		m_sort = a_levmxd(1)
	End If

	Sql = "UPDATE tbl_member SET "
	Sql = Sql & "m_lev='" & m_lev & "', "
	Sql = Sql & "m_sort=N'" & InsertText(m_sort) & "', "
	Sql = Sql & "moddate=getdate() WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='member.asp?" & pLink & "&page=" & page & "';</script>"
	Response.End


End If

%>