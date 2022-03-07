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
idx = Request("idx")

c_name = InsertText(Request("c_name"))
c_enddate = InsertText(Request("c_enddate"))
c_dc_type = InsertText(Request("c_dc_type"))
c_dc_amount = InsertText(Request("c_dc_amount"))
c_dl_type = InsertText(Request("c_dl_type"))

If mode="reg" Then

	Sql = "INSERT INTO tbl_coupon("
	Sql = Sql & "c_name, "
	Sql = Sql & "c_enddate, "
	Sql = Sql & "c_dc_type, "
	Sql = Sql & "c_dc_amount, "
	Sql = Sql & "c_dl_type) VALUES("
	Sql = Sql & 	"N'" & c_name & "', "
	Sql = Sql & 	"N'" & c_enddate & "', "
	Sql = Sql & 	"N'" & c_dc_type & "', "
	Sql = Sql & 	"N'" & c_dc_amount & "', "
	Sql = Sql & 	"N'" & c_dl_type & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.'); location.href='coupon.asp';</script>"


ElseIf mode="mod" Then

	Sql = "UPDATE tbl_coupon SET "
	Sql = Sql & "c_name='" & c_name & "', "
	Sql = Sql & "c_enddate=N'" & c_enddate & "', "
	Sql = Sql & "c_dc_type=N'" & c_dc_type & "', "
	Sql = Sql & "c_dc_amount=N'" & c_dc_amount & "', "
	Sql = Sql & "c_dl_type=N'" & c_dl_type & "' WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='coupon.asp';</script>"


ElseIf mode="del" Then

	Sql = "DELETE FROM tbl_coupon WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='coupon.asp';</script>"

End If
%>