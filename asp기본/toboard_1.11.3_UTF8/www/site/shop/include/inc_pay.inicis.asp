<%
If CInt(mc_order_lev)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('로그인이 필요하거나 구매 가능한 회원등급이 아닙니다.'); history.back();</script>"
	Response.End
End If

o_code = Request("o_code")
o_pay_point = CDbl(Request("o_pay_point"))
If o_pay_point="" Then o_pay_point=0

o_coupon_amount = CDbl(Request("o_coupon_amount"))
If o_coupon_amount="" Then o_coupon_amount=0

'주문 정보 취득
Set RsO = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_order "
Sql = Sql & " WHERE o_code='" & o_code & "' "
RsO.Open Sql, Dbcon, 1
If RsO.EOF=False Then
	idx = RsO("idx")
	o_name = RsO("o_name")
	o_tel = RsO("o_tel")
	o_email = RsO("o_email")
	o_amount = RsO("o_amount")
	o_deli_amount = RsO("o_deli_amount")
	o_total = Fix(o_amount+o_deli_amount-o_pay_point)
Else
	Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
	Response.End
End If
RsO.Close

'대표상품 취득
Set RsO = Server.Createobject("ADODB.Recordset")
Sql = "SELECT TOP 1 * FROM tbl_mall_cart "
Sql = Sql & " WHERE idx!='' AND o_code='' "
If W_ID<>"" Then
	Sql = Sql & " AND m_id='" & W_ID & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
RsO.Open Sql, Dbcon, 1
If RsO.EOF=False Then
	ct_p_name = RsO("p_name")
End If
RsO.Close

'회원 정보 취득
If W_ID<>"" Then
	Sql = "SELECT * FROM tbl_member WHERE m_id='" & W_ID & "' "
	RsO.Open Sql, Dbcon, 1
	If RsO.EOF=False Then
		o_name = RsO("m_name")
		o_tel = RsO("m_tel1") & "-" & RsO("m_tel2") & "-" & RsO("m_tel3")
		o_zip = RsO("m_zip1")
		o_addr1 = RsO("m_addr1")
		o_addr2 = RsO("m_addr2")
		o_email = RsO("m_email")
		m_point = RsO("m_point")
	End If
	RsO.Close
End If
Set RsO = Nothing

'쿠폰 적용
s_cd_code = Request("cd_code")
s_cd_dc_amount = Request("cd_dc_amount")
s_cd_dc_type = Request("cd_dc_type")
If s_cd_code<>"" Then
	If s_cd_dc_type="%" Then
		o_coupon_amount = Fix(o_amount*(s_cd_dc_amount/100))
	ElseIf s_cd_dc_type="원" Then
		o_coupon_amount = s_cd_dc_amount
	End If
End If

'최종 결제 금액	(= 주문 총액 + 배송비 - 사용포인트 - 쿠폰)
o_total = Fix(o_amount+o_deli_amount-o_pay_point-o_coupon_amount)
%>


<!--#include virtual="/site/shop/inipay/include/signature.asp"-->
<!--#include virtual="/site/shop/inipay/include/function.asp"-->
<%

'		*** 위변조 방지체크를 signature 생성 ***
'		* timestamp는 반드시 signature생성에 사용한 timestamp 값을 timestamp input에 그대로 사용하여야함


'############################################
' 1.전문 필드 값 설정(***가맹점 개발수정***)
'############################################

' 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
	maid				= "INIpayTest"										' 가맹점 ID(가맹점 수정후 고정)					
	
