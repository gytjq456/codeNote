<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp"-->
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")

If mode="mod" Then 

	Sql = "UPDATE tbl_mall_config SET "
	Sql = Sql & "mc_use=N'" & InsertText(Request("mc_use")) & "', "
	Sql = Sql & "mc_shop_url=N'" & InsertText(Request("mc_shop_url")) & "', "
	Sql = Sql & "mc_order_lev=N'" & InsertText(Request("mc_order_lev")) & "', "
	Sql = Sql & "mc_point_use=N'" & InsertText(Request("mc_point_use")) & "', "
	Sql = Sql & "mc_point_join=N'" & InsertText(Request("mc_point_join")) & "', "
	Sql = Sql & "mc_coupon=N'" & InsertText(Request("mc_coupon")) & "', "
	Sql = Sql & "mc_bank_flag=N'" & InsertText(Request("mc_bank_flag")) & "', "
	Sql = Sql & "mc_bank_no=N'" & InsertText(Request("mc_bank_no")) & "', "
	Sql = Sql & "mc_deli=N'" & InsertText(Request("mc_deli")) & "', "
	Sql = Sql & "mc_deli_charge=N'" & InsertText(Request("mc_deli_charge")) & "', "
	Sql = Sql & "mc_deli_free=N'" & InsertText(Request("mc_deli_free")) & "', "
	Sql = Sql & "mc_deli_content=N'" & InsertText(Request("mc_deli_content")) & "', "
	Sql = Sql & "mc_chng_content=N'" & InsertText(Request("mc_chng_content")) & "'"
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='mall-info.asp';</script>"

ElseIf mode="setpoint" Then 

	Sql = "UPDATE tbl_prod SET "
	Sql = Sql & "p_point=ROUND(p_price*" & Request("mc_point_set") & "/100, 0, 1) "
	Dbcon.Execute Sql

	Response.Write "<script>alert('포인트가 일괄 적용되었습니다.');location.href='mall-info.asp';</script>"


End If
%>