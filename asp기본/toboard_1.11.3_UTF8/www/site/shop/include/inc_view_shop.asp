<form id="shopform" name="shopform" method="post" action="<%=mc_shop_url%>?mode=cart_reg">
	<input type="hidden" name="mode" value="reg" />
	<input type="hidden" name="p_idx" value="<%=idx%>" />
	<input type="hidden" name="p_name" value="<%=p_name%>" />
	<input type="hidden" name="p_point" value="<%=p_point%>" />
	<input type="hidden" name="p_option" value="" />

	<ul class="info_txt">
		<li>
			<%If p_o_price<>"0" And p_o_price<>"" Then%>
				<div class="box">
					<div class="left">
						<p>정상가</p>
					</div>
					<div class="right price">
						<p><s><%=FormatNumber(p_o_price, 0)%><span>원</span></s></p>
					</div>
				</div>
			<%End If%>
			<div class="box">
				<div class="left">
					<p>판매가</p>
				</div>
				<div class="right price">
					<%If p_price="0" Then%>
						<p>별도 문의</p>
					<%Else%>
						<p><%=FormatNumber(p_price, 0)%><span>원</span></p>
					<%End If%>
					<%
					If p_o_price<>"0" Then 
						p_dc = Fix(100-((CDbl(p_price)/CDbl(p_o_price))*100))
						Response.Write "<font class=""mint_color"">(" & p_dc & "% 할인)</font>"
					End If
					%>
				</div>
			</div>
			<%If mc_point_use=True And p_point<>"" Then%>
				<div class="box">
					<div class="left">
						<p>적립금</p>
					</div>
					<div class="right price">
						<p class="gray_color"><%=FormatNumber(p_point, 0)%><span>p</span></p>
						<!--<font class="gray_color">(1% 적립)</font> -->
					</div>
				</div>
			<%End If%>
			<%
			'쿠폰 다운로드
			If mc_coupon=True Then
				Set RsCp = Server.Createobject("ADODB.Recordset")
				Sql = "SELECT * FROM tbl_coupon WHERE c_dl_type='dir' AND c_enddate>getdate()"
				RsCp.Open Sql, Dbcon, 1
				If RsCp.EOF=False Then%>
					<div class="box">
						<div class="left">
							<p>할인쿠폰</p>
						</div>
						<div class="right">
						<%
						Do Until RsCp.EOF
							idx = RsCp("idx")
							c_name=RsCp("c_name")
							c_enddate=RsCp("c_enddate")
							c_dc_type=RsCp("c_dc_type")
							c_dc_amount=RsCp("c_dc_amount")
							%>
							<p><a href="/site/shop/include/coupon_ok.asp?idx=<%=idx%>"><%=c_name%></a></p>
							<%
							RsCp.MoveNext
						Loop%>
						</div>
					</div>
				<%
				End If
				RsCp.Close
				Set RsCp = Nothing
			End If

			'옵션
			o_use = False
			For o_num=1 To 4
				If p_option(o_num-1)<>"" Then%>
					<div class="box">
						<div class="left">
							<p class="pt9"><%=p_option(o_num-1)%></p>
						</div>
						<div class="right">
							<select name="p_option<%=o_num%>" id="p_option<%=o_num%>" class="AXSelect" onchange="SetOption()">
								<option value="">--선택--</option>
								<%
								If p_option_val(o_num-1)<>"" Then
									arr_option = Split(p_option_val(o_num-1), ", ")
									For Each itm In arr_option
									%><option value="<%=itm%>"><%
										If InStr(itm, "§-")=0 Then
											Response.Write Replace(itm, "§", " : +") & "원"
										Else
											Response.Write Replace(itm, "§", " : ") & "원"
										End If
										%></option>
									<%
									Next
								End If
								%>
							</select>
						</div>
					</div>
					<%
					o_use = True
				End If
			Next
			%>
		</li>

		<script type="text/javascript">
		//옵션 선택
		function SetOption(){
			var v1 = $("#p_option1 option:selected").val();
			var v2 = $("#p_option2 option:selected").val();
			var v3 = $("#p_option3 option:selected").val();
			var v4 = $("#p_option4 option:selected").val();

			if(v1!="" && v2!="" && v3!="" && v4!=""){
				$.ajax({
					type: "POST", url : "/site/shop/include/inc_view_shop_option.asp", data: "p_price=<%=p_price%>&v1="+encodeURIComponent(v1)+"&v2="+encodeURIComponent(v2)+"&v3="+encodeURIComponent(v3)+"&v4="+encodeURIComponent(v4), success: function(resdata){
						$("#opt_sel").append(resdata);
						TotalAmount();
					}
				});
				$("#p_option1 option:eq(0)").prop("selected", true);
				$("#p_option2 option:eq(0)").prop("selected", true);
				$("#p_option3 option:eq(0)").prop("selected", true);
				$("#p_option4 option:eq(0)").prop("selected", true);
			}
		}
		</script>

	<%
	If p_price<>"" Then
		'옵션이 없는 경우
		If CDbl(p_price)>0 And o_use=False Then%>		
		<input type="hidden" name="p_amount" value="<%=p_price%>" required />
		<li style="border-bottom: 0px">
			<div class="box">
				<div class="left">
					<p class="pt8">수량</p>
				</div>
				<div class="right">
					<label for="" class="quantity_box">
						<button type="button" class="minus"><img src="/site/images/shop/view_quantity_minus.png" alt="이미지" /></button>
						<input type="text" name="p_qty" class="W40" value="1" maxlength="2" numberOnly min="1" max="99" />
						<button type="button" class="plus"><img src="/site/images/shop/view_quantity_plus.png" alt="이미지" /></button>
					</label>
				</div>
			</div>
		</li>
		<script type="text/javascript">
		function DoSubmit(){
			document.shopform.submit();
		}
		</script>

		<%
		'선택된 옵션이 존재하는 경우
		ElseIf CDbl(p_price)>0 And o_use=True Then%>
		<li id="opt_sel" style="border-bottom: 0px"></li>
		<script type="text/javascript">
		function DoSubmit(){
			var p_option_cnt = $("input[name=p_option_tmp]").length;
			if (p_option_cnt==0){
				alert('선택된 옵션이 없습니다.');
				return;
			}
			var p_option = "";
			for (i=0; i<p_option_cnt; i++){
				if (i==0){
					p_option = document.getElementsByName("p_option_tmp")[i].value;
				}else{
					p_option += "§" + document.getElementsByName("p_option_tmp")[i].value;
				}
			}
			$("input[name=p_option]").val(p_option);
			document.shopform.submit();
		}
		</script>

		<%End If%>
	<%End If%>
	</ul>

	<!--div class="total">
		<span>총 구매금액</span>
		<p>0<font>원</font></p>
	</div-->

	<%If p_price<>"0" Then%>
		<ul class="btn_box">
			<li><a href="#;" class="purchase_btn" onclick="RunDirectOrder()"><img src="/site/images/shop/info_btn_icon01.png" alt="이미지" />바로 구매하기</a></li>
			<li><a href="#;" class="basket_btn" onclick="RunCart()"><img src="/site/images/shop/info_btn_icon02.png" alt="이미지" />장바구니 담기</a></li>
			<%
			Set RsWish = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_mall_wish WHERE m_id='" & W_ID & "' AND p_idx='" & idx & "' "
			RsWish.Open Sql, Dbcon, 1
			If RsWish.EOF=False Then
				wish_idx = RsWish("idx")			
			End If
			RsWish.Close
			Set RsWish = Nothing
			%>
			<li><a href="/site/shop/include/wish_ok.asp?p_idx=<%=idx%>" class="attention_btn <%If wish_idx<>"" Then Response.Write "on"%>"><img src="/site/images/shop/info_btn_icon03.png" alt="이미지" />관심상품</a></li>
		</ul>
	<%End If%>