'인증
	signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"				' 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
	
	'timestamp			= time_stamp()
	correct 			= "09"								                ' 표준시와의 차이를 2자리 숫자로 입력 (예: 대한민국은 표준시와 9시간 차이이므로 09) 
	timestamp			= time_stamp(correct) 	
	oid					= o_code								' 가맹점 주문번호(가맹점에서 직접 설정)	
	price				= o_total										' 상품가격(특수기호 제외, 가맹점에서 직접 설정)
	cardQuotaBase		= "2:3:4:5:6:11:12:24:36"							' 가맹점에서 사용할 할부 개월수 설정

	'###############################################
	' 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
	'###############################################
	mKey = MakeSignature(signKey)
	
	'###############################################
	' 2.signature 생성
	'###############################################

	signParam = "oid="&oid
	signParam = signParam&"&price="&price
	signParam = signParam&"&timestamp="&timestamp

	' signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
	signature = MakeSignature(signParam)
		
	
	' 페이지 URL에서 고정된 부분을 적는다. 
	' Ex) returnURL이 http://test.inicis.com/INIpayStdSample/INIStdPayReturn.jsp 라면
	' http://test.inicis.com/INIpayStdSample 까지만 기입한다.
	
	siteDomain = "http://" & Request.ServerVariables("SERVER_NAME") '가맹점 도메인 입력
	
%>

<!-- 이니시스 표준결제 js -->
<!--
연동시 유의 사항!!
1) 테스트 URL(stgstdpay.inicis.com) - 샘플에 제공된 테스트 MID 전용으로 실제 가맹점 MID 사용 시 에러가 발생 할 수 있습니다.
2) 상용 URL(stdpay.inicis.com) - 실제 가맹점 MID 로 테스트 및 오픈 시 해당 URL 변경하여 사용합니다.
3) 가맹점의 URL이 http: 인경우 js URL도 https://stgstdpay.inicis.com/stdjs/INIStdPay.js 로 변경합니다.	
4) 가맹점에서 사용하는 케릭터셋이 EUC-KR 일 경우 charset="UTF-8"로 UTF-8 일 경우 charset="UTF-8"로 설정합니다.
-->	

<!-- 상용 JS(가맹점 MID 변경 시 주석 해제, 테스트용 JS 주석 처리 필수!) -->
<!--<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>-->

<!-- 테스트 JS(샘플에 제공된 테스트 MID 전용) -->
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>


