<script type="text/javascript" src="/site/js/tab_menu.js"></script>
<link rel="stylesheet" type="text/css" href="/site/ir/css/inv.css" />

<%
stock_code = "009310"
auth_key = "4PqwmQkYU8EfsbtJTUCl08jdq55rljX"

On Error Resume Next

'부호 처리
'1-상한, 2-상승, 3-보합, 4-하한, 5-하락
Function SetBuho(num)
	Select Case num
		Case "1"
			SetBuho = "<span style='color:#e00400'>▲▲</span>"
		Case "2"
			SetBuho = "<span style='color:#e00400'>▲</span>"
		Case "3"
			SetBuho = "〓"
		Case "4"
			SetBuho = "<span style='color:#005dde'>▼▼</span>"
		Case "5"
			SetBuho = "<span style='color:#005dde'>▼</span>"
	End Select
End Function

Set Xh = server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
Xhurl = "https://asp.koscom.co.kr/listservice/getStockInfoXML?code=" & stock_code & "&auth_key=" & auth_key & "&gubun=K"
Xh.open "GET", Xhurl, False
Xh.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
Xh.send
strResponseText = Xh.responseText
Set Xh = Nothing

Set Xhd = Server.CreateObject("Microsoft.XMLDOM")
Xhd.async = false
Xhd.loadXML(strResponseText)
%>

	<div class="top_info clearfix">
		<div class="stock">
			<div class="inv_tit">
				<span>stock price</span>
				<p><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("JongName")) & "(" & stock_code & ")"%> 주가정보</p>
			</div>
			<div class="money_box">
				<div class="now">
					<div>
						<p>현재가 <span><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("CurJuka"))%></span></p>
						<div class="date"><%=Trim(Xhd.getElementsByTagName("stockprice").Item(0).getAttribute("querytime"))%> 기준</div>
					</div>
				</div>
				<div class="list">
					<ul class="clearfix">
						<li>
							<dl>
								<dt>시가</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("StartJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>고가</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("HighJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>저가</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("LowJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>거래량</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Volume"))%></dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<div class="">
				<div class="table">
					<table class="inv_tb mt10">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="">
						</colgroup>
						<tr>
							<th>전일가</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("PrevJuka"))%></td>
							<th>액면가</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("FaceJuka"))%></td>
						</tr>
						<tr>
							<th>전일대비</th>
							<td>
							<%=SetBuho(Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("DungRak")))%>&nbsp;
							<%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Debi"))%></td>
							<th>상한가</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("UpJuka"))%></td>
						</tr>
						<tr>
							<th>거래대금</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Money"))%></td>
							<th>하한가</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("DownJuka"))%></td>
						</tr>
						<tr>
							<th>52주 최고</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("High52"))%></td>
							<th>PER</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Per"))%></td>
						</tr>
						<tr>
							<th>52주 최저</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Low52"))%></td>
							<th>상장주식수</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Amount"))%></td>
						</tr>
					</table>				
				</div>
			</div>

		</div>
		<div class="market">
			<div class="inv_tit">
				<span>market price</span>
				<p>일별시세</p>
			</div>

