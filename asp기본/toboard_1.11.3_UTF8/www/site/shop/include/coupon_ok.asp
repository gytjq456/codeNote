<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->
<%
idx = Request("idx")

If W_ID="" Then
	Response.Write "<script>alert('회원 로그인이 필요합니다.'); history.back();</script>"
	Response.End
End If

Call SetDirCouponDownload(W_ID, idx)

Response.Write "<script>alert('발급 완료 되었습니다.'); location.href='" & Request.ServerVariables("HTTP_REFERER") & "';</script>"
%>