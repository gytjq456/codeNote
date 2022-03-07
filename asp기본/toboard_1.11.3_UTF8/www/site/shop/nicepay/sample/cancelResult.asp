<%
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <취소 결과 설정>
' 사용전 결과 옵션을 사용자 환경에 맞도록 변경하세요.
' 상점키, MID는 꼭 변경하세요.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Set NICEpay = Server.CreateObject("NICE.NICETX2.1")
PInst = NICEpay.Initialize("")
NICEpay.SetActionType CLng(PInst),"CANCEL"
NICEpay.SetField CLng(PInst),"logpath","C:\log"                                     'Log Path 설정
NICEpay.SetField CLng(PInst),"LicenseKey","33F49GnCMS1mFYlGXisbUDzVf2ATWCl9k3R++d5hDd3Frmuos/XLx8XhXpe+LDYAbpGKZYSwtlyyLOtS/8aD7A==" '상점키
NICEpay.SetField CLng(PInst),"mid",Request("MID")                                   '상점 ID  
NICEpay.SetField CLng(PInst),"CancelPwd",Request("CancelPwd")                       '취소 패스워드
NICEpay.SetField CLng(PInst),"CancelAmt",Request("CancelAmt")                       '취소금액 
NICEpay.SetField CLng(PInst),"tid",Request("TID")                                   '공급가액 
NICEpay.SetField CLng(PInst),"CancelMSG",Request("CancelMsg")                       '취소 사유
NICEpay.SetField CLng(PInst),"partialcancelcode",Request("PartialCancelCode")       '부분취소 여부
NICEpay.SetField CLng(PInst),"debug","true"                                         '로그모드(true=상세한 로그)
NICEpay.StartAction(CLng(PInst))

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <취소 결과 필드>
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
m_tid            = NICEpay.GetResult(CLng(PInst),"tid")                             '거래번호
m_resultCode     = NICEpay.GetResult(CLng(PInst),"resultcode")                      '결과코드 (취소성공: 2001, 취소성공(LGU 계좌이체):2211)
m_resultMsg      = NICEpay.GetResult(CLng(PInst),"resultmsg")                       '결과메시지
m_cancelauthcode = NICEpay.GetResult((PInst),"CancelNum")                           '취소승인번호
m_cancelDate     = NICEpay.GetResult((PInst),"CancelDate")                          '취소일시
m_cancelTime     = NICEpay.GetResult((PInst),"CancelTime")                          '취소시간
m_cancelamt      = NICEpay.GetResult((PInst),"cancelamt")                           '취소금액
    
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' <인스턴스 해제>
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
NICEpay.Destroy CLng(PInst)
%>
<!DOCTYPE html>
<html>
<head>
<title>NICEPAY CANCEL RESULT(EUC-KR)</title>
<meta charset="euc-kr">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=yes, target-densitydpi=medium-dpi" />
<link rel="stylesheet" type="text/css" href="./css/import.css"/>
</head>
<body>
  <div class="payfin_area">
    <div class="top">NICEPAY CANCEL RESULT(EUC-KR)</div>
    <div class="conwrap">
      <div class="con">
        <div class="tabletypea">
          <table>
            <tr>
              <th><span>거래 아이디</span></th>
              <td><%=m_tid%></td>
            </tr>        
            <tr>
              <th><span>결과 내용</span></th>
              <td>[<%=m_resultCode%>]<%=m_resultMsg%></td>
            </tr>
            <tr>
              <th><span>취소 금액</span></th>
              <td><%=m_cancelamt%></td>
            </tr>
            <tr>
              <th><span>취소일</span></th>
              <td><%=m_cancelDate%></td>
            </tr>
            <tr>
              <th><span>취소시간</span></th>
              <td><%=m_cancelTime%></td>
            </tr>
          </table>
        </div>
      </div>
      <p>* 취소가 성공한 경우에는 다시 승인상태로 복구 할 수 없습니다.</p>
    </div>
  </div>
</body>
</html>