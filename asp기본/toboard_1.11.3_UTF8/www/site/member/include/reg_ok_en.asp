<%
m_lang = "en"
m_id = InsertText(LCase(Request("m_id")))
m_pw = InsertText(LCase(Request("m_pw")))
m_name = InsertText(Request("m_name"))
m_jumin = InsertText(Request("m_jumin"))
m_email = InsertText(Request("m_email"))
m_mailing = Request("m_mailing")
m_tel1 = Request("m_tel1")
m_tel2 = Request("m_tel2")
m_tel3 = Request("m_tel3")
m_cell1 = Request("m_cell1")
m_cell2 = Request("m_cell2")
m_cell3 = Request("m_cell3")
m_fax1 = Request("m_fax1")
m_fax2 = Request("m_fax2")
m_fax3 = Request("m_fax3")
m_zip1 = Request("m_zip1")
m_zip2 = Request("m_zip2")
m_addr1 = InsertText(Request("m_addr1"))
m_addr2 = InsertText(Request("m_addr2"))
addtext1 = InsertText(Request("addtext1"))
addtext2 = InsertText(Request("addtext2"))
addtext3 = InsertText(Request("addtext3"))
addtext4 = InsertText(Request("addtext4"))
addtext5 = InsertText(Request("addtext5"))
addtext6 = InsertText(Request("addtext6"))
addtext7 = InsertText(Request("addtext7"))
addtext8 = InsertText(Request("addtext8"))
addtext9 = InsertText(Request("addtext9"))
addtext10 = InsertText(Request("addtext10"))
addtext11 = InsertText(Request("addtext11"))
addtext12 = InsertText(Request("addtext12"))
addtext13 = InsertText(Request("addtext13"))
addtext14 = InsertText(Request("addtext14"))
addtext15 = InsertText(Request("addtext15"))
addtext16 = InsertText(Request("addtext16"))
addtext17 = InsertText(Request("addtext17"))
addtext18 = InsertText(Request("addtext18"))
addtext19 = InsertText(Request("addtext19"))
addtext20 = InsertText(Request("addtext20"))

If rturl="" Then rturl="/"

'회원 권한 설정
'm_lev = Request("m_lev")
'm_sort = Request("m_sort")
m_levmxd = Request("m_levmxd")
If m_levmxd<>"" Then
	a_levmxd = Split(m_levmxd, ":")
	m_lev = a_levmxd(0)
	m_sort = a_levmxd(1)
Else
	Set RsL = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member_level WHERE m_default='1' "
	RsL.Open Sql, Dbcon, 1
	If RsL.EOF=False Then
		m_lev = RsL("m_lev")
		m_sort = RsL("m_sort")
	End If
	RsL.Close
	Set RsL = Nothing
End If

