<%
If CInt(mc_order_lev)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('로그인이 필요하거나 구매 가능한 회원등급이 아닙니다.'); history.back();</script>"
	Response.End
End If

o_dir = Request("o_dir")
o_code = StrRand(12)

o_comp = InsertText(Request("o_comp"))
o_name = InsertText(Request("o_name"))
o_tel = InsertText(Request("o_tel"))
o_cell = InsertText(Request("o_cell"))
o_zip = InsertText(Request("o_zip"))
o_addr1 = InsertText(Request("o_addr1"))
o_addr2 = InsertText(Request("o_addr2"))
o_email = InsertText(Request("o_email"))
s_comp = InsertText(Request("s_comp"))
s_name = InsertText(Request("s_name"))
s_tel = InsertText(Request("s_tel"))
s_cell = InsertText(Request("s_cell"))
s_zip = InsertText(Request("s_zip"))
s_addr1 = InsertText(Request("s_addr1"))
s_addr2 = InsertText(Request("s_addr2"))
s_text = InsertText(Request("s_text"))
o_amount = InsertText(Request("o_amount"))
o_deli_amount = InsertText(Request("o_deli_amount"))

If SpamChk(Trim(Request("txtCaptcha")))=False Then
	Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); location.href='" & Request.ServerVariables("HTTP_REFERER") & "';</script>"
	Response.End
End If

'주문 정보 입력
Sql = "INSERT INTO tbl_mall_order("
Sql = Sql & "session_id, "
Sql = Sql & "m_id, "
Sql = Sql & "o_code, "
Sql = Sql & "o_comp, "
Sql = Sql & "o_name, "
Sql = Sql & "o_tel, "
Sql = Sql & "o_zip, "
Sql = Sql & "o_addr1, "
Sql = Sql & "o_addr2, "
Sql = Sql & "o_email, "
Sql = Sql & "s_comp, "
Sql = Sql & "s_name, "
Sql = Sql & "s_tel, "
Sql = Sql & "s_zip, "
Sql = Sql & "s_addr1, "
Sql = Sql & "s_addr2, "
Sql = Sql & "s_text, "
Sql = Sql & "o_amount, "
Sql = Sql & "o_deli_amount, "
Sql = Sql & "o_vat, "
Sql = Sql & "useragent) VALUES("
Sql = Sql & "N'" & W_SID & "', "
Sql = Sql & "N'" & W_ID & "', "
Sql = Sql & "N'" & o_code & "', "
Sql = Sql & "N'" & o_comp & "', "
Sql = Sql & "N'" & o_name & "', "
Sql = Sql & "N'" & o_tel & "', "
Sql = Sql & "N'" & o_zip & "', "
Sql = Sql & "N'" & o_addr1 & "', "
Sql = Sql & "N'" & o_addr2 & "', "
Sql = Sql & "N'" & o_email & "', "
Sql = Sql & "N'" & s_comp & "', "
Sql = Sql & "N'" & s_name & "', "
Sql = Sql & "N'" & s_tel & "', "
Sql = Sql & "N'" & s_zip & "', "
Sql = Sql & "N'" & s_addr1 & "', "
Sql = Sql & "N'" & s_addr2 & "', "
Sql = Sql & "N'" & s_text & "', "
Sql = Sql & "N'" & o_amount & "', "
Sql = Sql & "N'" & o_deli_amount & "', "
Sql = Sql & "N'" & o_vat & "', "
Sql = Sql & "N'" & Trim(Request.ServerVariables("HTTP_USER_AGENT")) & "')"
Dbcon.Execute Sql

Sql = "UPDATE tbl_mall_cart SET "
Sql = Sql & " o_code='" & o_code & "' "
Sql = Sql & " WHERE o_end='0' "
If o_dir<>"" Then Sql = Sql & " AND o_dir='1' "
If W_ID<>"" Then
	Sql = Sql & " AND m_id='" & W_ID & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
Dbcon.Execute Sql

Response.Redirect "?mode=pay&o_code=" & o_code

%>