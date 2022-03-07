<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- contents -->
<div class="contents">

<%
'메인 페이지 사용 권한
If W_LEVEL<>"1" And InStr(admin_a_auth, "0-main")=0 Then Response.Redirect "sub-basic/admin-info.asp"
%>

	<%
	'쇼핑몰 기능을 사용하는 경우에만 최근 주문정보/회원가입정보 활성화
	If mc_use=True Then%>
		<!-- stat-wrap -->
		<div class="stat-wrap">
			<h4>주문 현황</h4>
			<table>
				<colgroup>
					<col width="" />
					<col width="300px" />
				</colgroup>
				<tr>
					<td>
						<div class="order-cond1 cond-box" onclick="location.href='/site/manage/sub-order/order.asp?s_state=결제대기'">
							결제대기 <%=FormatNumber(order_count1, 0)%>건<br />
							<span><%=FormatNumber(order_amount1, 0)%>원</span>
						</div>
						<div class="order-cond2 cond-box" onclick="location.href='/site/manage/sub-order/order.asp?s_state=결제완료'">
							결제완료 <%=FormatNumber(order_count2, 0)%>건<br />
							<span><%=FormatNumber(order_amount2, 0)%>원</span>
						</div>
						<div class="order-cond3 cond-box" onclick="location.href='/site/manage/sub-order/order.asp?s_state=발송준비'">
							발송준비 <%=FormatNumber(order_count3, 0)%>건<br />
							<span><%=FormatNumber(order_amount3, 0)%>원</span>
						</div>
						<div class="order-cond4 cond-box" onclick="location.href='/site/manage/sub-order/order.asp?s_state=발송완료'">
							발송완료 <%=FormatNumber(order_count4, 0)%>건<br />
							<span><%=FormatNumber(order_amount4, 0)%>원</span>
						</div>
					</td>
					<td><!--#include file="inc_calendar.asp"--></td>
				</tr>
			</table>
		</div>
		<!-- //stat-wrap -->

		<!-- stat-wrap -->
		<div class="stat-wrap" style="width:100%">
			<table>
				<colgroup>
					<col width="60%" />
					<col width="40%" />
				</colgroup>
				<tr>
					<td style="vertical-align:top">
						<!-- tb_list -->
						<div class="tb_list" style="padding-right:15px;">
						<h4>최근 주문내역</h4>
							<table>
								<colgroup>
									<col width="20%" />
									<col width="20%" />
									<col width="" />
									<col width="20%" />
									<col width="20%" />
								</colgroup>
								<tr>
									<th class="bdr">주문코드</th>
									<th class="bdr">이름</th>
									<th class="bdr">금액</th>
									<th class="bdr">상태</th>
									<th class="bdr">주문일</th>
								</tr>
								<%
								Set Rs = Server.Createobject("ADODB.Recordset")
								Sql = "SELECT TOP 5 A.* FROM tbl_mall_order A "
								Sql = Sql & " LEFT JOIN tbl_member B ON A.m_id=B.m_id "
								Sql = Sql & " WHERE A.idx!='' AND A.o_state!='' "
								Sql = Sql & " ORDER BY A.regdate DESC"
								Rs.Open Sql, Dbcon, 1
								Do Until Rs.EOF
									o_idx = Rs("idx")
									o_code = Rs("o_code")
									o_name = Rs("o_name")
									o_total_amount = FormatNumber(Rs("o_amount")+Rs("o_deli_amount")+Rs("o_vat")-Rs("o_pay_point")-Rs("o_coupon_amount"), 0)
									o_pay_method = Rs("o_pay_method")
									o_state = Rs("o_state")
									s_addr1 = Rs("s_addr1")
									s_addr2 = Rs("s_addr2")
									regdate = Left(Rs("regdate"), 10)
									%>
									<tr>
										<td class="bdr bdt"><a href="./sub-order/order-reg.asp?mode=mod&o_code=<%=o_code%>" style="text-decoration:underline"><%=o_code%></a></td>
										<td class="bdr bdt"><a href="./sub-order/order-reg.asp?mode=mod&o_code=<%=o_code%>" style="text-decoration:underline"><%=o_name%></a></td>
										<td class="bdr bdt"><%=o_total_amount%></td>
										<td class="bdr bdt"><%=o_state%></td>
										<td class="bdt"><%=regdate%></td>
									</tr>
									<%
									Rs.MoveNext
								Loop
								Rs.Close
								Set Rs = Nothing%>
							</table>
						</div>
						<!-- tb_list -->
					</td>
					<td style="vertical-align:top">
						<!-- 최근 가입 회원 정보 -->
						<!-- tb_list -->
						<div class="tb_list">
						<h4>최근 가입 회원 내역</h4>
							<table>
								<colgroup>
									<col width="33%" />
									<col width="" />
									<col width="33%" />
								</colgroup>
								<tr>
									<th class="bdr">아이디</th>
									<th class="bdr">이름</th>
									<th class="bdr">가입일</th>
								</tr>
								<%
								Set Rs = Server.Createobject("ADODB.Recordset")
								Sql = "SELECT TOP 5 * FROM tbl_member "
								Sql = Sql & " WHERE idx!='' "
								Sql = Sql & " AND m_lev>=10 "	'관리자를 제외한 회원만 검색
								Sql = Sql & " ORDER BY regdate DESC"
								Rs.Open Sql, Dbcon, 1
								Do Until Rs.EOF
									m_idx = Rs("idx")
									m_id = Rs("m_id")
									m_name = Rs("m_name")
									m_regdate = Left(Rs("regdate"), 10)
									%>
									<tr>
										<td class="bdr bdt">
										<%=SnsMemberIcon(m_id)%>
										<%=m_id%></td>
										<td class="bdr bdt"><%=m_name%></td>
										<td class="bdt"><%=m_regdate%></td>
									</tr>
									<%
									Rs.MoveNext
								Loop
								Rs.Close
								Set Rs = Nothing%>
							</table>
						</div>
						<!-- tb_list -->
					</td>
				</tr>
			</table>
		</div>
		<!-- //stat-wrap -->
		<br />
		<br />
		<br />
	<%End If%>


