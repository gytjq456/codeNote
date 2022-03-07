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

k_id = InsertText(Request("k_id"))
k_group = InsertText(Request("k_group"))
k_pagelist = Request("k_pagelist")
k_upload = Request("k_upload")
k_category = InsertText(Request("k_category"))
k_comment = Request("k_comment")
k_replist = Request("k_replist")
k_prevnext = Request("k_prevnext")
k_regmail = Request("k_regmail")
k_repmail = Request("k_repmail")
k_regsms = Request("k_regsms")
k_repsms = Request("k_repsms")
k_uploadfolder = Request("k_uploadfolder")
k_newicon = Request("k_newicon")
k_mode = Request("k_mode")
k_mode_mobile = Request("k_mode_mobile")
k_mode_admin = Request("k_mode_admin")
k_counsel = Request("k_counsel")
k_filter = InsertText(Request("k_filter"))
k_rss = Request("k_rss")
k_sns = Request("k_sns")
k_spamcode = Request("k_spamcode")
k_seo = Request("k_seo")
k_naverblog = Request("k_naverblog")
k_thumbview = Request("k_thumbview")
k_editor= Request("k_editor")
u_tel = Request("u_tel")
u_fax = Request("u_fax")
u_url = Request("u_url")
u_privacy = Request("u_privacy")
u_privacy_txt = InsertText(Request("u_privacy_txt"))
a_list = Request("a_list")
a_write = Request("a_write")
a_reply = Request("a_reply")
a_content = Request("a_content")
a_comment = Request("a_comment")
p_lev = Request("p_lev")

If mode="reg" Then 

	Sql = "INSERT INTO tbl_board_id("
	Sql = Sql & "k_group, "
	Sql = Sql & "k_id, "
	Sql = Sql & "k_mode, "
	Sql = Sql & "p_lev) VALUES("
	Sql = Sql & "'" & k_group & "', "
	Sql = Sql & "'" & k_id & "', "
	Sql = Sql & "'" & k_mode & "', "
	Sql = Sql & "'" & p_lev & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('게시판이 생성 되었습니다.');location.href='bbs-setting.asp';</script>"


ElseIf mode="mod" Then 

	Sql = "UPDATE tbl_board_id SET "
	Sql = Sql & "k_id=N'" & k_id & "', "
	Sql = Sql & "k_group=N'" & k_group & "', "
	Sql = Sql & "k_pagelist='" & k_pagelist & "', "
	Sql = Sql & "k_upload='" & k_upload & "', "
	Sql = Sql & "k_category=N'" & k_category & "', "
	Sql = Sql & "k_comment='" & k_comment & "', "
	Sql = Sql & "k_replist='" & k_replist & "', "
	Sql = Sql & "k_prevnext='" & k_prevnext & "', "
	Sql = Sql & "k_regmail='" & k_regmail & "', "
	Sql = Sql & "k_repmail='" & k_repmail & "', "
	Sql = Sql & "k_regsms='" & k_regsms & "', "
	Sql = Sql & "k_repsms='" & k_repsms & "', "
	Sql = Sql & "k_uploadfolder=N'" & k_uploadfolder & "', "
	Sql = Sql & "k_newicon='" & k_newicon & "', "
	Sql = Sql & "k_mode=N'" & k_mode & "', "
	Sql = Sql & "k_mode_mobile=N'" & k_mode_mobile & "', "
	Sql = Sql & "k_mode_admin=N'" & k_mode_admin & "', "
	Sql = Sql & "k_counsel='" & k_counsel & "', "
	Sql = Sql & "k_filter=N'" & k_filter & "', "
	Sql = Sql & "k_rss='" & k_rss & "', "
	Sql = Sql & "k_sns='" & k_sns & "', "
	Sql = Sql & "k_spamcode='" & k_spamcode & "', "
	Sql = Sql & "k_seo='" & k_seo & "', "
	Sql = Sql & "k_naverblog='" & k_naverblog & "', "
	Sql = Sql & "k_thumbview='" & k_thumbview & "', "
	Sql = Sql & "k_editor='" & k_editor & "', "
	Sql = Sql & "u_tel='" & u_tel & "', "
	Sql = Sql & "u_fax='" & u_fax & "', "
	Sql = Sql & "u_url='" & u_url & "', "
	Sql = Sql & "u_privacy='" & u_privacy & "', "
	Sql = Sql & "u_privacy_txt=N'" & u_privacy_txt & "', "
	Sql = Sql & "a_list='" & a_list & "', "
	Sql = Sql & "a_write='" & a_write & "', "
	Sql = Sql & "a_reply='" & a_reply & "', "
	Sql = Sql & "a_content='" & a_content & "', "
	Sql = Sql & "a_comment='" & a_comment & "' WHERE idx='" & idx & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('게시판이 수정 되었습니다.');location.href='bbs-setting.asp';</script>"