<div class="payment_info">
	<div class="order_left_box">
		<%If mc_coupon=True And W_ID<>"" Then%>
		<!-- 쿠폰 사용 -->
		<div class="order_type">
			<div class="top_box">
				<p>쿠폰 사용</p>
			</div>
			<table class="order_tb">
				<caption>쿠폰 정보</caption>
				<colgroup>
					<col width="178px">
					<col width="*">
				</colgroup>
				<tbody>
				<tr>
					<th>쿠폰 적용 금액</th>
					<td>
						<label for="" class="w200">
							<input type="text" name="o_coupon_amount" class="AXInput W100" readonly value="<%=o_coupon_amount%>" />원 할인
							<input type="button" class="AXButton" value="쿠폰선택" onclick="CouponSelect()">
						</label>
					</td>
				</tr>
				</tbody>
			</table>
			<script type="text/javascript">
			function CouponSelect(){
				open("/site/shop/include/popup_coupon_select.asp?o_code=<%=o_code%>", "cc", "width=400px, height=400px, left=0px, top=0px, scrollbars=yes");
			}
			</script>
		</div>
		<%End If%>

		<%If mc_point_use=True And W_ID<>"" Then%>
			<!-- 포인트 사용 -->
			<div class="order_type">
				<form name="pointform" method="post" action="?mode=pay&o_code=<%=o_code%>" onsubmit="return UsePoint()">
					<input type="hidden" name="s_cd_code" value="<%=s_cd_code%>" />
					<input type="hidden" name="s_cd_dc_amount" value="<%=s_cd_dc_amount%>" />
					<input type="hidden" name="s_cd_dc_type" value="<%=s_cd_dc_type%>" />
					<div class="top_box">
						<p>적립금 사용</p>
					</div>
					<table class="order_tb">
						<caption>적립금 정보</caption>
						<colgroup>
							<col width="178px">
							<col width="*">
						</colgroup>
						<tbody>
						<tr>
							<th>보유 적립금</th>
							<td><%=FormatNumber(m_point, 0)%>p</td>
						</tr>
						<tr>
							<th>사용할 적립금</th>
							<td><input type="text" name="o_pay_point" class="AXInput W100" numberOnly value="<%=o_pay_point%>" required />p
							<input type="submit" class="AXButton" value="사용"></td>
						</tr>
						<%If o_pay_point>0 Then%>
						<tr>
							<th>잔여 적립금</th>
							<td><%=FormatNumber(m_point-o_pay_point, 0)%>p</td>
						</tr>
						<%End If%>
						</tbody>
					</table>
				</form>
			</div>

			<script type="text/javascript">
			function UsePoint(){
				if(document.pointform.o_pay_point.value><%=m_point%>){
					alert('보유 포인트를 초과하여 사용할 수 없습니다.');
					document.pointform.o_pay_point.value=0;
					return false;
				}
				if(document.pointform.o_pay_point.value><%=o_amount+o_deli_amount-o_coupon_amount%>){
					alert('주문 금액을 초과하여 사용할 수 없습니다.');
					document.pointform.o_pay_point.value=0;
					return false;
				}
			}		
			</script>
		<%End If%>


		<form name="payform" method="post" action="?mode=pay_bank_ok" class="mt10">
			<input type="hidden" name="o_coupon_code" value="<%=s_cd_code%>" />
			<input type="hidden" name="o_coupon_amount" value="<%=o_coupon_amount%>" />
			<input type="hidden" name="o_pay_point" value="<%=o_pay_point%>" />

			<input type="hidden" name="version" value="1.0" >
			<input type="hidden" name="mid" value="<%=maid%>" >
			<input type="hidden" name="goodname" value="<%=ct_p_name%>" >
			<input type="hidden" name="oid" value="<%=o_code%>" >
			<input type="hidden" name="price" value="<%=o_total%>" >
			<input type="hidden" name="currency" value="WON" >
			<input type="hidden" name="buyername" value="<%=o_name%>" >
			<input type="hidden" name="buyertel" value="<%=o_tel%>" >
			<input type="hidden" name="buyeremail" value="<%=o_email%>" >
			<input type="hidden" type="hidden" name="timestamp" value="<%=timestamp%>" >
			<input type="hidden" type="hidden" name="signature" value="<%=signature%>" >
			<input type="hidden" name="returnUrl" value="<%=siteDomain%>/site/shop/include/pay_inicis_ok.asp?o_code=<%=o_code%>" >
			<input type="hidden"  name="mKey" value="<%=mKey%>" >

			<input type="hidden" name="gopaymethod" value="Card" >
			<input type="hidden" name="offerPeriod" value="" >
			<input type="hidden" name="acceptmethod" value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000" >

			<input type="hidden" name="languageView" value="" >
			<input type="hidden" name="charset" value="UTF-8" >
			<input type="hidden" name="payViewType" value="" >
			<input type="hidden" name="closeUrl" value="<%=siteDomain%>/site/shop/inipay/close.asp" >
			<input type="hidden" name="popupUrl" value="<%=siteDomain%>/site/shop/inipay/popup.asp" >

			<input type="hidden" name="quotabase" value="<%=cardQuotaBase%>" >
			<input type="hidden" name="nointerest" value="" >
			<input type="hidden" name="ini_only_cardcode" value="" >
			<input type="hidden" name="vbankRegNo" value="" >
			<input type="hidden" name="merchantData" value="<%=o_pay_point%>" >

			<%If o_total=0 Then%>
				<input type="hidden" name="o_pay_method" value="포인트결제" />
			<%Else%>
				<div class="order_type">
					<div class="top_box">
						<p>결제정보</p>
					</div>
					<table class="order_tb">
						<colgroup>
							<col width="178px">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>결제방법<span>*</span></th>
								<td>
									<select name="o_pay_method" id="o_pay_method" class="AXSelect" required onchange="SetBank(this.value)">
										<option value="">--- 선택 ---</option>
										<%If mc_bank_flag=True Then%><option value="무통장입금">무통장입금</option><%End If%>
										<option value="신용카드">신용카드</option>
									</select>
								</td>
							</tr>
							<tr class="tr-bank" style="display:none">
								<th>무통장 입금 계좌<span>*</span></th>
								<td>
									<select name="o_pay_bank" id="o_pay_bank" class="AXSelect">
										<option value="">--- 선택 ---</option>
										<%
										ar_mc_bank_no = Split(mc_bank_no, "|")
										For Each itm In ar_mc_bank_no
										%>
										<option value="<%=itm%>"><%=itm%></option>
										<%
										Next
										%>
									</select>
								</td>
							</tr>
							<tr class="tr-bank" style="display:none">
								<th>입금자 명<span>*</span></th>
								<td><input type="text" name="o_pay_bank_name" size="20" value="" class="AXInput" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				<script type="text/javascript">
				function SetBank(val){
					$('.tr-bank').css("display", "none");
					if(val=='무통장입금'){
						$('.tr-bank').css("display", "");
					}
				}
				</script>
			<%End If%>
		</div>
		<div class="order_type payment_type">
			<div class="top_box">
				<p>최종 결제정보</p>
			</div>
			<div class="payment">
				<div class="type type01">
					<div class="box">
						<span>총 상품금액</span>
						<p><%=FormatNumber(o_amount, 0)%><font>원</font></p>
					</div>
					<%If o_coupon_amount>0 Then%>
					<div class="box">
						<span>쿠폰 사용</span>
						<p>(-)<%=FormatNumber(o_coupon_amount, 0)%><font>원</font></p>
					</div>
					<%End If%>
					<%If o_pay_point>0 Then%>
					<div class="box">
						<span>적립금 사용</span>
						<p>(-)<%=FormatNumber(o_pay_point, 0)%><font>원</font></p>
					</div>
					<%End If%>
				</div>
				<div class="type type02">
					<span>배송비(선불)</span>
					<p>(+)<%=FormatNumber(o_deli_amount, 0)%><font>원</font></p>
				</div>
				<div class="type type03">
					<span>최종 결제금액</span>
					<p><%=FormatNumber(o_total, 0)%><font>원</font></p>
				</div>
			</div>

			<div class="cart_btn">
				<!--a href="cart.asp" class="type02">
					<img src="/site/images/shop/cancel_icon.png" alt="이미지" />
					주문 취소하기
				</a-->
				<a href="#;" class="type03" onclick="DoPay()">
					<img src="/site/images/shop/finalpayment_icon.png" alt="이미지" />
					최종 결제하기
				</a>			
			</div>

		</form>

		</div>
	</div>