'회원 등록(가입)
If mode="reg_p" Then

	'자동 등록 방지 체크
	If SpamChk(Trim(Request("txtCaptcha")))=False Then
		Response.Write "<script language='javascript'>alert('Automatic registration prevention code entered incorrectly.'); history.back();</script>"
		Response.End
	End If

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	'아이디 중복체크
	If IdDuplChk(m_id)=False Then
		Response.Write"<script>alert('This ID is currently in use. Please enter another ID.'); history.back();</script>"
		Response.End
	End If

	Sql = "INSERT INTO tbl_member("
	Sql = Sql & "m_lang, "
	Sql = Sql & "m_lev, "
	Sql = Sql & "m_sort, "
	Sql = Sql & "m_id, "
	Sql = Sql & "m_pw, "
	Sql = Sql & "m_name, "
	Sql = Sql & "m_nick, "
	Sql = Sql & "m_jumin, "
	Sql = Sql & "m_email, "
	Sql = Sql & "m_mailing, "
	Sql = Sql & "m_tel1, "
	Sql = Sql & "m_tel2, "
	Sql = Sql & "m_tel3, "
	Sql = Sql & "m_cell1, "
	Sql = Sql & "m_cell2, "
	Sql = Sql & "m_cell3, "
	Sql = Sql & "m_fax1, "
	Sql = Sql & "m_fax2, "
	Sql = Sql & "m_fax3, "
	Sql = Sql & "m_zip1, "
	Sql = Sql & "m_zip2, "
	Sql = Sql & "m_addr1, "
	Sql = Sql & "m_addr2, "
	Sql = Sql & "addtext1, "
	Sql = Sql & "addtext2, "
	Sql = Sql & "addtext3, "
	Sql = Sql & "addtext4, "
	Sql = Sql & "addtext5, "
	Sql = Sql & "addtext6, "
	Sql = Sql & "addtext7, "
	Sql = Sql & "addtext8, "
	Sql = Sql & "addtext9, "
	Sql = Sql & "addtext10, "
	Sql = Sql & "addtext11, "
	Sql = Sql & "addtext12, "
	Sql = Sql & "addtext13, "
	Sql = Sql & "addtext14, "
	Sql = Sql & "addtext15, "
	Sql = Sql & "addtext16, "
	Sql = Sql & "addtext17, "
	Sql = Sql & "addtext18, "
	Sql = Sql & "addtext19, "
	Sql = Sql & "addtext20) VALUES("
	Sql = Sql & "N'" & m_lang & "', "
	Sql = Sql & "N'" & m_lev & "', "
	Sql = Sql & "N'" & m_sort & "', "
	Sql = Sql & "N'" & m_id & "', "
	Sql = Sql & "N'" & AESEncrypt(m_pw, "webmoa") & "', "
	Sql = Sql & "N'" & m_name & "', "
	Sql = Sql & "N'" & m_nick & "', "
	Sql = Sql & "N'" & m_jumin & "', "
	Sql = Sql & "N'" & m_email & "', "
	Sql = Sql & "'" & m_mailing & "', "
	Sql = Sql & "N'" & m_tel1 & "', "
	Sql = Sql & "N'" & m_tel2 & "', "
	Sql = Sql & "N'" & m_tel3 & "', "
	Sql = Sql & "N'" & m_cell1 & "', "
	Sql = Sql & "N'" & m_cell2 & "', "
	Sql = Sql & "N'" & m_cell3 & "', "
	Sql = Sql & "N'" & m_fax1 & "', "
	Sql = Sql & "N'" & m_fax2 & "', "
	Sql = Sql & "N'" & m_fax3 & "', "
	Sql = Sql & "N'" & m_zip1 & "', "
	Sql = Sql & "N'" & m_zip2 & "', "
	Sql = Sql & "N'" & m_addr1 & "', "
	Sql = Sql & "N'" & m_addr2 & "', "
	Sql = Sql & "N'" & addtext1 & "', "
	Sql = Sql & "N'" & addtext2 & "', "
	Sql = Sql & "N'" & addtext3 & "', "
	Sql = Sql & "N'" & addtext4 & "', "
	Sql = Sql & "N'" & addtext5 & "', "
	Sql = Sql & "N'" & addtext6 & "', "
	Sql = Sql & "N'" & addtext7 & "', "
	Sql = Sql & "N'" & addtext8 & "', "
	Sql = Sql & "N'" & addtext9 & "', "
	Sql = Sql & "N'" & addtext10 & "', "
	Sql = Sql & "N'" & addtext11 & "', "
	Sql = Sql & "N'" & addtext12 & "', "
	Sql = Sql & "N'" & addtext13 & "', "
	Sql = Sql & "N'" & addtext14 & "', "
	Sql = Sql & "N'" & addtext15 & "', "
	Sql = Sql & "N'" & addtext16 & "', "
	Sql = Sql & "N'" & addtext17 & "', "
	Sql = Sql & "N'" & addtext18 & "', "
	Sql = Sql & "N'" & addtext19 & "', "
	Sql = Sql & "N'" & addtext20 & "')"

	'Response.write sql
	Dbcon.Execute Sql

	rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl

	'회원가입 포인트 적립
	If mc_point_use=True And mc_point_join>0 Then
		Call SetPoint(m_id, "+", mc_point_join, "회원 가입")
	End If

	'회원가입 쿠폰 발급
	If mc_coupon=True Then
		Call SetJoinCouponDownload(m_id)
	End If

	Response.Write "<script>alert('Membership has been complete.'); location.href='" & rturl & "';</script>"
	Response.End


