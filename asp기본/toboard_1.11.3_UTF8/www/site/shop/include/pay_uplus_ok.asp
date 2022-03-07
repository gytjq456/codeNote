<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->
<% 
'/*
' * [최종결제요청 페이지(STEP2-2)]
' *
' * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
' */

' ※ 중요
' 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
' 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
' 예) [Window 계열] C:\inetpub\wwwroot\lgdacom -- 절대불가(웹 디렉토리)

configPath = "C:/lgdacom"  'LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf, /conf/mall.conf") 위치 지정.  

'/*
' *************************************************
' * 1.최종결제 요청 - BEGIN
' *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
' *************************************************
' */
CST_PLATFORM               = trim(request("CST_PLATFORM"))
CST_MID                    = trim(request("CST_MID"))
if CST_PLATFORM = "test" then
	LGD_MID = "t" & CST_MID
else
	LGD_MID = CST_MID
end if
LGD_PAYKEY                 = trim(request("LGD_PAYKEY"))
LGD_BUYER                 = trim(request("LGD_BUYER"))
LGD_AMOUNT                 = trim(request("LGD_AMOUNT"))
LGD_TID                 = trim(request("LGD_TID"))

Dim xpay            '결제요청 API 객체
Dim amount_check    '금액비교 결과
Dim i, j
Dim itemName

'해당 API를 사용하기 위해 setup.exe 를 설치해야 합니다.
Set xpay = server.CreateObject("XPayClientCOM.XPayClient")
xpay.Init configPath, CST_PLATFORM

xpay.Init_TX(LGD_MID)
xpay.Set "LGD_TXNAME", "PaymentByKey"
xpay.Set "LGD_PAYKEY", LGD_PAYKEY

p_pay_log = xpay.resCode & " / " & xpay.resMsg

'금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
'DB_AMOUNT = "DB나 세션에서 가져온 금액" 	'반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
'xpay.Set "LGD_AMOUNTCHECKYN", "Y"
'xpay.Set "LGD_AMOUNT", DB_AMOUNT
	
'/*
' *************************************************
' * 1.최종결제 요청(수정하지 마세요) - END
' *************************************************
' */

'/*
' * 2. 최종결제 요청 결과처리
' *
' * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
' */

If xpay.TX() then
	  
	LGD_TID = xpay.Response("LGD_TID", 0)
	
	'authdata
	'	 1. mertid + tid + mert_key => 인증문자열
	'	 2. md5(인증문자열) => authdata
	'	 mert_key는 데이콤에서 발급한 상점용 개인키(private key)로 상점관리자에서 확인 가능
	LGD_MERTKEY = "77dc5ee22ac1b848a87bb28acb2c348c"	
	authdata = LGD_MID & LGD_TID & LGD_MERTKEY

	if xpay.resCode = "0000" then

		'@@@@@@@@@@@@@@@@@ DB처리 @@@@@@@@@@@@@@@@@@@@@@@@
		o_code = Request("o_code")
		o_pay_method = "신용카드"
		o_coupon_code = Request("o_coupon_code")
		o_coupon_amount = Request("o_coupon_amount")
		o_pay_point = Request("o_pay_point")

		Sql = "UPDATE tbl_mall_cart SET "
		Sql = Sql & " o_end='1' "
		Sql = Sql & " WHERE o_code='" & o_code & "' "
		If W_ID<>"" Then
			Sql = Sql & " AND m_id='" & W_ID & "' "
		Else
			Sql = Sql & " AND session_id='" & W_SID & "' "
		End If
		'Response.write sql
		Dbcon.Execute Sql

		'주문정보 수정
		Sql = "UPDATE tbl_mall_order SET "
		Sql = Sql & " o_pay_method=N'" & o_pay_method & "', "
		Sql = Sql & " o_pay_point=N'" & o_pay_point & "', "
		Sql = Sql & " o_coupon_code=N'" & o_coupon_code & "', "
		Sql = Sql & " o_coupon_amount=N'" & o_coupon_amount & "', "
		Sql = Sql & " o_pay_log=N'" & p_pay_log & "', "
		Sql = Sql & " o_state=N'결제완료' "
		Sql = Sql & " WHERE o_code='" & o_code & "' "
		If W_ID<>"" Then
			Sql = Sql & " AND m_id='" & W_ID & "' "
		Else
			Sql = Sql & " AND session_id='" & W_SID & "' "
		End If
		'Response.write sql
		Dbcon.Execute Sql

		'포인트 결제
		If o_pay_point>0 Then 
			Call SetPoint(W_ID, "-", o_pay_point, "포인트 사용 (주문코드 : " & o_code & ")")
		End If

		Response.Redirect mc_shop_url & "?mode=order_end&o_code=" & o_code

	Else
		'결제결제요청 결과 실패 DB처리
		Response.Write("결제요청이 실패하였습니다. 고객센터로 문의주시기 바랍니다." & "<br>")
		Response.Write("TX Response_code = " & xpay.resCode & "<br>")
		Response.Write("TX Response_msg = " & xpay.resMsg & "<p>")
	end If
	
Else
	'2)API 요청실패 화면처리
	Response.Write("결제요청이 실패하였습니다. 고객센터로 문의주시기 바랍니다.<br>")
	Response.Write("TX Response_code = " & xpay.resCode & "<br>")
	Response.Write("TX Response_msg = " & xpay.resMsg & "<p>")
		
	'결제요청 결과 실패 상점 DB처리
	Sql = "UPDATE tbl_pay SET "
	Sql = Sql & "p_method='" & p_order & "', "
	Sql = Sql & "p_state='취소' "
	Sql = Sql & " WHERE idx='" & idx & "'"
	'response.write Sql
	Dbcon.Execute Sql
		
End if
%>
<script>
// 결제 중 새로고침 방지 샘플 스크립트 (중복결제 방지)
function noRefresh()
{
	/* CTRL + N키 막음. */
	if ((event.keyCode == 78) && (event.ctrlKey == true))
	{
		event.keyCode = 0;
		return false;
	}
	/* F5 번키 막음. */
	if(event.keyCode == 116)
	{
		event.keyCode = 0;
		return false;
	}
}

document.onkeydown = noRefresh ;
</script>