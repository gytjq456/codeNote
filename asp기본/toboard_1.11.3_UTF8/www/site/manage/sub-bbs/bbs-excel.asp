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
	background-color:#AAAAAA
}
</style>
</head>
<%
bid=Request("bid")
s_cate=Request("s_cate")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_keyword = Request("s_keyword")
s_lock = Request("s_lock")

Response.CacheControl = "public" 
Response.ContentType = "application/vnd.ms-excel"
Response.AddHeader "Content-disposition","attachment;filename=BBS" & bid & "_" & Date() & ".xls"
%>

<table>
	<tr>
		<th class="tblhead1">카테고리</th>
		<th class="tblhead1">e1_idx</th>
		<th class="tblhead1">e2_idx</th>
		<th class="tblhead1">num</th>
		<th class="tblhead1">p_num</th>
		<th class="tblhead1">r_num</th>
		<th class="tblhead1">d_num</th>
		<th class="tblhead1">이름</th>
		<th class="tblhead1">아이디</th>
		<th class="tblhead1">패스워드</th>
		<th class="tblhead1">연락처</th>
		<th class="tblhead1">팩스</th>
		<th class="tblhead1">URL</th>
		<th class="tblhead1">이메일</th>
		<th class="tblhead1">추가필드1</th>
		<th class="tblhead1">추가필드2</th>
		<th class="tblhead1">추가필드3</th>
		<th class="tblhead1">추가필드4</th>
		<th class="tblhead1">추가필드5</th>
		<th class="tblhead1">추가필드6</th>
		<th class="tblhead1">추가필드7</th>
		<th class="tblhead1">추가필드8</th>
		<th class="tblhead1">추가필드9</th>
		<th class="tblhead1">추가필드10</th>
		<th class="tblhead1">추가필드11</th>
		<th class="tblhead1">추가필드12</th>
		<th class="tblhead1">추가필드13</th>
		<th class="tblhead1">추가필드14</th>
		<th class="tblhead1">추가필드15</th>
		<th class="tblhead1">추가필드16</th>
		<th class="tblhead1">추가필드17</th>
		<th class="tblhead1">추가필드18</th>
		<th class="tblhead1">추가필드19</th>
		<th class="tblhead1">추가필드20</th>
		<th class="tblhead1">제목</th>
		<th class="tblhead1">내용</th>
		<th class="tblhead1">SEO Title</th>
		<th class="tblhead1">SEO Keyword</th>
		<th class="tblhead1">SEO Description</th>
		<th class="tblhead1">댓글수</th>
		<th class="tblhead1">조회수</th>
		<th class="tblhead1">작성자 아이피</th>
		<th class="tblhead1">첨부파일1</th>
		<th class="tblhead1">첨부파일2</th>
		<th class="tblhead1">첨부파일3</th>
		<th class="tblhead1">첨부파일4</th>
		<th class="tblhead1">첨부파일5</th>
		<th class="tblhead1">첨부파일6</th>
		<th class="tblhead1">첨부파일7</th>
		<th class="tblhead1">첨부파일8</th>
		<th class="tblhead1">첨부파일9</th>
		<th class="tblhead1">첨부파일10</th>
		<th class="tblhead1">첨부파일11</th>
		<th class="tblhead1">첨부파일12</th>
		<th class="tblhead1">첨부파일13</th>
		<th class="tblhead1">첨부파일14</th>
		<th class="tblhead1">첨부파일15</th>
		<th class="tblhead1">html</th>
		<th class="tblhead1">notice</th>
		<th class="tblhead1">repmail</th>
		<th class="tblhead1">lock</th>
		<th class="tblhead1">popup</th>
		<th class="tblhead1">작성일</th>
	</tr>

<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_board_data WHERE idx!='' AND board_idx='" & bid & "' "
If s_keyword<>"" Then
	Sql = Sql & " AND (mem_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR title LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR content LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext3 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext4 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext5 LIKE '%" & s_keyword & "%') "
End If

If s_srdate<>"" And s_erdate<>"" Then
	Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
ElseIf s_srdate<>"" Then
	Sql = Sql & "AND regdate>'" & s_srdate & "' "
ElseIf s_erdate<>"" Then
	Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
End If

If s_cate<>"" Then Sql = Sql & "AND cate like '" & s_cate & "' "
If e1_idx<>"" Then Sql = Sql & "AND e1_idx like '" & e1_idx & "' "

Sql = Sql & " ORDER BY notice DESC, p_num DESC, r_num ASC"
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Rs.EOF=False Then
	Do Until Rs.EOF
		Response.Write "<tr>"
		For i=2 To 64
		%>
			<td class="xl2225652"><%=strTagDel(Rs(i))%></td>
		<%
		Next		
		Response.Write "</tr>"
		Rs.MoveNext
	Loop
End If
Rs.Close
Set Rs = Nothing%>
</table>