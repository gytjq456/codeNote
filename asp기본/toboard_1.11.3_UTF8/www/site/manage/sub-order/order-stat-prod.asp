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
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
If s_srdate="" Then s_srdate=DateAdd("yyyy", -1, Date())
If s_erdate="" Then s_erdate=Date()
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")

page = Request("page")
If page="" Then page=1

pLink = "s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_state=" & s_state & "&s_pay_method=" & s_pay_method
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>제품별 주문현황</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>제품별 주문현황</li>
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
				<th class="bdb bdr">주문일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W90" autocomplete="off" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W90" autocomplete="off" /></div>
				</td>
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
		<h4>주문현황 리스트</h4>
		<table>
			<colgroup>
				<col width="5%" />
				<col width="" />
				<col width="20%" />
				<col width="20%" />
			</colgroup>
			<tr>
				<th class="bdr">No</th>
				<th class="bdr">제품명</th>
				<th class="bdr">수량</th>
				<th class="bdr">주문합계(원)</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = " SELECT p_idx, p_name, sum(p_qty) p_qty, sum(p_amount) p_amount "
			Sql = Sql & " FROM tbl_mall_cart "
			Sql = Sql & " WHERE idx!='' AND o_code!='' "

			If s_srdate<>"" And s_erdate<>"" Then
				Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
			ElseIf s_srdate<>"" Then
				Sql = Sql & "AND regdate>'" & s_srdate & "' "
			ElseIf s_erdate<>"" Then
				Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
			End If

			Sql = Sql & " GROUP BY p_idx, p_name "
			Sql = Sql & " ORDER BY p_qty desc "
			Rs.Open Sql, Dbcon, 1

			If Rs.EOF=False Then
				num = 1
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					p_idx = Rs("p_idx")
					p_name = Rs("p_name")
					p_amount = Rs("p_amount")
					p_qty = Rs("p_qty")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt tit"><%=p_name%></td>
						<td class="bdr bdt"><%=FormatNumber(p_qty, 0)%></td>
						<td class="bdt"><%=FormatNumber(p_amount, 0)%></td>
					</tr>
					<%
					num=num+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="4" class="bdr bdt">주문건이 존재하지 않습니다.</td>
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
<!-- 			<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='order-excel.asp?<%=pLink%>'"></span> -->
		</p>
	</div>
	<!-- //btn_left_right -->

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<!-- #include virtual="/site/manage/inc/footer.asp" -->