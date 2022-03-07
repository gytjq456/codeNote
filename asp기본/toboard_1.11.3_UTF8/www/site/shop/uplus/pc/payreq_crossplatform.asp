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

    CST_PLATFORM               = trim(request("CST_PLATFORM"))             'LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
    CST_MID                    = trim(request("CST_MID"))                  '상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
                                                                           '테스트 아이디는 't'를 반드시 제외하고 입력하세요.
    if CST_PLATFORM = "test" then                                          '상점아이디(자동생성)
        LGD_MID = "t" & CST_MID
    else
        LGD_MID = CST_MID
    end if
    LGD_OID                    = trim(request("LGD_OID"))                  '주문번호(상점정의 유니크한 주문번호를 입력하세요)
    LGD_AMOUNT                 = trim(request("LGD_AMOUNT"))               '결제금액("," 를 제외한 결제금액을 입력하세요)
    LGD_BUYER                  = trim(request("LGD_BUYER"))                '구매자명
    LGD_PRODUCTINFO            = trim(request("LGD_PRODUCTINFO"))          '상품명
    LGD_BUYEREMAIL             = trim(request("LGD_BUYEREMAIL"))           '구매자 이메일 
    LGD_CUSTOM_SKIN            = "red"                                     '상점정의 결제창 스킨
	LGD_CUSTOM_SWITCHINGTYPE   = trim(request("LGD_CUSTOM_SWITCHINGTYPE")) '신용카드 카드사 인증 페이지 연동 방식
	LGD_CUSTOM_USABLEPAY       = trim(request("LGD_CUSTOM_USABLEPAY"))     '디폴트 결제수단 (해당 필드를 보내지 않으면 결제수단 선택 UI 가 보이게 됩니다.)     
	LGD_WINDOW_TYPE            = trim(request("LGD_WINDOW_TYPE"))          '수정불가
    LGD_OSTYPE_CHECK           = "P"									   '값 P: XPay 실행(PC 결제 모듈): PC용과 모바일용 모듈은 파라미터 및 프로세스가 다르므로 PC용은 PC 웹브라우저에서 실행 필요. "P", "M" 외의 문자(Null, "" 포함)는 모바일 또는 PC 여부를 체크하지 않음
	'LGD_ACTIVEXYN			   = "N"									   '계좌이체 결제시 사용, ActiveX 사용 여부로 "N" 이외의 값: ActiveX 환경에서 계좌이체 결제 진행(IE)
	LGD_WINDOW_VER		       = "2.5"									   '결제창 버젼정보
    LGD_CUSTOM_PROCESSTYPE     = "TWOTR"                                   '결제 방식 정보 (수정불가)
	LGD_CASNOTEURL		       = "https://상점URL/cas_noteurl.asp"         '가상계좌(무통장) 결제 연동을 하시는 경우 아래 LGD_CASNOTEURL 을 설정하여 주시기 바랍니다

    'LGD_RETURNURL 을 설정하여 주시기 바랍니다. 반드시 현재 페이지와 동일한 프로트콜 및  호스트이어야 합니다. 아래 부분을 반드시 수정하십시요.
	LGD_RETURNURL		       = "https://상점URL/returnurl.asp" ' FOR MANUAL 


	' ※ 중요
	' 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
	' 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
	' 예) [Window 계열] C:\inetpub\wwwroot\lgdacom -- 절대불가(웹 디렉토리)
	'공통정보
    configPath				   = "C:/lgdacom"						 'LG유플러스에서 제공한 환경파일(/conf/lgdacom.conf, /conf/mall.conf)이 위치한 디렉토리 지정 
  
	' (1) XpayClient의 사용을 위한 xpay 객체 생성
	Set xpay = server.CreateObject("XPayClientCOM.XPayClient")	

	' (2) XPayClient 초기화(환경설정 파일 로드)
	' configPath: 설정파일
	' CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는 url(srvice) 사용
	'				- test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
    xpay.Init configPath, CST_PLATFORM    

	'/*
    ' *************************************************
    ' * 2. MD5 해쉬암호화 (수정하지 마세요) - BEGIN
    ' *
    ' * MD5 해쉬암호화는 거래 위변조를 막기위한 방법입니다.
    ' *************************************************
    ' */
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
	'payReqMap.Add "LGD_ACTIVEXYN",              LGD_ACTIVEXYN				    '계좌이체 결제시 사용, ActiveX 사용 여부		      



	'수정 불가 ( 인증 후 자동 셋팅 )
	payReqMap.Add "LGD_RESPCODE",                ""
	payReqMap.Add "LGD_RESPMSG",                 ""
	payReqMap.Add "LGD_PAYKEY",                  ""

	set Session("PAYREQ_MAP") = payReqMap
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>통합LG유플러스 전자결서비스 결제테스트</title>
<!-- test일 경우 -->
<script language="javascript" src="https://pretest.uplus.co.kr:9443/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
<!-- 
  service일 경우 아래 URL을 사용 
<script language="javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js" type="text/javascript"></script>
 -->
<script type="text/javascript">

/*
* 수정불가.
*/
	var LGD_window_type = '<%=LGD_WINDOW_TYPE%>';
	

/*
* 수정불가
*/
function launchCrossPlatform(){
      lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), '<%= CST_PLATFORM %>', LGD_window_type, null, "", "");
}
/*
* FORM 명만  수정 가능
*/
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
			 document.getElementById("LGD_PAYINFO").target = "_self";
			 document.getElementById("LGD_PAYINFO").action = "payres.asp";
			 document.getElementById("LGD_PAYINFO").submit();
		
	} else {
		alert("LGD_RESPCODE (결과코드) : " + fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + "LGD_RESPMSG (결과메시지): " + fDoc.document.getElementById('LGD_RESPMSG').value);
		closeIframe();
	}
}

//-->
</script>

</head>
<body>
<form method="post" name ="LGD_PAYINFO" id="LGD_PAYINFO" action="payres.asp">
	<table>
		<tr>
			<td>윈도우 호출방식 </td>
			<td><%= LGD_WINDOW_TYPE %></td>
		</tr>
		<tr>
			<td>아이디 </td>
			<td><%= LGD_MID %></td>
		</tr>
		<tr>
			<td>구매자 이름 </td>
			<td><%= LGD_BUYER %></td>
		</tr>
		<tr>
			<td>구매자 IP </td>
			<td><%= LGD_BUYERIP %></td>
		</tr>
		<tr>
			<td>구매자 ID </td>
			<td><%= LGD_BUYERID %></td>
		</tr>
		<tr>
			<td>상품정보 </td>
			<td><%= LGD_PRODUCTINFO %></td>
		</tr>
		<tr>
			<td>결제금액 </td>
			<td><%= LGD_AMOUNT %></td>
		</tr>
		<tr>
			<td>구매자 이메일 </td>
			<td><%= LGD_BUYEREMAIL %></td>
		</tr>
		<tr>
			<td>주문번호 </td>
			<td><%= LGD_OID %></td>
		</tr>
		<tr>
			<td colspan="2">* 추가 상세 결제요청 파라미터는 메뉴얼을 참조하시기 바랍니다.</td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="button" value="인증요청" onclick="launchCrossPlatform();"/>
			</td>
		</tr>    
	</table>
	<br>

<%
  For Each eachitem In payReqMap
    response.write "<input type=""hidden"" name="""& eachitem &""" id="""& eachitem &""" value=""" & payReqMap.item(eachitem) & """><br>"
  Next
%>
</form>
</body>
</html>



