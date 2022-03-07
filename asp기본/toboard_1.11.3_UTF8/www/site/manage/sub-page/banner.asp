<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
s_bc_name = Request("s_bc_name")

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.');history.back();</script>"
	Response.End
End If

Set Rs = Server.CreateObject("ADODB.Recordset")

Sql = "SELECT * FROM tbl_banner "
Sql = Sql & " WHERE idx!='' "
If s_bc_name<>"" Then Sql = Sql & " AND b_sort='" & s_bc_name & "' "
Sql = Sql & " ORDER BY p_lev desc"

pLink = "s_bc_name=" & s_bc_name

'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Request("page") = "" Then
	page = 1
Else
	page = Request("page")
End If

If Rs.EOF=False then

	Rs.pagesize = 30
	Rs.absolutepage = page
	recordcount = Rs.recordcount

	if Rs.recordcount mod Rs.pagesize > 0 then
		maxpage = CInt(recordcount/Rs.pagesize)+1
	Else
		maxpage = CInt(recordcount/Rs.pagesize)
	End If

Else
	recordcount = 0
End If

%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>배너 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>배너 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>배너 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="129px" />
				<col width="250px" />
				<col width="" />
				<col width="110px" />
				<col width="90px" />
				<col width="120px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">이미지</th>
				<th class="bdr">분류</th>
				<th class="bdr">제목</th>
				<th class="bdr">진열레벨</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
			i=0
			k=Rs.recordcount - ((page - 1) * Rs.pagesize) - i
			If Rs.EOF=False Then
				Do Until Rs.eof or i >= Rs.pagesize
					idx = Rs("idx")
					b_sort = Rs("b_sort")
					b_title = Rs("b_title")
					b_file = Rs("b_file")
					b_url = Rs("b_url")
					regdate = Rs("regdate")
					p_lev = Rs("p_lev")
					%>
					<tr>
						<td class="bdr bdt"><%=k%></td>
						<td class="bdr bdt"><img src="/upload/banner/<%=b_file%>" style="width:120px" /></td>
						<td class="bdr bdt"><%=b_sort%></td>
						<td class="bdr bdt tit"><%=b_title%><br />
						<%If b_url<>"" Then%>
						<a href="<%=b_url%>" target="_blank"><%=b_url%></a>
						<%End If%></td>
						<td class="bdr bdt">
						<form name="modform<%=idx%>" method="post" action="banner-reg-ok.asp?<%=pLink%>&mode=levmod&idx=<%=idx%>&page=<%=page%>">
						<input type="text" name="p_lev" class="AXInput W30" value="<%=p_lev%>" numberOnly />
						<input type="submit" value="수정" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
						</form></td>
						<td class="bdr bdt"><%=Left(regdate,10)%></td>
						<td class="bdt">
						<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b" onclick="location.href='banner-reg.asp?mode=mod&idx=<%=idx%>&<%=pLink%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('삭제 하시겠습니까?')){ location.href='banner-reg-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>' }"></td>
					</tr>
					<%
					k=k-1
					i=i+1
					Rs.MoveNext
				Loop
			Else
				%>
				<tr>
					<td colspan="7" class="bdt">등록된 자료가 없습니다</td>
				</tr>
				<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="button" value="   등록   " class="AXButton Blue" onclick="location.href='banner-reg.asp?mode=reg&<%=pLink%>'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->	

	<!-- page -->
	<%Call pagelist("banner.asp?" & pLink, CInt(page), 30, 10, recordcount)%>
	<!-- //page -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>배너 코드 삽입 방법</b><br />
			* 단일 배너<br />
			&lt;%=BannerSingle("분류")%&gt;<br />
			* 리스트 배너<br />			
			&lt;%=BannerList("분류", "&lt;li&gt;", "&lt;/li&gt;")%&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>

<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->