<%
page = Request("page")
If page="" Then page=1
%>

<article id="cont" class="">
	<table class="ntb-tb" style="width:100%" cellpadding="0" cellspacing="0">
		<colgroup>
			<col width="25%" />
			<col width="20%" />
			<col width="17%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
		<tr>
			<th>쿠폰</th>
			<th>쿠폰코드</th>
			<th>쿠폰명</th>
			<th>만료일</th>
			<th>발급일</th>
		</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.* FROM tbl_coupon_dl A "
			Sql = Sql & " WHERE A.m_id='" & W_ID & "' AND c_used='0' "			
			Sql = Sql & " ORDER BY A.regdate DESC"
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 20
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
					cd_code = Rs("cd_code")
					cd_name = Rs("cd_name")
					cd_enddate = Rs("cd_enddate")
					cd_dc_amount = Rs("cd_dc_amount")
					cd_dc_type = Rs("cd_dc_type")
					regdate = Rs("regdate")
					%>
					<tr>
						<td><%=cd_dc_amount & " " & cd_dc_type%></td>
						<td><%=Mid(cd_code, 1, 5) & "-" & Mid(cd_code, 6, 5) & "-" & Mid(cd_code, 11, 5) & "-" & Mid(cd_code, 16, 5)%></td>
						<td><%=cd_name%></td>
						<td><%=cd_enddate%></td>
						<td><%=regdate%></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="5">보유 중인 쿠폰이 없습니다.</td>
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
			<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
		</ul>
	</div>
	<!-- //page -->

</article>