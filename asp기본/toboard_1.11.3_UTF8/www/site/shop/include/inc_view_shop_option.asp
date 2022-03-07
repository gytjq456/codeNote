<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<%
v1 = InsertText(Request("v1"))
v2 = InsertText(Request("v2"))
v3 = InsertText(Request("v3"))
v4 = InsertText(Request("v4"))
p_price = Request("p_price")

a1 = Split(v1, "§")
a2 = Split(v2, "§")
a3 = Split(v3, "§")
a4 = Split(v4, "§")

If UBound(a1)=0 Then : v1_price = 0 : Else : v1_price = CDbl(a1(1)) : End If
If UBound(a2)=0 Then : v2_price = 0 : Else : v2_price = CDbl(a2(1)) : End If
If UBound(a3)=0 Then : v3_price = 0 : Else : v3_price = CDbl(a3(1)) : End If
If UBound(a4)=0 Then : v4_price = 0 : Else : v4_price = CDbl(a4(1)) : End If

total_price = p_price+v1_price+v2_price+v3_price+v4_price
%>
<div class="box">
	<%p_option = a1(0)%>
	<%If a2(0)<>"undefined" And a2(0)<>"" Then p_option = p_option & ", " & a2(0)%>
	<%If a3(0)<>"undefined" And a3(0)<>"" Then p_option = p_option & ", " & a3(0)%>
	<%If a4(0)<>"undefined" And a4(0)<>"" Then p_option = p_option & ", " & a4(0)%>
	<input type="hidden" name="p_option_tmp" value="<%=p_option%>" />
	<input type="hidden" name="p_amount" class="p_amount" value="<%=total_price%>" />
	<p style="margin-right:20px"><%=p_option%></p>
	<div class="right" style="float:none; margin-right:20px">
		<p>수량: </p>
		<label for="" class="quantity_box">
			<button type="button" class="minus"><img src="/site/images/shop/view_quantity_minus.png" alt="이미지" /></button>
			<input type="text" name="p_qty" class="W40" value="1" maxlength="2" numberOnly min="1" max="99" onchange="SetQty(this)" onkeyup="SetQty(this)"/>
			<button type="button" class="plus"><img src="/site/images/shop/view_quantity_plus.png" alt="이미지" /></button>
		</label>
	</div>
	<div name="td_price"><%=FormatNumber(total_price, 0)%>원</div>
	<div><button type="button" class="AXButtonSmall" onclick="SetDel(this)">×</button></div>
</div>