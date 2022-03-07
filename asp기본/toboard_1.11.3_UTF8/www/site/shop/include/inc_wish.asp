<div class="top_txt_box">
	<p>관심상품 이용안내</p>
	<ul>
		<li><p>관심상품 내에 있는 상품을 주문하시더라도 관심상품 목록에 있는 제품은 삭제되지 않고 그대로 저장됩니다.</p></li>
		<li><p>관심상품 목록과 장바구니 상품 목록은 다르기때문에 여러개를 담으신 후 결제 금액을 확인하시고 싶으신 경우 장바구니에 제품을 담아주세요.</p></li>
	</ul>
</div>

<div class="cart_tb">
	<table>
		 <colgroup>
			<col class="img_w" width="6.7%">
			<col class="info_w" width="*">
			<col class="total_w" width="20%">
			<col class="change_w" width="15.8%">
		 </colgroup>
		 <thead>
			<tr>
				<th colspan="2">상품정보</th>
				<th>가격</th>
				<th class="m_none"></th>
			</tr>
		 </thead>
		 <tbody>
			<%
			Set RsWish = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.*, B.idx p_idx, B.p_name, B.p_price, B.p_o_price, B.p_image1 FROM tbl_mall_wish A "
			Sql = Sql & " INNER JOIN tbl_prod B ON A.p_idx=B.idx "
			Sql = Sql & " WHERE A.m_id='" & W_ID & "' "
			Sql = Sql & " ORDER BY A.idx ASC"
			RsWish.Open Sql, Dbcon, 1

			If RsWish.EOF=False Then
				Do Until RsWish.EOF
					w_idx = RsWish("idx")
					w_p_idx = RsWish("p_idx")
					w_p_price = RsWish("p_price")
					w_p_o_price = RsWish("p_o_price")
					w_p_image1 = RsWish("p_image1")
					w_p_name = RsWish("p_name")
					%>
					<tr>
						<td class="cart_img">
							<a href="/sub/product/product.asp?mode=view&idx=<%=w_p_idx%>"><img src="/upload/prod/thumb_s/<%=w_p_image1%>" alt="이미지" /></a>
						</td>
						<td class="cart_info">
							<p><a href="/sub/product/product.asp?mode=view&idx=<%=w_p_idx%>"><%=w_p_name%></a></p>
						</td>
						<td class="price total">
								<%If w_p_o_price<>"0" Then %>
									<p class="sale"><%=FormatNumber(w_p_o_price, 0)%><span>원</span></p>
								<%End If%>
							<p><%=FormatNumber(w_p_price, 0)%><span>원</span></p>
						</td>
						<td class="change">
							<a href="javascript:if(confirm('삭제하시겠습니까?')){ location.href='/site/shop/include/wish_ok.asp?p_idx=<%=w_p_idx%>'};">삭제</a>
						</td>
					</tr>
					<%
					RsWish.Movenext
				Loop
			Else
			%>
					<tr>
						<td colspan="4" class="cart_info"><p>관심상품 목록이 비어있습니다.</p></td>
					</tr>
			<%
			End If
			RsWish.Close
			Set RsWish = Nothing
			%>
		 </tbody>
	</table>

</div>