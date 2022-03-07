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
mode = Request("mode")

If mode="mod" Then

	Sql = "UPDATE tbl_site_config SET "
	Sql = Sql & "sc_email='" & Request("sc_email") & "', "
	Sql = Sql & "smtpserver='" & Request("smtpserver") & "', "
	Sql = Sql & "smtpserverport='" & Request("smtpserverport") & "', "
	Sql = Sql & "smtpusessl='" & Request("smtpusessl") & "', "
	Sql = Sql & "smtpauthenticate='" & Request("smtpauthenticate") & "', "
	Sql = Sql & "sendusername='" & Request("sendusername") & "', "
	Sql = Sql & "sendpassword='" & Request("sendpassword") & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('정보가 수정되었습니다.');location.href='smtp.asp';</script>"


ElseIf mode="send" Then

	On Error Resume Next

	ms_subject_ch = "[메일검사]"
	ms_content_ch = "본 메일의 내용을 확인할 수 있다면 정상적으로 설정 되었습니다."
	MailSendReturnValue = eMailCDOSend(ms_content_ch, ms_subject_ch, Request("from_email"), Request("to_email"), "", "")

	If Err.Number<>0 then
		err_msg = "[SMTP 설정에 오류가 있습니다. 메일서비스 제공업체에 문의바랍니다.]<br />"
		err_msg = err_msg & "- Error Number : " & Err.Number & "<br />"
		err_msg = err_msg & "- Error Source : " & Err.Source & "<br />"
		err_msg = err_msg & "- Error Description : " & Err.Description  & "<br />"
		'err_msg = err_msg & "- Error HelpContext : " & Err.HelpContext & "<br />"
		'err_msg = err_msg & "- Error NativeError : " & Err.NativeError  & "<br />"
		'err_msg = err_msg & "- Error HelpFile : " & Err.HelpFile  & "<br />"
		Response.Write err_msg
		'Response.Write "<script>alert('" & err_msg & "'); location.href='smtp.asp';</script>"
	Else
		Response.Write "<script>alert('메일 발송이 완료되었습니다. 받은메일함(또는 스팸메일함)을 확인 바랍니다.'); location.href='smtp.asp';</script>"
	End If

End If
%>