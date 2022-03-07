<%
If CInt(mc_order_lev)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('로그인이 필요하거나 구매 가능한 회원등급이 아닙니다.'); history.back();</script>"
	Response.End
End If

o_code = Request("o_code")
o_pay_point = CDbl(Request("o_pay_point"))
If o_pay_point="" Then o_pay_point=0

Set RsO = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_order "
Sql = Sql & " WHERE o_code='" & o_code & "' "
RsO.Open Sql, Dbcon, 1
If RsO.EOF=False Then
	idx = RsO("idx")
	o_tel = RsO("o_tel")
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
%>

<article id="cont" class="">

	<%If mc_point_use=True And W_ID<>"" Then%>

		<form name="pointform" method="post" action="?mode=pay&o_code=<%=o_code%>" onsubmit="return UsePoint()">
			<!-- 포인트 사용 -->
			<h4 class="sub_title">포인트 사용</h3>
			<table class="ntb-tb-view" style="width:100%" cellpadding="0" cellspacing="0">
				<caption>결제 정보</caption>
				<colgroup>
					<col width="25%">
					<col width="">
				</colgroup>
				<thead>
				</thead>
				<tbody>
				<tr>
					<th>보유 포인트</th>
					<td class="left"><%=FormatNumber(m_point, 0)%>p</td>
				</tr>
				<tr>
					<th>사용할 포인트</th>
					<td class="left"><input type="text" name="o_pay_point" class="AXInput W100" numberOnly value="<%=o_pay_point%>" required />p
					<input type="submit" class="AXButton" value="사용"></td>
				</tr>
				<%If o_pay_point>0 Then%>
				<tr>
					<th>잔여 포인트</th>
					<td class="left"><%=FormatNumber(m_point-o_pay_point, 0)%>p</td>
				</tr>
				<%End If%>
				</tbody>
			</table>
		</form>

		<script type="text/javascript">
		function UsePoint(){
			if(document.pointform.o_pay_point.value><%=m_point%>){
				alert('보유 포인트를 초과하여 사용할 수 없습니다.');
				document.pointform.o_pay_point.value=0;
				return false;
			}
			if(document.pointform.o_pay_point.value><%=o_amount+o_deli_amount%>){
				alert('주문 금액을 초과하여 사용할 수 없습니다.');
				document.pointform.o_pay_point.value=0;
				return false;
			}
		}		
		</script>

	<%End If%>


<!--#include virtual="/site/shop/nicepay/lib/SHA256.asp"-->
<%
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <결제요청 파라미터>
' 결제시 Form 에 보내는 결제요청 파라미터입니다.
' 샘플페이지에서는 기본(필수) 파라미터만 예시되어 있으며, 
' 추가 가능한 옵션 파라미터는 연동메뉴얼을 참고하세요.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
merchantKey      = "7sfxwmAfUbtNUTPxTT9RXDTh6hcT+AbiFlc/a6el4SqqIX+fM2rQh+wJiSgjkdRh+AsXauXDvuolGB5GjlhPaA=="  '상점키
merchantID       = "nicepay00m"                             '상점아이디
goodsCnt         = "1"                                      '결제상품개수
goodsName        = ct_p_name                             '결제상품명
'price            = "1000"                                   '결제상품금액	
price            = o_total                                   '결제상품금액	
buyerName        = o_name                                 '구매자명
buyerTel         = o_tel                            '구매자연락처
buyerEmail       = o_email                        '구매자메일주소
moid             = o_code                        '상품주문번호	
encodeParameters = "CardNo,CardExpire,CardPwd"              '암호화대상항목 (변경불가)

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <가상계좌 입금 만료일>
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
tomorrow = (date()+1)
tomorrow = Replace(tomorrow, "-", "")

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <해쉬암호화> (수정하지 마세요)
' SHA256 해쉬암호화는 거래 위변조를 막기위한 방법입니다. 
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
call initCodecs

ediDate = getNow()
hashString = SHA256_Encrypt(ediDate & merchantID & price & merchantKey)

Function getNow()
Dim aDate(2), aTime(2)
    aDate(0) = Year(Now)
    aDate(1) = Right("0" & Month(Now), 2)
    aDate(2) = Right("0" & Day(Now), 2)
    aTime(0) = Right("0" & Hour(Now), 2)
    aTime(1) = Right("0" & Minute(Now), 2)
    aTime(2) = Right("0" & Second(Now), 2)	
    getNow   = aDate(0)&aDate(1)&aDate(2)&aTime(0)&aTime(1)&aTime(2)	   
End Function
%>

<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js" type="text/javascript"></script>
<script type="text/javascript">
//결제창 최초 요청시 실행됩니다.
function nicepayStart(){
    goPay(document.payform);
}

//결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
function nicepaySubmit(){
    document.payform.submit();
}

