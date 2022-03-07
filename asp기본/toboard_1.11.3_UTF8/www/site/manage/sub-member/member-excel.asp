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
.tblhead1{
	background-color:#FFAA99
}
.tblhead2{
	background-color:#CCAAFF
}
</style>
</head>
<%
Response.CacheControl = "public" 
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-disposition","attachment;filename=MEMBER_" & Date() & ".xls"

s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")

s_align = Request("s_align")
If s_align="" Then s_align="0"
%>


<table>
<tr>
	<th class="tblhead1">등급</th>
	<th class="tblhead1">분류</th>
	<th class="tblhead1">아이디</th>
	<th class="tblhead1">이름</th>
	<th class="tblhead1">이메일</th>
	<th class="tblhead1">메일수신</th>
	<th class="tblhead1">연락처</th>
	<th class="tblhead1">휴대전화</th>
	<th class="tblhead1">우편번호</th>
	<th class="tblhead1">주소</th>
	<th class="tblhead1">로그인 횟수</th>
	<th class="tblhead1">가입일</th>
	<th class="tblhead1">최종수정일</th>
</tr>
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_member "
Sql = Sql & " WHERE idx!='' "
Sql = Sql & " AND m_lev>=10 "	'관리자를 제외한 회원만 검색

If s_keyword<>"" Then
	Sql = Sql & " AND (m_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR m_id LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR m_email LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR m_addr1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR m_addr2 LIKE '%" & s_keyword & "%') "
End If

If s_srdate<>"" And s_erdate<>"" Then
	Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
ElseIf s_srdate<>"" Then
	Sql = Sql & "AND regdate>'" & s_srdate & "' "
ElseIf s_erdate<>"" Then
	Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
End If

Select Case s_align
	Case "0"
		Sql = Sql & " ORDER BY regdate DESC"
	Case "1"
		Sql = Sql & " ORDER BY regdate"
	Case "2"
		Sql = Sql & " ORDER BY m_name DESC"
	Case "3"
		Sql = Sql & " ORDER BY m_name"
	Case "4"
		Sql = Sql & " ORDER BY m_id DESC"
	Case "5"
		Sql = Sql & " ORDER BY m_id"
	Case "6"
		Sql = Sql & " ORDER BY m_logcount DESC"
	Case "7"
		Sql = Sql & " ORDER BY m_logcount"
End Select
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Rs.EOF=False Then
	Do Until Rs.EOF
		idx = Rs("idx")
		m_lev = Rs("m_lev")
		m_sort = Rs("m_sort")
		m_id = Rs("m_id")
		m_pw = Rs("m_pw")
		m_name = Rs("m_name")
		m_jumin = Rs("m_jumin")
		m_email = Rs("m_email")
		m_mailing = Rs("m_mailing")
		m_tel1 = Rs("m_tel1")
		m_tel2 = Rs("m_tel2")
		m_tel3 = Rs("m_tel3")
		m_cell1 = Rs("m_cell1")
		m_cell2 = Rs("m_cell2")
		m_cell3 = Rs("m_cell3")
		m_zip1 = Rs("m_zip1")
		m_zip2 = Rs("m_zip2")
		m_addr1 = Rs("m_addr1")
		m_addr2 = Rs("m_addr2")
		m_logcount = Rs("m_logcount")
		addtext1 = Rs("addtext1")
		addtext2 = Rs("addtext2")
		addtext3 = Rs("addtext3")
		addtext4 = Rs("addtext4")
		addtext5 = Rs("addtext5")
		addtext6 = Rs("addtext6")
		addtext7 = Rs("addtext7")
		addtext8 = Rs("addtext8")
		addtext9 = Rs("addtext9")
		addtext10 = Rs("addtext10")
		addtext11 = Rs("addtext11")
		addtext12 = Rs("addtext12")
		addtext13 = Rs("addtext13")
		addtext14 = Rs("addtext14")
		addtext15 = Rs("addtext15")
		addtext16 = Rs("addtext16")
		addtext17 = Rs("addtext17")
		addtext18 = Rs("addtext18")
		addtext19 = Rs("addtext19")
		addtext20 = Rs("addtext20")
		regdate = Rs("regdate")
		moddate = Rs("moddate")
		%>
		<tr>
			<td class="xl2225652"><%=m_lev%></td>
			<td class="xl2225652"><%=m_sort%></td>
			<td class="xl2225652"><%=m_id%></td>
			<td class="xl2225652"><%=m_name%></td>
			<td class="xl2225652"><%=m_email%></td>
			<td class="xl2225652"><%If m_mailing=True Then Response.Write "o"%></td>
			<td class="xl2225652"><%=m_tel1 & "-" & m_tel2 & "-" & m_tel3%></td>
			<td class="xl2225652"><%=m_cell1 & "-" & m_cell2 & "-" & m_cell3%></td>
			<td class="xl2225652"><%=m_zip1 & "-" & m_zip2%></td>
			<td class="xl2225652"><%=m_addr1 & " " & m_addr2%></td>
			<td class="xl2225652"><%=m_logcount%></td>
			<td class="xl2225652"><%=regdate%></td>
			<td class="xl2225652"><%=moddate%></td>
		</tr>
		<%
		Rs.MoveNext
	Loop
End If
Rs.Close
Set Rs = Nothing%>
</table>