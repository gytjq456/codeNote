<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<%
SHOP_ID = "np_nhopo696108"
CERTI_KEY = "07F08905-25AA-446B-B0FE-5A2F6B72F048"

QueryString = "SHOP_ID=" & SHOP_ID
QueryString = QueryString & "&CERTI_KEY=" & CERTI_KEY
'QueryString = QueryString & "&SHIPPING_PRICE=" & p_deli_amount
'QueryString = QueryString & "&SHIPPING_TYPE=PAYED"	'선불
'QueryString = QueryString & "&SHIPPING_TYPE=ONDELIVERY"	'착불
'QueryString = QueryString & "&SHIPPING_TYPE=FREE"	'무료배송
QueryString = QueryString & "&BACK_URL=" & Server.URLEncode("http://" & Request.ServerVariables("SERVER_NAME") & "/kr/sub/shop/shop.asp?mode=cart")
QueryString = QueryString & "&RESERVE1="
QueryString = QueryString & "&RESERVE2="
QueryString = QueryString & "&RESERVE3="
QueryString = QueryString & "&RESERVE4="
QueryString = QueryString & "&RESERVE5="
QueryString = QueryString & "&SA_CLICK_ID=" & mSaClickId 'CTS CPA 스크립트 가이드 설치업체는 해당 값 전달
QueryString = QueryString & "&CPA_INFLOW_CODE=" & Server.URLEncode(mCpaInflowCode)
QueryString = QueryString & "&NAVER_INFLOW_CODE=" & Server.URLEncode(Request.Cookies("NA_CO"))

'장바구니 정보 취득
Set RsCart = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_cart "
Sql = Sql & " WHERE idx!='' AND o_code='' "
If Request.Cookies("W_ID")<>"" Then
	Sql = Sql & " AND m_id='" & Request.Cookies("W_ID") & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
Sql = Sql & " ORDER BY idx ASC"
RsCart.Open Sql, Dbcon, 1

ct_all_amount=0
If RsCart.EOF=False Then
	Do Until RsCart.EOF
		num=num+1
		ct_p_idx = RsCart("p_idx")
		ct_p_name = RsCart("p_name")
		ct_p_option = RsCart("p_option")
		ct_p_amount = RsCart("p_amount")
		ct_p_qty = RsCart("p_qty")
		ct_p_tamount = ct_p_amount*ct_p_qty

		QueryString = QueryString & "&ITEM_ID=" & Server.URLEncode(ct_p_idx)
		QueryString = QueryString & "&ITEM_NAME=" & Server.URLEncode(ct_p_name)
		QueryString = QueryString & "&ITEM_COUNT=" & Server.URLEncode(ct_p_qty)
		QueryString = QueryString & "&ITEM_UPRICE=" & Server.URLEncode(ct_p_amount)
		QueryString = QueryString & "&ITEM_TPRICE=" & Server.URLEncode(ct_p_tamount)
		QueryString = QueryString & "&ITEM_OPTION=" & Server.URLEncode(ct_p_option)

		ct_all_amount = ct_all_amount+ct_p_tamount
		RsCart.Movenext
	Loop
End If
RsCart.Close
Set RsCart = Nothing

If all_amount>=50000 Then
	p_deli_amount = 0
	QueryString = QueryString & "&SHIPPING_PRICE=" & p_deli_amount
	QueryString = QueryString & "&SHIPPING_TYPE=FREE"	'무료배송
Else
	p_deli_amount = 3000
	QueryString = QueryString & "&SHIPPING_PRICE=" & p_deli_amount
	QueryString = QueryString & "&SHIPPING_TYPE=PAYED"	'선불
End If
QueryString = QueryString & "&TOTAL_PRICE=" & Server.URLEncode(ct_all_amount+p_deli_amount)

Set objXMLHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
objXMLHTTP.setOption 2, 13056 'ignore SSL errors
objXMLHTTP.Open "POST", "https://pay.naver.com/customer/api/order.nhn", False
objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"
objXMLHTTP.Send QueryString

If objXMLHTTP.status=200 Then
	orderId = objXMLHTTP.responseText
	Response.write orderId & "||" & SHOP_ID & "||" & ct_all_amount
End If

%>