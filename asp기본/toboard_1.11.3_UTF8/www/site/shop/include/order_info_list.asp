<%
s_o_name = InsertText(Request("s_o_name"))
s_o_email = InsertText(Request("s_o_email"))

page = Request("page")
If page="" Then page=1

pLink = "s_o_name=" & s_o_name & "&s_o_email=" & s_o_email
%>

<div class="right_con quick_start">
	<!--div class="route_box">
		<h5><img src="/site/images/shop/history_icon.png" alt="아이콘" />주문내역</h5>
	</div-->
	<div class="caution_txt">
		<p>주문 및 배송내역의 경우 실시간으로 자동 반영되지 않으므로 시간상 다소 오차가 있을 수 있습니다. 자세한 내용은 고객센터로 연락 부탁드립니다.</p>
		<p>급하게 주소가 변경되시거나 취소하셔야하는 상황이 발생하신 경우에는 반드시 전화로 연락을 주시면 감사드리겠습니다.</p>
	</div>
	<div class="cart_tb cart_tb01">
		<p>주문내역 상세보기</p>
		<table>
			 <colgroup>
				<col class="data_w" width="20.9%">
				<col class="img_w" width="9.9%">
				<col class="info_w" width="*">
				<col class="price_w" width="10.4%">
				<col class="total_w" width="13.9%">
				<col class="accumulate_w" width="8.6%">
				<col class="change_w" width="10.6%">
			 </colgroup>
			 <thead>
				<tr>
					<th>주문날짜</th>
					<th colspan="2">주문 제품</th>
					<th class="m_none">상품 금액</th>
					<th class="m_none">최종 결제 금액</th>
					<th class="m_none">배송비</th>
					<th class="m_none">주문 상태</th>
				</tr>
			 </thead>
			 <tbody>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.*, C.p_name, C.p_option, C.p_amount, C.p_qty, D.p_image1 FROM tbl_mall_order A "
			Sql = Sql & " LEFT JOIN tbl_member B ON A.m_id=B.m_id "
			Sql = Sql & " LEFT JOIN tbl_mall_cart C ON A.o_code=C.o_code "
			Sql = Sql & " LEFT JOIN tbl_prod D ON C.p_idx=D.idx "
			Sql = Sql & " WHERE A.idx!='' AND A.o_state!='' "

			'비회원인 경우 조회
			If s_o_name<>"" And s_o_email<>"" Then
				Sql = Sql & " AND A.o_name='" & s_o_name & "' AND A.o_email='" & s_o_email & "'AND A.m_id='' "
			'회원인 경우 조회
			ElseIf W_ID<>"" Then
				Sql = Sql & " AND A.m_id='" & W_ID & "' "
			Else
				Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
				Response.End
			End If

			Sql = Sql & " ORDER BY A.regdate DESC"
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			If s_o_name<>"" And s_o_email<>"" And Rs.EOF Then
				Response.Write "<script>alert('조회된 내역이 없습니다.'); history.back();</script>"
				Response.End
			End If

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
					o_code = Rs("o_code")
					o_name = Rs("o_name")
					o_pay_method = Rs("o_pay_method")
					o_deli_amount = Rs("o_deli_amount")
					o_state = Rs("o_state")
					op_name = Rs("p_name")
					op_option = Rs("p_option")
					op_amount = Rs("p_amount")
					op_qty = Rs("p_qty")
					op_total_amount = op_amount*op_qty
					op_image1 = Rs("p_image1")
					regdate = Replace(Left(Rs("regdate"), 10), "-", ".")
					%>
					<tr onclick="location.href='?mode=order_info_view&o_code=<%=o_code%>&<%=pLink%>'" style="cursor:pointer">
						<td class="data">
							<b><%=regdate%></b>
							<p>(<%=o_code%>)</p>
						</td>
						<td class="cart_img">
							<img src="/upload/prod/thumb_s/<%=op_image1%>" alt="이미지" />
						</td>
						<td class="cart_info">
							<!-- span>농축음료</span -->
							<p><%=op_name%></p>
							<%If op_option<>"" Then%>
							<div class="option_box">
								<span>옵션 : </span><p><%=op_option%></p>
							</div>
							<%End If%>
						</td>
						<td class="price">
							<p><%=FormatNumber(op_amount, 0)%><span>원</span></p>
							<font>(수량:<%=FormatNumber(op_qty, 0)%>개)</font>
						</td>
						<td class="price total">
							<p><%=FormatNumber(op_total_amount, 0)%><span>원</span></p>
						</td>
						<td class="price accumulate">
							<p><%=FormatNumber(o_deli_amount, 0)%><span>원</span></p>
						</td>
						<td class="change">
							<p><%=o_state%></p>
							<a href="javascript:;">주문조회</a>
						</td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="7">주문건이 존재하지 않습니다.</td>
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
				<%Call pagelist("?mode=order_info_list&" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
			</ul>
		</div>
		<!-- //page -->
	</div>
</div>