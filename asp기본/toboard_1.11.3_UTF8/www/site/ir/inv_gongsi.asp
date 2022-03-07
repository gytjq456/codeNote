<link rel="stylesheet" type="text/css" href="/site/ir/css/inv.css" />

<%
stock_code = "333620"
auth_key = "ec4GKuIutfOgIzwLHOxu7h8vKYoKc46g"

If ir_lang="영어" Then
	xml_lang = "E"
	txt_title = "Information disclosure"
	txt_tbl_title1 = "Date"
	txt_tbl_title2 = "Disclosure title"
	txt_tbl_title3 = "Submit obligator"
Else
	xml_lang = "K"
	txt_title = "공시정보"
	txt_tbl_title1 = "일자"
	txt_tbl_title2 = "공시제목"
	txt_tbl_title3 = "제출의무자"
End If

Set objXmlHttp = server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
objXmlHttp.open "GET", "https://asp.koscom.co.kr/listservice/getDisInfoXML?code=" & stock_code & "&auth_key=" & auth_key & "&gubun=" & xml_lang

objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
objXmlHttp.send
strResponseText = objXmlHttp.responseText
Set objXmlHttp = Nothing

Set objMsXmlDom = Server.CreateObject("Microsoft.XMLDOM")
objMsXmlDom.async = false
objMsXmlDom.loadXML(strResponseText)
%>

<div class="inv_section" style="margin-top:0px;">
	<p class="inv_tit right">
		<!--<%=txt_title%> -->
		<span class="inv_date">[ <%=Trim(objMsXmlDom.getElementsByTagName("disclosureMain").Item(0).getAttribute("querytime"))%> ]</span></p>
	<table class="inv_tb">
		<colgroup>
			<col width="">
			<col width="60%">
			<col width="">
		</colgroup>
		<tr>
			<th><%=txt_tbl_title1%></th>
			<th><%=txt_tbl_title2%></th>
			<th class="br_none"><%=txt_tbl_title3%></th>
		</tr>
		<%For dd=0 To objMsXmlDom.getElementsByTagName("disInfo").Length-1%>
		<tr>
			<td><%=Left(Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("distime")), 4) & "-" & Mid(Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("distime")), 5, 2) & "-" & Mid(Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("distime")), 7)%></td>
			<td style="text-align:left; padding-left:30px"><a href="http://kind.krx.co.kr/common/disclsviewer.do?method=search&acptno=<%=Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("disAcpt_no"))%>" target="_blank"><%=Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("disTitle"))%></a></td>
			<td class="br_none"><%=Trim(objMsXmlDom.getElementsByTagName("disInfo").Item(dd).getAttribute("submitOblgNm"))%></td>
		</tr>
		<%Next%>
	</table>
</div>
<%
Set objMsXmlDom = Nothing
%>