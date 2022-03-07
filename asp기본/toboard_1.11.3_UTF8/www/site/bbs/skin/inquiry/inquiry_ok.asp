<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->

<%
bid					= "1"
cate					= InsertText(Request("cate"))
mem_name		= InsertText(Request("mem_name"))
mem_tel			= Request("mem_tel")
mem_email		= Request("mem_email")
mem_pw			= "1234"
content		= InsertText(Request("content"))
addtext1		= InsertText(Request("addtext1"))
addtext2		= InsertText(Request("addtext2"))
addtext3		= InsertText(Request("addtext3"))
addtext4		= InsertText(Request("addtext4"))
addtext5		= InsertText(Request("addtext5"))
addtext6		= InsertText(Request("addtext6"))
addtext7		= InsertText(Request("addtext7"))
addtext8		= InsertText(Request("addtext8"))
addtext9		= InsertText(Request("addtext9"))
addtext10		= InsertText(Request("addtext10"))
title				= mem_name
html		= "0"

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT TOP 1 num FROM tbl_board_data WHERE board_idx='" & bid & "' ORDER BY num DESC"
Rs.Open Sql, DbCon, 1
If Rs.EOF=True Then
	num=1
Else
	num=CInt(Rs(0))+1
End If
Rs.Close
Set Rs = Nothing

Sql = "INSERT INTO tbl_board_data("
Sql = Sql & "board_idx, "
Sql = Sql & "cate, "
Sql = Sql & "num, "
Sql = Sql & "p_num, "
Sql = Sql & "r_num, "
Sql = Sql & "d_num, "
Sql = Sql & "mem_name, "
Sql = Sql & "mem_id, "
Sql = Sql & "mem_pw, "
Sql = Sql & "mem_tel, "
Sql = Sql & "mem_url, "
Sql = Sql & "mem_email, "
Sql = Sql & "title, "
Sql = Sql & "content, "
Sql = Sql & "addtext1, "
Sql = Sql & "addtext2, "
Sql = Sql & "addtext3, "
Sql = Sql & "addtext4, "
Sql = Sql & "addtext5, "
Sql = Sql & "addtext6, "
Sql = Sql & "addtext7, "
Sql = Sql & "addtext8, "
Sql = Sql & "addtext9, "
Sql = Sql & "addtext10, "
Sql = Sql & "seo_title, "
Sql = Sql & "seo_keyword, "
Sql = Sql & "seo_description, "
Sql = Sql & "ip, "
Sql = Sql & "html, "
Sql = Sql & "notice, "
Sql = Sql & "repmail, "
Sql = Sql & "lock) VALUES("
Sql = Sql & "'" & bid & "',"
Sql = Sql & "N'" & cate & "',"
Sql = Sql & "'" & num & "',"
Sql = Sql & "'" & num & "',"
Sql = Sql & "'" & "0',"
Sql = Sql & "'" & "0',"
Sql = Sql & "N'" & mem_name & "',"
Sql = Sql & "N'" & mem_id & "',"
Sql = Sql & "N'" & AESEncrypt(mem_pw, "webmoa") & "',"
Sql = Sql & "N'" & mem_tel & "',"
Sql = Sql & "N'" & mem_url & "',"
Sql = Sql & "N'" & mem_email & "',"
Sql = Sql & "N'" & title & "',"
Sql = Sql & "N'" & content & "',"
Sql = Sql & "N'" & addtext1 & "',"
Sql = Sql & "N'" & addtext2 & "',"
Sql = Sql & "N'" & addtext3 & "',"
Sql = Sql & "N'" & addtext4 & "',"
Sql = Sql & "N'" & addtext5 & "',"
Sql = Sql & "N'" & addtext6 & "',"
Sql = Sql & "N'" & addtext7 & "',"
Sql = Sql & "N'" & addtext8 & "',"
Sql = Sql & "N'" & addtext9 & "',"
Sql = Sql & "N'" & addtext10 & "',"
Sql = Sql & "N'" & seo_title & "',"
Sql = Sql & "N'" & seo_keyword & "',"
Sql = Sql & "N'" & seo_description & "',"
Sql = Sql & "'" & Request.ServerVariables("REMOTE_HOST") & "',"
Sql = Sql & "'" & html & "',"
Sql = Sql & "'" & notice & "',"
Sql = Sql & "'" & repmail & "',"
Sql = Sql & "'" & lock & "')"

'response.write sql
Dbcon.Execute Sql

'메일발송
If sc_email<>"" Then
	MailTag = "문의 신청 알림<br />"
	MailTag = MailTag & "- 제목 : " & title & "<br />"
	MailTag = MailTag & "- 이름 : " & mem_name & "<br />"
	MailTag = MailTag & "- 연락처 : " & mem_tel & "<br />"
	MailTag = MailTag & "- 이메일 : " & mem_email & "<br />"
	MailTag = MailTag & "- 내용 : <br />" & TagText(content) & "<br />"
	MailTag = MailSkin(MailTag)
	'sc_email = "blue@webmoa.co.kr"
	'rtn = eMailCDOSend(MailTag, "[" & sc_name & "] 문의 신청 알림.", sc_email, sc_email, "", "")
End If

Response.Write "<script>alert('신청이 접수 되었습니다.\n\n감사합니다.'); location.href='/';</script>"
%>