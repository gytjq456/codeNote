<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<%
SHOP_ID = "np_nhopo696108"
CERTI_KEY = "07F08905-25AA-446B-B0FE-5A2F6B72F048"

p_idx = Request("p_idx")
p_name = Request("p_name")
p_option = Request("p_option")
p_amount = Request("p_amount")
p_qty = Request("p_qty")
all_amount = p_amount*p_qty

QueryString = "SHOP_ID=" & Server.URLEncode(SHOP_ID)
QueryString = QueryString & "&CERTI_KEY=" & Server.URLEncode(CERTI_KEY)
If all_amount>=50000 Then
	p_deli_amount = 0
	QueryString = QueryString & "&SHIPPING_PRICE=" & p_deli_amount
	QueryString = QueryString & "&SHIPPING_TYPE=FREE"	'무료배송
Else
	p_deli_amount = 3000
	QueryString = QueryString & "&SHIPPING_PRICE=" & p_deli_amount
	QueryString = QueryString & "&SHIPPING_TYPE=PAYED"	'선불
End If
'QueryString = QueryString & "&SHIPPING_TYPE=ONDELIVERY"	'착불
'QueryString = QueryString & "&SHIPPING_TYPE=FREE"	'무료배송
QueryString = QueryString & "&TOTAL_PRICE=" & Server.URLEncode(all_amount+p_deli_amount)
QueryString = QueryString & "&BACK_URL=" & Server.URLEncode("http://" & Request.ServerVariables("SERVER_NAME") & "/kr/sub/shop/list.asp?q=prod&mode=view&idx=" & p_idx)
QueryString = QueryString & "&RESERVE1="
QueryString = QueryString & "&RESERVE2="
QueryString = QueryString & "&RESERVE3="
QueryString = QueryString & "&RESERVE4="
QueryString = QueryString & "&RESERVE5="
QueryString = QueryString & "&SA_CLICK_ID=" & mSaClickId 'CTS CPA 스크립트 가이드 설치업체는 해당 값 전달
QueryString = QueryString & "&CPA_INFLOW_CODE=" & Server.URLEncode(mCpaInflowCode)
QueryString = QueryString & "&NAVER_INFLOW_CODE=" & Server.URLEncode(Request.Cookies("NA_CO"))

QueryString = QueryString & "&ITEM_ID=" & Server.URLEncode(p_idx)
QueryString = QueryString & "&ITEM_NAME=" & Server.URLEncode(p_name)
QueryString = QueryString & "&ITEM_COUNT=" & Server.URLEncode(p_qty)
QueryString = QueryString & "&ITEM_UPRICE=" & Server.URLEncode(p_amount)
QueryString = QueryString & "&ITEM_TPRICE=" & Server.URLEncode(p_amount*p_qty)
QueryString = QueryString & "&ITEM_OPTION=" & Server.URLEncode(p_option)

'Response.write QueryString

Set objXMLHTTP = server.CreateObject("MSXML2.ServerXMLHTTP")
objXMLHTTP.setOption 2, 13056 'ignore SSL errors
objXMLHTTP.Open "POST", "https://pay.naver.com/customer/api/order.nhn", False
objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"
objXMLHTTP.Send QueryString

If objXMLHTTP.status=200 Then
	orderId = objXMLHTTP.responseText
	Response.write orderId & "||" & SHOP_ID & "||" & all_amount
End If

%>