<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>쇼핑몰 기본 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>쇼핑몰 기본 설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

	<form name="regform" action="mall-info-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>쇼핑몰 기본 설정</h4>
		<table>
			<colgroup>
				<col width="180px" />
				<col width="" />
			</colgroup>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">쇼핑몰 기능 사용</th>
				<td class="bdt">
					<input type="checkbox" name="mc_use" value="1" <%If mc_use=True Then Response.Write "checked"%>> 쇼핑몰 기능을 사용하는 경우 체크 하세요.<br />
					<input type="text" name="mc_shop_url" value="<%=mc_shop_url%>" class="AXInput" style="width:90%" placeholder="쇼핑몰 프로그램 삽입 페이지 경로 (예: /sub/shop/shop.asp)" <%If mc_shop_url<>"" Then Response.Write "readonly"%> />
				</td>
			</tr>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">구매 가능 회원등급</th>
				<td class="bdt">
					<select name="mc_order_lev" id="mc_order_lev" class="AXSelect">
						<option value="100" <%If mc_order_lev="100" Then Response.Write "selected"%>>비회원</option>
						<%For mc=99 To 1 Step -1%>
							<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
							<%If mc_order_lev=mc Then Response.Write "selected"%>><%=mc%></option>
						<%Next%>
						<option value="0" <%If mc_order_lev="0" Then Response.Write "selected"%>>사용안함</option>
					</select>
				</td>
			</tr>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">포인트 사용</th>
				<td class="bdt">
					<label><input type="checkbox" name="mc_point_use" value="1" <%If mc_point_use=True Then Response.Write "checked"%>> 포인트 적립 및 결제 기능을 사용하는 경우 체크 하세요.</label>
				</td>
			</tr>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">회원가입시 포인트 적립</th>
				<td class="bdt"><input type="text" name="mc_point_join" value="<%=mc_point_join%>" class="AXInput W100">p 적립</td>
			</tr>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">포인트 일괄 적용</th>
				<td class="bdt">판매가의 <input type="text" name="mc_point_set" class="AXInput W50">% <input type="button" value=" 일괄적용 " class="AXButton Blue" onclick="SetPoint()"><br />
				<span class="txt_small">등록된 모든 상품의 포인트를 일괄적으로 조정합니다.</span><br /></td>
			</tr>
			<tr <%If W_LEVEL<>"1" Then Response.Write "style=""display:none"""%>>
				<th class="title bdr bdt">할인쿠폰 사용</th>
				<td class="bdt">
					<label><input type="checkbox" name="mc_coupon" value="1" <%If mc_coupon=True Then Response.Write "checked"%>> 할인쿠폰 발급 및 다운로드 기능을 사용하는 경우 체크 하세요.</label>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">무통장 입금 사용</th>
				<td class="bdt">
					<label><input type="checkbox" name="mc_bank_flag" value="1" <%If mc_bank_flag=True Then Response.Write "checked"%>> 주문시 무통장 입금을 사용하는 경우 체크 하세요.</label>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">무통장 입금 계좌정보</th>
				<td class="bdt"><input type="text" name="mc_bank_no" value="<%=mc_bank_no%>" class="AXInput" style="width:90%"><br />
				<span class="txt_small">e.g) 기업은행 137-000000-00-000 (주)웹모아</span><br />
				<span class="txt_small">계좌가 2개 이상인 경우 구분은 '|' 기호입니다.</span><br />
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">배송업체</th>
				<td class="bdt">
				<select name="mc_deli" class="AXSelect">
					<option value="">없음</option>
					<option value="자체배송" <%If mc_deli="자체배송" Then Response.Write "selected"%>>자체배송</option>
					<option value="경동택배" <%If mc_deli="경동택배" Then Response.Write "selected"%>>경동택배</option>
					<option value="대신택배" <%If mc_deli="대신택배" Then Response.Write "selected"%>>대신택배</option>
					<option value="동부택배" <%If mc_deli="동부택배" Then Response.Write "selected"%>>동부택배</option>
					<option value="로젠택배" <%If mc_deli="로젠택배" Then Response.Write "selected"%>>로젠택배</option>
					<option value="우체국" <%If mc_deli="우체국" Then Response.Write "selected"%>>우체국</option>
					<option value="이노지스택배" <%If mc_deli="이노지스택배" Then Response.Write "selected"%>>이노지스택배</option>
					<option value="한진택배" <%If mc_deli="한진택배" Then Response.Write "selected"%>>한진택배</option>
					<option value="롯데택배" <%If mc_deli="롯데택배" Then Response.Write "selected"%>>롯데택배</option>
					<option value="CJ대한통운" <%If mc_deli="CJ대한통운" Then Response.Write "selected"%>>CJ대한통운</option>
					<option value="CVSnet편의점택배" <%If mc_deli="CVSnet편의점택배" Then Response.Write "selected"%>>CVSnet편의점택배</option>
					<option value="KG옐로우캡택배" <%If mc_deli="KG옐로우캡택배" Then Response.Write "selected"%>>KG옐로우캡택배</option>
					<option value="KGB택배" <%If mc_deli="KGB택배" Then Response.Write "selected"%>>KGB택배</option>
					<option value="KG로지스" <%If mc_deli="KG로지스" Then Response.Write "selected"%>>KG로지스</option>
					<option value="건영택배" <%If mc_deli="건영택배" Then Response.Write "selected"%>>건영택배</option>
					<option value="호남택배" <%If mc_deli="호남택배" Then Response.Write "selected"%>>호남택배</option>
                </select>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">배송비 무료</th>
				<td class="bdt"><input type="text" name="mc_deli_free" value="<%=mc_deli_free%>" class="AXInput W100" numberOnly />원 이상 배송비 무료</td>
			</tr>
			<tr>
				<th class="title bdr bdt">배송비</th>
				<td class="bdt"><input type="text" name="mc_deli_charge" value="<%=mc_deli_charge%>" class="AXInput W100" numberOnly />원</td>
			</tr>
			<tr>
				<th class="title bdr bdt">배송정보</th>
				<td class="bdt"><textarea cols="" rows="" name="mc_deli_content" id="mc_deli_content" style="width:100%; height:250px"><%=mc_deli_content%></textarea></td>
			</tr>
			<tr>
				<th class="title bdr bdt">교환/반품</th>
				<td class="bdt"><textarea cols="" rows="" name="mc_chng_content" id="mc_chng_content" style="width:100%; height:250px"><%=mc_chng_content%></textarea></td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
			<span><input type="button" value="   취소   " class="AXButton"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>쇼핑몰 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%q="shop"%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 컨텐츠 표시 영역에 아래의 코드 삽입<br />
			&lt;!--#include virtual="/site/shop/shop.asp" --&gt;<br /><br />

			3) 해당 페이지의 mode 파라메터 값으로 구분하여 사용<br />
			cart : 장바구니, order_login : 주문 로그인, order : 주문, pay : 결제, order_end : 주문완료<br />
			order_info : 주문내역조회, order_info_list : 주문내역 리스트, order_info_view : 주문내역상세, my_coupon : 내 쿠폰
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>


</div>
<!-- //contents -->


<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(obj){
	oEditors.getById["mc_deli_content"].exec("UPDATE_CONTENTS_FIELD", []);
	oEditors.getById["mc_chng_content"].exec("UPDATE_CONTENTS_FIELD", []);
}

function SetPoint(){
	var obj = document.regform;
	if(obj.mc_point_set.value==""){ alert('일괄적용 할 수치를 입력하세요'); return; }
	obj.action="mall-info-ok.asp?mode=setpoint";
	obj.submit();

}

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "mc_deli_content",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "mc_chng_content",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>


<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->