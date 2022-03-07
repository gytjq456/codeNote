<%
If Len(W_LEVEL)<>1 Then
	Response.Write "<script>alert('접속 권한이 없습니다.'); location.href='/site/manage'</script>"
	Response.End
End If
%>