<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>
am4core.ready(function() {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end

	var chart = am4core.create("chartdiv", am4charts.XYChart);
	chart.paddingRight = 20;

	var data = [<%
	min_value = 0
	For dd=Xhd.getElementsByTagName("DailyStock").Length-1 To 1 Step -1
		daydate = Split(Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Date")), "/")
		endprice = Replace(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_EndPrice"), ",", "")
		If min_value="" Or min_value<endprice Then
			min_value = endprice-(endprice*0.05)
		End If
		%>{
		  "date": new Date(20<%=daydate(0)%>, <%=daydate(1)%>, <%=daydate(2)%>),
		  "value": <%=endprice%>
		}<%If dd<>1 Then Response.Write ", "%>
	<%Next%>];
	var visits = 10;
	var previousValue;


	chart.data = data;

	var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
	dateAxis.renderer.grid.template.location = 0;
	dateAxis.renderer.axisFills.template.disabled = true;
	dateAxis.renderer.ticks.template.disabled = true;

	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
	valueAxis.tooltip.disabled = true;
	valueAxis.renderer.minWidth = 35;
	valueAxis.renderer.axisFills.template.disabled = true;
	valueAxis.renderer.ticks.template.disabled = true;

	var series = chart.series.push(new am4charts.LineSeries());
	series.dataFields.dateX = "date";
	series.dataFields.valueY = "value";
	series.strokeWidth = 2;
	series.tooltipText = "날짜: {dateX}, 시가: {valueY}원";

	// set stroke property field
	series.propertyFields.stroke = "color";

	chart.cursor = new am4charts.XYCursor();

	var scrollbarX = new am4core.Scrollbar();
	chart.scrollbarX = scrollbarX;

	dateAxis.start = 0;
	dateAxis.keepSelection = true;


}); // end am4core.ready()
</script>

			<div id="chartdiv" style="width:100%; height: 550px; text-align:center;margin:0 auto;"></div>		
		</div>
	</div>


<!-- tabs -->
<ul class="inv_tab">
	<li class="on"><a href="#tab1">거래원정보</a></li>
	<li><a href="#tab2">일별시세</a></li>
	<li class="last"><a href="#tab3">시간대별 체결가</a></li>
</ul>
<!-- //tabs -->

<!-- tab_container -->
<div class="tab_container">

	<!-- tab01 -->
	<div id="tab1" class="tab_content cont01">
		<div class="inv_tit">
			<span>info</span>
			<p>거래원정보</p>
		</div>
		<div class="table">
		<table class="inv_tb">
			<colgroup>
				<col width="">
				<col width="">
				<col width="">
				<col width="">
			</colgroup>
			<tr>
				<th>매도 상위</th>
				<th>거래량</th>
				<th>매수 상위</th>
				<th class="br_none">거래량</th>
			</tr>
			<%For dd=0 To Xhd.getElementsByTagName("AskPrice").Length-1%>
			<tr>
				<td><%=Trim(Xhd.getElementsByTagName("AskPrice").Item(dd).getAttribute("member_memdoMem"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("AskPrice").Item(dd).getAttribute("member_memdoVol"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("AskPrice").Item(dd).getAttribute("member_memsoMem"))%></td>
				<td class="br_none"><%=Trim(Xhd.getElementsByTagName("AskPrice").Item(dd).getAttribute("member_mesuoVol"))%></td>
			</tr>
			<%Next%>
		</table>
		</div>
	</div>
	<!-- //tab1 -->

	<!-- tab2 -->
	<div id="tab2" class="tab_content cont02">
		<div class="inv_tit">
			<span>info</span>
			<p>일별시세</p>
		</div>
		<div class="table">
		<table class="inv_tb">
			<colgroup>
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
			</colgroup>
			<tr>
				<th>날짜</th>
				<th>종가</th>
				<th>전일비</th>
				<th>시가</th>
				<th>고가</th>
				<th>저가</th>
				<th>거래량</th>
				<th class="br_none">거래대금</th>
			</tr>
			<%For dd=0 To Xhd.getElementsByTagName("DailyStock").Length-1%>
			<tr>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Date"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_EndPrice"))%></td>
				<td>
				<%=SetBuho(Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Dungrak")))%>&nbsp;
				<%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_getDebi"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Start"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_High"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Low"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_Volume"))%></td>
				<td class="br_none"><%=Trim(Xhd.getElementsByTagName("DailyStock").Item(dd).getAttribute("day_getAmount"))%></td>
			</tr>
			<%Next%>
		</table>
		</div>
	</div>
	<!-- //tab2 -->

	<!-- tab3 -->
	<div id="tab3" class="tab_content cont03">
		<div class="inv_tit">
			<span>info</span>
			<p>시간대별 체결가</p>
		</div>
		<div class="table">
		<table class="inv_tb">
			<colgroup>
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
				<col width="">
			</colgroup>
			<tr>
				<th>체결시각</th>
				<th>체결가</th>
				<th>전일비</th>
				<th>매도</th>
				<th>매수</th>
				<th class="br_none">거래량</th>
			</tr>
			<%For dd=1 To  Xhd.getElementsByTagName("TBL_TimeConclude").Length-1%>
			<tr>
				<td><%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("time"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("negoprice"))%></td>
				<td>
				<%=SetBuho(Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("Dungrak")))%>&nbsp;
				<%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("Debi"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("sellprice"))%></td>
				<td><%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("buyprice"))%></td>
				<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_TimeConclude").Item(dd).getAttribute("amount"))%></td>
			</tr>
			<%Next%>
		</table>
		</div>
	</div>
	<!-- //tab3 -->


<div class="inv_section">
	<div class="inv_tit">
		<span>index</span>
		<p>주요지수</p>
		<em class="inv_date">[ 조회일자 : <%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myNowTime"))%> ]</em>
	</div>
	<table class="inv_tb">
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="25%">
			<col width="">
		</colgroup>
		<tr>
			<th>코스닥 종합지수</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisu"))%></td>
			<th>코스닥 전일대비</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisuBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisuDebi"))%></td>
		</tr>
		<tr>
			<th>코스닥 스타지수</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisu"))%></td>
			<th>코스닥 스타지수 전일대비</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisuBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisuDebi"))%></td>
		</tr>
		<tr>
			<th>장중구분</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myJangGubun"))%></td>
			<th>공모가</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myPublicPrice"))%></td>
		</tr>
		<tr>
			<th>KRX100지수</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100Jisu"))%></td>
			<th>KRX100지수 전일대비</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100buho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100Debi"))%></td>
		</tr>
		<tr>
			<th>코스피지수</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiJisu"))%></td>
			<th>코스피지수 전일대비</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiDebi"))%></td>
		</tr>
		<tr>
			<th>코스피200지수</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Jisu"))%></td>
			<th>코스피200지수 전일대비</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Buho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Debi"))%></td>
		</tr>
	</table>
</div>

<%
Set Xhd = Nothing
%>