<%Response.ContentType = "text/xml; charset=utf-8"%><?xml version="1.0" encoding="UTF-8" ?>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<!--#include virtual="/site/bbs/include/inc_setting.asp" -->
<rss version="2.0">
	<channel>
		<title><%=TagText(k_id)%></title>
		<link>http://<%=Request.ServerVariables("HTTP_HOST")%></link>
		<description><%=TagText(k_id)%></description>
		<language>ko-KO</language>
		<%
		Set Rs = Server.CreateObject("Adodb.Recordset")
		Sql = "SELECT TOP 50 idx, regdate, title, mem_name, content FROM tbl_board_data "
		Sql = Sql & "WHERE board_idx='" & bid & "' and lock='0' "
		Sql = Sql & " ORDER BY regdate DESC"
		Rs.open Sql, Dbcon, 1

		Do Until Rs.EOF
			Rs_idx = Rs("idx")
			Rs_regdate = Rs("regdate")
			Rs_title = TagText(Rs("title"))
			Rs_mem_name = TagText(Rs("mem_name"))
			Rs_content = TagText(strTagDel(Rs("content")))
			%>
			<item>
				<title><%=Rs_title%></title>
				<link>http://<%=Request.ServerVariables("HTTP_HOST")%></link>
				<author><%=Rs_mem_name%></author>
				<description><%=Replace(Rs_content, "<br>", Chr(13))%></description>
				<pubDate><%=FormatDateTime(Rs_regdate,2) & " " & FormatDateTime(Rs_regdate,4)%></pubDate>
			</item>
		<%Rs.movenext
		Loop
		Rs.close
		Set Rs= Nothing%>
	</channel>
</rss>
