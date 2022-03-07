<%
'게시물정보 취득
If mode="view" Or mode="mod" Then 

	ReDim c_file(15)

	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT * FROM tbl_board_data WHERE board_idx='" & bid & "' AND idx='" & idx & "'"
	Rs.open Sql, Dbcon, 1
	If Rs.EOF=False Then
		c_idx = Rs("idx")
		c_board_idx = Rs("board_idx")
		c_cate = Rs("cate")
		c_e1_idx = Rs("e1_idx")
		c_e2_idx = Rs("e2_idx")
		c_num = Rs("num")
		c_p_num = Rs("p_num")
		c_r_num = Rs("r_num")
		c_d_num = Rs("d_num")
		c_mem_name = Rs("mem_name")
		c_mem_id = Rs("mem_id")
		c_mem_pw = AESDecrypt(Rs("mem_pw"), "webmoa")
		c_mem_tel = Rs("mem_tel")
		c_mem_fax = Rs("mem_fax")
		c_mem_url = Rs("mem_url")
		c_mem_email = Rs("mem_email")
		c_addtext1 = Rs("addtext1")
		c_addtext2 = Rs("addtext2")
		c_addtext3 = Rs("addtext3")
		c_addtext4 = Rs("addtext4")
		c_addtext5 = Rs("addtext5")
		c_addtext6 = Rs("addtext6")
		c_addtext7 = Rs("addtext7")
		c_addtext8 = Rs("addtext8")
		c_addtext9 = Rs("addtext9")
		c_addtext10 = Rs("addtext10")
		c_addtext11 = Rs("addtext11")
		c_addtext12 = Rs("addtext12")
		c_addtext13 = Rs("addtext13")
		c_addtext14 = Rs("addtext14")
		c_addtext15 = Rs("addtext15")
		c_addtext16 = Rs("addtext16")
		c_addtext17 = Rs("addtext17")
		c_addtext18 = Rs("addtext18")
		c_addtext19 = Rs("addtext19")
		c_addtext20 = Rs("addtext20")
		c_title = Rs("title")
		c_content = Rs("content")
		c_seo_title = Rs("seo_title")
		c_seo_keyword = Rs("seo_keyword")
		c_seo_description = Rs("seo_description")
		c_comment_count = Rs("comment_count")
		c_read_count = Rs("read_count")
		c_ip = Rs("ip")
		For fc=0 To k_upload-1
			c_file(fc) = Rs("file" & fc+1)
		Next
		c_html = Rs("html")
		c_notice = Rs("notice")
		c_repmail = Rs("repmail")
		c_lock = Rs("lock")
		c_popup = Rs("popup")
		c_regdate = Rs("regdate")
	Else
		Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing
End If 

%>