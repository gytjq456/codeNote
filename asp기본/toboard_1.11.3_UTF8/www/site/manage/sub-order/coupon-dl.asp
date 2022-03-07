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
s_used = Request("s_used")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_used=" & s_used
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>발급된 쿠폰 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>발급된 쿠폰 관리</li>
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
				<th class="bdb bdr">통합 검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%"></td>
				<th class="bdb bdr">사용여부</th>
				<td class="bdb bdr">
				<select name="s_used" id="s_used" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="0" <%If s_used="0" Then Response.Write "selected"%>>미사용</option>
					<option value="1" <%If s_used="1" Then Response.Write "selected"%>>사용완료</option>
				</select></td>
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

	<!-- tb_list -->
	<div class="tb_list">
		<h4>발급된 쿠폰 리스트</h4>
		<table>
			<colgroup>
				<col width="5%" />
				<col width="10%" />
				<col width="10%" />
				<col width="" />
				<col width="" />
				<col width="10%" />
				<col width="" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">아이디</th>
				<th class="bdr">할인금액</th>
				<th class="bdr">쿠폰코드</th>
				<th class="bdr">쿠폰명</th>
				<th class="bdr">만료일</th>
				<th class="bdr">발급일</th>
				<th class="bdr">사용여부</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.* FROM tbl_coupon_dl A "
			Sql = Sql & " WHERE idx!='' "			
			If s_keyword<>"" Then
				Sql = Sql & " AND (A.m_id LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.cd_code LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.cd_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.cd_enddate LIKE '%" & s_keyword & "%') "
			End If
			If s_used<>"" Then
				Sql = Sql & " AND A.c_used='" & s_used & "' "
			End If
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
					m_id = Rs("m_id")
					cd_code = Rs("cd_code")
					cd_name = Rs("cd_name")
					cd_enddate = Rs("cd_enddate")
					cd_dc_amount = Rs("cd_dc_amount")
					cd_dc_type = Rs("cd_dc_type")
					c_used = Rs("c_used")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt"><%=m_id%></td>
						<td class="bdr bdt"><%=cd_dc_amount & " " & cd_dc_type%></td>
						<td class="bdr bdt"><%=Mid(cd_code, 1, 5) & "-" & Mid(cd_code, 6, 5) & "-" & Mid(cd_code, 11, 5) & "-" & Mid(cd_code, 16, 5)%></td>
						<td class="bdr bdt"><%=cd_name%></td>
						<td class="bdr bdt"><%=cd_enddate%></td>
						<td class="bdr bdt"><%=regdate%></td>
						<td class="bdr bdt"><%
						If c_used=True Then
							Response.Write "사용완료"
						Else
							Response.Write "미사용"
						End If%></td>
						<td class="bdt">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 쿠폰을 삭제 하시겠습니까? (삭제 후 재발급이 가능합니다.)')){ location.href='coupon-dl-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>' }">
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
					<td colspan="9" class="bdr bdt">발급된 쿠폰이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	<!-- page -->
	<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
	<!-- //page -->

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->


<!-- #include virtual="/site/manage/inc/footer.asp" -->