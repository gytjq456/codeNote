<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->

<!-- Resources -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

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
If s_srdate="" Then s_srdate=DateAdd("m", -1, Date())
If s_erdate="" Then s_erdate=Date()
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")

pLink = "s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_state=" & s_state & "&s_pay_method=" & s_pay_method
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>일별 주문현황</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>일별 주문현황</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>최근 주문현황</h4>
		<%
		Set Rs = Server.Createobject("ADODB.Recordset")
		Sql = " SELECT TOP 20 CONVERT(CHAR(10), regdate, 23) AS o_date, count(*) AS o_count, isnull(sum(o_amount+o_deli_amount), 0) AS o_total "
		Sql = Sql & " FROM tbl_mall_order "
		Sql = Sql & " WHERE idx!='' AND o_state!='' "
		Sql = Sql & " GROUP BY CONVERT(CHAR(10), regdate, 23) "
		Sql = Sql & " ORDER BY CONVERT(CHAR(10), regdate, 23) ASC"
		'Response.Write Sql
		Rs.Open Sql, Dbcon, 1

		If Rs.EOF=False Then
			Do Until Rs.EOF
				o_date = Rs("o_date")
				o_count = Rs("o_count")
				o_total = Rs("o_total")

				o_data_prov = o_data_prov & "{" & Chr(13) & Chr(10)
				o_data_prov = o_data_prov & """날짜"": """ & Month(o_date) & "월 " & Day(o_date) & "일" & """," & Chr(13) & Chr(10)
				o_data_prov = o_data_prov & """주문금액"": """ & o_total& """," & Chr(13) & Chr(10)
				o_data_prov = o_data_prov & """주문건수"": """ & o_count& """" & Chr(13) & Chr(10)
				o_data_prov = o_data_prov & "}, " & Chr(13) & Chr(10)

				Rs.MoveNext
			Loop
		End If
		Rs.Close
		Set Rs = Nothing%>

		<!-- Chart code -->
		<script>
		var chart = AmCharts.makeChart("chartdiv", {
			"type": "serial",
			"theme": "light",
			"legend": {
				"equalWidths": false,
				"useGraphSettings": true,
				"valueAlign": "left",
				"valueWidth": 120
			},
			"dataProvider": [
			<%=o_data_prov%>	
			],
			"valueAxes": [{
				"id": "주문금액Axis",
				"axisAlpha": 0,
				"gridAlpha": 0,
				"position": "left",
				"title": "주문금액",
				"minimum": 0
			}, {
				"id": "durationAxis",
				"axisAlpha": 0,
				"gridAlpha": 0,
				"position": "right",
				"title": "주문 건 수",
				"minimum": 0
			}],
			"startDuration": 1,
			"graphs": [{
				"alphaField": "alpha",
				"balloonText": "[[value]] 원",
				"fillAlphas": 0.8,
				"fillColors": "#e5caed",
				"lineAlpha": 0.5,
				"lineColor": "#be7bd1",
				"legendPeriodValueText": "합계 : [[value.sum]] 원",
				"legendValueText": "[[value]] 원",
				"title": "주문금액",
				"type": "column",
				"valueField": "주문금액",
				"valueAxis": "주문금액Axis"
			}, {
				"bullet": "square",
				"bulletBorderAlpha": 1,
				"bulletBorderThickness": 1,
				"balloonText": "[[value]]건",
				"legendValueText": "[[value]] 건",
				"title": "주문건수",
				"fillAlphas": 0,
				"legendPeriodValueText": "합계 : [[value.sum]] 건",
				"valueField": "주문건수",
				"valueAxis": "durationAxis"
			}],
			"chartCursor": {
				"cursorAlpha": 0.1,
				"cursorColor":"#000000",
				 "fullWidth":true,
				"valueBalloonsEnabled": false,
				"zoomable": false
			},
			"categoryField": "날짜",
			"categoryAxis": {
				"gridPosition": "start"
			},
			"export": {
				"enabled": true
			 }
		});
		</script>
		<div id="chartdiv" style="width: 100%; height: 400px;"></div>

	</div>

	<br />
	<br />
	<br />


	<form name="searchform" method="post" action="?">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">주문일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W90" autocomplete="off" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W90" autocomplete="off" /></div>
				</td>
				<th class="bdb bdr">진행상태</th>
				<td class="bdb bdr">
				<select name="s_state" id="s_state" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="결제대기" <%If s_state="결제대기" Then Response.Write "selected"%>>결제대기</option>
					<option value="결제완료" <%If s_state="결제완료" Then Response.Write "selected"%>>결제완료</option>
					<option value="발송준비" <%If s_state="발송준비" Then Response.Write "selected"%>>발송준비</option>
					<option value="발송완료" <%If s_state="발송완료" Then Response.Write "selected"%>>발송완료</option>
					<option value="주문취소" <%If s_state="주문취소" Then Response.Write "selected"%>>주문취소</option>
					<option value="교환" <%If s_state="교환" Then Response.Write "selected"%>>교환</option>
					<option value="반품" <%If s_state="반품" Then Response.Write "selected"%>>반품</option>
				</select></td>
				<th class="bdb bdr">결제수단</th>
				<td class="bdb">
				<select name="s_pay_method" id="s_pay_method" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<%If mc_bank_flag=True Then%><option value="무통장입금" <%If s_pay_method="무통장입금" Then Response.Write "selected"%>>무통장입금</option><%End If%>
					<option value="신용카드" <%If s_pay_method="신용카드" Then Response.Write "selected"%>>신용카드</option>
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
		<h4>주문현황 리스트</h4>
		<table>
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdr">주문일</th>
				<th class="bdr">주문수(건)</th>
				<th class="bdr">주문합계(원)</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = " SELECT CONVERT(CHAR(10), regdate, 23) AS o_date, count(*) AS o_count, isnull(sum(o_amount+o_deli_amount), 0) AS o_total "
			Sql = Sql & " FROM tbl_mall_order "
			Sql = Sql & " WHERE idx!='' AND o_state!='' "
			If s_state<>"" Then Sql = Sql & " AND o_state='" & s_state & "' "
			If s_pay_method<>"" Then Sql = Sql & " AND o_pay_method='" & s_pay_method & "' "

			If s_srdate<>"" And s_erdate<>"" Then
				Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
			ElseIf s_srdate<>"" Then
				Sql = Sql & "AND regdate>'" & s_srdate & "' "
			ElseIf s_erdate<>"" Then
				Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
			End If

			Sql = Sql & " GROUP BY CONVERT(CHAR(10), regdate, 23) "
			Sql = Sql & " ORDER BY CONVERT(CHAR(10), regdate, 23) ASC"
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			If Rs.EOF=False Then
				Do Until Rs.EOF
					o_date = Rs("o_date")
					o_count = Rs("o_count")
					o_total = Rs("o_total")
					t_o_count = t_o_count + o_count
					t_o_total = t_o_total + o_total
					%>
					<tr>
						<td class="bdr bdt"><%=o_date%></td>
						<td class="bdr bdt"><%=o_count%></td>
						<td class="bdt"><%=FormatNumber(o_total, 0)%></td>
					</tr>
					<%
					Rs.MoveNext
				Loop
				%>
					<tr>
						<td class="bdr bdt">합계</td>
						<td class="bdr bdt"><%=t_o_count%></td>
						<td class="bdt"><%=FormatNumber(t_o_total, 0)%></td>
					</tr>
			<%
			Else
			%>
				<tr>
					<td colspan="3" class="bdr bdt">주문건이 존재하지 않습니다.</td>
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