</form>

<script type="text/javascript">
function SetDel(obj) {
    var tr = $(obj).parent().parent();
    tr.remove();
}

function RunCart(){
	document.shopform.action="<%=mc_shop_url%>?mode=cart_reg"
	DoSubmit();
}

function RunDirectOrder(){
	document.shopform.action="<%=mc_shop_url%>?mode=order_dir"
	DoSubmit();
}

function SetQty(obj){
	var p_qty = obj.value;
	var opt_idx = $("input[name=p_qty]").index(obj);
	var p_amount = document.getElementsByName("p_amount")[opt_idx].value;

	var p_total = p_qty*p_amount;
	p_total = p_total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

	document.getElementsByName("td_price")[opt_idx].innerHTML = p_total + "원";
}
</script>


<%
'네이버페이 연동
If sc_naverpay=True Then
	If sc_mobile=True Then%>
	<script type="text/javascript" src="http://pay.naver.com/customer/js/mobile/naverPayButton.js" charset="UTF-8"></script>
	<%Else%>
	<script type="text/javascript" src="http://pay.naver.com/customer/js/naverPayButton.js" charset="UTF-8"></script>
	<%End If%>
	<script type="text/javascript" >
	function buy_nc(){
		<%If o_use=True Then%>
			var p_option_cnt = $("input[name=p_option_tmp]").length;
			if (p_option_cnt==0){
				alert('선택된 옵션이 없습니다.');
				return false;
			}
			var p_option = "";
			for (i=0; i<p_option_cnt; i++){
				if (i==0){
					p_option = document.getElementsByName("p_option_tmp")[i].value;
				}else{
					p_option += "§" + document.getElementsByName("p_option_tmp")[i].value;
				}
			}
			$("input[name=p_option]").val(p_option);
		<%End If%>

		$.ajax({
			url : "/site/shop/include/np_order.asp",
			type : "POST",
			data : jQuery("#shopform").serialize(),
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

	function wishlist_nc() {
		// 네이버페이로 찜 정보를 등록하는 가맹점 페이지 팝업 창 생성.
		// 해당 페이지에서 찜 정보 등록 후 네이버페이 찜 페이지로 이동.
				<%If sc_mobile=True Then%>
					location.href = "/site/shop/include/np_wish.asp?idx=<%=idx%>&s_mob=1"
				<%Else%>
					window.open("/site/shop/include/np_wish.asp?idx=<%=idx%>&s_mob=0","","scrollbars=yes,width=400,height=267");
				<%End If%>
		return false;
	}

	naver.NaverPayButton.apply({
		BUTTON_KEY: "CCD330FA-C8FE-45B4-88C6-0FEF9FD09132", // 네이버페이에서 제공받은 버튼 인증 키 입력
		<%If sc_mobile=True Then%>
		TYPE: "MA", // 버튼 모음 종류 설정
		<%Else%>
		TYPE: "A", // 버튼 모음 종류 설정
		<%End If%>
		COLOR: 1, // 버튼 모음의 색 설정 2. 네이버페이 버튼 네이버페이 가맹점 연동 가이드  21
		COUNT: 2, // 버튼 개수 설정. 구매하기 버튼만 있으면(장바구니 페이지) 1, 찜하기 버튼도있으면(상품 상세 페이지) 2를 입력.
		ENABLE: "Y", // 품절 등의 이유로 버튼 모음을 비활성화할 때에는 "N" 입력
		BUY_BUTTON_HANDLER: buy_nc, 
		WISHLIST_BUTTON_HANDLER:wishlist_nc, // 찜하기 버튼 이벤트 Handler 함수 등록          
		"":""
	 });
	</script>
<%End If%>