'회원 정보 수정
ElseIf mode="mod_p" Then

	Sql = "UPDATE tbl_member SET "
	Sql = Sql & "m_lev='" & m_lev & "', "
	Sql = Sql & "m_sort=N'" & InsertText(m_sort) & "', "
	If m_pw<>"" Then Sql = Sql & "m_pw=N'" & AESEncrypt(m_pw, "webmoa") & "', "
	Sql = Sql & "m_name=N'" & InsertText(m_name) & "', "
	Sql = Sql & "m_email=N'" & InsertText(m_email) & "', "
	Sql = Sql & "m_mailing='" & InsertText(m_mailing) & "', "
	Sql = Sql & "m_tel1=N'" & InsertText(m_tel1) & "', "
	Sql = Sql & "m_tel2=N'" & InsertText(m_tel2) & "', "
	Sql = Sql & "m_tel3=N'" & InsertText(m_tel3) & "', "
	Sql = Sql & "m_cell1=N'" & InsertText(m_cell1) & "', "
	Sql = Sql & "m_cell2=N'" & InsertText(m_cell2) & "', "
	Sql = Sql & "m_cell3=N'" & InsertText(m_cell3) & "', "
	Sql = Sql & "m_fax1=N'" & InsertText(m_fax1) & "', "
	Sql = Sql & "m_fax2=N'" & InsertText(m_fax2) & "', "
	Sql = Sql & "m_fax3=N'" & InsertText(m_fax3) & "', "
	Sql = Sql & "m_zip1=N'" & InsertText(m_zip1) & "', "
	Sql = Sql & "m_zip2=N'" & InsertText(m_zip2) & "', "
	Sql = Sql & "m_addr1=N'" & InsertText(m_addr1) & "', "
	Sql = Sql & "m_addr2=N'" & InsertText(m_addr2) & "', "
	Sql = Sql & "addtext1=N'" & InsertText(addtext1) & "', "
	Sql = Sql & "addtext2=N'" & InsertText(addtext2) & "', "
	Sql = Sql & "addtext3=N'" & InsertText(addtext3) & "', "
	Sql = Sql & "addtext4=N'" & InsertText(addtext4) & "', "
	Sql = Sql & "addtext5=N'" & InsertText(addtext5) & "', "
	Sql = Sql & "addtext6=N'" & InsertText(addtext6) & "', "
	Sql = Sql & "addtext7=N'" & InsertText(addtext7) & "', "
	Sql = Sql & "addtext8=N'" & InsertText(addtext8) & "', "
	Sql = Sql & "addtext9=N'" & InsertText(addtext9) & "', "
	Sql = Sql & "addtext10=N'" & InsertText(addtext10) & "', "
	Sql = Sql & "addtext11=N'" & InsertText(addtext11) & "', "
	Sql = Sql & "addtext12=N'" & InsertText(addtext12) & "', "
	Sql = Sql & "addtext13=N'" & InsertText(addtext13) & "', "
	Sql = Sql & "addtext14=N'" & InsertText(addtext14) & "', "
	Sql = Sql & "addtext15=N'" & InsertText(addtext15) & "', "
	Sql = Sql & "addtext16=N'" & InsertText(addtext16) & "', "
	Sql = Sql & "addtext17=N'" & InsertText(addtext17) & "', "
	Sql = Sql & "addtext18=N'" & InsertText(addtext18) & "', "
	Sql = Sql & "addtext19=N'" & InsertText(addtext19) & "', "
	Sql = Sql & "addtext20=N'" & InsertText(addtext20) & "', "
	Sql = Sql & "moddate=getdate() WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql


	rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl

	Response.Write "<script>location.href='" & rturl & "';</script>"
	Response.End


'회원 삭제(탈퇴)
ElseIf mode="del_p" Then

	Sql = "DELETE FROM tbl_member WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql

	Response.Cookies("W_ID")=""
	Response.Cookies("W_NAME")=""
	Response.Cookies("W_PW")=""
	Response.Cookies("W_EMAIL")=""
	Response.Cookies("W_LEVEL")=""

	Response.Write "<script>alert('Your withdrawal has been processed.'); location.href='/';</script>"
	Response.End


'로그인
ElseIf mode="login_p" Then

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' AND m_lang='en' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False then
		Response.Cookies("W_ID")=Rs("m_id")
		Response.Cookies("W_NAME")=Rs("m_name")
		Response.Cookies("W_PW")=m_pw
		Response.Cookies("W_EMAIL")=Rs("m_email")
		Response.Cookies("W_LEVEL")=Rs("m_lev")
	Else
		Response.Write "<script>alert('The ID and password are incorrect.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing

	'로그인 횟수 업데이트
	Sql = "UPDATE tbl_member SET m_logcount=m_logcount+1 WHERE m_id='" & m_id & "'"
	Dbcon.Execute Sql


	rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl

	Response.Redirect rturl


