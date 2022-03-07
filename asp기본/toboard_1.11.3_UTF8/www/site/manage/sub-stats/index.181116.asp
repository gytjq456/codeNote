<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>

<%
s_type = Request("s_type")
If s_type="" Then s_type="d"
s_year = Request("s_year")
If s_year="" Then s_year=Year(Date)
s_month = Request("s_month")
If s_month="" Then s_month=Month(Date)

If s_month = 12 then
	next_year = s_year + 1
	next_month = 1
Else
	next_month = s_month + 1
	next_year = s_year
End If

If s_type="d" Then
	last_obj = Day(DateAdd("d", -1, CDate(next_year & "-" & next_month & "-01")))
ElseIf s_type="w" Then
	last_obj = 7
ElseIf s_type="m" Then
	last_obj = 12
End If

ReDim objun(last_obj)
For i=0 To last_obj-1
	objun(i)=0
Next
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>접속자 통계</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>접속자 통계</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

	<div class="AXTabs" style="margin-bottom:30px">
		<div class="AXTabsTray">
			<a href="?s_type=d" class="AXTab <%If s_type="d" Then Response.Write "on"%>">일별</a>
			<a href="?s_type=w" class="AXTab <%If s_type="w" Then Response.Write "on"%>">요일별</a>
			<a href="?s_type=m" class="AXTab <%If s_type="m" Then Response.Write "on"%>">월별</a>
			<div class="clear"></div>
		</div>
	</div>

	<%
	Set Rs = Server.Createobject("ADODB.Recordset")
	'일별
	If s_type="d" Then
		Sql = "SELECT c_day, c_count FROM tbl_counter "
		Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
		Sql = Sql & " ORDER BY c_day ASC "
		Rs.Open Sql, Dbcon, 1
		Do Until Rs.EOF
			objun(Rs(0)-1)=Rs(1)
		Rs.Movenext
		Loop

		max_count = 0
		For i=0 To last_obj-1
			i_cnt = objun(i)
			If Trim(i_cnt)="" Then i_cnt=0
			chdt=chdt&",['" & s_month & "월 " & i+1 & "일', " & i_cnt & ", '']"
		Next

		c_title = s_year & "년 " & s_month & "월 일별 접속자 통계"
		%>
			<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
			<script type="text/javascript">
			google.charts.load('current', {packages: ['corechart', 'bar']});
			google.charts.setOnLoadCallback(drawBasic);

			function drawBasic() {

				var data = google.visualization.arrayToDataTable([
				['', '접속자 수', { role: "style" }]<%=chdt%>
				]);

				var view = new google.visualization.DataView(data);
				view.setColumns([0, 1,
				   { calc: "stringify",
					 sourceColumn: 1,
					 type: "string",
					 role: "annotation"}]);

				var options = {
					chartArea:{top:0, bottom:80},
					width:880, height:1200,
					colors: ['#4285f4']
				};

				var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
				chart.draw(view, options);

			}
		  </script>

	<%
	'요일별
	ElseIf s_type="w" Then
		Sql = "SELECT DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) AS c_weekday, SUM(CONVERT(int, c_count)) "
		Sql = Sql & " FROM tbl_counter "
		Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
		Sql = Sql & " GROUP BY DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) "
		Sql = Sql & " ORDER BY c_weekday ASC "
		Rs.Open Sql, Dbcon, 1
		Do Until Rs.EOF
			objun(Rs(0)-1)=Rs(1)
		Rs.Movenext
		Loop

		max_count = 0
		For i=0 To last_obj-1
			i_cnt = objun(i)
			If Trim(i_cnt)="" Then i_cnt=0
			chdt=chdt&",['" & strWeekday(i+1) & "요일', " & i_cnt & "]"
		Next

		c_title = s_year & "년 " & s_month & "월 요일별 접속자 통계"
		%>

		<script type="text/javascript">
		  google.charts.load("current", {packages:["corechart"]});
		  google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
			var data = google.visualization.arrayToDataTable([
				['요일', '접속자 수']<%=chdt%>
			]);

			var options = {
				title: '<%=s_year%>년 <%=s_month%>월 요일별 접속자 통계',
				width:880, height:500,
				is3D: true,
			};

			var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			chart.draw(data, options);
		}
		</script>
	<%
	'월별
	ElseIf s_type="m" Then

		Sql = "SELECT c_month, SUM(CONVERT(int, c_count)) "
		Sql = Sql & " FROM tbl_counter "
		Sql = Sql & " WHERE c_year='" & s_year & "' "
		Sql = Sql & " GROUP BY c_month "
		Sql = Sql & " ORDER BY c_month ASC "

		Rs.Open Sql, Dbcon, 1
		Do Until Rs.EOF
			objun(Rs(0)-1)=Rs(1)
		Rs.Movenext
		Loop

		max_count = 0
		For i=0 To last_obj-1
			i_cnt = objun(i)
			If Trim(i_cnt)="" Then i_cnt=0
			chdt=chdt&",['" & i+1 & "월', " & i_cnt & "]"
		Next
				
		c_title = s_year & "년 월별 접속자 통계"
		%>

			<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
			<script type="text/javascript">
			google.charts.load('current', {packages: ['corechart', 'bar']});
			google.charts.setOnLoadCallback(drawBasic);

			function drawBasic() {
				var data = google.visualization.arrayToDataTable([
					['월', '접속자 수']<%=chdt%>
				]);

				var view = new google.visualization.DataView(data);
				view.setColumns([0, 1,
				   { calc: "stringify",
					 sourceColumn: 1,
					 type: "string",
					 role: "annotation"}]);

				var options = {
					chartArea:{top:20, bottom:80},
					width:880, height:500,
					colors: ['#db4437'],
					hAxis: {format: 'decimal'}
				};

				var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
				chart.draw(view, options);

			}
			</script>
		
	<%
	End If
	Rs.Close
	%>


	<!-- tb_info -->
	<div class="tb_info" style="position:relative;">
		<h4><%=c_title%></h4>
		
		<!-- 차트 삽입 -->
		<p style="margin:0 auto;"><div id="chart_div" style="margin-top:30px;"></div></p>	

		<form name="searchform" action="?s_type=<%=s_type%>" method="post">
		<p style="position:absolute;top:0;right:0;">
			<select name="s_year" class="AXSelect">
			<%For yyyy=2013 To Year(Date)%>
				<option value="<%=yyyy%>" <%If Trim(yyyy)=Trim(s_year) Then Response.Write "selected"%>><%=yyyy%>년</option>
			<%Next%>
			</select>
			<%If s_type<>"m" Then%>
			<select name="s_month" class="AXSelect">
			<%For mm=1 To 12%>
				<option value="<%=mm%>" <%If Trim(mm)=Trim(s_month) Then Response.Write "selected"%>><%=mm%>월</option>
			<%Next%>
			</select>
			<%End If%>
			<input type="submit" value="검색" class="AXButton">
		</p>
		</form>
	</div>
	<!-- tb_info -->

