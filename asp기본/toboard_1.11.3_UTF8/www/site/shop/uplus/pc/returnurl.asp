<%@CodePage = 65001%>
<%
  Set payReqMap = Session.Contents("PAYREQ_MAP")

  'payreq_crossplatform.asp 에서 세션에 저장했던 파라미터 값이 유효한지 체크
  '세션 유지 시간(로그인 유지시간)을 적당히 유지 하거나 세션을 사용하지 않는 경우 DB처리 하시기 바랍니다.
	if IsNull(payReqMap)then
		response.write "세션이 만료 되었거나 유효하지 않은 요청 입니다."
	end if 
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<script type="text/javascript">

		function setLGDResult() {
			parent.payment_return();
			try {
			} catch (e) {
				alert(e.message);
			}
		}
		
	</script>
</head>
<body onload="setLGDResult()">
<p><h1>RETURN_URL (인증결과)</h1></p>
<div>
<%
  LGD_RESPCODE = Trim(Request("LGD_RESPCODE"))
  LGD_RESPMSG  = Trim(Request("LGD_RESPMSG"))
  LGD_PAYKEY	 = ""

  payReqMap.item("LGD_RESPCODE") = LGD_RESPCODE
  payReqMap.item("LGD_RESPMSG")  = LGD_RESPMSG

  if LGD_RESPCODE = "0000" then
	  LGD_PAYKEY = Trim(Request("LGD_PAYKEY"))	
	  payReqMap.item("LGD_PAYKEY")   = LGD_PAYKEY
  Else
    response.write "LGD_RESPCODE:" & LGD_RESPCODE & " ,LGD_RESPMSG:" & LGD_RESPMSG '인증 실패에 대한 처리 로직 추가
  End If 
%><form method="post" name="LGD_RETURNINFO" id="LGD_RETURNINFO"><%
    For Each eachitem In payReqMap
      response.write "<input type=""hidden"" name="""& eachitem &""" id="""& eachitem &""" value=""" & payReqMap.item(eachitem) & """><br>"
    Next
%></form>
</div>
</body>
</html>