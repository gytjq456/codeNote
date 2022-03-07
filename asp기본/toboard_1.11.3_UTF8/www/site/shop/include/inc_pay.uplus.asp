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
	o_tel = RsO("o_tel")
	o_amount = RsO("o_amount")	'주문 총액
	o_deli_amount = RsO("o_deli_amount")	'배송비
Else
	Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
	Response.End
End If
RsO.Close

'대표상품 취득
Sql = "SELECT * FROM tbl_mall_cart "
Sql = Sql & " WHERE idx!='' "
If W_ID<>"" Then
	Sql = Sql & " AND m_id='" & W_ID & "' "
Else
	Sql = Sql & " AND session_id='" & W_SID & "' "
End If
RsO.Open Sql, Dbcon, 1
If RsO.EOF=False Then
	p_name = RsO("p_name")
Else
	Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
	Response.End
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

<article id="cont" class="">

	<%If mc_coupon=True And W_ID<>"" Then%>
		<!-- 쿠폰 사용 -->
		<h4 class="sub_title">쿠폰 사용</h4>
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
				<th>쿠폰 적용 금액</th>
				<td class="left"><input type="text" name="o_coupon_amount" class="AXInput W100" readonly value="<%=o_coupon_amount%>" />원 할인
				<input type="button" class="AXButton" value="쿠폰선택" onclick="CouponSelect()"></td>
			</tr>
			</tbody>
		</table>
		<script type="text/javascript">
		function CouponSelect(){
			open("/site/shop/include/popup_coupon_select.asp?o_code=<%=o_code%>", "cc", "width=400px, height=400px, left=0px, top=0px, scrollbars=yes");
		}
		</script>
	<%End If%>

	<%If mc_point_use=True And W_ID<>"" Then%>

		<form name="pointform" method="post" action="?mode=pay&o_code=<%=o_code%>" onsubmit="return UsePoint()">
			<!-- 포인트 사용 -->
			<h4 class="sub_title">포인트 사용</h4>
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


	<form name="LGD_PAYINFO" id="LGD_PAYINFO" method="post" action="?mode=pay_bank_ok">
		<input type="hidden" name="o_coupon_code" value="<%=s_cd_code%>" />
		<input type="hidden" name="o_coupon_amount" value="<%=o_coupon_amount%>" />
		<input type="hidden" name="o_pay_point" value="<%=o_pay_point%>" />

		<h4 class="sub_title">결제 금액</h4>
		<table class="ntb-tb mytb_st" style="width:100%" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<th>합계</th>
					<th>배송비</th>
					<%If o_coupon_amount>0 Then%><th>쿠폰할인</th><%End If%>
					<%If o_pay_point>0 Then%><th>사용포인트</th><%End If%>
					<th class="r_none">결제금액</th>
				</tr>
				<tr>
					<td class="pd25"><span><%=FormatNumber(o_amount, 0)%></span>원</td>
					<td class="pd25"><span>(+)<%=FormatNumber(o_deli_amount, 0)%></span>원</td>
					<%If o_pay_point>0 Then%>
					<td class="pd25"><span>(-)<%=FormatNumber(o_pay_point, 0)%></span>p</td>
					<%End If%>
					<%If o_coupon_amount>0 Then%>
					<td class="pd25"><span>(-)<%=FormatNumber(o_coupon_amount, 0)%></span>원</td>
					<%End If%>
					<td class="pd25"><span class="cl_pri"><%=FormatNumber(o_total, 0)%></span>원</td>
				</tr>
			</tbody>
		</table>


		<%If o_total=0 Then%>
			<input type="hidden" name="o_pay_method" value="포인트결제" />
		<%Else%>
		<!-- 결제 정보 -->
		<h4 class="sub_title">결제 정보</h4>
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
<!-- 						<option value="계좌이체">계좌이체</option> -->
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


<!-- test일 경우 -->
<!-- <script language="javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script> -->
<!-- service일 경우 아래 URL을 사용  -->
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>

<%
'/*
' * [결제 인증요청 페이지(STEP2-1)]
' *
' * 샘플페이지에서는 기본 파라미터만 예시되어 있으며, 별도로 필요하신 파라미터는 연동메뉴얼을 참고하시어 추가 하시기 바랍니다.
' */

