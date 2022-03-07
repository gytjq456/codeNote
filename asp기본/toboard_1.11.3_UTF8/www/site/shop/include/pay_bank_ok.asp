<%
If CInt(mc_order_lev)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('로그인이 필요하거나 구매 가능한 회원등급이 아닙니다.'); history.back();</script>"
	Response.End
End If

o_code = Request("o_code")
o_pay_method = Request("o_pay_method")
o_pay_bank = Request("o_pay_bank")
o_pay_bank_name = Request("o_pay_bank_name")
o_pay_point = Request("o_pay_point")
o_coupon_code = Request("o_coupon_code")
o_coupon_amount = Request("o_coupon_amount")

Sql = "UPDATE tbl_mall_cart SET "
Sql = Sql & " o_end='1' "
Sql = Sql & " WHERE o_code='" & o_code & "' "
If W_ID<>"" Then
	Sql = Sql & " AND m_id='" & W_ID & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
'Response.write sql
Dbcon.Execute Sql

If o_pay_method="포인트결제" Then
	o_state="결제완료"
Else
	o_state="결제대기"
End If

'주문정보 수정
Sql = "UPDATE tbl_mall_order SET "
Sql = Sql & " o_pay_method=N'" & o_pay_method & "', "
Sql = Sql & " o_pay_bank=N'" & o_pay_bank & "', "
Sql = Sql & " o_pay_bank_name=N'" & o_pay_bank_name & "', "
Sql = Sql & " o_pay_point=N'" & o_pay_point & "', "
Sql = Sql & " o_coupon_code=N'" & o_coupon_code & "', "
Sql = Sql & " o_coupon_amount=N'" & o_coupon_amount & "', "
Sql = Sql & " o_state=N'" & o_state & "' "
Sql = Sql & " WHERE o_code='" & o_code & "' "
If W_ID<>"" Then
	Sql = Sql & " AND m_id='" & W_ID & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
'Response.write sql
Dbcon.Execute Sql

'쿠폰사용 처리
If o_coupon_code<>"" Then
	Sql = "UPDATE tbl_coupon_dl SET c_used=1 "
	Sql = Sql & " WHERE cd_code='" & o_coupon_code & "' AND m_id='" & W_ID & "' "
	Dbcon.Execute Sql
End If

'포인트 결제
If o_pay_point>0 Then 
	Call SetPoint(W_ID, "-", o_pay_point, "포인트 사용 (주문코드 : " & o_code & ")")
End If


Response.Redirect "?mode=order_end&o_code=" & o_code

%>

<script>
// 결제 중 새로고침 방지 샘플 스크립트 (중복결제 방지)
function noRefresh()
{
	/* CTRL + N키 막음. */
	if ((event.keyCode == 78) && (event.ctrlKey == true))
	{
		event.keyCode = 0;
		return false;
	}
	/* F5 번키 막음. */
	if(event.keyCode == 116)
	{
		event.keyCode = 0;
		return false;
	}
}

document.onkeydown = noRefresh ;
</script>