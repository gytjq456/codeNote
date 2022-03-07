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

	<%
	Set Rs = Server.Createobject("ADODB.Recordset")
	'일별
	If s_type="d" Then

		c_title = s_year & "년 " & s_month & "월 일별 접속자 통계"
		%>

		<!-- Resources -->
		<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js"></script>
		<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
		<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
		<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

		<!-- Chart code -->
		<script>
		var chart = AmCharts.makeChart( "chartdiv", {
		  "type": "serial",
		  "theme": "light",
		  "dataProvider": [
		<%
		Sql = "SELECT c_day, c_count FROM tbl_counter "
		Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
		Sql = Sql & " ORDER BY CONVERT(int, c_day) ASC "
		Rs.Open Sql, Dbcon, 1
		num=0
		Do Until Rs.EOF
			objun(Rs(0)-1)=Rs(1)
			Response.Write "{""date"": """ & s_month & "월 " & Rs(0) & "일"", ""visits"": " & Rs(1) & "},"
			num=num+1
			Rs.Movenext
		Loop
		%>
		],
		  "valueAxes": [ {
			"gridColor": "#FFFFFF",
			"gridAlpha": 0.2,
			"dashLength": 0
		  } ],
		  "gridAboveGraphs": true,
		  "startDuration": 1,
		  "graphs": [ {
			"balloonText": "[[date]]: <b>[[visits]]</b>",
			"fillAlphas": 0.8,
			"lineAlpha": 0.2,
			"type": "column",
			"valueField": "visits"
		  } ],
		  "chartCursor": {
			"categoryBalloonEnabled": false,
			"cursorAlpha": 0,
			"zoomable": false
		  },
		  "categoryField": "date",
		  "categoryAxis": {
			"gridPosition": "start",
			"gridAlpha": 0,
			"tickPosition": "start",
			"tickLength": 20
		  },
		  "rotate": true,
		  "export": {
			"enabled": true
		  }

		} );
		</script>

		<style>
		#chartdiv {
			width		: 100%;
			height		: <%=50+(num*36)%>px;
			font-size	: 11px;
		}
		</style>

	<%
	'요일별
	ElseIf s_type="w" Then
		c_title = s_year & "년 " & s_month & "월 요일별 접속자 통계"
		%>

		<!-- Resources -->
		<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
		<script src="https://www.amcharts.com/lib/3/pie.js"></script>
		<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
		<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
		<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

		<!-- Chart code -->
		<script>
		var chart = AmCharts.makeChart( "chartdiv", {
		  "type": "pie",
		  "theme": "light",
		  "dataProvider": [
		<%
		Sql = "SELECT DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) AS c_weekday, SUM(CONVERT(int, c_count)) "
		Sql = Sql & " FROM tbl_counter "
		Sql = Sql & " WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
		Sql = Sql & " GROUP BY DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) "
		Sql = Sql & " ORDER BY c_weekday ASC "
		Rs.Open Sql, Dbcon, 1
		Do Until Rs.EOF
			c_weekday = Rs(0)
			Response.Write "{""date"": """ & strWeekday(c_weekday) & "요일"", ""visits"": " & Rs(1) & "},"
		Rs.Movenext
		Loop
		%>
		  ],
		  "valueField": "visits",
		  "titleField": "date",
		   "balloon":{
		   "fixedPosition":true
		  },
		  "export": {
			"enabled": true
		  }
		} );
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

		<!-- Resources -->
		<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
		<script src="https://www.amcharts.com/lib/3/serial.js"></script>
		<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
		<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
		<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>

		<!-- Chart code -->
		<script>
		var chart = AmCharts.makeChart( "chartdiv", {
		  "type": "serial",
		  "theme": "light",
		  "dataProvider": [
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
			Response.Write "{""date"": """ & i+1 & "월"", ""visits"": " & i_cnt & "},"
		Next
		%>
		],
		  "valueAxes": [ {
			"gridColor": "#FFFFFF",
			"gridAlpha": 0.2,
			"dashLength": 0
		  } ],
		  "gridAboveGraphs": true,
		  "startDuration": 1,
		  "graphs": [ {
			"balloonText": "[[date]]: <b>[[visits]]</b>",
			"fillAlphas": 0.8,
			"fillColors": "#efb64c",
			"lineAlpha": 0.5,
			"lineColor": "#bc6a00",
			"type": "column",
			"valueField": "visits"
		  } ],
		  "chartCursor": {
			"categoryBalloonEnabled": false,
			"cursorAlpha": 0,
			"zoomable": false
		  },
		  "categoryField": "date",
		  "categoryAxis": {
			"gridPosition": "start",
			"gridAlpha": 0,
			"tickPosition": "start",
			"tickLength": 20
		  },
		  "export": {
			"enabled": true
		  }

		} );
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