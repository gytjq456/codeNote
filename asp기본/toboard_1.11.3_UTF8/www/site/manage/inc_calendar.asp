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

<div class="">
	<table class="calendar">
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
			<th colspan="7"><%=intyear%>. <%=intmonth%></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>SUN</th>
			<th>MON</th>
			<th>TUE</th>
			<th>WED</th>
			<th>THU</th>
			<th>FRI</th>
			<th>SAT</th>
		</tr>
		<%
		inttoday = 1

		'1일 이전의 공백 생성
		for i=1 to intweekdayoffirstday - 1%><td>&nbsp;</td><%next

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
			<td <%
			'오늘 날짜 표시
			If ndate=CStr(Date()) Then Response.Write " class='today' "
			%>><a href="/site/manage/sub-order/order.asp?s_srdate=<%=ndate%>&s_erdate=<%=ndate%>"  class="<%
			'토요일, 일요일 색깔
			If Weekday(ndate)=1 Then
				Response.Write "sun"
			ElseIf Weekday(ndate)=7 Then
				Response.Write "sat"
			End If%>"><%=i%></a></td><%
			inttoday = inttoday + 1
		Next

		'마지막날 이후 달력 끝날때까지 빈칸 생성
		For i = inttoday To 7%><td>&nbsp;</td><%Next%>
			 </tr>
		 </tbody>
	 </table>
 </div>
