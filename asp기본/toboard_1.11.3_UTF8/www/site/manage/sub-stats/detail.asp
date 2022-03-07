<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script>
$( function() {
	$("#s_srdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#s_erdate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
</head>

<%
s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate

%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>세부 접속 로그</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>세부 접속 로그</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="searchform" method="post" action="?">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="IP, HTTP_USER_AGENT, SESSION ID 등"></td>
				<th class="bdb bdr">날짜</th>
				<td class="bdb">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div>
				</td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<form name="listform" method="post" action="?">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>접속 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="120px" />
				<col width="150px" />
				<col width="150px" />
				<col width="120px" />
				<col width="" />
				<col width="180px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">접속 IP</th>
				<th class="bdr">접속 사이트</th>
				<th class="bdr">검색 키워드</th>
				<th class="bdr">SESSION ID</th>
				<th class="bdr">HTTP_USER_AGENT</th>
				<th class="bdr">날짜</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_counter_log "
			Sql = Sql & " WHERE cl_ip!='' "

			If s_keyword<>"" Then
				Sql = Sql & " AND (cl_ip LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR cl_site LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR cl_useragent LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR cl_keyword LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR cl_sessionid LIKE '%" & s_keyword & "%') "
			End If

			If s_srdate<>"" And s_erdate<>"" Then Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "

			Sql = Sql & " ORDER BY regdate DESC"
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 50
				Rs.AbsolutePage = page
				Rs_RecordCount = Rs.RecordCount
				If Rs_RecordCount Mod Rs.PageSize>0 Then
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
				Else
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)
				End If
			End If

			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					cl_ip = Rs("cl_ip")
					cl_site = Left(Rs("cl_site"), 30)
					If Len(cl_site)>30 Then cl_site=cl_site & "..."
					cl_keyword = Left(Rs("cl_keyword"), 30)
					If Len(cl_keyword)>30 Then cl_keyword=cl_keyword & "..."
					cl_sessionid = Rs("cl_sessionid")
					cl_useragent = Rs("cl_useragent")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt"><%=cl_ip%></td>
						<td class="bdr bdt"><%=cl_site%></td>
						<td class="bdr bdt"><%=cl_keyword%></td>
						<td class="bdr bdt"><%=cl_sessionid%></td>
						<td class="bdr bdt"><%=cl_useragent%></td>
						<td class="bdr bdt"><%=regdate%></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="7" class="bdr bdt">접속 로그가 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<!-- page -->
	<div class="page">
		<ul>
			<%Call pagelist("?" & pLink, CInt(page), 50, 10, Rs_RecordCount)%>
		</ul>
	</div>
	<!-- //page -->

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->