//결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
function nicepayClose(){
    alert("결제가 취소 되었습니다");
}
</script>


	<form name="payform" method="post" action="?mode=pay_bank_ok">
		<input type="hidden" name="o_pay_point" value="<%=o_pay_point%>" />

		<h4 class="sub_title">결제 금액</h3>
		<table class="ntb-tb mytb_st" style="width:100%" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<th>합계</th>
					<th>배송비</th>
					<%If o_pay_point>0 Then%><th>사용포인트</th><%End If%>
					<th class="r_none">결제금액</th>
				</tr>
				<tr>
					<td class="ico_plus pd25"><span><%=FormatNumber(o_amount, 0)%></span>원</td>
					<%If o_pay_point>0 Then%>
					<td class="ico_minus pd25"><span><%=FormatNumber(o_deli_amount, 0)%></span>원</td>
					<td class="ico_total pd25"><span><%=FormatNumber(o_pay_point, 0)%></span>p</td>
					<%Else%>
					<td class="ico_total pd25"><span><%=FormatNumber(o_deli_amount, 0)%></span>원</td>
					<%End If%>
					<td class="pd25"><span class="cl_pri"><%=FormatNumber(o_total, 0)%></span>원</td>
				</tr>
			</tbody>
		</table>


		<%If o_total=0 Then%>
			<input type="hidden" name="o_pay_method" value="포인트결제" />
		<%Else%>
		<!-- 결제 정보 -->
		<h4 class="sub_title">결제 정보</h3>
		<table class="ntb-tb-view" style="width:100%" cellpadding="0" cellspacing="0">
			<caption>결제 정보</caption>
			<colgroup>
				<col width="25%">
				<col width="">
			</colgroup>
			<thead>
			</thead>
			<tbody>
			<tr>
				<th>결제수단 선택 *</th>
				<td class="left">
					<select name="o_pay_method" id="o_pay_method" class="AXSelect" required onchange="SetBank(this.value)">
						<option value="">--- 선택 ---</option>
						<%If mc_bank_flag=True Then%><option value="무통장입금">무통장입금</option><%End If%>
						<option value="신용카드">신용카드</option>
					</select>
				</td>
			</tr>
			<tr class="tr-bank" style="display:none">
				<th>무통장 입금 계좌 *</th>
				<td class="left">
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
				<th>입금자 명 *</th>
				<td class="left"><input type="text" name="o_pay_bank_name" size="20" value="" class="AXInput" /></td>
			</tr>
			</tbody>
		</table>
		<%End If%>

		<p style="float:right; height:50px; margin-top:20px;">
			<button type="button" class="AXButton Red" onclick="DoPay()">결제하기</button>
		</p>


		<input type="hidden" name="PayMethod" value="CARD">
		<input type="hidden" name="GoodsName" value="<%=goodsName%>">
		<input type="hidden" name="GoodsCnt" value="<%=goodsCnt%>">
		<input type="hidden" name="Amt" value="<%=price%>">
		<input type="hidden" name="BuyerName" value="<%=buyerName%>">
		<input type="hidden" name="BuyerTel" value="<%=buyerTel%>">
		<input type="hidden" name="Moid" value="<%=moid%>">
		<input type="hidden" name="MID" value="<%=merchantID%>">

		<!-- IP --> 
		<input type="hidden" name="UserIP" value="<%=Request.ServerVariables("REMOTE_ADDR")%>">
		<input type="hidden" name="MallIP" value="<%=Request.ServerVariables("LOCAL_ADDR")%>">

		<!-- 옵션 -->
		<input type="hidden" name="VbankExpDate" value="<%=tomorrow%>"/>             <!-- 가상계좌입금만료일 -->
		<input type="hidden" name="BuyerEmail" value="<%=buyerEmail%>"/>             <!-- 구매자 이메일 -->				  
		<input type="hidden" name="GoodsCl" value="0"/>                              <!-- 상품구분(실물(1),컨텐츠(0)) -->
		<input type="hidden" name="TransType" value="0"/>                            <!-- 일반(0)/에스크로(1) --> 

		<!-- 변경 불가능 -->
		<input type="hidden" name="EncodeParameters" value="<%=encodeParameters%>"/> <!-- 암호화대상항목 -->
		<input type="hidden" name="EdiDate" value="<%=ediDate%>"/>                   <!-- 전문 생성일시 -->
		<input type="hidden" name="EncryptData" value="<%=hashString%>"/>            <!-- 해쉬값 -->
		<input type="hidden" name="TrKey" value=""/>                                 <!-- 필드만 필요 -->
		<input type="hidden" name="SocketYN" value="Y">                              <!-- 소켓통신 유무-->
		<input type="hidden" name="MerchantKey" value="<%=merchantKey%>"/>           <!-- 상점 키 -->

	</form>

</article>

<script type="text/javascript">
function SetBank(val){
	$('.tr-bank').css("display", "none");
	if(val=='무통장입금'){
		$('.tr-bank').css("display", "");
	}
}

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
		frm.action="/site/shop/include/pay_nice_ok.asp?o_code=<%=o_code%>";
		nicepayStart();
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