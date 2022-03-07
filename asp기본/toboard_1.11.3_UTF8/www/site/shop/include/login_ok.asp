<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp" -->
<% 
m_id = InsertText(LCase(Request("m_id")))
m_pw = InsertText(LCase(Request("m_pw")))

'사용불가 문자 체크
If disableChar(m_id)=False Or disableChar(m_pw)=False Then
	Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
	Response.End
End If

Set Rs = Server.CreateObject("ADODB.Recordset")
Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False then
	Response.Cookies("W_ID")=Rs("m_id")
	Response.Cookies("W_NAME")=Rs("m_name")
	Response.Cookies("W_PW")=m_pw
	Response.Cookies("W_EMAIL")=Rs("m_email")
	Response.Cookies("W_LEVEL")=Rs("m_lev")
Else
	Response.Write "<script>alert('아이디와 비밀번호가 올바르지 않습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing

'로그인 횟수 업데이트
Sql = "UPDATE tbl_member SET m_logcount=m_logcount+1 WHERE m_id='" & m_id & "';"

'기존에 담겨져 있는 회원 장바구니 초기화
Sql = Sql & "DELETE FROM tbl_mall_cart "
Sql = Sql & " WHERE o_code='' AND m_id='" & m_id & "'; "

'비회원 -> 회원 장바구니 이관
Sql = Sql & "UPDATE tbl_mall_cart SET m_id='" & m_id & "' "
Sql = Sql & " WHERE o_code='' AND session_id='" & W_SID & "'; "

Dbcon.Execute Sql

rturl = "http://" & Request.ServerVariables("SERVER_NAME") & mc_shop_url & "?mode=order"
Response.Redirect rturl

%>