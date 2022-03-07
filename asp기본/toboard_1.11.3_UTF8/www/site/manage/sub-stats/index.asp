<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
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
	
	<!-- Resources -->
	<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
	<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

	<%
	Set Rs = Server.Createobject("ADODB.Recordset")
	'일별
	If s_type="d" Then

		c_title = s_year & "년 " & s_month & "월 일별 접속자 통계"
		%>

		<!-- Chart code -->
		<script>
		am4core.ready(function() {
			am4core.useTheme(am4themes_animated);
			var chart = am4core.create("chartdiv", am4charts.XYChart);
			chart.padding(40, 40, 40, 40);

			var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "date";
			categoryAxis.renderer.minGridDistance = 1;
			categoryAxis.renderer.inversed = true;
			categoryAxis.renderer.grid.template.disabled = true;

			var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryY = "date";
			series.dataFields.valueX = "visits";
			series.tooltipText = "{valueX.value}"
			series.columns.template.strokeOpacity = 0;
			series.columns.template.column.cornerRadiusBottomRight = 15;
			series.columns.template.column.cornerRadiusTopRight = 15;
			series.columns.template.column.fillOpacity = 0.7;

			var labelBullet = series.bullets.push(new am4charts.LabelBullet())
			labelBullet.label.horizontalCenter = "left";
			labelBullet.label.dx = 10;
			labelBullet.label.text = "{valueX.value}";
			labelBullet.locationX = 1;

			series.columns.template.adapter.add("fill", function(fill, target){
				return chart.colors.getIndex(target.dataItem.index);
			});

			chart.data = [
			<%
			Sql = "SELECT c_day, c_count FROM tbl_counter "
			Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
			Sql = Sql & " ORDER BY CONVERT(int, c_day) ASC "
			Rs.Open Sql, Dbcon, 1
			num=1
			Do Until Rs.EOF
				objun(Rs(0)-1)=Rs(1)
				Response.Write "{""date"": """ & s_month & "월 " & Rs(0) & "일"", ""visits"": " & Rs(1) & "},"
				num=num+1
				Rs.Movenext
			Loop
			%>]
		}); // end am4core.ready()
		</script>

		<style>
		#chartdiv {
			width		: 100%;
			height		: <%=100+(num*35)%>px;
			font-size	: 11px;
		}
		</style>


	<%
	'요일별
	ElseIf s_type="w" Then
		c_title = s_year & "년 " & s_month & "월 요일별 접속자 통계"
		%>

		<script>
		am4core.ready(function() {
			am4core.useTheme(am4themes_animated);
			var chart = am4core.create("chartdiv", am4charts.PieChart3D);
			chart.hiddenState.properties.opacity = 0;
			chart.data = [
			<%
			Sql = "SELECT DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) AS c_weekday, SUM(CONVERT(int, c_count)) "
			Sql = Sql & " FROM tbl_counter "
			Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
			Sql = Sql & " GROUP BY DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) "
			Sql = Sql & " ORDER BY c_weekday ASC "
			Rs.Open Sql, Dbcon, 1
			Do Until Rs.EOF
				c_weekday = Rs(0)
				Response.Write "{""Weekday"": """ & strWeekday(c_weekday) & "요일"", ""Visits"": " & Rs(1) & "},"
			Rs.Movenext
			Loop
			%>];

			// Add and configure Series
			var pieSeries = chart.series.push(new am4charts.PieSeries());
			pieSeries.dataFields.value = "Visits";
			pieSeries.dataFields.category = "Weekday";

			// Let's cut a hole in our Pie chart the size of 40% the radius
			chart.innerRadius = am4core.percent(25);
			chart.depth = 120;

			// Set up fills
			pieSeries.slices.template.strokeWidth = 0;
			pieSeries.slices.template.fillOpacity = 0.7;
			//pieSeries.slices.template.cornerRadius = 5;
			pieSeries.colors.step = 2;

			var hs = pieSeries.slices.template.states.getKey("hover");
			hs.properties.scale = 1;
			hs.properties.fillOpacity = 0.9;

		}); // end am4core.ready()
		</script>

		<!-- Styles -->
		<style>
		#chartdiv {
		  width: 100%;
		  height: 600px;
		}
		</style>

	<%
	'월별
	ElseIf s_type="m" Then
		c_title = s_year & "년 월별 접속자 통계"
		%>
		<script>
		am4core.ready(function() {
			am4core.useTheme(am4themes_animated);
			var chart = am4core.create("chartdiv", am4charts.XYChart);
			chart.data = [
			<%
			Redim objun(12)
			Sql = "SELECT c_month, SUM(CONVERT(int, c_count)) "
			Sql = Sql & " FROM tbl_counter "
			Sql = Sql & " WHERE c_year='" & s_year & "' "
			Sql = Sql & " GROUP BY c_month "
			Sql = Sql & " ORDER BY CONVERT(int, c_month) ASC "
			Rs.Open Sql, Dbcon, 1
			Do Until Rs.EOF
				objun(Rs(0)-1)=Rs(1)
			Rs.Movenext
			Loop

			max_count = 0
			For i=0 To last_obj-1
				i_cnt = objun(i)
				If Trim(i_cnt)="" Then i_cnt=0
				Response.Write "{""Month"": """ & i+1 & "월"", ""Visits"": " & i_cnt & "},"
			Next
			%>
			];
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "Month";
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.renderer.minGridDistance = 30;

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

			// Create series
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.valueY = "Visits";
			series.dataFields.categoryX = "Month";
			series.name = "Visits";
			series.columns.template.tooltipText = "{categoryX}: [bold]{valueY}[/]";
			
			series.columns.template.strokeWidth = 0;
			series.columns.template.column.cornerRadiusTopLeft = 20;
			series.columns.template.column.cornerRadiusTopRight = 20;
			series.columns.template.column.fillOpacity = 0.7;
			series.columns.template.adapter.add("fill", function(fill, target) {
				return chart.colors.getIndex(target.dataItem.index);
			});

			var labelBullet = series.bullets.push(new am4charts.LabelBullet())
			labelBullet.label.text = "{valueY.value}";
			labelBullet.label.verticalCenter = "bottom";

		}); // end am4core.ready()
		</script>

		<style>
		#chartdiv {
			width		: 100%;
			height		: 500px;
			font-size	: 11px;
		}
		</style>

	<%
	End If
	Rs.Close
	%>


	<!-- tb_list -->
	<div class="tb_list" style="position:relative;">
		<h4><%=c_title%></h4>

		<!-- 차트 삽입 -->
		<p style="margin:0 auto;">
		<!-- HTML -->
		<div id="chartdiv"></div></p>

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
	<!-- tb_list -->

	<br />
	<br />

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
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
			봇(bot) 등에 의해 실제 방문자와 차이가 있을 수 있으니 단순 참고용으로만 이용바랍니다.<br />
			디테일한 분석을 원하시면 전문 로그분석 솔루션을 이용하시기 바랍니다.
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->


<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->