<script type="text/javascript">
function DoPay(){

	var frm = document.payform;
	if(frm.o_pay_method.value==""){ alert('결제 수단을 선택하세요.'); frm.o_pay_method.focus(); return; }

	//무통장입금
	if(frm.o_pay_method.value=="무통장입금"){
		frm.action="?mode=pay_bank_ok&o_code=<%=o_code%>";
		if(frm.o_pay_bank.value==""){ alert('무통장 입금 계좌를 선택하세요.'); frm.o_pay_bank.focus(); return; }
		if(frm.o_pay_bank_name.value==""){ alert('입금자 명을 입력하세요.'); frm.o_pay_bank_name.focus(); return; }
		frm.submit();

	}else if(frm.o_pay_method.value=="신용카드"){
		document.cookie = 'same-site-cookie=foo; SameSite=Lax';
		document.cookie = 'cross-site-cookie=bar; SameSite=None; Secure';
		INIStdPay.pay('payform');
		return;

	}else if(frm.o_pay_method.value=="포인트결제"){
		frm.action="?mode=pay_bank_ok&o_code=<%=o_code%>";
		frm.submit();
	}else{
		alert('결제수단을 선택하세요.');
		return;
	}
}
</script>


<script type="text/javascript">
history.pushState(null, null, location.href);
window.onpopstate = function(event) {
	history.go(1);
};
</script>