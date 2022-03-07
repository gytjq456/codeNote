<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
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
Response.AddHeader "Content-disposition","attachment;filename=PRODUCT_" & Date() & ".xls"

s_cate1=Request("catcode1")
s_cate2=Request("catcode2")
s_cate3=Request("catcode3")

If s_cate1="" Then s_cate1=Request("s_cate1")
If s_cate2="" Then s_cate2=Request("s_cate2")
If s_cate3="" Then s_cate3=Request("s_cate3")
s_keyword = Request("s_keyword")
s_hide = Request("s_hide")

ReDim p_item(10), p_item_text(10), p_image(8), p_file(6), p_content(6), p_addtext(5)
%>

<table>
<tr>
	<th class="tblhead1">제품명</th>
	<th class="tblhead1">카테고리코드</th>
	<th class="tblhead1">제품코드</th>
	<%
	For i=1 To 10
	%>
	<th class="tblhead1">항목명<%=i%></th>
	<th class="tblhead1">항목내용<%=i%></th>
	<%
	Next
	For i=1 To 6
	%>
	<th class="tblhead1">설명<%=i%></th>
	<%
	Next
	For i=1 To 8
	%>
	<th class="tblhead1">이미지파일<%=i%></th>
	<%
	Next
	For i=1 To 6
	%>
	<th class="tblhead1">첨부파일<%=i%></th>
	<%
	Next
	%>
	<th class="tblhead1">판매가격</th>
	<th class="tblhead1">진열레벨</th>
	<th class="tblhead1">조회수</th>
	<th class="tblhead1">숨김여부</th>
	<th class="tblhead1">등록일</th>
	<th class="tblhead1">최종수정일</th>
</tr>

<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_prod "
Sql = Sql & " WHERE idx!='' "
If s_cate1<>"" Then
	Sql = Sql & " AND (p_cate='" & s_cate1 & "' OR p_cate LIKE '" & s_cate1 & ".%') "
End If
If s_cate2<>"" Then
	Sql = Sql & " AND (p_cate='" & s_cate2 & "' OR p_cate LIKE '" & s_cate2 & ".%') "
End If
If s_cate3<>"" Then
	Sql = Sql & " AND p_cate LIKE '" & s_cate3 & "' "
End If

If s_keyword<>"" Then
	Sql = Sql & " AND (p_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_code LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text3 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text4 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text5 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text6 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text7 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text8 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text9 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_item_text10 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_addtext1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_addtext2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_addtext3 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_addtext4 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_addtext5 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content3 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content4 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content5 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR p_content6 LIKE '%" & s_keyword & "%') "
End If

If s_hide<>"" Then
	Sql = Sql & " AND p_hide='" & s_hide & "' "
End If

Select Case s_align
	Case "0"
		Sql = Sql & " ORDER BY p_lev DESC"
	Case "1"
		Sql = Sql & " ORDER BY p_lev"
	Case Else
		Sql = Sql & " ORDER BY p_lev DESC"
End Select
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Rs.EOF=False Then
	Do Until Rs.EOF
		p_name=Rs("p_name")
		p_cate=Rs("p_cate")
		p_code=Rs("p_code")
		For i=1 To 10
			p_item(i-1)=Rs("p_item" & i)
			p_item_text(i-1)=Rs("p_item_text" & i)
		Next
		For i=1 To 8
			p_image(i-1)=Rs("p_image" & i)
		Next
		For i=1 To 6
			p_file(i-1)=Rs("p_file" & i)
			p_content(i-1)=Rs("p_content" & i)
		Next
		For i=1 To 5
			p_addtext(i-1)=Rs("p_addtext" & i)
		Next
		p_memo=Rs("p_memo")
		p_price=Rs("p_price")
		p_lev=Rs("p_lev")
		p_hit=Rs("p_hit")
		p_hide=Rs("p_hide")
		regdate=Rs("regdate")
		moddate=Rs("moddate")
		%>
		<tr>
			<td class="xl2225652"><%=p_name%></td>
			<td class="xl2225652"><%=p_cate%></td>
			<td class="xl2225652"><%=p_code%></td>
			<%
			For i=1 To 10
			%>
			<td class="xl2225652"><%=p_item(i-1)%></td>
			<td class="xl2225652"><%=p_item_text(i-1)%></td>
			<%
			Next
			For i=1 To 6
			%>
			<td class="xl2225652"><%=TagText(p_content(i-1))%></td>
			<%
			Next
			For i=1 To 8
			%>
			<td class="xl2225652"><%=p_image(i-1)%></td>
			<%
			Next
			For i=1 To 6
			%>
			<td class="xl2225652"><%=p_file(i-1)%></td>
			<%
			Next
			%>
			<td class="xl2225652"><%=p_price%></td>
			<td class="xl2225652"><%=p_lev%></td>
			<td class="xl2225652"><%=p_hit%></td>
			<td class="xl2225652"><%If p_hide=True Then : Response.Write "o" : Else : Response.Write "x" : End If%></td>
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