<%@CodePage = 65001%>
<%
Response.CharSet="utf-8"
Session.codepage="65001"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"
%>
<!--#include virtual="/site/setting.asp"-->
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
s_fromnum = sc_tel
s_tonum = Trim(Request("s_tonum"))
s_tonum = Replace(s_tonum, "-", "")
s_tonum = Replace(s_tonum, ",", "#$#")

sms_content = Request("sms_content")
'sms_content = Replace(sms_content, "{MEM_ID}", m_id)
'sms_content = Replace(sms_content, "{MEM_NAME}", m_name)
'sms_content = Replace(sms_content, "{MEM_EMAIL}", m_email)
'sms_content = Replace(sms_content, "{SITE_NAME}", sc_name)
'sms_content = Replace(sms_content, "{SITE_URL}", sc_url)

Call SendSMS(s_fromnum, s_tonum, sms_content, "전송 완료 되었습니다.", "http://" & Request.ServerVariables("SERVER_NAME") & "/site/manage/sub-member/member.asp")
%>