<%
Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter "
Rs.Open Sql, Dbcon, 1
	total_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
Rs.Open Sql, Dbcon, 1
	month_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' AND c_day='" & Day(Date) & "' "
Rs.Open Sql, Dbcon, 1
	today_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(AVG(CONVERT(int, c_count)), 0) FROM tbl_counter "
Rs.Open Sql, Dbcon, 1
	avg_count = Rs(0)
Rs.Close
Set Rs = Nothing
%>

	<!-- tb_info -->
	<div class="tb_info">
		<h4>접속자 통계 요약</h4>
		<table>
			<colgroup>
				<col width="180px" />
				<col width="" />
				<col width="180px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">총 접속자 수</th>
				<td class="bdt bdr"><%=FormatNumber(total_count, 0)%>명</td>
				<th class="title bdr bdt">이달의 접속자 수</th>
				<td class="bdt"><%=FormatNumber(month_count, 0)%>명</td>
			</tr>
			<tr>
				<th class="title bdr bdt">오늘 접속자 수</th>
				<td class="bdt bdr"><%=FormatNumber(today_count, 0)%>명</td>
				<th class="title bdr bdt">일일 평균 접속자 수</th>
				<td class="bdt"><%=FormatNumber(avg_count, 0)%>명</td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- tip_box -->
	<!--
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
			보다 디테일한 통계 분석를 원하시면 Google Analytics를 이용 해 주세요.
		</p>
	</div>
	-->
	<!-- //tip_box -->

</div>
<!-- //contents -->


<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->