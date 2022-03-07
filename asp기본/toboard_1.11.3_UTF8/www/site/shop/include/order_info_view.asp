<%
o_code = Request("o_code")

s_o_name = InsertText(Request("s_o_name"))
s_o_email = InsertText(Request("s_o_email"))

page = Request("page")
If page="" Then page=1

pLink = "s_o_name=" & s_o_name & "&s_o_email=" & s_o_email
%>

<!-- contents -->
<div class="contents">

<%
Set Rs = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM tbl_mall_order WHERE o_code='" & o_code & "' "
'Response.write sql
Rs.open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_id = Rs("m_id")
	o_code = Rs("o_code")
	o_comp = Rs("o_comp")
	o_name = Rs("o_name")
	o_tel = Rs("o_tel")
	o_zip = Rs("o_zip")
	o_addr1 = Rs("o_addr1")
	o_addr2 = Rs("o_addr2")
	o_email = Rs("o_email")
	s_comp = Rs("s_comp")
	s_name = Rs("s_name")
	s_tel = Rs("s_tel")
	s_zip = Rs("s_zip")
	s_addr1 = Rs("s_addr1")
	s_addr2 = Rs("s_addr2")
	s_text = Rs("s_text")
	o_amount = Rs("o_amount")
	o_deli_amount = Rs("o_deli_amount")
	o_vat = Rs("o_vat")
	o_deli = Rs("o_deli")
	o_deli_code = Rs("o_deli_code")
	o_deli_date = Rs("o_deli_date")
	o_pay_bank = Rs("o_pay_bank")
	o_pay_bank_name = Rs("o_pay_bank_name")
	o_pay_method = Rs("o_pay_method")
	o_pay_log = Rs("o_pay_log")
	o_pay_point = Rs("o_pay_point")
	o_coupon_code = Rs("o_coupon_code")
	o_coupon_amount = Rs("o_coupon_amount")
	o_state = Rs("o_state")
	regdate = Rs("regdate")
	o_memo = Rs("o_memo")
Else
	Response.Write "<script>alert('조회 내역이 없습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close

Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "' "
'Response.write sql
Rs.open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_lev = Rs("m_lev")
	m_sort = Rs("m_sort")
	m_email = Rs("m_email")
	m_regdate = Rs("regdate")
End If
Rs.Close
Set Rs = Nothing

If o_deli="" Then o_deli=mc_deli
%>


