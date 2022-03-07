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


<script type="application/x-javascript">
    
    addEventListener("load", function()
    {
        setTimeout(updateLayout, 0);
    }, false);
 
    var currentWidth = 0;
    
    function updateLayout()
    {
        if (window.innerWidth != currentWidth)
        {
            currentWidth = window.innerWidth;
 
            var orient = currentWidth == 320 ? "profile" : "landscape";
            document.body.setAttribute("orient", orient);
            setTimeout(function()
            {
                window.scrollTo(0, 1);
            }, 100);            
        }
    }
 
    setInterval(updateLayout, 400);
    
</script>

<script language=javascript>
window.name = "BTPG_CLIENT";

var width = 330;
var height = 480;
var xpos = (screen.width - width) / 2;
var ypos = (screen.width - height) / 2;
var position = "top=" + ypos + ",left=" + xpos;
var features = position + ", width=320, height=440";


function on_web()
{
	var order_form = document.payform;
	var paymethod = order_form.paymethod.value;
	var wallet = window.open("", "BTPG_WALLET", features);
	<!--
	if (wallet == null) 
	{
		if ((webbrowser.indexOf("Windows NT 5.1")!=-1) && (webbrowser.indexOf("SV1")!=-1)) 
		{    // Windows XP Service Pack 2
			alert("팝업이 차단되었습니다. 브라우저의 상단 노란색 [알림 표시줄]을 클릭하신 후 팝업창 허용을 선택하여 주세요.");
		} 
		else 
		{
			alert("팝업이 차단되었습니다.");
		}
		return false;
	}
	-->
	
	order_form.target = "BTPG_WALLET";
	order_form.action = "https://mobile.inicis.com/smart/" + paymethod + "/";
	order_form.submit();
}

function onSubmit()
{
	var order_form = document.payform;
	var inipaymobile_type = order_form.inipaymobile_type.value;
	if( inipaymobile_type == "web" )
		return on_web();
}

</script>


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

			<input type="hidden" name="paymethod" value="" >
			<input type="hidden" name="inipaymobile_type" value="web" >

			<input type="hidden" name="P_OID" value="<%=o_code%>" >
			<input type="hidden" name="P_GOODS" value="<%=ct_p_name%>" >
			<input type="hidden" name="P_AMT" value="<%=o_total%>" >
			<input type="hidden" name="P_UNAME" value="<%=o_name%>" >
			<input type="hidden" name="P_MNAME" value="VVINT" >
			<input type="hidden" name="P_MOBILE" value="<%=o_tel%>" >
			<input type="hidden" name="P_EMAIL" value="<%=o_email%>" >

	<!-- 		<input type="hidden" name="P_MID" value="INIpayTest">  -->
			<input type="hidden" name="P_MID" value="Webmoavvin">
			<input type="hidden" name="P_NEXT_URL" value="http://<%=Request.ServerVariables("SERVER_NAME")%>/site/shop/include/pay_inicis_m_ok.asp?o_code=<%=o_code%>">
			<input type="hidden" name="P_HPP_METHOD" value="1">
			<input type="hidden" name="P_CHARSET" value="utf8" />
			<input type="hidden" name="P_RESERVED" value="twotrs_isp=Y&block_isp=Y&twotrs_isp_noti=N" />

			<input type="hidden" name="P_NOTI" value="<%=o_pay_point%>" >

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
		frm.acceptCharset = "euc-kr";
		frm.paymethod.value="wcard";
		onSubmit();

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