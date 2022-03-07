<script type="text/javascript" src="/site/js/tab_menu.js"></script>
<link rel="stylesheet" type="text/css" href="/site/ir/css/inv.css" />
<style>
	table.inv_tb th{ font-size:14px;}
</style>

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
Xhurl = "http://asp.koscom.co.kr/listservice/getStockInfoXML?code=" & stock_code & "&auth_key=" & auth_key & "&gubun=E"
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
				<p><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("JongName")) & "(" & stock_code & ")"%> Stock price</p>
			</div>
			<div class="money_box">
				<div class="now">
					<div>
						<p>Current price <span><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("CurJuka"))%></span></p>
						<div class="date"><%=Trim(Xhd.getElementsByTagName("stockprice").Item(0).getAttribute("querytime"))%> As of</div>
					</div>
				</div>
				<div class="list">
					<ul class="clearfix">
						<li>
							<dl>
								<dt>Opening price</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("StartJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>Highest</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("HighJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>Lowest</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("LowJuka"))%></dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>Volume</dt>
								<dd><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Volume"))%></dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<div class="money_box">
				<div class="table">
					<table class="inv_tb mt10">
						<colgroup>
							<col width="20%">
							<col width="">
							<col width="20%">
							<col width="">
						</colgroup>
						<tr>
							<th>Previous day</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("PrevJuka"))%></td>
							<th>Par value</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("FaceJuka"))%></td>
						</tr>
						<tr>
							<th>Net change</th>
							<td>
							<%=SetBuho(Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("DungRak")))%>&nbsp;
							<%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Debi"))%></td>
							<th>Upper daily price limit</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("UpJuka"))%></td>
						</tr>
						<tr>
							<th>Transaction</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Money"))%></td>
							<th>Lower daily price limit</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("DownJuka"))%></td>
						</tr>
						<tr>
							<th>52-week high</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("High52"))%></td>
							<th>PER</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Per"))%></td>
						</tr>
						<tr>
							<th>52-week low</th>
							<td><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Low52"))%></td>
							<th>Listed stocks</th>
							<td class="br_none"><%=Trim(Xhd.getElementsByTagName("TBL_StockInfo").Item(0).getAttribute("Amount"))%></td>
						</tr>
					</table>				
				</div>
			</div>

		</div>
		<div class="market">
			<div class="inv_tit">
				<span>market price</span>
				<p>Daily price</p>
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
	series.tooltipText = "Date : {dateX}, Price: {valueY}";

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
	<li class="on"><a href="#tab1">Trader info</a></li>
	<li><a href="#tab2">Daily price</a></li>
	<li class="last"><a href="#tab3">Traded price by time</a></li>
</ul>
<!-- //tabs -->

<!-- tab_container -->
<div class="tab_container">

	<!-- tab01 -->
	<div id="tab1" class="tab_content cont01">
		<div class="inv_tit">
			<span>info</span>
			<p>Trader info</p>
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
				<th>Sell ​​Top</th>
				<th>volume</th>
				<th>Buying top</th>
				<th class="br_none">volume</th>
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
			<p>Daily price</p>
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
				<th>Date</th>
				<th>Closing price</th>
				<th>Daily difference (%)</th>
				<th>Opening price</th>
				<th>High</th>
				<th>Low</th>
				<th>Volume</th>
				<th class="br_none">Transaction</th>
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
			<p>Traded price by time</p>
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
				<th>Trading time</th>
				<th>Traded price</th>
				<th>Daily difference</th>
				<th>Sell</th>
				<th>Buy</th>
				<th class="br_none">Volume</th>
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
		<p>Major indices</p>
		<em class="inv_date">[ Date of inquiry : <%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myNowTime"))%> ]</em>
	</div>
	<table class="inv_tb">
		<colgroup>
			<col width="25%">
			<col width="25%">
			<col width="25%">
			<col width="">
		</colgroup>
		<tr>
			<th>KOSDAQ</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisu"))%></td>
			<th>KOSDAQ daily net change</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisuBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kosdaqJisuDebi"))%></td>
		</tr>
		<tr>
			<th>KOSDAQ Stars</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisu"))%></td>
			<th>KOSDAQ Star daily net change</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisuBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("starJisuDebi"))%></td>
		</tr>
		<tr>
			<th>Midday classification</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myJangGubun"))%></td>
			<th>Public offering price</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("myPublicPrice"))%></td>
		</tr>
		<tr>
			<th>KRX100</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100Jisu"))%></td>
			<th>KRX100 daily net change</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100buho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("krx100Debi"))%></td>
		</tr>
		<tr>
			<th>KOSPI</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiJisu"))%></td>
			<th>KOSPI daily net change</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiBuho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospiDebi"))%></td>
		</tr>
		<tr>
			<th>KOSPI 200</th>
			<td class="br_none"><%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Jisu"))%></td>
			<th>KOSPI 200 daily net change</th>
			<td class="br_none">
			<%=SetBuho(Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Buho")))%>&nbsp;
			<%=Trim(Xhd.getElementsByTagName("stockInfo").Item(0).getAttribute("kospi200Debi"))%></td>
		</tr>
	</table>
</div>

<%
Set Xhd = Nothing
%>