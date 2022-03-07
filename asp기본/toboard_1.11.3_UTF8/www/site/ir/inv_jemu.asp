<script type="text/javascript" src="/site/js/tab_menu.js"></script>
<link rel="stylesheet" type="text/css" href="/site/ir/css/inv.css" />

<%
If ir_lang="영어" Then
	xml_lang = "XMLJemuEng"
	txt_title = "Financial information"
	txt_hangmok = "Financial items"
	txt_tbl_title1 = "Balance sheet"
	txt_tbl_title2 = "Income statement"
	txt_tbl_title3 = "Cash flow indexes"
	txt_tbl_hangmok1 = "Amounts(Million Won)"
	txt_tbl_hangmok2 = "Composition(%)"
	txt_tbl_hangmok3 = "Rate of change(%)"
Else
	xml_lang = "XMLJemu"
	txt_title = "재무 정보"
	txt_hangmok = "재무 항목"
	txt_tbl_title1 = "대차대조표"
	txt_tbl_title2 = "손익계산서"
	txt_tbl_title3 = "현금흐름관련지표"
	txt_tbl_hangmok1 = "금액(백만원)"
	txt_tbl_hangmok2 = "구성비(%)"
	txt_tbl_hangmok3 = "증감률(%)"
End If

Set objXmlHttp = server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
objXmlHttp.open "POST", "http://asp1.krx.co.kr/servlet/krx.asp." & xml_lang & "?code=" & stock_code, false

objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
objXmlHttp.send
strResponseText = objXmlHttp.responseText
Set objXmlHttp = Nothing

Set objMsXmlDom = Server.CreateObject("Microsoft.XMLDOM")
objMsXmlDom.async = false
objMsXmlDom.loadXML(strResponseText)
%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  google.charts.load('current', {'packages':['bar']});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {
	var data = google.visualization.arrayToDataTable([
	['<%=txt_hangmok%>', '<%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year0"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month0"))%>', '<%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year1"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month1"))%>', '<%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year2"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month2"))%>'],
	['<%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(2).getAttribute("hangMok2"))%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(2).getAttribute("year1Money2")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(2).getAttribute("year2Money2")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(2).getAttribute("year3Money2")), ",", "")%>],
	['<%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(5).getAttribute("hangMok5"))%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(5).getAttribute("year1Money5")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(5).getAttribute("year2Money5")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(5).getAttribute("year3Money5")), ",", "")%>],
	['<%=Replace(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(9).getAttribute("hangMok9"), "'", "\'")%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(9).getAttribute("year1Money9")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(9).getAttribute("year2Money9")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(9).getAttribute("year3Money9")), ",", "")%>],
	['<%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(0).getAttribute("hangMok0"))%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(0).getAttribute("year1Money0")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(0).getAttribute("year2Money0")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(0).getAttribute("year3Money0")), ",", "")%>],
	['<%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(1).getAttribute("hangMok1"))%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(1).getAttribute("year1Money1")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(1).getAttribute("year2Money1")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(1).getAttribute("year3Money1")), ",", "")%>],
	['<%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(5).getAttribute("hangMok5"))%>', <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(5).getAttribute("year1Money5")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(5).getAttribute("year2Money5")), ",", "")%>, <%=Replace(Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(5).getAttribute("year3Money5")), ",", "")%>]
	]);

	var options = {
		chart: {
			title: '', subtitle: ''
	},
	bars: 'vertical',
	colors: ['#ff812d', '#ffd101', '#81d734']
	};

	var chart = new google.charts.Bar(document.getElementById('chart_div'));
	chart.draw(data, options);
  }
</script>

<p class="inv_tit"><%=txt_title%>  <span class="inv_date">[ <%=Trim(objMsXmlDom.getElementsByTagName("financialTotal").Item(0).getAttribute("querytime"))%> ]</span></p>

<div id="chart_div" style="width:100%; height:500px;padding:30px 0;"></div>

<!-- tab_container -->
<div class="tab_container">

	<!-- tabs -->
	<ul class="inv_tab">
		<li class="on"><a href="#tab1"><%=txt_tbl_title1%></a></li>
		<li><a href="#tab2"><%=txt_tbl_title2%></a></li>
		<li class="last"><a href="#tab3"><%=txt_tbl_title3%></a></li>
	</ul>
	<!-- //tabs -->

	<!-- tab01 -->
	<div id="tab1" class="tab_content cont01">
		<p class="inv_tit"><%=txt_tbl_title1%></p>
		<table class="inv_tb">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr>
				<th rowspan="2"><%=txt_hangmok%></th>
				<th colspan="3"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year0"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month0"))%></th>
				<th colspan="3"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year1"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month1"))%></th>
				<th colspan="3" class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("year2"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha").Item(0).getAttribute("month2"))%></th>
			</tr>
			<tr>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th class="br_none"><%=txt_tbl_hangmok3%></th>
			</tr>
			<%For dd=0 To objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Length-1%>
			<tr>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("hangMok" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year1Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year1GuSungRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year1JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year2Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year2GuSungRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year2JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year3Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year3GuSungRate" & dd))%></td>
				<td class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_DaeCha_data").Item(dd).getAttribute("year3JungGamRate" & dd))%></td>
			</tr>
			<%Next%>
		</table>
	</div>
	<!-- //tab01 -->

	<!-- tab2 -->
	<div id="tab2" class="tab_content cont02">
		<p class="inv_tit"><%=txt_tbl_title2%></p>
		<table class="inv_tb">
			<colgroup>
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr>
				<th rowspan="2"><%=txt_hangmok%></th>
				<th colspan="3"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("year0"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("month0"))%></th>
				<th colspan="3"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("year1"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("month1"))%></th>
				<th colspan="3" class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("year2"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk").Item(0).getAttribute("month2"))%></th>
			</tr>
			<tr>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok2%></th>
				<th class="br_none"><%=txt_tbl_hangmok3%></th>
			</tr>
			<%For dd=0 To objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Length-1%>
			<tr>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("hangMok" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year1Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year1GuSungRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year1JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year2Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year2GuSungRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year2JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year3Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year3GuSungRate" & dd))%></td>
				<td class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_SonIk_data").Item(dd).getAttribute("year3JungGamRate" & dd))%></td>
			</tr>
			<%Next%>
		</table>
	</div>
	<!-- //tab2 -->

	<!-- tab3 -->
	<div id="tab3" class="tab_content cont03">
		<p class="inv_tit"><%=txt_tbl_title3%></p>
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
				<th rowspan="2"><%=txt_hangmok%></th>
				<th colspan="2"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("year0"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("month0"))%></th>
				<th colspan="2"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("year1"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("month1"))%></th>
				<th colspan="2" class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("year2"))%>. <%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow").Item(0).getAttribute("month2"))%></th>
			</tr>
			<tr>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th><%=txt_tbl_hangmok3%></th>
				<th><%=txt_tbl_hangmok1%></th>
				<th class="br_none"><%=txt_tbl_hangmok3%></th>
			</tr>
			<%For dd=0 To objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Length-1%>
			<tr>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("hangMok" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year1Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year1JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year2Money" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year2JungGamRate" & dd))%></td>
				<td><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year3Money" & dd))%></td>
				<td class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("TBL_CashFlow_data").Item(dd).getAttribute("year3JungGamRate" & dd))%></td>
			</tr>
			<%Next%>
		</table>
	</div>
	<!-- //tab3 -->


</div>
<!-- //tab_container -->

<%
Set objMsXmlDom = Nothing
%>