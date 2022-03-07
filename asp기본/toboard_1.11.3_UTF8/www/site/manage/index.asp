<%@CodePage = 65001%>
<%
If Request.Cookies("W_LEVEL")<>"" Then
	If Request.Cookies("W_LEVEL")<10 Then
		Response.Redirect "/site/manage/main.asp"
	End If
End If 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="No-Cache" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<!--#include virtual="/site/setting.asp" -->
<link rel="stylesheet" type="text/css" href="/site/manage/css/admin.css" />
<link rel="stylesheet" type="text/css" href="/site/manage/css/login.css" />

<%
Set Rs = Server.CreateObject("ADODB.Recordset")
Sql = "SELECT TOP 1 m_email FROM tbl_member WHERE m_lev='2' ORDER BY idx DESC"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_email = Rs(0)
End If
Rs.Close
Set Rs = Nothing
%>

<script type="text/javascript">
function setCookie (name, value, expires) {
	document.cookie = name + "=" + escape (value) +
	"; path=/; expires=" + expires.toGMTString();
} 

function getCookie(Name) {
	var search = Name + "="
	if (document.cookie.length > 0) { 
		offset = document.cookie.indexOf(search)
		if (offset != -1) { 
			offset += search.length
			end = document.cookie.indexOf(";", offset)
		if (end == -1)
			end = document.cookie.length
			return unescape(document.cookie.substring(offset, end))
		}
	}
	return "";
}

function SaveId(form) {  
	if (document.loginform.checksaveid.checked==true) {
	var check;
	check = confirm("아이디 및 패스워드 저장 기능을 사용하시겠습니까?");
	if(check==false) {document.loginform.checksaveid.checked=false;} 	 
	var expdate = new Date();
	if (form.checksaveid.checked)
		expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30);
	else
		expdate.setTime(expdate.getTime() - 1);
	setCookie("saveid", form.m_id.value, expdate);
	setCookie("savepw", form.m_pw.value, expdate);
	}  
}

function getid(form) {
	form.checksaveid.checked = ((form.m_id.value = getCookie("saveid")) != "");
	form.checksaveid.checked = ((form.m_pw.value = getCookie("savepw")) != "");
}

function LoginChk(){
	if(!document.loginform.m_id.value){
		alert('아이디를 입력해주세요');
		document.loginform.m_id.focus();
		return false;
	}
	if(!document.loginform.m_pw.value){
		alert('패스워드를 입력해주세요');
		document.loginform.m_pw.focus();
		return false;
	}
	return true;
}

function AccountFind(){
	if(confirm('등록된 관리자 메일주소(<%=m_email%>)로 아이디와 임시패스워드를 발송합니다.\n진행 하시겠습니까?')){
		location.href='login_ok.asp?mode=idpw';
	}
}
</script>
</head>

<body onload="getid(document.loginform)">
	<div id="wrap">
		<div id="login_container">
			<div id="login_container_in">
				<form name="loginform" method="post" action="login_ok.asp?mode=in" onsubmit="return LoginChk();">
					<h1 class="login_title"><img src="/site/manage/images/obj/login_title.gif" alt="ADMIN LOGIN" /></h1>
					<div class="login_box">
						<p class="txt"><img src="/site/manage/images/obj/login_text.gif" alt="웹사이트 운영을 위한 관리자 모드입니다." maxlength="15" /></p>
						<dl>
							<dt>ID</dt>
							<dd><input type="text" name="m_id" class="login_input" style="ime-mode:disabled;" autocomplete="off" maxlength="15" /></dd>
							<dt>Password</dt>
							<dd><input type="password" name="m_pw" class="login_input" /></dd>
						</dl>
						<p class="remember"><label><input type="checkbox" name="checksaveid" onClick="SaveId(this.form)"> 아이디/패스워드 기억하기</label>
						<!--
						&nbsp;&nbsp;|&nbsp;&nbsp;
						<span style="float:right"><a href="javascript:AccountFind()">계정정보 분실 <img src="/site/manage/images/icon/icon_quest.gif"></a></span>
						-->
						</p>
						<p class="login_btn"><input type="image" src="/site/manage/images/btn/btn_login.gif" alt="로그인" /></p>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>