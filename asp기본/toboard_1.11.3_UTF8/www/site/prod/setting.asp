<%
mode = Request("mode")
If mode="" Then mode="list"
idx = Request("idx")

s_cate=Request("s_cate")
s_keyword = Request("s_keyword")
s_display = Request("s_display")
s_align = Request("s_align")
If s_align="" Then s_align="0"

page = Request("page")
If page="" Then page=1

If disableChar(s_keyword)=False Then
	Response.Write "<script>alert('검색에 사용할 수 없는 문자가 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_display=" & s_display & "&s_align=" & s_align


'제품관리 설정정보 취득
Set RsProd = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_prod_config "
RsProd.Open Sql, Dbcon, 1
If RsProd.EOF=False Then
	pc_pagelist = RsProd("pc_pagelist")
	pc_skin_list = RsProd("pc_skin_list")
	pc_skin_view = RsProd("pc_skin_view")
	pc_naverblog = RsProd("pc_naverblog")
	pc_seo = RsProd("pc_seo")
	pc_lg_platform = RsProd("pc_lg_platform")
	pc_lg_mid = RsProd("pc_lg_mid")
	pc_lg_mertkey = RsProd("pc_lg_mertkey")
End If
RsProd.Close
Set RsProd = Nothing

'카테고리명 취득
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_cate WHERE c_code='" & Left(s_cate, 2) & "' AND c_depth='1' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	cate_name1 = Rs("c_name")
End If
Rs.Close
Sql = "SELECT * FROM tbl_cate WHERE c_code='" & Left(s_cate, 4) & "' AND c_depth='2' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	cate_name2 = Rs("c_name")
End If
Rs.Close
Sql = "SELECT * FROM tbl_cate WHERE c_code='" & Left(s_cate, 6) & "' AND c_depth='3' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	cate_name3 = Rs("c_name")
End If
Rs.Close
Set Rs = Nothing

'뷰 페이지 정보
If mode="view" Then

	ReDim p_item(10), p_item_text(10), p_image(8), p_file(6), p_content(6), p_addtext(5), p_option(4), p_option_val(4)

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_name=Rs("p_name")
		p_cate=Rs("p_cate")
		p_code=Rs("p_code")
		For i=1 To 10
			p_item(i-1)=Rs("p_item" & i)
			p_item_text(i-1)=Rs("p_item_text" & i)
		Next
		For i=1 To 8
			p_image(i-1)=Rs("p_image" & i)
		Next
		For i=1 To 6
			p_file(i-1)=Rs("p_file" & i)
			p_content(i-1)=Rs("p_content" & i)
		Next
		For i=1 To 5
			p_addtext(i-1)=Rs("p_addtext" & i)
		Next
		For i=1 To 4
			p_option(i-1)=Rs("p_option" & i)
			p_option_val(i-1)=Rs("p_option_val" & i)
		Next
		p_memo=Rs("p_memo")
		p_o_price=Rs("p_o_price")
		p_price=Rs("p_price")
		p_point=Rs("p_point")
		If p_point="" Then p_point=0
		If mc_point_use=False Then p_point=0
		p_inquiry=Rs("p_inquiry")
		p_display=Rs("p_display")
		p_lev=Rs("p_lev")
		p_hit=Rs("p_hit")
		p_hide=Rs("p_hide")

		p_head_title=Rs("head_title")
		p_meta_keywords=Rs("meta_keywords")
		p_meta_description=Rs("meta_description")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>