<!--카테고리-->
<div class="ntb-top-area">
<%
'카테고리 셀렉트
If k_category<>"" Then
	%>
	<select name="s_cate" class="AXSelect" onchange="location.href='?mode=list&amp;bid=<%=bid%>&amp;s_cate='+this.value">
		<option value="">------전체------</option>
		<%
		a_category = Split(k_category, "|")
		For Each cate_item In a_category
		%>
			<option value="<%=cate_item%>" <%If Trim(s_cate)=Trim(cate_item) Then Response.Write "selected"%>><%=cate_item%></option>
		<%
		Next
		%>
	</select>
	<%
End If

'RSS사용
If k_rss=True Then%>
<a href="<%=T_PATH%>/bbs/bbs_rss.asp?bid=<%=bid%>" target="_blank"><img src="<%=T_PATH%>/images/board/icon_rss.gif" border="0" alt="rss" class="vmiddle" /></a>
<%End If%>
</div>

<%
If Request("s_year") = "" then
	intyear = Year(Date())
	intmonth = Month(Date())
Else 
	intyear = Request("s_year")
	intmonth = Request("s_month")
End If

If intmonth = 1 then
	intprevyear = intyear - 1
	intprevmonth = 12
Else
	intprevmonth = intmonth - 1
	intprevyear = intyear
End If

If intmonth = 12 then
	intnextyear = intyear + 1
	intnextmonth = 1
Else
	intnextmonth = intmonth + 1
	intnextyear = intyear
End If

intweekdayoffirstday = Weekday(intyear & "-" & intmonth & "-01")
intprevdayofthismonth = Day(DateAdd("d", -1, intnextyear & "-" & intnextmonth & "-01"))


If Len(intmonth)=1 Then
	z_month = "0" & intmonth
Else
	z_month = intmonth
End If

%>

			 <div class="calendar_month">
				 <a href="?<%=pLink%>&s_year=<%=intprevyear%>&s_month=<%=intprevmonth%>">이전달</a>&nbsp;&nbsp;&nbsp;&nbsp;
				 <%=intyear%>년 <%=intmonth%>월
				 &nbsp;&nbsp;&nbsp;&nbsp;<a href="?<%=pLink%>&s_year=<%=intnextyear%>&s_month=<%=intnextmonth%>">다음달</a>
			 </div>

			 <table width="100%" cellpadding="0" cellspacing="0" class="ntb-calendar">
			 <colgroup>
				 <col width="14.2%" />
				 <col width="14.2%" />
				 <col width="14.2%" />
				 <col width="14.2%" />
				 <col width="14.2%" />
				 <col width="14.2%" />
				 <col width="14.2%" />
			 </colgroup>
			 <thead>
				<tr>
        <th>SUN</th>
        <th>MON</th>
        <th>TUE</th>
        <th>WED</th>
        <th>THU</th>
        <th>FRI</th>
        <th>SAT</th>
				</tr>
			 </thead>
			 <tbody>
<%

inttoday = 1

'1일 이전의 공백 생성
for i=1 to intweekdayoffirstday - 1%>
	<td class='bla'></td>
<%next

inttoday = inttoday + intweekdayoffirstday - 1

'1일부터 마지막날까지 달력생성
For i=1 To intprevdayofthismonth		
	If inttoday > 7 then%>
		</tr>
		<tr>
		<%inttoday = 1
	End If

	If CInt(i)<10 Then
		z_i = "0" & i
	Else
		z_i = i
	End If

	ndate = intyear & "-" & z_month & "-" & z_i

	%>
	<td class="<%
	'토요일, 일요일 색깔
	If Weekday(ndate)=1 Then
		Response.Write "sun"
	ElseIf Weekday(ndate)=7 Then
		Response.Write "sat"
	End If
	'오늘 날짜 표시
	If ndate=CStr(Date()) Then Response.Write " today"
	%>"> <%=i%>
	<p class="day"><span><%=strWeekday(ndate)%></span></p>
	<div class="schelist">
	<%
	Set Rs2 = Server.CreateObject("ADODB.Recordset")

	Sql = "SELECT idx, cate, title, addtext1, addtext2, addtext3, addtext4, mem_id, lock FROM tbl_board_data WHERE board_idx='" & bid & "' AND addtext1<='" & CDate(ndate) & "' AND addtext2>='" & CDate(ndate) & "' "
	If s_cate<>"" Then Sql = Sql & "AND cate like '" & s_cate & "' "
	Rs2.Open Sql, Dbcon, 1
	Do Until Rs2.EOF
		ArrCnt = CInt(Right(Rs2("addtext1"), 2))-1
		sc_idx = Rs2("idx")
		sc_title = Rs2("title")
		sc_cate = Rs2("cate")
		sc_addtext1 = Rs2("addtext1")
		sc_addtext2 = Rs2("addtext2")
		sc_addtext3 = Rs2("addtext3")
		sc_addtext4 = Rs2("addtext4")
		sc_lock = Rs2("lock")
		sc_mem_id = Rs2("mem_id")

		sc_tmp = ""

		'비밀글 이미지
		If sc_lock=True Then
			sc_tmp = sc_tmp & "<img src='" & T_PATH & "/images/board/lock.gif' alt='lock' /> "
		End If

		'공지사항은 bold 처리
		If sc_lock=True Then
			If (W_ID<>"" And W_ID=sc_mem_id) Or W_LEVEL="1" Or W_LEVEL="2" Then
				sc_tmp = sc_tmp & "<a href='?mode=view&amp;" & pLink & "&amp;idx=" & sc_idx & "&amp;page=" & page & "' style='color:#ffffff'>"
			Else
				sc_tmp = sc_tmp & "<a href='?mode=view_l&amp;" & pLink & "&amp;idx=" & sc_idx & "&amp;page=" & page & "' style='color:#ffffff'>"
			End If
		Else
			sc_tmp = sc_tmp & "<a href='?mode=view&amp;" & pLink & "&amp;idx=" & sc_idx & "&amp;page=" & page & "' style='color:#ffffff'>"
		End If
		If sc_cate<>"" Then sc_tmp = sc_tmp & "[" & sc_cate & "] "
		sc_tmp = sc_tmp & TagText(sc_title)
		sc_tmp = sc_tmp & "</a>"

		Response.Write "<p class='info' style='background-color:" & sc_addtext3 & "; text-align:center;'>" & sc_tmp & "</p>"
		Rs2.MoveNext
	Loop
	Rs2.Close
	Set Rs2 = Nothing
	%>


	</div>
	</td>
	<%
	inttoday = inttoday + 1
Next

'마지막날 이후 달력 끝날때까지 빈칸 생성
For i = inttoday To 7%>
	<td class='bla'></td>
<%Next%>
       </tr>
			 </tbody>
		 </table>

<br />

<!--버튼-->
<div class="ntb-listbtn-area">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<input type="button" value=" 쓰기 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=reg'">
	<%End If%>
</div>
