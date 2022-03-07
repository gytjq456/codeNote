<%If W_ID<>"" Then%>
<ul class="shop_tab">
	<li <%If InStr(mode, "order_info") Then Response.Write "class=""on"""%>><a href="<%=mc_shop_url%>?mode=order_info">주문내역</a></li>
	<li <%If mode="wish" Then Response.Write "class=""on"""%>><a href="<%=mc_shop_url%>?mode=wish">관심상품</a></li>
	<li <%If InStr(urlPath, "point.asp") Then Response.Write "class=""on"""%>><a href="/sub/shop/point.asp">적립금 내역</a></li>
	<li <%If InStr(urlPath, "modify.asp") Then Response.Write "class=""on"""%>><a href="/sub/shop/modify.asp">나의정보수정</a></li>
	<li><a href="/sub/member/login.asp?mode=logout_p">로그아웃</a></li>
</ul>
<%End If%>