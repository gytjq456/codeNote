<%
	'/*
    ' * [최종결제요청 페이지(STEP2-2)]
	' * 
    ' * 매뉴얼 "5.1. XPay 결제 요청 페이지 개발"의 "단계 5. 최종 결제 요청 및 요청 결과 처리" 참조
	' * 
    ' * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
    ' */
	
	
    CST_PLATFORM				= trim(request("CST_PLATFORM"))			'LG유플러스 결제 서비스 선택(test:테스트, service:서비스)
    CST_MID						= trim(request("CST_MID"))				'상점아이디(LG유플러스으로 부터 발급받으신 상점아이디를 입력하세요)
																		'테스트 아이디는 't'를 반드시 제외하고 입력하세요.
    if CST_PLATFORM = "test" then										'상점아이디(자동생성)
        LGD_MID = "t" & CST_MID
    else
        LGD_MID = CST_MID
    end if
    LGD_OID						= trim(request("LGD_OID"))            	'주문번호(상점정의 유니크한 주문번호를 입력하세요)
    LGD_PAYKEY          		= trim(request("LGD_PAYKEY"))     		'페이키
    
	' ※ 중요
	' 환경설정 파일의 경우 반드시 외부에서 접근이 가능한 경로에 두시면 안됩니다.
	' 해당 환경파일이 외부에 노출이 되는 경우 해킹의 위험이 존재하므로 반드시 외부에서 접근이 불가능한 경로에 두시기 바랍니다. 
	' 예) [Window 계열] C:\inetpub\wwwroot\lgdacom -- 절대불가(웹 디렉토리)
	'공통정보
    configPath				   = "C:/lgdacom"						 'LG유플러스에서 제공한 환경파일(/conf/lgdacom.conf, /conf/mall.conf)이 위치한 디렉토리 지정 
    
	Dim xpay
	Dim i, j
	Dim itemName
	
	
	' (1) XpayClient의 사용을 위한 xpay 객체 생성
	Set xpay = server.CreateObject("XPayClientCOM.XPayClient")	

	' (2) XPayClient 초기화(환경설정 파일 로드)
	' configPath: 설정파일
	' CST_PLATFORM: - test, service 값에 따라 lgdacom.conf의 test_url(test) 또는 url(srvice) 사용
	'				- test, service 값에 따라 테스트용 또는 서비스용 아이디 생성
    xpay.Init configPath, CST_PLATFORM    

    ' (3) Init_TX: 메모리에 mall.conf, lgdacom.conf 할당 및 트랜잭션의 고유한 키 TXID 생성
	xpay.Init_TX(LGD_MID)
    xpay.Set "LGD_TXNAME", "PaymentByKey"
    xpay.Set "LGD_PAYKEY", LGD_PAYKEY 
	

	' (4) TX: lgdacom.conf에 설정된 URL로 소켓 통신하여 최종 인증요청, 결과값으로 true, false 리턴
    if  xpay.TX() then
        '1)결제결과 처리(성공,실패 결과 처리를 하시기 바랍니다.)
        Response.Write("결제요청이 완료되었습니다. <br>")
        Response.Write("TX 통신 응답코드 = " & xpay.resCode & "<br>")				'통신 응답코드("0000" 일 때 통신 성공)
        Response.Write("TX 통신 응답메시지 = " & xpay.resMsg & "<p>")

	    Response.Write("거래번호 : " & xpay.Response("LGD_TID", 0) & "<br>")
	    Response.Write("상점아이디 : " & xpay.Response("LGD_MID", 0) & "<br>")
	    Response.Write("상점주문번호 : " & xpay.Response("LGD_OID", 0) & "<br>")
	    Response.Write("결제금액 : " & xpay.Response("LGD_AMOUNT", 0) & "<br>")
	    Response.Write("결과코드 : " & xpay.Response("LGD_RESPCODE", 0) & "<br>")	'LGD_RESPCODE 가 반드시 "0000" 일때만 결제 성공, 그 외는 모두 실패
	    Response.Write("결과메세지 : " & xpay.Response("LGD_RESPMSG", 0) & "<p>")

        Response.Write("[결제요청 결과 파라미터]<br>")

        '아래는 결제요청 결과 파라미터를 모두 찍어 줍니다.
        Dim itemCount
        Dim resCount
        itemCount = xpay.resNameCount
        resCount = xpay.resCount

        For i = 0 To itemCount - 1
            itemName = xpay.ResponseName(i)
            Response.Write(itemName & "&nbsp:&nbsp")
            For j = 0 To resCount - 1
                Response.Write(xpay.Response(itemName, j) & "<br>")
            Next
        Next
        
        Response.Write("<p>")
        
		' (5) DB에 요청 결과 처리
        if xpay.resCode = "0000" then
        	'통신상의 문제가 없을시
         	'최종결제요청 결과 성공 DB처리(LGD_RESPCODE 값에 따라 결제가 성공인지, 실패인지 DB처리)
        	Response.Write("최종결제요청 결과 성공 DB처리하시기 바랍니다." & "<br>")
        	            	            	
        	'최종결제요청 결과를 DB처리합니다. (결제성공 또는 실패 모두 DB처리 가능)
			'상점내 DB에 어떠한 이유로 처리를 하지 못한경우 false로 변경해 주세요.
        	isDBOK = true 'DB처리 실패시 false로 변경해 주세요.
        	
        	if isDBOK then
        	else
        		Response.Write("<p>")
        		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" & xpay.Response("LGD_TID",0) & ",MID:" & xpay.Response("LGD_MID",0) & ",OID:" & xpay.Response("LGD_OID",0) & "]")
        		
                Response.Write("TX Rollback Response_code = " & xpay.resCode & "<br>")
                Response.Write("TX Rollback Response_msg = " & xpay.resMsg & "<p>")
        		
                if "0000" = xpay.resCode then
                	Response.Write("자동취소가 정상적으로 완료 되었습니다.<br>")
                else
                	Response.Write("자동취소가 정상적으로 처리되지 않았습니다.<br>")
                end if
        	end if            	
        else
        	'통신상의 문제 발생(최종결제요청 결과 실패 DB처리)
        	Response.Write("최종결제요청 결과 실패 DB처리하시기 바랍니다." & "<br>")
        end if
    else
        '2)API 요청실패 처리
        Response.Write("결제요청이 실패하였습니다. <br>")
        Response.Write("TX Response_code = " & xpay.resCode & "<br>")
        Response.Write("TX Response_msg = " & xpay.resMsg & "<p>")
        
        '결제요청 결과 실패 상점 DB처리
        Response.Write("결제결제요청 결과 실패 DB처리하시기 바랍니다." & "<br>")
    end if 
%>
