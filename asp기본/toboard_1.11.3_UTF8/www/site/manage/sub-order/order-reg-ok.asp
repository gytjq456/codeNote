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
o_code = Request("o_code")

s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_state=" & s_state & "&s_pay_method=" & s_pay_method

If mode="mod" Then

	o_name = InsertText(Request("o_name"))
	o_tel = InsertText(Request("o_tel"))
	o_zip = InsertText(Request("o_zip"))
	o_addr1 = InsertText(Request("o_addr1"))
	o_addr2 = InsertText(Request("o_addr2"))
	o_email = InsertText(Request("o_email"))
	s_name = InsertText(Request("s_name"))
	s_tel = InsertText(Request("s_tel"))
	s_zip = InsertText(Request("s_zip"))
	s_addr1 = InsertText(Request("s_addr1"))
	s_addr2 = InsertText(Request("s_addr2"))
	s_text = InsertText(Request("s_text"))
	o_state = Request("o_state")
	o_deli = InsertText(Request("o_deli"))
	o_deli_code = InsertText(Request("o_deli_code"))
	o_deli_date = InsertText(Request("o_deli_date"))
	o_memo = InsertText(Request("o_memo"))

	Sql = "UPDATE tbl_mall_order SET "
	Sql = Sql & "o_name='" & o_name & "', "
	Sql = Sql & "o_tel='" & o_tel & "', "
	Sql = Sql & "o_zip='" & o_zip & "', "
	Sql = Sql & "o_addr1='" & o_addr1 & "', "
	Sql = Sql & "o_addr2='" & o_addr2 & "', "
	Sql = Sql & "o_email='" & o_email & "', "
	Sql = Sql & "s_name='" & s_name & "', "
	Sql = Sql & "s_tel='" & s_tel & "', "
	Sql = Sql & "s_zip='" & s_zip & "', "
	Sql = Sql & "s_addr1='" & s_addr1 & "', "
	Sql = Sql & "s_addr2='" & s_addr2 & "', "
	Sql = Sql & "s_text='" & s_text & "', "
	Sql = Sql & "o_state='" & o_state & "', "
	Sql = Sql & "o_deli=N'" & o_deli & "', "
	Sql = Sql & "o_deli_code=N'" & o_deli_code & "', "
	Sql = Sql & "o_deli_date=N'" & o_deli_date & "', "
	Sql = Sql & "o_memo=N'" & o_memo & "' WHERE o_code='" & o_code & "' "
	Dbcon.Execute Sql

	'포인트 지급처리
	If o_state="발송완료" And mc_point_use=True Then Call SetPointProv(o_code)

	Response.Write "<script>alert('수정 되었습니다.'); location.href='order.asp?" & pLink & "';</script>"


ElseIf mode="st_mod" Then

	o_state = Request("o_state")

	Sql = "UPDATE tbl_mall_order SET "
	Sql = Sql & "o_state='" & o_state & "' "
	Sql = Sql & " WHERE o_code='" & o_code & "' "
	Dbcon.Execute Sql

	'포인트 지급처리
	If o_state="발송완료" And mc_point_use=True Then Call SetPointProv(o_code)

	Response.Write "<script>alert('" & o_state & " 상태로 수정 되었습니다.'); location.href='order.asp?" & pLink & "';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_mall_order WHERE o_code='" & o_code & "' "
	Dbcon.Execute Sql

	Sql = "DELETE FROM tbl_mall_cart WHERE o_code='" & o_code & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='order.asp?" & pLink & "';</script>"


ElseIf mode="seldel_p" Then

	a_o_code = Split(o_code, ", ")

	Sql = ""
	For Each itm In a_o_code
		Sql = Sql & "DELETE FROM tbl_mall_order WHERE o_code='" & itm & "'; " & Chr(13) & Chr(10)
		Sql = Sql & "DELETE FROM tbl_mall_cart WHERE o_code='" & itm & "'; " & Chr(13) & Chr(10)
	Next
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='order.asp?" & pLink & "';</script>"


End If
%>