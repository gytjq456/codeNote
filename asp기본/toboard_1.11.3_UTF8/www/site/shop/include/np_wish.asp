<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<%
SHOP_ID = "np_nhopo696108"
CERTI_KEY = "07F08905-25AA-446B-B0FE-5A2F6B72F048"

QueryString = "SHOP_ID=" & SHOP_ID
QueryString = QueryString & "&CERTI_KEY=" & CERTI_KEY
QueryString = QueryString & "&RESERVE1="
QueryString = QueryString & "&RESERVE2="
QueryString = QueryString & "&RESERVE3="
QueryString = QueryString & "&RESERVE4="
QueryString = QueryString & "&RESERVE5="

idx = Request("idx")
s_mob = Request("s_mob")

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	p_idx = Rs("idx")
	p_name = Rs("p_name")
	p_price = Rs("p_price")
	p_image1	= Rs("p_image1")

	QueryString = QueryString & "&ITEM_ID=" & p_idx
	QueryString = QueryString & "&ITEM_NAME=" & Server.URLEncode(p_name)
	QueryString = QueryString & "&ITEM_UPRICE=" & p_price
	QueryString = QueryString & "&ITEM_IMAGE=" & Server.URLEncode("http://" & Request.ServerVariables("SERVER_NAME") & "/upload/prod/" & p_image1)
	QueryString = QueryString & "&ITEM_THUMB=" & Server.URLEncode("http://" & Request.ServerVariables("SERVER_NAME") & "/upload/prod/thumb_m/" & p_image1)
	QueryString = QueryString & "&ITEM_URL=" & Server.URLEncode("http://" & Request.ServerVariables("SERVER_NAME") & "/kr/sub/shop/list.asp?q=prod&mode=view&idx=" & p_idx)

End If
Rs.Close
Set Rs = Nothing

Set objXMLHTTP = Server.CreateObject("MSXML2.ServerXMLHTTP")
objXMLHTTP.setOption 2,13056 'ignore SSL errors
objXMLHTTP.Open "POST", "https://pay.naver.com/customer/api/wishlist.nhn", False
objXMLHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"
objXMlHTTP.Send QueryString

If objXMLHTTP.status = 200 Then
	itemId = objXMLHTTP.responseText
End If

If s_mob="1" Then
	send_url = "https://m.pay.naver.com/mobile/customer/wishList.nhn"
Else
	send_url = "https://pay.naver.com/customer/wishlistPopup.nhn"
End If
%>

<html>
<body>
<form name="frm" method="get" action="<%=send_url%>">
	<input type="hidden" name="SHOP_ID" value="<%=SHOP_ID%>">
	<input type="hidden" name="ITEM_ID" value="<%=itemId%>">
</form>
</body>
<script>
<% If objXMLHTTP.status = 200 Then %>
document.frm.target = "_top";
document.frm.submit();
<% End if
Set objXMLHTTP = Nothing
%>
</script>
</html>