<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
bbs_keyword = Request("bbs_keyword")

page = Request("page")
If page="" Then page=1

If InStr(bbs_keyword,"'")<>0 Or InStr(bbs_keyword,"%")<>0 Or InStr(bbs_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "bbs_keyword=" & bbs_keyword

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT A.idx, A.board_idx, A.cate, A.title, A.mem_name, A.regdate, B.k_id FROM tbl_board_data A "
Sql = Sql & " LEFT JOIN tbl_board_id B ON A.board_idx=B.idx "
Sql = Sql & " WHERE A.idx!='' "
If bbs_keyword<>"" Then
	Sql = Sql & " AND (A.mem_name LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext1 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext2 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext3 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext4 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext5 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext6 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext7 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext8 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext9 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext10 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext11 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext12 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext13 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext14 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.addtext15 LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.title LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.content LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.seo_title LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.seo_keyword LIKE '%" & bbs_keyword & "%' "
	Sql = Sql & " OR A.seo_description LIKE '%" & bbs_keyword & "%') "
End If
Sql = Sql & " ORDER BY A.regdate DESC "
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

'페이지 설정
If Rs.EOF=False Then
	Rs.PageSize = 30
	Rs.AbsolutePage = page
	Rs_RecordCount = Rs.RecordCount
	If Rs_RecordCount Mod Rs.PageSize>0 Then
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
	Else
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)
	End If
End If
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>게시판 검색 결과</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>게시판 검색 결과</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list pdb50">
		<table>
			<colgroup>
				<col width="50px" />
				<col width="120px" />
				<col width="" />
				<col width="120px" />
				<col width="120px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">게시판 명</th>
				<th class="bdr">제목</th>
				<th class="bdr">작성자</th>
				<th class="bdr">등록일</th>
			</tr>
			<%
			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					sch_idx = Rs("idx")
					sch_bid = Rs("board_idx")
					sch_bname = Rs("k_id")
					sch_cate = Rs("cate")
					sch_title = Rs("title")
					sch_writer = Rs("mem_name")
					sch_regdate = Left(Rs("regdate"), 10)
					%>
				<tr>
					<td class="bdr bdt"><%=num%></td>
					<td class="bdr bdt"><a href="bbs.asp?bid=<%=sch_bid%>&mode=list"><%=sch_bname%></a></td>
					<td class="bdr bdt tit"><a href="bbs.asp?bid=<%=sch_bid%>&mode=view&idx=<%=sch_idx%>"><%=sch_title%></a></td>
					<td class="bdr bdt"><%=sch_writer%></td>
					<td class="bdt"><%=sch_regdate%></td>
				</tr>
				<%
				num=num-1
				cnt=cnt+1
				Rs.MoveNext
			Loop
			Else
				%>
			<tr>
				<td colspan="5" class="bdt">검색결과가 존재하지 않습니다.</td>
			</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	<!-- page -->
	<div class="page">
		<ul>
			<%Call pagelist("bbs-search.asp?" & pLink, CInt(page), 30, 10, Rs_RecordCount)%>
		</ul>
	</div>
	<!-- //page -->

</div>

<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->