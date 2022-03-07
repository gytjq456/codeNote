<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp"-->
<%
P_STATUS = Request("P_STATUS")
P_RMESG1 = Request("P_RMESG1")
P_TID = Request("P_TID")
P_REQ_URL = Request("P_REQ_URL")
P_NOTI = Request("P_NOTI")

P_MID = "ESWMAnorm0"  

If P_STATUS = "00" Then  '인증성공시
			
	postdata = "P_MID=" & P_MID & "&P_TID=" & P_TID	   
								
	'On Error Resume Next
					
	Set xmlHttp = CreateObject("Msxml2.XMLHTTP")
					
	url = P_REQ_URL	
				  
	xmlHttp.open "post",url, False
	xmlHttp.setRequestHeader "Connection", "close"
	xmlHttp.setRequestHeader "Content-Length", Len(postdata)
	xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded;charset=utf-8"
	xmlHttp.Send postdata	'post data send

	statusText = xmlHttp.responseBody  '응답 결과메시지(binary data)
	strData = BinaryToText(statusText, "utf-8") ' binary data 를 string으로 변환

	arrStrData = Split(Trim(strData), "&")
	'Response.write("배열의 크기 : " & UBound(arrStrData) & " <br>")

	Dim d
	Set d=Server.CreateObject("Scripting.Dictionary")
	For i=0 To UBound(arrStrData)
		s = InStr(Trim(arrStrData(i)), "=")
		key1 = Mid(arrStrData(i), 1, s-1)
		value1 = Mid(arrStrData(i), s+1)
		'Response.write(key1 & "=" & value1 & "<br>")
		d.Add key1, value1
	Next

	Set xmlHttp = Nothing
	

	'//////////// DB 처리 ///////////////
	P_STATUS = d.Item("P_STATUS")
	P_RMESG1 = "Mobile" & Chr(13) & d.Item("P_RMESG1")
	P_TID = d.Item("P_TID")
	P_MID = d.Item("P_MID")
	P_TYPE = d.Item("P_TYPE")
	o_pay_point = d.Item("P_NOTI")

	'//////////// DB 처리 ///////////////
	If P_STATUS="00" Then '결제성공

		o_code = Request("o_code")

		If P_TYPE="DBANK" Then
			o_pay_method = "실시간계좌이체"
		ElseIf P_TYPE="VBANK" Then
			o_pay_method = "가상계좌"
		ElseIf P_TYPE="CARD" Then
			o_pay_method = "신용카드"
		Else
			o_pay_method = "기타_" & P_TYPE
		End If

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
		Sql = Sql & " o_pay_log=N'" & P_STATUS & " / " & P_RMESG1 & "', "
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
		%>
		<script type="text/javascript">
		alert('주문이 완료 되었습니다. 감사합니다.');
		opener.location.href='<%=mc_shop_url & "?mode=order_end&o_code=" & o_code%>';
		window.close();
		</script>
	<%
	Else
		Response.Write "결제실패 " & P_STATUS & " : " & P_RMESG1
	End If

Else      '인증실패시 
	Response.Write "인증실패 " & P_STATUS & " : " & P_RMESG1
End IF


'바이너리 데이터를 원하는 캐릭터셋으로 변환해주는 함수
Function BinaryToText(BinaryData, CharSet)

	Const adTypeText = 2
	Const adTypeBinary = 1

	Dim BinaryStream
	Set BinaryStream = CreateObject("ADODB.Stream")

	'원본 데이터 타입
	BinaryStream.Type = adTypeBinary
	BinaryStream.Open
	BinaryStream.Write BinaryData

	  ' binary -> text
	BinaryStream.Position = 0
	BinaryStream.Type = adTypeText

	' 변환할 데이터 캐릭터셋
	BinaryStream.CharSet = CharSet 

	'변환한 데이터 반환
	BinaryToText = BinaryStream.ReadText

End Function
 
%>
