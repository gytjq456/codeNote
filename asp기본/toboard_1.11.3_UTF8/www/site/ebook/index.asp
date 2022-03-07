<%
s_keyword = Request("s_keyword")

page = Request("page")
If page="" Then page=1

pLink = "s_keyword=" & s_keyword

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT A.idx, A.e_title, A.regdate, "
Sql = Sql & " (SELECT top 1 B.e_file FROM tbl_ebook_img B "
Sql = Sql & " WHERE B.e_idx=A.idx ORDER BY B.e_lev ASC) AS e_file "
Sql = Sql & " FROM tbl_ebook A "
Sql = Sql & " WHERE A.idx!='' ORDER BY A.regdate DESC "
Rs.Open Sql, Dbcon, 1

'페이지 설정
If Rs.EOF=False Then
	Rs.PageSize = 10
	Rs.AbsolutePage = page
	Rs_RecordCount = Rs.RecordCount
	If Rs_RecordCount Mod Rs.PageSize>0 Then
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
	Else
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)
	End If
End If
%>

<ul class="ebooklist">
<%
If Rs.EOF=False Then
	cnt=0
	num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
	Do Until Rs.EOF Or cnt>=Rs.pagesize
		idx = Rs("idx")
		e_title = Rs("e_title")
		e_file = Rs("e_file")
		regdate = Rs("regdate")
		%>
		<li onclick="open('/site/ebook/ebook.asp?idx=<%=idx%>', 'pop2', 'width=1220px, height=900px')" style="cursor:pointer">
			<img src="/upload/ebook/thumb/<%=e_file%>" />
			<p><%=e_title%></p>
		</li>
		<%
		num=num-1
		cnt=cnt+1
		Rs.MoveNext
	Loop
End If
Rs.Close
Set Rs = Nothing%>
</ul>

<!--페이징-->
<div class="page">
	<ul>
		<%Call pagelist("?" & pLink, CInt(page), 10, 10, Rs_RecordCount)%>
	</ul>
</div>

<style>
.ebooklist { overflow: hidden;}
.ebooklist li { overflow: hidden; float: left; width: 145px; margin: 0 0 20px 20px;}
.ebooklist li:first-child, .ebooklist li:nth-child(5n+1) { margin-left: 0;}
.ebooklist li img { width: 145px; height: 200px;}
.ebooklist li p { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; height: 30px; line-height: 30px; text-align: center;}
</style>