<%
mode = Request("mode")
idx = Request("idx")
p_idx = Request("p_idx")
p_name = Request("p_name")
p_option = Request("p_option")
p_amount = Request("p_amount")
p_point_a = Request("p_point")
p_qty = Request("p_qty")

ar_p_option = Split(p_option, "§")
ar_p_cnt = UBound(ar_p_option)+1

'장바구니 추가
If mode="cart_reg" Or mode="order_dir" Then
	
	If mode="cart_reg" Then
		o_dir="0"
	ElseIf mode="order_dir" Then
		o_dir="1"
		If W_ID<>"" Then
			Sql = "DELETE FROM tbl_mall_cart WHERE m_id='" & W_ID & "' AND o_code='' AND o_dir='1' "
		Else
			Sql = "DELETE FROM tbl_mall_cart WHERE session_id='" & W_SID & "' AND o_code='' AND o_dir='1' "
		End If 
		Dbcon.Execute Sql
	End If

	'복수의 옵션인 경우
	If ar_p_cnt>1 Then
		ar_p_amount = Split(p_amount, ", ")
		ar_p_qty = Split(p_qty, ", ")

		Sql = ""
		For o=1 To ar_p_cnt
			Sql = Sql & "INSERT INTO tbl_mall_cart("
			Sql = Sql & "m_id, "
			Sql = Sql & "session_id, "
			Sql = Sql & "o_code, "
			Sql = Sql & "p_idx, "
			Sql = Sql & "p_name, "
			Sql = Sql & "p_option, "
			Sql = Sql & "p_amount, "
			Sql = Sql & "p_point_a, "
			Sql = Sql & "p_qty, "
			Sql = Sql & "o_dir) VALUES("
			Sql = Sql & "N'" & W_ID & "', "
			Sql = Sql & "N'" & W_SID & "', "
			Sql = Sql & "N'" & o_code & "', "
			Sql = Sql & "N'" & p_idx & "', "
			Sql = Sql & "N'" & p_name & "', "
			Sql = Sql & "N'" & ar_p_option(o-1) & "', "
			Sql = Sql & "N'" & ar_p_amount(o-1) & "', "
			Sql = Sql & "N'" & p_point_a & "', "
			Sql = Sql & "N'" & ar_p_qty(o-1) & "', "
			Sql = Sql & "N'" & o_dir & "');" & Chr(13) & Chr(10)
		Next

		'Response.write sql		
		Dbcon.Execute Sql

	Else
		Sql = "INSERT INTO tbl_mall_cart("
		Sql = Sql & "m_id, "
		Sql = Sql & "session_id, "
		Sql = Sql & "o_code, "
		Sql = Sql & "p_idx, "
		Sql = Sql & "p_name, "
		Sql = Sql & "p_option, "
		Sql = Sql & "p_amount, "
		Sql = Sql & "p_point_a, "
		Sql = Sql & "p_qty, "
		Sql = Sql & "o_dir) VALUES("
		Sql = Sql & "N'" & W_ID & "', "
		Sql = Sql & "N'" & W_SID & "', "
		Sql = Sql & "N'" & o_code & "', "
		Sql = Sql & "N'" & p_idx & "', "
		Sql = Sql & "N'" & p_name & "', "
		Sql = Sql & "N'" & p_option & "', "
		Sql = Sql & "N'" & p_amount & "', "
		Sql = Sql & "N'" & p_point_a & "', "
		Sql = Sql & "N'" & p_qty & "', "
		Sql = Sql & "N'" & o_dir & "')"
		Dbcon.Execute Sql
	End If

	If mode="cart_reg" Then
		Response.Write "<script>if(confirm('장바구니에 상품을 담았습니다.\n장바구니로 이동하여 확인 하시겠습니까?\n계속 쇼핑하시려면 취소(아니요) 버튼을 눌러주세요.')){location.href='" & mc_shop_url & "?mode=cart'}else{location.href='" & Request.ServerVariables("HTTP_REFERER") & "'}</script>"
	ElseIf mode="order_dir" Then
		Response.Redirect mc_shop_url & "?mode=order_login&o_dir=1"
	End If


ElseIf mode="cart_mod" Then

	Sql = "UPDATE tbl_mall_cart SET "
	Sql = Sql & "p_qty='" & p_qty & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Redirect "?mode=cart"


ElseIf mode="cart_del" Then

	Sql = "DELETE FROM tbl_mall_cart WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Redirect "?mode=cart"


ElseIf mode="cart_alldel" Then

	If W_ID<>"" Then
		Sql = "DELETE FROM tbl_mall_cart WHERE m_id='" & W_ID & "' AND o_code='' "
	Else
		Sql = "DELETE FROM tbl_mall_cart WHERE session_id='" & W_SID & "' AND o_code='' "
	End If 
	Dbcon.Execute Sql

	Response.Write "<script>alert('전체 삭제 되었습니다.'); location.href='?mode=cart';</script>"


End If
%>