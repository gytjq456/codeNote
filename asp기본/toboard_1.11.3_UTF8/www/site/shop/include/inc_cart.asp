<div class="top_txt_box">
	<p>장바구니 이용안내</p>
	<ul>
		<li><p>수량 변경은 변경을 희망하시는 제품의 수량을 선택하신 후 변경 버튼을 클릭하셔야 수량 변경이 가능합니다.</p></li>
		<li><p>정확한 결제금액은 다음 단계인 주문 및 결제 페이지로 이동하시면 최종 결제 금액이 출력됩니다.</p></li>
		<%If mc_point_use=True Then%>
		<li><p>적립금의 경우 이벤트 및 행사에 따라 금액에 변동이 있을 수 있으므로 이용시 참고 부탁드립니다.</p></li>
		<li><p>비회원으로 구매하시는 경우 적립금 적립은 불가능하며 추후 가입하시더라도 이전 결제 적립금 적립은 불가합니다.</p></li>
		<%End If%>
	</ul>
</div>

<div class="cart_tb">
	<table>
		 <colgroup>
			<col class="img_w" width="6.7%">
			<col class="info_w" width="*">
			<col class="quantity_w" width="14.3%">
			<col class="total_w" width="14.3%">
			<col class="change_w" width="15.8%">
		 </colgroup>
		 <thead>
			<tr>
				<th colspan="2">상품명 및 옵션정보</th>
				<th>수량</th>
				<th>합계</th>
				<th class="m_none">삭제</th>
			</tr>
		 </thead>
		 <tbody>
			<%
			Set RsCart = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.*, B.p_o_price, B.p_image1 FROM tbl_mall_cart A "
			Sql = Sql & " LEFT JOIN tbl_prod B ON A.p_idx=B.idx "
			Sql = Sql & " WHERE A.o_end='0' "
			If W_ID<>"" Then
				Sql = Sql & " AND A.m_id='" & W_ID & "' "
			Else
				Sql = Sql & " AND A.session_id='" & W_SID & "' "
			End If
			Sql = Sql & " ORDER BY A.idx ASC"
			RsCart.Open Sql, Dbcon, 1

			num=0
			ct_all_amount=0
			If RsCart.EOF=False Then
				Do Until RsCart.EOF
					num=num+1
					ct_idx = RsCart("idx")
					ct_p_o_price = RsCart("p_o_price")
					ct_p_image1 = RsCart("p_image1")
					ct_p_name = RsCart("p_name")
					ct_p_option = RsCart("p_option")
					ct_p_amount = RsCart("p_amount")
					ct_p_qty = RsCart("p_qty")
					ct_p_tamount = ct_p_amount*ct_p_qty
					%>
					<tr>
						<td class="cart_img">
							<img src="/upload/prod/thumb_s/<%=ct_p_image1%>" alt="이미지" />
						</td>
						<td class="cart_info">
							<!--span>농축음료</span-->
							<p><%=ct_p_name%></p>
							<div class="price">
								<%If ct_p_o_price<>"0" Then %>
									<p class="sale"><%=FormatNumber(ct_p_o_price, 0)%><span>원</span></p>
								<%End If%>
								<p><%=FormatNumber(ct_p_amount, 0)%><span>원</span></p>
							</div>
							<%If ct_p_option<>"" Then%>
							<div class="option_box">
								<span>옵션 : </span><p><%=ct_p_option%></p>
							</div>
							<%End If%>
						</td>
						<td class="quantity">
							<form name="cartform<%=ct_idx%>" method="post" action="?mode=cart_mod&idx=<%=ct_idx%>">
								<div class="box">
									<label for="" class="quantity_box">
										<button type="button" class="minus"><img src="/site/images/shop/quantity_minus.png" alt="이미지" /></button>
										<input type="text" name="p_qty" value="<%=ct_p_qty%>" required>
										<button type="button" class="plus"><img src="/site/images/shop/quantity_plus.png" alt="이미지" /></button>
									</label>
								</div>
								<button type="submit">변경</button>
							</form>
							<!--select name="p_qty" class="AXSelect" onchange="location.href='?mode=cart_mod&idx=<%=ct_idx%>&p_qty='+this.value">
								<%For q=1 To 99%>
								<option value="<%=q%>" <%If q=ct_p_qty Then Response.Write "selected"%>><%=q%></option>
								<%Next%>
							</select-->
						</td>
						<td class="price total">
							<p><%=FormatNumber(ct_p_tamount, 0)%><span>원</span></p>
						</td>
						<td class="change">
							<a href="javascript:if(confirm('삭제하시겠습니까?')){ location.href='?mode=cart_del&amp;idx=<%=ct_idx%>'};">삭제</a>
						</td>
					</tr>
					<%
					ct_all_amount = ct_all_amount+ct_p_tamount
					RsCart.Movenext
				Loop
			Else
			%>
					<tr>
						<td colspan="5" class="cart_info"><p>장바구니가 비어있습니다.</p></td>
					</tr>
			<%
			End If
			RsCart.Close
			Set RsCart = Nothing
			%>
		 </tbody>
	</table>

