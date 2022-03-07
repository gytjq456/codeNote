<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.xl2225652{
	mso-ignore:padding;
	mso-generic-font-family:auto;
	mso-font-charset:129;
	mso-number-format:"\@";
	mso-background-source:auto;
	mso-pattern:auto;
}
.tblhead1{background-color:#de2316; color:#fff; font-weight:bold;}
.tblhead2{background-color:#009905; color:#fff; font-weight:bold;}
.tblhead3{background-color:#0074d4; color:#fff; font-weight:bold;}
</style>
</head>
<%
Response.CacheControl = "public" 
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-disposition","attachment;filename=ORDER_" & Date() & ".xls"

s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")
%>

<table>
<tr>
	<th class="tblhead1">주문코드</th>
	<th class="tblhead1">회원분류</th>
	<th class="tblhead1">아이디</th>
	<th class="tblhead1">이름</th>
	<th class="tblhead1">결제수단</th>
	<th class="tblhead1">진행상태</th>
	<th class="tblhead1">주문일</th>

	<th class="tblhead2">상품명</th>
	<th class="tblhead2">옵션</th>
	<th class="tblhead2">단가(원)</th>
	<th class="tblhead2">수량</th>
	<th class="tblhead2">합계금액(원)</th>

	<th class="tblhead3">수취인</th>
	<th class="tblhead3">수취인 연락처</th>
	<th class="tblhead3">수취주소</th>
	<th class="tblhead3">메모</th>
</tr>
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT A.*, B.*, C.m_sort, C.addtext1, C.addtext2 FROM dbo.tbl_mall_cart A "
Sql = Sql & " INNER JOIN tbl_mall_order B ON A.o_code=B.o_code "
Sql = Sql & " LEFT JOIN tbl_member C ON A.m_id=C.m_id "
Sql = Sql & " WHERE A.o_code!='' "

If s_keyword<>"" Then
	Sql = Sql & " AND (B.o_code LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.m_id LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.o_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.o_tel LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.o_email LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_tel LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_addr1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_addr2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_zip LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.s_text LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR B.o_memo LIKE '%" & s_keyword & "%') "
End If


If s_state="-1" Then
	Sql = Sql & " AND A.o_state='' "
ElseIf s_state<>"" Then
	Sql = Sql & " AND A.o_state='" & s_state & "' "
End If
If s_pay_method<>"" Then Sql = Sql & " AND B.o_pay_method='" & s_pay_method & "' "

If s_srdate<>"" And s_erdate<>"" Then
	Sql = Sql & "AND B.regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
ElseIf s_srdate<>"" Then
	Sql = Sql & "AND B.regdate>'" & s_srdate & "' "
ElseIf s_erdate<>"" Then
	Sql = Sql & "AND B.regdate<'" & DateAdd("d", 1, s_erdate) & "' "
End If

Sql = Sql & " ORDER BY B.regdate DESC"
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Rs.EOF=False Then
	Do Until Rs.EOF
		idx = Rs("idx")
		m_id = Rs("m_id")
		o_code = Rs("o_code")
		o_pay_method = Rs("o_pay_method")
		o_state = Rs("o_state")
		o_name = Rs("o_name")
		s_name = Rs("s_name")
		s_tel = Rs("s_tel")
		s_zip = Rs("s_zip")
		s_addr1 = Rs("s_addr1")
		s_addr2 = Rs("s_addr2")
		s_text = Rs("s_text")
		regdate = Rs("regdate")

		p_name = Rs("p_name")
		p_option = Rs("p_option")
		p_amount = Rs("p_amount")
		p_point_a = Rs("p_point_a")
		p_qty = Rs("p_qty")
		p_total = p_amount*p_qty

		m_sort = Rs("m_sort")
		%>
		<tr>
			<td class="xl2225652"><%=o_code%></td>
			<td class="xl2225652"><%=m_sort%></td>
			<td class="xl2225652"><%=m_id%></td>
			<td class="xl2225652"><%=o_name%></td>
			<td class="xl2225652"><%=o_pay_method%></td>
			<td class="xl2225652"><%=o_state%></td>
			<td class="xl2225652"><%=regdate%></td>

			<td class="xl2225652"><%=p_name%></td>
			<td class="xl2225652"><%=p_option%></td>
			<td class="xl2225652"><%=p_amount%></td>
			<td class="xl2225652"><%=p_qty%></td>
			<td class="xl2225652"><%=p_total%></td>

			<td class="xl2225652"><%=s_name%></td>
			<td class="xl2225652"><%=s_tel%></td>
			<td class="xl2225652"><%="[" & s_zip & "] " & s_addr1 & " " & s_addr2%></td>
			<td class="xl2225652"><%=s_text%></td>
		</tr>
		<%
		Rs.MoveNext
	Loop
End If
Rs.Close
Set Rs = Nothing%>
</table>