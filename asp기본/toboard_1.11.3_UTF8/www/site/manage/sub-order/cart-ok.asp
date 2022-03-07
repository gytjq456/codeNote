<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp"-->
<%
mode = Request("mode")
idx = Request("idx")
o_code = Request("o_code")
p_qty = Request("p_qty")

If mode="mod" Then

	Sql = "UPDATE tbl_mall_cart SET "
	Sql = Sql & "p_qty='" & p_qty & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	'결제금액, 배송비 재계산
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT SUM(p_amount*p_qty) FROM tbl_mall_cart WHERE o_code='" & o_code & "' "
	Rs.Open Sql, Dbcon, 1
		o_amount = Rs(0)
	Rs.Close
	Set Rs = Nothing

	If mc_deli_free<=o_amount Then
		ct_deli_charge = 0
	Else
		ct_deli_charge = mc_deli_charge
	End If

	Sql = "UPDATE tbl_mall_order SET "
	Sql = Sql & "o_amount='" & o_amount & "', "
	Sql = Sql & "o_deli_amount='" & ct_deli_charge & "' WHERE o_code='" & o_code & "' "
	'Response.write sql
	Dbcon.Execute Sql

	Response.Redirect "order-reg.asp?mode=mod&o_code=" & o_code & "#pdlist"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_mall_cart WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	'결제금액, 배송비 재계산
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT SUM(p_amount*p_qty) FROM tbl_mall_cart WHERE o_code='" & o_code & "' "
	Rs.Open Sql, Dbcon, 1
		o_amount = Rs(0)
	Rs.Close
	Set Rs = Nothing

	If mc_deli_free<=o_amount Then
		ct_deli_charge = 0
	Else
		ct_deli_charge = mc_deli_charge
	End If

	Sql = "UPDATE tbl_mall_order SET "
	Sql = Sql & "o_amount='" & o_amount & "', "
	Sql = Sql & "o_deli_amount='" & ct_deli_charge & "' WHERE o_code='" & o_code & "' "
	'Response.write sql
	Dbcon.Execute Sql


	Response.Write "<script>alert('삭제 되었습니다.'); location.href='order-reg.asp?mode=mod&o_code=" & o_code & "#pdlist';</script>"


End If
%>