<div class="right_con quick_start">
	<!--div class="route_box">
		<h5><img src="/site/images/shop/history_icon.png" alt="아이콘" />주문내역</h5>
	</div-->
	<div class="top_txt_box">
		<p>주문내역을 확인하시기 전에 꼭 읽어주세요</p>
		<ul>
			<li><p>배송이 진행되기 전에 입력하신 주소와 연락처가 정확한지 다시 한 번 확인해 주시면 감사드리겠습니다.</p></li>
			<li><p>주문하시는 분과 실제 상품을 수령하는 분이 다를 수 있으므로 두 가지 정보가 뒤바뀌지 않게 체크해주세요. </p></li>
			<li><p>대량 구매 시 재고 상황에 따라 배송이 다소 지연될 수 있는 점 미리 양해부탁드립니다.</p></li>
		</ul>
	</div>
	<div class="order_type">
		<div class="top_box">
			<p>주문 정보</p>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="200px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>주문번호</th>
					<td>
						<p><%=o_code%></p>
					</td>
				</tr>
				<tr>
					<th>주문날짜</th>
					<td>
						<p><%=regdate%></p>
					</td>
				</tr>
				<tr>
					<th>주문상태</th>
					<td>
						<p><%=o_state%></p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="cart_tb cart_tb01">
		<p>주문내역 상세보기</p>
		<form action="">
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
				Sql = Sql & " WHERE A.idx!='' AND A.o_state!='' AND A.o_code='" & o_code & "' "
				Sql = Sql & " ORDER BY A.regdate DESC"
				'Response.Write Sql
				Rs.Open Sql, Dbcon, 1
				
				If Rs.EOF=False Then
					num=1
					Do Until Rs.EOF
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
						all_total = all_total+op_total_amount
						%>
						<tr>
							<td class="data">
								<b><%=regdate%></b>
								<p>(<%=o_code%>)</p>
							</td>
							<td class="cart_img">
								<img src="/upload/prod/thumb_s/<%=op_image1%>" alt="이미지" />
							</td>
							<td class="cart_info">
								<!-- <span>농축음료</span> -->
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
							</td>
						</tr>
						<%
						num=num-1
						cnt=cnt+1
						Rs.MoveNext
					Loop
				End If
				Rs.Close
				Set Rs = Nothing%>
					<tr>
						<td colspan="7" class="price_wrap">
							<!--div class="savings">
								<span>예상적립금</span>
								<p>200<font>원</font></p>
							</div-->
							<div class="total_price">
								<div class="type">
									<p>상품금액</p>
									<span><%=FormatNumber(all_total, 0)%><font>원</font></span>
								</div>
								<div class="type type01">
									<p>+</p>
								</div>
								<div class="type">
									<p>배송비</p>
									<span><%=FormatNumber(o_deli_amount, 0)%><font>원</font></span>
								</div>
								<%If o_pay_point>0 Then%>
									<div class="type type01">
										<p>-</p>
									</div>
									<div class="type">
										<p>사용적립금</p>
										<span><%=FormatNumber(o_pay_point, 0)%><font>p</font></span>
									</div>
								<%End If%>
								<%If o_coupon_amount>0 Then%>
									<div class="type type01">
										<p>-</p>
									</div>
									<div class="type">
										<p>쿠폰할인</p>
										<span><%=FormatNumber(o_coupon_amount, 0)%><font>p</font></span>
									</div>
								<%End If%>
								<div class="type type01">
									<p>=</p>
								</div>
								<div class="type type02">
									<p>전체 합계</p>
									<span><%=FormatNumber(all_total+o_deli_amount-o_pay_point-o_coupon_amount, 0)%><font>원</font></span>
								</div>
							</div>
						</td>
					</tr>
				 </tbody>
			</table>
		</form>
	</div>
	<div class="order_type">
		<div class="top_box">
			<p>주문하시는 분</p>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="200px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>성명</th>
					<td>
						<p><%=o_name%>
						[<%If m_id="" Then : Response.Write "비회원" : Else : Response.Write m_id : End If%>]
						</p>
					</td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td>
						<p><%=o_tel%></p>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<p><%=o_email%></p>
					</td>
				</tr>
				<tr>
					<th>주문자 주소</th>
					<td>
						<p>
							<%=o_zip%><br />
							<%=o_addr1%><br />
							<%=o_addr2%>
						</p>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="order_type">
		<div class="top_box">
			<p>받는 사람(배송지) 정보</p>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="200px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>성명</th>
					<td>
						<p><%=s_name%></p>
					</td>
				</tr>
				<tr>
					<th>휴대폰 번호</th>
					<td>
						<p><%=s_tel%></p>
					</td>
				</tr>
				<tr>
					<th>배송지 주소</th>
					<td>
						<p>
							<%=s_zip%><br />
							<%=s_addr1%><br />
							<%=s_addr2%>
						</p>
					</td>
				</tr>
				<tr>
					<th>배송 요청사항</th>
					<td>
						<p><%=TagText(s_text)%></p>
					</td>
				</tr>
				<%If o_deli_code<>"" Then%>
				<tr>
					<th>배송 및 송장번호</th>
					<td>
						<p>
						택배사 : <%=o_deli%> / 
						송장번호 : <%=o_deli_code%> / 
						배송날짜 : <%=o_deli_date%>
						<%If DeliveryTrace(o_deli, o_deli_code)<>"" Then%>
							<input type="button" value="배송추적" class="AXButton Classic" onclick="open('<%=DeliveryTrace(o_deli, o_deli_code)%>', 'pop', '')">
						<%End If%>
						</p>
					</td>
				</tr>
				<%End If%>
			</tbody>
		</table>
	</div>
	<div class="order_type">
		<div class="top_box">
			<p>결제 정보</p>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="200px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>결제수단</th>
					<td>
						<p><%=o_pay_method%></p>
					</td>
				</tr>
				<%If o_pay_method="무통장입금" Then%>
				<tr>
					<th>입금계좌</th>
					<td>
						<p><%=o_pay_bank%></p>
					</td>
				</tr>
				<tr>
					<th>입금계좌</th>
					<td>
						<p><%=o_pay_bank_name%></p>
					</td>
				</tr>
				<tr>
					<th>최종 결제금액</th>
					<td>
						<p class="total"><%=FormatNumber(all_total+o_deli_amount-o_pay_point-o_coupon_amount, 0)%> <span>원</span></p>
					</td>
				</tr>
				<%ElseIf o_pay_method="신용카드" Then%>
				<%End If%>
			</tbody>
		</table>
	</div>
</div>

<div class="cart_btn">
	<a href="?mode=order_info_list&<%=pLink%>" class="type03">
		<img src="/site/images/shop/cart_btn_icon04.png" alt="이미지" />
		주문 목록
	</a>
	<%If o_state="결제대기" Or o_state="결제완료" Or o_state="발송준비" Then%>
		<a href="/sub/mypage/order_cancel.asp?o_code=<%=o_code%>&c_cate=취소요청" class="type02">
			<img src="/site/images/shop/cart_btn_icon04.png" alt="이미지" />
			주문 취소 요청
		</a>
	<%ElseIf o_state="발송완료" Then%>
		<a href="/sub/mypage/order_cancel.asp?o_code=<%=o_code%>&c_cate=반품요청" class="type02">
			<img src="/site/images/shop/cart_btn_icon04.png" alt="이미지" />
			반품 요청
		</a>
	<%End If%>
</div>