'/*
' * 1. 기본결제 인증요청 정보 변경
' *
' * 기본정보를 변경하여 주시기 바랍니다.(파라미터 전달시 POST를 사용하세요)
' */

Set xpay = server.CreateObject("XPayClientCOM.XPayClient")	

CST_PLATFORM               = "test"
CST_MID                    = "lgdacomxpay"

if CST_PLATFORM = "test" then                                          '상점아이디(자동생성)
	LGD_MID = "t" & CST_MID
else
	LGD_MID = CST_MID
end if
LGD_OID                    = o_code
LGD_AMOUNT                 = o_total
LGD_BUYER                  = o_name
LGD_PRODUCTINFO            = p_name
LGD_CUSTOM_SKIN            = "blue"                                     '상점정의 결제창 스킨
LGD_CUSTOM_SWITCHINGTYPE   = "IFRAME" '신용카드 카드사 인증 페이지 연동 방식
LGD_CUSTOM_USABLEPAY       = "SC0010"     '디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)     
LGD_WINDOW_TYPE            = "iframe"
LGD_OSTYPE_CHECK           = "P"									   '값 P: XPay 실행(PC 결제 모듈): PC용과 모바일용 모듈은 파라미터 및 프로세스가 다르므로 PC용은 PC 웹브라우저에서 실행 필요. "P", "M" 외의 문자(Null, "" 포함)는 모바일 또는 PC 여부를 체크하지 않음
'LGD_ACTIVEXYN			   = "N"									   '계좌이체 결제시 사용, ActiveX 사용 여부로 "N" 이외의 값: ActiveX 환경에서 계좌이체 결제 진행(IE)
LGD_WINDOW_VER		       = "2.5"									   '결제창 버젼정보
LGD_CUSTOM_PROCESSTYPE     = "TWOTR"                                   '결제 방식 정보 (수정불가)
LGD_CASNOTEURL		       = "http://" & Request.ServerVariables("SERVER_NAME") & "/site/shop/uplus/pc/cas_noteurl.asp"
LGD_RETURNURL		       = "http://" & Request.ServerVariables("SERVER_NAME") & "/site/shop/uplus/pc/returnurl.asp"


configPath				   = "C:/lgdacom"						 'LG유플러스에서 제공한 환경파일(/conf/lgdacom.conf, /conf/mall.conf)이 위치한 디렉토리 지정 

xpay.Init configPath, CST_PLATFORM   

LGD_TIMESTAMP = xpay.GetTimeStamp

LGD_HASHDATA = xpay.GetHashData(LGD_MID,LGD_OID,LGD_AMOUNT,LGD_TIMESTAMP)


'/*
' *************************************************
' * 2. MD5 해쉬암호화 (수정하지 마세요) - END
' *************************************************
' */
Set payReqMap = Server.CreateObject("Scripting.Dictionary")
payReqMap.Add "CST_PLATFORM",                CST_PLATFORM                   '테스트, 서비스 구분
payReqMap.Add "CST_MID",                     CST_MID                        '상점아이디
payReqMap.Add "LGD_WINDOW_TYPE",             LGD_WINDOW_TYPE
payReqMap.Add "LGD_MID",                     LGD_MID                        '상점아이디
payReqMap.Add "LGD_OID",                     LGD_OID                        '주문번호
payReqMap.Add "LGD_BUYER",                   LGD_BUYER                      '구매자
payReqMap.Add "LGD_PRODUCTINFO",             LGD_PRODUCTINFO                '상품정보
payReqMap.Add "LGD_AMOUNT",                  LGD_AMOUNT                     '결제금액
payReqMap.Add "LGD_BUYEREMAIL",              LGD_BUYEREMAIL                 '구매자 이메일
payReqMap.Add "LGD_CUSTOM_SKIN",             LGD_CUSTOM_SKIN                '결제창 SKIN
payReqMap.Add "LGD_CUSTOM_PROCESSTYPE",      LGD_CUSTOM_PROCESSTYPE         '트랜잭션 처리방식
payReqMap.Add "LGD_TIMESTAMP",               LGD_TIMESTAMP                  '타임스탬프
payReqMap.Add "LGD_HASHDATA",                LGD_HASHDATA                   'MD5 해쉬암호값
payReqMap.Add "LGD_RETURNURL",   			 LGD_RETURNURL      		    '응답수신페이지
payReqMap.Add "LGD_VERSION",         		 "ASP_Non-ActiveX_Standard"     '사용타입 정보(수정 및 삭제 금지): 이 정보를 근거로 어떤 서비스를 사용하는지 판단할 수 있습니다.
payReqMap.Add "LGD_CUSTOM_USABLEPAY",        LGD_CUSTOM_USABLEPAY     	    '결제수단 정보
payReqMap.Add "LGD_CUSTOM_SWITCHINGTYPE",    "IFRAME"					    '신용카드 카드사 인증 페이지 연동 방식
payReqMap.Add "LGD_CASNOTEURL",              LGD_CASNOTEURL                 '가상계좌 할당/ 입금시 통보를 받게되는 page URL
payReqMap.Add "LGD_WINDOW_VER",  		     LGD_WINDOW_VER			      
payReqMap.Add "LGD_OSTYPE_CHECK",            LGD_OSTYPE_CHECK			    '값 P: XPay 실행(PC용 결제 모듈), PC, 모바일 에서 선택적으로 결제가능 
payReqMap.Add "LGD_DOMAIN_URL",           	 "xpayvvip"
payReqMap.Add "LGD_ENCODING",           	 "UTF-8"
payReqMap.Add "LGD_ENCODING_NOTEURL",           	 "UTF-8"
payReqMap.Add "LGD_ENCODING_RETURNURL",           	 "UTF-8"
'payReqMap.Add "LGD_ACTIVEXYN",              LGD_ACTIVEXYN				    '계좌이체 결제시 사용, ActiveX 사용 여부		      