<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT TOP 10 A.idx, A.board_idx, A.cate, A.title, A.mem_name, A.regdate, B.k_id FROM tbl_board_data A "
Sql = Sql & " LEFT JOIN tbl_board_id B ON A.board_idx=B.idx "
Sql = Sql & " WHERE A.idx!='' "
Sql = Sql & " ORDER BY A.regdate DESC "
Rs.Open Sql, Dbcon, 1
%>

	<!-- tb_list -->
	<div class="tb_list">
	<h4>최근 게시물</h4>
		<table>
			<colgroup>
				<col width="8%" />
				<col width="20%" />
				<col width="" />
				<col width="12%" />
				<col width="12%" />
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
				num = Rs.RecordCount
				Do Until Rs.EOF
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
					<td class="bdr bdt"><a href="sub-bbs/bbs.asp?bid=<%=sch_bid%>&mode=list"><%=sch_bname%></a></td>
					<td class="bdr bdt tit"><a href="sub-bbs/bbs.asp?bid=<%=sch_bid%>&mode=view&idx=<%=sch_idx%>"><%=sch_title%></a></td>
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
			Rs.Close%>
		</table>
	</div>
	<!-- tb_list -->

	<br />
	<br />

<%
s_year=Year(Date)
s_month=Month(Date)
s_day=Day(Date)

Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter "
Rs.Open Sql, Dbcon, 1
	total_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' "
Rs.Open Sql, Dbcon, 1
	month_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(SUM(CONVERT(int, c_count)), 0) FROM tbl_counter WHERE c_year='" & s_year & "' AND c_month='" & s_month & "' AND c_day='" & s_day & "' "
