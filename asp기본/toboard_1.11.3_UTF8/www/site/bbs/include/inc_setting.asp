<%
'site 폴더 경로 (루트인 경우 빈칸)
T_PATH = "/site"
'너비
T_WIDTH = "100%"

If bid="" Then				bid = InsertText(Request("bid"))
If s_type="" Then			s_type = XssFilter(InsertText(Request("s_type")))
If s_keyword="" Then		s_keyword = XssFilter(InsertText(Request("s_keyword")))
If s_cate="" Then			s_cate = InsertText(Request("s_cate"))

mode =	XssFilter(InsertText(Request("mode")))
If mode="" Then			mode="list"
idx = XssFilter(InsertText(Request("idx")))
page = XssFilter(InsertText(Request("page")))
If page="" Then				page=1

pLink = "bid=" & bid & "&amp;s_type=" & s_type & "&amp;s_keyword=" & s_keyword & "&amp;s_cate=" & s_cate

Set Rs = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM tbl_board_id WHERE idx='" & bid & "'"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	k_id = Rs("k_id")
	k_pagelist = Rs("k_pagelist")
	k_upload = Rs("k_upload")
	k_category = Rs("k_category")
	k_comment = Rs("k_comment")
	k_replist = Rs("k_replist")
	k_prevnext = Rs("k_prevnext")
	k_uploadfolder = Rs("k_uploadfolder")
	k_newicon = Rs("k_newicon")
	k_mode = Rs("k_mode")		'PC버전 스킨
	k_mode_mobile = Rs("k_mode_mobile")		'모바일 버전 스킨
	k_mode_admin = Rs("k_mode_admin")		'관리용 스킨
	k_counsel = Rs("k_counsel")
	k_regmail = Rs("k_regmail")
	k_repmail = Rs("k_repmail")
	k_regsms = Rs("k_regsms")
	k_repsms = Rs("k_repsms")
	k_filter = Split(Rs("k_filter"),",")
	k_rss = Rs("k_rss")
	k_sns = Rs("k_sns")
	k_spamcode = Rs("k_spamcode")
	k_seo = Rs("k_seo")
	k_naverblog = Rs("k_naverblog")
	k_thumbview = Rs("k_thumbview")
	k_editor= Rs("k_editor")
	k_html="1"
	If k_editor="" Then k_html="0"

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
Else
	Response.Write "<script>alert('게시판이 존재하지않습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close

'온라인상담폼인경우 기본페이지를 등록페이지로
If Request("mode")="" And k_counsel=True Then mode="reg"

'디폴트 값
If mode="mod" Then
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT mem_name, mem_email FROM tbl_board_data WHERE idx='" & idx & "'"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		W_NAME = Rs(0)
		W_EMAIL = Rs(1)
	End If
	Rs.Close
End If

'정렬 최상/최하위 설정
Set Rs2 = Server.Createobject("ADODB.Recordset")
Sql = "SELECT ISNULL(MAX(num), 0) FROM tbl_board_data WHERE board_idx='" & bid & "' AND notice='0' "
Rs2.Open Sql, Dbcon, 1
If Rs2.EOF=False Then c_rmax = Rs2(0)
Rs2.Close

Sql = "SELECT ISNULL(MIN(num), 0) FROM tbl_board_data WHERE board_idx='" & bid & "' AND notice='0' "
Rs2.Open Sql, Dbcon, 1
If Rs2.EOF=False Then c_rmin = Rs2(0)
Rs2.Close
Set Rs2 = Nothing
%>