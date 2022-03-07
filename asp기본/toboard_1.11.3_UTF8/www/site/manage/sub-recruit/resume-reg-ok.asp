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
	mode					= Request("mode")
	r_info					= Request("r_info")
	r_education		= Request("r_education")
	r_personal			= Request("r_personal")
	r_army				= Request("r_army")
	r_job					= Request("r_job")
	r_disabled			= Request("r_disabled")
	r_lower				= Request("r_lower")
	r_body				= Request("r_body")
	r_family				= Request("r_family")
	r_license			= Request("r_license")
	r_oa					= Request("r_oa")
	r_language		= Request("r_language")
	r_portfolio			= Request("r_portfolio")
	r_skill					= Request("r_skill")
	r_career				= Request("r_career")
	r_experience		= Request("r_experience")
	r_project				= Request("r_project")
	r_prime				= Request("r_prime")
	r_training			= Request("r_training")
	r_complete		= Request("r_complete")
	r_swot				= Request("r_swot")
	r_etc					= Request("r_etc")
	r_introduction	= Request("r_introduction")

	If rturl="" Then rturl="/site/manage/sub-recruit/resume-reg.asp?mode=reg"

	'회원 정보 수정
	If mode="mod_p" Then

		SQL = "UPDATE tbl_resume_config SET "
		SQL = SQL & "r_info='" & r_info & "', "
		SQL = SQL & "r_education='" & r_education & "', "
		SQL = SQL & "r_personal='" & r_personal & "', "
		SQL = SQL & "r_army='" & r_army & "', "
		SQL = SQL & "r_job='" & r_job & "', "
		SQL = SQL & "r_disabled='" & r_disabled & "', "
		SQL = SQL & "r_lower='" & r_lower & "', "
		SQL = SQL & "r_body='" & r_body & "', "
		SQL = SQL & "r_family='" & r_family & "', "
		SQL = SQL & "r_license='" & r_license & "', "
		SQL = SQL & "r_oa='" & r_oa & "', "
		SQL = SQL & "r_language='" & r_language & "', "
		SQL = SQL & "r_portfolio='" & r_portfolio & "', "
		SQL = SQL & "r_skill='" & r_skill & "', "
		SQL = SQL & "r_career='" & r_career & "', "
		SQL = SQL & "r_experience='" & r_experience & "', "
		SQL = SQL & "r_project='" & r_project & "', "
		SQL = SQL & "r_prime='" & r_prime & "', "
		SQL = SQL & "r_training='" & r_training & "', "
		SQL = SQL & "r_complete='" & r_complete & "', "
		SQL = SQL & "r_swot='" & r_swot & "', "
		SQL = SQL & "r_etc='" & r_etc & "', "
		SQL = SQL & "r_introduction='" & r_introduction & "' "
		Dbcon.Execute SQL

		rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl

		Response.Write "<script>alert('정보가 수정 되었습니다.'); location.href='" & rturl & "';</script>"
		Response.End

	End If
%>