ElseIf mode="copy" Then 

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_board_id WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF Then
		Response.Write "<script>alert('잘못된 접근입니다.');location.href='/site/manage/';</script>"
		Response.End
	Else
		k_id = Rs("k_id")
		k_group = Rs("k_group")
		k_pagelist = Rs("k_pagelist")
		k_upload = Rs("k_upload")
		k_category = Rs("k_category")
		k_comment = Rs("k_comment")
		k_replist = Rs("k_replist")
		k_prevnext = Rs("k_prevnext")
		k_regmail = Rs("k_regmail")
		k_repmail = Rs("k_repmail")
		k_regsms = Rs("k_regsms")
		k_repsms = Rs("k_repsms")
		k_uploadfolder = Rs("k_uploadfolder")
		k_newicon = Rs("k_newicon")
		k_mode = Rs("k_mode")
		k_mode_mobile = Rs("k_mode_mobile")
		k_mode_admin = Rs("k_mode_admin")
		k_counsel = Rs("k_counsel")
		k_filter = Rs("k_filter")
		k_rss = Rs("k_rss")
		k_sns = Rs("k_sns")
		k_spamcode = Rs("k_spamcode")
		k_seo = Rs("k_seo")
		k_naverblog = Rs("k_naverblog")
		k_thumbview = Rs("k_thumbview")
		k_editor= Rs("k_editor")
		u_tel = Rs("u_tel")
		u_fax = Rs("u_fax")
		u_url = Rs("u_url")
		u_privacy = Rs("u_privacy")
		u_privacy_txt = Rs("u_privacy_txt")
		a_list = Rs("a_list")
		a_write = Rs("a_write")
		a_reply = Rs("a_reply")
		a_content = Rs("a_content")
		a_comment = Rs("a_comment")
		regdate = Rs("regdate")
	End If
	Rs.Close
	Set Rs = Nothing


	Sql = "INSERT INTO tbl_board_id("
	Sql = Sql & "k_group, "
	Sql = Sql & "k_id, "
	Sql = Sql & "k_pagelist, "
	Sql = Sql & "k_upload, "
	Sql = Sql & "k_category, "
	Sql = Sql & "k_comment, "
	Sql = Sql & "k_replist, "
	Sql = Sql & "k_prevnext, "
	Sql = Sql & "k_regmail, "
	Sql = Sql & "k_repmail, "
	Sql = Sql & "k_regsms, "
	Sql = Sql & "k_repsms, "
	Sql = Sql & "k_uploadfolder, "
	Sql = Sql & "k_newicon, "
	Sql = Sql & "k_mode, "
	Sql = Sql & "k_mode_mobile, "
	Sql = Sql & "k_mode_admin, "
	Sql = Sql & "k_counsel, "
	Sql = Sql & "k_filter, "
	Sql = Sql & "k_rss, "
	Sql = Sql & "k_sns, "
	Sql = Sql & "k_spamcode, "
	Sql = Sql & "k_seo, "
	Sql = Sql & "k_naverblog, "
	Sql = Sql & "k_thumbview, "
	Sql = Sql & "k_editor, "
	Sql = Sql & "u_tel, "
	Sql = Sql & "u_fax, "
	Sql = Sql & "u_url, "
	Sql = Sql & "u_privacy, "
	Sql = Sql & "u_privacy_txt, "
	Sql = Sql & "a_list, "
	Sql = Sql & "a_write, "
	Sql = Sql & "a_reply, "
	Sql = Sql & "a_content, "
	Sql = Sql & "a_comment) VALUES("
	Sql = Sql & "N'" & k_group & "', "
	Sql = Sql & "N'" & k_id & " (복사)', "
	Sql = Sql & "'" & k_pagelist & "', "
	Sql = Sql & "'" & k_upload & "', "
	Sql = Sql & "N'" & k_category & "', "
	Sql = Sql & "'" & k_comment & "', "
	Sql = Sql & "'" & k_replist & "', "
	Sql = Sql & "'" & k_prevnext & "', "
	Sql = Sql & "'" & k_regmail & "', "
	Sql = Sql & "'" & k_repmail & "', "
	Sql = Sql & "'" & k_regsms & "', "
	Sql = Sql & "'" & k_repsms & "', "
	Sql = Sql & "'" & k_uploadfolder & "', "
	Sql = Sql & "'" & k_newicon & "', "
	Sql = Sql & "N'" & k_mode & "', "
	Sql = Sql & "N'" & k_mode_mobile & "', "
	Sql = Sql & "N'" & k_mode_admin & "', "
	Sql = Sql & "'" & k_counsel & "', "
	Sql = Sql & "N'" & k_filter & "', "
	Sql = Sql & "'" & k_rss & "', "
	Sql = Sql & "'" & k_sns & "', "
	Sql = Sql & "'" & k_spamcode & "', "
	Sql = Sql & "'" & k_seo & "', "
	Sql = Sql & "'" & k_naverblog & "', "
	Sql = Sql & "'" & k_thumbview & "', "
	Sql = Sql & "'" & k_editor & "', "
	Sql = Sql & "'" & u_tel & "', "
	Sql = Sql & "'" & u_fax & "', "
	Sql = Sql & "'" & u_url & "', "
	Sql = Sql & "'" & u_privacy & "', "
	Sql = Sql & "N'" & u_privacy_txt & "', "
	Sql = Sql & "'" & a_list & "', "
	Sql = Sql & "'" & a_write & "', "
	Sql = Sql & "'" & a_reply & "', "
	Sql = Sql & "'" & a_content & "', "
	Sql = Sql & "'" & a_comment & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('게시판이 복사 되었습니다.');location.href='bbs-setting.asp';</script>"



ElseIf mode="del" Then 

	Sql = "DELETE FROM tbl_board_id WHERE idx='" & idx & "' "
	Dbcon.Execute Sql
	Sql = "DELETE FROM tbl_board_data WHERE board_idx='" & idx & "' "
	Dbcon.Execute Sql
	Sql = "DELETE FROM tbl_board_comment WHERE board_idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('게시판이 삭제 되었습니다.');location.href='bbs-setting.asp';</script>"


'정렬레벨 수정
ElseIf mode="levmod" Then	

	Sql = "UPDATE tbl_board_id SET "
	Sql = Sql & "p_lev='" & InsertText(Request("p_lev")) & "' WHERE idx='" & idx & "' "

	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='bbs-setting.asp';</script>"

End If
%>