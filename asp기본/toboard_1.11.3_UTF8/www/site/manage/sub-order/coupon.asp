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
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_state=" & s_state & "&s_pay_method=" & s_pay_method
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>쿠폰 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>쿠폰 관리</li>
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
			</colgroup>
			<tr>
				<th class="bdb bdr">쿠폰명 검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%"></td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" style="color:#fff;background:#c4c5c9;border:1px solid #c4c5c9" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<form name="listform" method="post" action="?">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>쿠폰 리스트</h4>
		<table>
			<colgroup>
				<col width="5%" />
				<col width="20%" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">쿠폰명</th>
				<th class="bdr">만료일</th>
				<th class="bdr">금액설정</th>
				<th class="bdr">발급방식</th>
				<th class="bdr">상태</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.* FROM tbl_coupon A "
			Sql = Sql & " WHERE A.idx!='' "

			If s_keyword<>"" Then Sql = Sql & " AND A.c_name LIKE '%" & s_keyword & "%' "

			Sql = Sql & " ORDER BY A.regdate DESC"
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 20
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
					idx = Rs("idx")
					c_name=Rs("c_name")
					c_enddate=Rs("c_enddate")
					c_dc_type=Rs("c_dc_type")
					c_dc_amount=Rs("c_dc_amount")
					c_dl_type=Rs("c_dl_type")
					regdate=Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt"><%=c_name%></td>
						<td class="bdr bdt"><%=c_enddate%></td>
						<td class="bdr bdt"><%=c_dc_amount & "  " & c_dc_type%></td>
						<td class="bdr bdt"><%
						If c_dl_type="join" Then
							Response.Write "회원가입시 자동 발급"
						ElseIf c_dl_type="dir" Then
							Response.Write "직접 다운로드 발급"
						End If%></td>
						<td class="bdr bdt"><%
						If CDate(c_enddate)>Date() Then
							Response.Write "사용가능"
						Else
							Response.Write "기간만료"
						End If
						%></td>
						<td class="bdr bdt"><%=regdate%></td>
						<td class="bdt">
						<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='coupon-reg.asp?mode=mod&idx=<%=idx%>&<%=pLink%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 쿠폰을 삭제 하시겠습니까?')){ location.href='coupon-reg-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>' }">
						</td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="8" class="bdr bdt">등록된 쿠폰이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="button" value="   등록   " class="AXButton Blue" onclick="location.href='coupon-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<!-- page -->
	<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
	<!-- //page -->

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->


<!-- #include virtual="/site/manage/inc/footer.asp" -->