'수정 불가 ( 인증 후 자동 셋팅 )
payReqMap.Add "LGD_RESPCODE",                ""
payReqMap.Add "LGD_RESPMSG",                 ""
payReqMap.Add "LGD_PAYKEY",                  ""

Set Session("PAYREQ_MAP") = payReqMap
%>

		<%
		For Each eachitem In payReqMap
			Response.write "<input type=""hidden"" name="""& eachitem &""" id="""& eachitem &""" value=""" & payReqMap.item(eachitem) & """>"
		Next
		%>

	</form>

</article>

<script type="text/javascript">
function SetBank(val){
	$('.tr-bank').css("display", "none");
	if(val=='무통장입금'){
		$('.tr-bank').css("display", "");
	}
}

var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';

function DoPay(){
	document.cookie = 'same-site-cookie=foo; SameSite=Lax';
	document.cookie = 'cross-site-cookie=bar; SameSite=None; Secure';
	var frm = document.LGD_PAYINFO;
	if(frm.o_pay_method.value==""){ alert('결제 수단을 선택하세요.'); frm.o_pay_method.focus(); return; }

	//무통장입금
	if(frm.o_pay_method.value=="무통장입금"){
		frm.action="?mode=pay_bank_ok&o_code=<%=o_code%>";
		if(frm.o_pay_bank.value==""){ alert('무통장 입금 계좌를 선택하세요.'); frm.o_pay_bank.focus(); return; }
		if(frm.o_pay_bank_name.value==""){ alert('입금자 명을 입력하세요.'); frm.o_pay_bank_name.focus(); return; }
		frm.submit();

	}else if(frm.o_pay_method.value=="신용카드"){
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");

	}else if(frm.o_pay_method.value=="계좌이체"){
		lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");

	}else if(frm.o_pay_method.value=="포인트결제"){
		frm.action="?mode=pay_bank_ok&o_code=<%=o_code%>";
		frm.submit();
	}else{
		alert('결제수단을 선택하세요.');
		return;
	}
}

function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}

/*
 * 인증결과 처리
 */
function payment_return() {
	var fDoc;
		fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
	
	if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {
		     document.getElementById("LGD_PAYKEY").value = fDoc.document.getElementById('LGD_PAYKEY').value;
			 document.getElementById("LGD_PAYINFO").target = "_top";
			 document.getElementById("LGD_PAYINFO").action = "/site/shop/include/pay_uplus_ok.asp?o_code=<%=o_code%>";
			 document.getElementById("LGD_PAYINFO").submit();
		
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}
</script>

<script type="text/javascript">
history.pushState(null, null, location.href);
window.onpopstate = function(event) {
	history.go(1);
};
</script>