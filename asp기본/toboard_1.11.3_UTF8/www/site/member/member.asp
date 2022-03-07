<%
If Request("mode")<>"" Then mode = Request("mode")
If rturl="" Then rturl = "/"
If m_id="" Then m_id = W_ID
If b_lang="" Then b_lang="kr"
%>

<%
'한국어
If b_lang="kr" Then%>
	<%If mode="reg" Or mode="mod" Then %><!--#include file="include/inc_reg.asp"-->
	<%ElseIf mode="join" Then%><!--#include file="include/inc_agree.asp"-->
	<%ElseIf mode="idpw" Then%><!--#include file="include/inc_idpw.asp"-->
	<%ElseIf mode="login" Then%><!--#include file="include/inc_login.asp"-->
	<%ElseIf mode="point" Then%><!--#include file="include/inc_point.asp"-->
	<%ElseIf mode="reg_p" Or mode="mod_p" Or mode="del_p" Or mode="id_p" Or mode="pw_p" Or mode="login_p" Or mode="logout_p" Or mode="sns_login_p" Then%><!--#include file="include/reg_ok.asp"-->
	<%End If%>
<%
'영어
ElseIf b_lang="en" Then%>
	<%If mode="reg" Or mode="mod" Then %><!--#include file="include/inc_reg_en.asp"-->
	<%ElseIf mode="join" Then%><!--#include file="include/inc_agree_en.asp"-->
	<%ElseIf mode="idpw" Then%><!--#include file="include/inc_idpw_en.asp"-->
	<%ElseIf mode="login" Then%><!--#include file="include/inc_login_en.asp"-->
	<%ElseIf mode="reg_p" Or mode="mod_p" Or mode="del_p" Or mode="id_p" Or mode="pw_p" Or mode="login_p" Or mode="logout_p" Or mode="sns_login_p" Then%><!--#include file="include/reg_ok_en.asp"-->
	<%End If%>
<%End If%>