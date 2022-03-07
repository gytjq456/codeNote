<%
o_dir = Request("o_dir")

If CInt(mc_order_lev)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('로그인이 필요하거나 구매 가능한 회원등급이 아닙니다.'); history.back();</script>"
	Response.End
End If
%>

<script type="text/javascript">
//주문자정보 동일 체크
function SetSend(){
	if($("input[name=eq_o]").is(":checked")){
		$("input[name=s_name]").val($("input[name=o_name]").val());
		$("input[name=s_tel]").val($("input[name=o_tel]").val());
		$("input[name=s_zip]").val($("input[name=o_zip]").val());
		$("input[name=s_addr1]").val($("input[name=o_addr1]").val());
		$("input[name=s_addr2]").val($("input[name=o_addr2]").val());
	}else{
		$("input[name=s_name]").val("");
		$("input[name=s_tel]").val("");
		$("input[name=s_zip]").val("");
		$("input[name=s_addr1]").val("");
		$("input[name=s_addr2]").val("");
	}
}
</script>

<form name="orderform" method="post" action="?mode=order_ok&o_dir=<%=o_dir%>">

<div class="cart_tb">
	<table>
		 <colgroup>
			<col class="img_w" width="11.1%">
			<col class="info_w" width="*">
			<col class="price_w" width="18%">
			<col class="quantity_w" width="14.3%">
			<col class="total_w" width="14.3%">
		 </colgroup>
		 <thead>
			<tr>
				<th colspan="2">상품명 및 옵션정보</th>
				<th>가격</th>
				<th>수량</th>
				<th>합계</th>
			</tr>
		 </thead>
		 <tbody>
		<%
		Set RsCart = Server.Createobject("ADODB.Recordset")
		Sql = "SELECT A.*, B.p_o_price, B.p_image1 FROM tbl_mall_cart A "
		Sql = Sql & " LEFT JOIN tbl_prod B ON A.p_idx=B.idx "
		Sql = Sql & " WHERE A.o_end='0' "
		If o_dir<>"" Then Sql = Sql & " AND A.o_dir='1' "
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
						<%If ct_p_option<>"" Then%>
						<div class="option_box">
							<span>옵션 : </span><p><%=ct_p_option%></p>
						</div>
						<%End If%>
					</td>
					<td class="price">
						<%If ct_p_o_price<>"0" Then %>
							<p class="sale"><%=FormatNumber(ct_p_o_price, 0)%><span>원</span></p>
						<%End If%>
						<p><%=FormatNumber(ct_p_amount, 0)%><span>원</span></p>
					</td>
					<td class="quantity">
						<p><%=ct_p_qty%></p>
					</td>
					<td class="price total">
						<p><%=FormatNumber(ct_p_tamount, 0)%><span>원</span></p>
					</td>
				</tr>
				<%
				ct_all_amount = ct_all_amount+ct_p_tamount
				RsCart.Movenext
			Loop
		End If
		RsCart.Close
		Set RsCart = Nothing

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
			<tr>
				<td colspan="5" class="price_wrap">
					<div class="total_price">
						<div class="type">
							<p>상품금액</p>
							<span><%=FormatNumber(ct_all_amount, 0)%><font>원</font></span>
						</div>
						<div class="type type01">
							<p>+</p>
						</div>
						<div class="type">
							<p>배송비</p>
							<span><%=FormatNumber(ct_deli_charge, 0)%><font>원</font></span>
						</div>
						<div class="type type01">
							<p>=</p>
						</div>
						<div class="type type02">
							<p>전체 합계</p>
							<span><%=FormatNumber(fn_amount, 0)%><font>원</font></span>
						</div>
					</div>
				</td>
			</tr>
		<%
		Else
			Response.Write "<script>alert('잘못된 접근입니다.');history.back();</script>"
			Response.End
		End If
		%>
		 </tbody>
	</table>
</div>

<%
'회원 정보 취득
If W_ID<>"" Then
	Set RsM = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member WHERE m_id='" & W_ID & "' "
	RsM.Open Sql, Dbcon, 1
	If RsM.EOF=False Then
		o_name = RsM("m_name")
		o_tel = RsM("m_cell1") & "-" & RsM("m_cell2") & "-" & RsM("m_cell3")
		If o_tel="--" Then o_tel = RsM("m_tel1") & "-" & RsM("m_tel2") & "-" & RsM("m_tel3")
		o_zip = RsM("m_zip1")
		o_addr1 = RsM("m_addr1")
		o_addr2 = RsM("m_addr2")
		o_email = RsM("m_email")
	End If
	RsM.Close
	Set RsM = Nothing

'비회원
Else
%>
<div class="privacy_box">
	<div class="txt_box">
		<h3>개인정보 수집에 대한 동의</h3>
		<div class="type">
			<p><%=TagText(sc_agree2)%></p>
		</div>
	</div>
	<label class="check f_right">
		<input type="checkbox" name="agree" value="1" required>
		<span class="ico"></span>
		<span class="txt">위의 개인정보 수집에 대해 동의합니다.</span>
	</label>
</div>
<%
End If
%>