<%
'장바구니에 상품이 있는 경우
If num>0 And ct_all_amount>0 Then

	If mc_deli_free<=ct_all_amount Then
		ct_deli_charge = 0
	Else
		ct_deli_charge = mc_deli_charge
	End If

	'최종금액
	fn_amount = ct_all_amount+ct_deli_charge
	%>
	<div class="cart_btn">
		<a href="javascript:if(confirm('장바구니에 담긴 모든 상품을 삭제하시겠습니까?')){ location.href='?mode=cart_alldel'};" class="type01">
			<img src="/site/images/shop/cart_btn_icon02.png" alt="이미지" />
			전체상품 삭제
		</a>
		<a href="?mode=order_login" class="type03">
			<img src="/site/images/shop/cart_btn_icon04.png" alt="이미지" />
			전체상품 주문
		</a>
	</div>
<%End If%>


<%
'네이버페이 연동
If sc_naverpay=True Then
	If num>0 And ct_all_amount>0 Then%>

	<%If sc_mobile=True Then%>
	<script type="text/javascript" src="http://pay.naver.com/customer/js/mobile/naverPayButton.js" charset="UTF-8"></script>
	<%Else%>
	<script type="text/javascript" src="http://pay.naver.com/customer/js/naverPayButton.js" charset="UTF-8"></script>
	<%End If%>
	<script type="text/javascript" >
	function buy_nc(){
		$.ajax({
			url : "/site/shop/include/np_cart_order.asp",
			type : "POST",
			data : "",
			async : false, cache : false, dataType : "text",
			error: function(xhr, status, error){
				alert(error);
			},
			success : function(data) {
				if(data.error) {
					alert(data.error);
					return false;
				}
				var dsp = data.split('||');
				var orderid = dsp[0];
				var shopid = dsp[1];
				var total_price = dsp[2];

				<%If sc_mobile=True Then%>
					location.href = "https://m.pay.naver.com/mobile/customer/order.nhn?ORDER_ID="+orderid+"&SHOP_ID="+shopid+"&TOTAL_PRICE="+total_price;
				<%Else%>
					var openNewWindow = window.open("about:blank");
					openNewWindow.location.href = "https://pay.naver.com/customer/order.nhn?ORDER_ID="+orderid+"&SHOP_ID="+shopid+"&TOTAL_PRICE="+total_price;
				<%End If%>
			}
		});
	}

	naver.NaverPayButton.apply({
		BUTTON_KEY: "CCD330FA-C8FE-45B4-88C6-0FEF9FD09132", // 네이버페이에서 제공받은 버튼 인증 키 입력
		<%If sc_mobile=True Then%>
		TYPE: "MA", // 버튼 모음 종류 설정
		<%Else%>
		TYPE: "A", // 버튼 모음 종류 설정
		<%End If%>
		COLOR: 1, // 버튼 모음의 색 설정 2. 네이버페이 버튼 네이버페이 가맹점 연동 가이드  21
		COUNT: 1, // 버튼 개수 설정. 구매하기 버튼만 있으면(장바구니 페이지) 1, 찜하기 버튼도있으면(상품 상세 페이지) 2를 입력.
		ENABLE: "Y", // 품절 등의 이유로 버튼 모음을 비활성화할 때에는 "N" 입력
		BUY_BUTTON_HANDLER: buy_nc, 
		"":""
	 });
	</script>
	<!-- // 네이버페이 연동 -->

	<%
	End If
End If
%>

</div>