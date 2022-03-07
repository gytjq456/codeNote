<%
page = Request("page")
If page="" Then page=1

pLink = "s_m_id=" & m_id

If mc_point_use=False Then
	Response.Write "<script>alert('포인트 사용이 불가합니다.'); history.back();</script>"
	Response.End
End If

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_name = Rs("m_name")
	m_point = Rs("m_point")
Else
	Response.Write "<script>alert('회원정보가 없거나 탈퇴한 회원입니다.'); history.back();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing
%>

<div class="right_con quick_start">
	<div class="cart_tb cart_tb01">
		<p>사용가능 포인트</p>
		<table>
			<colgroup>
				<col width="" />
			</colgroup>
			<thead>
			<tr>
				<th style="padding:50px">
				<span style="font-size:45px;line-height:45px;font-family:Impact"><%=FormatNumber(m_point, 0)%>p</span></th>
			</tr>
			</thead>	
		</table>
	</div>

	<div class="cart_tb cart_tb01">
		<p>포인트 적립 및 사용 내역</p>
		<table>
			<colgroup>
				<col width="30%" />
				<col width="20%" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th>날짜</th>
					<th>금액</th>
					<th>비고</th>
				</tr>
			</thead>			
			<tbody>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_member_point "
			Sql = Sql & " WHERE idx!='' AND m_id='" & m_id & "' "
			Sql = Sql & " ORDER BY idx DESC "
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 50
				Rs.AbsolutePage = page
				Rs_RecordCount = Rs.RecordCount
				If Rs_RecordCount Mod Rs.PageSize>0 Then
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
				Else
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)
				End If
			End If

			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					idx = Rs("idx")
					m_id = Rs("m_id")
					mp_point = Rs("mp_point")
					mp_pm = Rs("mp_pm")
					mp_bigo = Rs("mp_bigo")
					regdate = Rs("regdate")

					If InStr(mp_pm, "+")>0 Then
						txtcolor="style='color:#4286f4'"
					Else
						txtcolor="style='color:#f44141'"
					End If
					%>
					<tr>
						
						<td class="cart_info" style="text-align:center;"><p><%=regdate%></p></td>
						<td class="cart_info" style="text-align:center;"><p <%=txtcolor%>><%=mp_pm & FormatNumber(mp_point, 0)%>p</p></td>
						<td class="cart_info"><p><%=mp_bigo%></p></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="3" class="bdr bdt">포인트 내역이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
			</tbody>
		</table>

		<!-- page -->
		<div class="page">
			<ul>
				<%Call pagelist("?" & pLink, CInt(page), 50, 10, Rs_RecordCount)%>
			</ul>
		</div>
	</div>
</div>
<!-- //page -->