'로그아웃
ElseIf mode="logout_p" Then

	Response.Cookies("W_ID")=""
	Response.Cookies("W_NAME")=""
	Response.Cookies("W_PW")=""
	Response.Cookies("W_EMAIL")=""
	Response.Cookies("W_LEVEL")=""
	
	Response.Redirect rturl


'아이디 찾기
ElseIf mode="id_p" Then

	'사용불가 문자 체크
	If disableChar(m_name)=False Or disableChar(m_email)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id FROM tbl_member WHERE m_name='" & m_name & "' AND m_email='" & m_email & "' AND m_lang='en' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		mailTitle = "We will let you know your ID on the " & sc_name & "."
		mailContent = "Hi. We will let you know your ID on " & sc_name & ".<br />Your ID is <b>" & Rs(0) & "</b>. <br />Thank you. "
		mailContent = MailSkin(mailContent)

		MailSendReturnValue = eMailCDOSend (mailContent, mailTitle, sc_email, m_email, "", "")

		Response.Write "<script>alert('Your ID information has been sent by " & m_email & ".'); location.href='" & rturl & "';</script>"
		Response.End
	Else		
		Response.Write "<script>alert('No member exists.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing


'패스워드 찾기
ElseIf mode="pw_p" Then

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_name)=False Or disableChar(m_email)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	'임시비번생성
	m_newpass = Replace(Right(timer(), 5), ".", "")

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id FROM tbl_member WHERE m_name='" & m_name & "' AND m_id='" & m_id & "' AND m_email='" & m_email & "' AND m_lang='en' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		mailTitle = "We will let you know your temporary password on the " & sc_name & "."
		mailContent = "Hi. " & m_name & ".<br />"
		mailContent = mailContent & "Your temporary password is <b>" & m_newpass & "</b>.<br />"
		mailContent = mailContent & "Thank you. "
		mailContent = MailSkin(mailContent)

		Sql = "UPDATE tbl_member SET m_pw='" & AESEncrypt(m_newpass, "webmoa") & "' WHERE m_id='" & m_id & "' "
		Dbcon.Execute Sql

		MailSendReturnValue = eMailCDOSend (mailContent, mailTitle, sc_email, m_email, "", "")

		Response.Write "<script>alert('Your temporary password information has been sent by " & m_email & ".'); location.href='" & rturl & "';</script>"
		Response.End
	Else
		Response.Write "<script>alert('No member exists.'); history.back();</script>"
		Response.End
	End If
	Rs.Close


'카카오/페이스북 로그인
ElseIf mode="sns_login_p" Then

	'첫 로그인인 경우 멤버 인서트
	If IdDuplChk(m_id)=True Then
		Sql = "INSERT INTO tbl_member("
		Sql = Sql & "m_lang, "
		Sql = Sql & "m_lev, "
		Sql = Sql & "m_sort, "
		Sql = Sql & "m_id, "
		Sql = Sql & "m_pw, "
		Sql = Sql & "m_name, "
		Sql = Sql & "m_jumin, "
		Sql = Sql & "m_email, "
		Sql = Sql & "m_mailing) VALUES("
		Sql = Sql & "'" & m_lang & "', "
		Sql = Sql & "'" & m_lev & "', "
		Sql = Sql & "N'" & m_sort & "', "
		Sql = Sql & "N'" & m_id & "', "
		Sql = Sql & "N'" & AESEncrypt(m_pw, "webmoa") & "', "
		Sql = Sql & "N'" & m_name & "', "
		Sql = Sql & "N'" & m_jumin & "', "
		Sql = Sql & "N'" & m_email & "', "
		Sql = Sql & "'" & m_mailing & "')"

		'Response.write sql
		Dbcon.Execute Sql
	End If


	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' AND m_lang='en' "
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
	Sql = "UPDATE tbl_member SET m_logcount=m_logcount+1 WHERE m_id='" & m_id & "'"
	Dbcon.Execute Sql

	Response.Redirect rturl


End If


%>