<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->
<!--#include virtual="/site/common/base64.asp" -->
<!--#include virtual="/site/common/json.asp" -->
<% 

skey = "test_sk_D4yKeq5bgrp5xKw6yWL8GX0lzW6Y"	'시크릿키
atz = "Basic " & BASE64_ENCODE(skey & ":")

Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
objXMLHTTP.setOption 2, 13056 'ignore SSL errors
objXMLHTTP.Open "POST", "https://api.tosspayments.com/v1/payments/" & Request("paymentKey"), False
objXMLHTTP.setRequestHeader "Authorization", atz
objXMLHTTP.setRequestHeader "Content-Type", "application/json"
objXMLHTTP.Send "{""orderId"": """ & Request("orderId") & """, ""amount"": " & Request("amount") & "}"

resp = objXMLHTTP.responseText
'Response.write resp

Set result = JSON.parse(join(array(resp)))

'결제 승인 시
If result.status="DONE" Then

	o_code = result.orderId
	if result.method="카드" Then
		o_pay_method = "신용카드"
	Else
		o_pay_method = result.method
	End If
	o_coupon_code = Request("o_coupon_code")
	o_coupon_amount = Request("o_coupon_amount")
	o_pay_point = Request("o_pay_point")
	p_pay_log = result.card.company & " / " & result.card.number & " / " & result.card.cardType & " / " & result.card.ownerType

	Sql = "UPDATE tbl_mall_cart SET "
	Sql = Sql & " o_code='" & o_code & "' "
	Sql = Sql & " WHERE o_code='' "
	If W_ID<>"" Then
		Sql = Sql & " AND m_id='" & W_ID & "' "
	Else
		Sql = Sql & " AND session_id='" & W_SID & "' "
	End If
	'Response.write sql
	Dbcon.Execute Sql

	'주문정보 수정
	Sql = "UPDATE tbl_mall_order SET "
	Sql = Sql & " o_pay_method=N'" & o_pay_method & "', "
	Sql = Sql & " o_pay_point=N'" & o_pay_point & "', "
	Sql = Sql & " o_coupon_code=N'" & o_coupon_code & "', "
	Sql = Sql & " o_coupon_amount=N'" & o_coupon_amount & "', "
	Sql = Sql & " o_pay_log=N'" & p_pay_log & "', "
	Sql = Sql & " o_state=N'결제완료' "
	Sql = Sql & " WHERE o_code='" & o_code & "' "
	If W_ID<>"" Then
		Sql = Sql & " AND m_id='" & W_ID & "' "
	Else
		Sql = Sql & " AND session_id='" & W_SID & "' "
	End If
	'Response.write sql
	Dbcon.Execute Sql

	'포인트 결제
	If o_pay_point>0 Then 
		Call SetPoint(W_ID, "-", o_pay_point, "포인트 사용 (주문코드 : " & o_code & ")")
	End If

	Response.Redirect mc_shop_url & "?mode=order_end&o_code=" & o_code
Else
	Response.Write result.status & " / "
	Response.Write result.message
End If

Set result = Nothing
%>
<script>
/*
function noRefresh(){
	if ((event.keyCode == 78) && (event.ctrlKey == true))	{
		event.keyCode = 0;
		return false;
	}
	if(event.keyCode == 116)	{
		event.keyCode = 0;
		return false;
	}
}

document.onkeydown = noRefresh ;
*/
</script>