Rs.Open Sql, Dbcon, 1
	today_count = Rs(0)
Rs.Close
Sql = "SELECT ISNULL(AVG(CONVERT(int, c_count)), 0) FROM tbl_counter "
Rs.Open Sql, Dbcon, 1
	avg_count = Rs(0)
Rs.Close
%>

	<!-- stat-wrap -->
	<div class="stat-wrap" style="width:100%; height:300px">

		<table>
			<colgroup>
				<col width="30%" />
				<col width="30%" />
				<col width="40%" />
			</colgroup>
			<tr>
				<td>
					<!-- tb_list -->
					<div class="tb_list" style="width:100%; float:left">
						<h4>접속자 통계 요약</h4>
						<table>
							<colgroup>
								<col width="50%" />
								<col width="" />
							</colgroup>
							<tr>
								<th class="title bdr bdt">총 접속자 수</th>
								<td class="bdt bdr"><%=FormatNumber(total_count, 0)%>명</td>
							</tr>
							<tr>
								<th class="title bdr bdt">이달의 접속자 수</th>
								<td class="bdt bdr"><%=FormatNumber(month_count, 0)%>명</td>
							</tr>
							<tr>
								<th class="title bdr bdt">오늘 접속자 수</th>
								<td class="bdt bdr"><%=FormatNumber(today_count, 0)%>명</td>
							</tr>
							<tr>
								<th class="title bdr bdt">일일 평균 접속자 수</th>
								<td class="bdt"><%=FormatNumber(avg_count, 0)%>명</td>
							</tr>
						</table>
					</div>
					<!-- tb_info -->
				</td>
				<td>
				<!-- Resources -->
				<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
				<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
				<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
				<!-- Chart code -->
				<script>
				am4core.ready(function() {
					am4core.useTheme(am4themes_animated);
					var chart = am4core.create("chartdiv", am4charts.PieChart3D);
					chart.hiddenState.properties.opacity = 0;
					chart.data = [
					<%
					Sql = "SELECT DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) AS c_weekday, SUM(CONVERT(int, c_count)) "
					Sql = Sql & " FROM tbl_counter "
					Sql = Sql & " WHERE c_year='" & s_year & "' "
					Sql = Sql & " GROUP BY DATEPART(weekday, CONVERT(datetime, c_year+'-'+c_month+'-'+c_day)) "
					Sql = Sql & " ORDER BY c_weekday ASC "
					Rs.Open Sql, Dbcon, 1
					Do Until Rs.EOF
						c_weekday = Rs(0)
						Response.Write "{""Weekday"": """ & strWeekday(c_weekday) & "요일"", ""Visits"": " & Rs(1) & "},"
					Rs.Movenext
					Loop
					Rs.Close
					%>
					];

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
				<style>
				#chartdiv {width:100%; height:220px;}
				</style>
				<p style="padding-top:30px;"><div id="chartdiv"></div></p>
				</td>
				<td>
				<!-- Chart code -->
				<script>
				am4core.ready(function() {
					am4core.useTheme(am4themes_animated);
					var chart = am4core.create("chartdiv2", am4charts.XYChart);
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
						Rs.Close

						max_count = 0
						For i=0 To 11
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
				}); // end am4core.ready()
				</script>
				<style>
				#chartdiv2 {width:100%;height:220px;font-size:11px;}
				</style>
				<p style="padding-top:30px;"><div id="chartdiv2"></div></p>
				</td>
			</tr>
		</table>

	</div>
	<!-- //stat-wrap -->

	<!-- main-ban -->
	<!--div class="main-ban">
		<div class="main-ban01">웹모아 홈페이지 바로가기 banner-area</div>
		<div class="main-ban02">웹모아 통합관리 시스템 (WIMS) banner-area</div>
		<div class="main-ban03">원 스탑 서비스 banner-area</div>
	</div -->
	<!-- //main-ban -->

</div>
<!-- //contents -->

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->