<div class="order_wrap">
	<div class="order_type">
		<div class="top_box">
			<p>주문하시는 분</p>
			<span><font>* 항목</font>은 반드시 입력하셔야하는 필수 항목입니다.</span>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="200px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>이름<span>*</span></th>
					<td>
						<label for="" class="w200"><input type="text" name="o_name" size="20" value="<%=o_name%>" class="AXInput" required /></label>
					</td>
				</tr>
				<tr>
					<th>연락처<span>*</span></th>
					<td>
						<label for="" class="w200"><input type="text" name="o_tel" size="20" value="<%=o_tel%>" class="AXInput" required /></label>
					</td>
				</tr>
				<tr>
					<th>이메일<span>*</span></th>
					<td>
						<label for="" class="w300"><input type="text" name="o_email" size="35" value="<%=o_email%>" class="AXInput" required /></label>
					</td>
				</tr>
				<tr>
					<th>주문자 주소<span>*</span></th>
					<td>
						<div class="address_wrap">
							<div class="box">
								<label for="" class="w200"><input type="text" name="o_zip" id="o_zip" value="<%=o_zip%>" class="AXInput W60" maxlength="5" placeholder="우편번호" readonly required /></label>
								<button type="button" onclick="PostSearch('o');">우편번호찾기</button>
							</div>
							<div class="box">
								<label for="" class="w_full"><input type="text" name="o_addr1" id="o_addr1" value="<%=o_addr1%>" style="width:90%" placeholder="기본주소" readonly class="AXInput" required /></label>
								<label for="" class="w_full"><input type="text" name="o_addr2" id="o_addr2" value="<%=o_addr2%>" style="width:90%" placeholder="상세주소" class="AXInput" required /></label>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="order_type">
		<div class="top_box">
			<p>받는 사람(배송지) 정보</p>
			<label class="check f_right">
				<input type="checkbox" name="eq_o" value="1" onclick="SetSend()"/>
				<span class="ico"></span>
				<span class="txt">구매자 정보와 동일합니다.</span>
			</label>
		</div>
		<table class="order_tb">
			<colgroup>
				<col width="178px">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th>이름<span>*</span></th>
					<td>
						<label for="" class="w200"><input type="text" name="s_name" size="20" value="" class="AXInput" required /></label>
					</td>
				</tr>
				<tr>
					<th>연락처<span>*</span></th>
					<td>
						<label for="" class="w200"><input type="text" name="s_tel" size="20" value="" class="AXInput" required /></label>
					</td>
				</tr>
				<tr>
					<th>배송지 주소<span>*</span></th>
					<td>
						<div class="address_wrap">
							<div class="box">
								<label for="" class="w200"><input type="text" name="s_zip" id="s_zip" value="" class="AXInput W60" maxlength="5" placeholder="우편번호" readonly required /></label>
								<button type="button" onclick="PostSearch('s');">우편번호찾기</button>
							</div>
							<div class="box">
								<label for="" class="w_full"><input type="text" name="s_addr1" id="s_addr1" value="" style="width:90%" placeholder="기본주소" readonly class="AXInput" required /></label>
								<label for="" class="w_full"><input type="text" name="s_addr2" id="s_addr2" value="" style="width:90%" placeholder="상세주소" class="AXInput" required /></label>
								<!--p>* 도서산간 지역은 배송 불가합니다. 양해 부탁드립니다.</p-->
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>배송 요청사항</th>
					<td>
						<label for="" class="w_full">
							<textarea name="s_text" id="s_text" style="width:90%; height:100px; line-height:1.6;" class="AXInput"></textarea>
						</label>
					</td>
				</tr>
				<tr>
					<th>자동등록방지<span>*</span></th>
					<td>
						<label for="" class="w_full">
							<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" onclick="RefreshImage('imgCaptcha');" style="vertical-align: middle;">
							<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput vmiddle" style="width:118px; ime-mode:disabled" maxlength="5" placeholder="코드를 입력하세요" required autocomplete="off" />
						</label>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<input type="hidden" name="o_amount" value="<%=ct_all_amount%>" />
<input type="hidden" name="o_deli_amount" value="<%=ct_deli_charge%>" />

<div class="cart_btn">
	<button class="type03" type="submit"><img src="/site/images/shop/finalpayment_icon.png" alt="이미지" />주문하기</button>
</div>

</form>

</article>

<div id="addr_pop_wrap" style="display:none;position:fixed;overflow:hidden;z-index:1000;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<%If Request.ServerVariables("SERVER_PORT")=443 Then%>
<!-- https --><script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<%Else%>
<!-- http --><script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%End If%>

<script>
// 우편번호 찾기 찾기 화면을 넣을 element
var element_wrap = document.getElementById('addr_pop_wrap');

function foldDaumPostcode() {
	// iframe을 넣은 element를 안보이게 한다.
	element_wrap.style.display = 'none';
}

function PostSearch(md) {
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			if(data.userSelectedType === 'R'){
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ')';
				}
			}

			if (md=="o"){
				document.getElementById('o_zip').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('o_addr1').value = addr;
				document.getElementById('o_addr2').focus();
			}else if (md=="s"){
				document.getElementById('s_zip').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('s_addr1').value = addr;
				document.getElementById('s_addr2').focus();
			}

			element_wrap.style.display = 'none';
			document.body.scrollTop = currentScroll;
		},
		width : '100%',
		height : '100%'
	}).embed(element_wrap);

	element_wrap.style.display = 'block';

	initLayerPosition();
}

function initLayerPosition(){
	var width = 300;
	var height = 400;
	var borderWidth = 5;

	element_wrap.style.width = width + 'px';
	element_wrap.style.height = height + 'px';
	element_wrap.style.border = borderWidth + 'px solid';
	element_wrap.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	element_wrap.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}
</script>