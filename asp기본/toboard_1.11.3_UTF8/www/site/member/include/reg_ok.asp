<%
m_lang = "kr"

'회원 등록(가입)
If mode="reg_p" Then

	Set UploadForm = Server.Createobject("DEXT.FileUpload")
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/member/")
	UploadForm.DefaultPath = UploadPath

	m_id = InsertText(LCase(UploadForm("m_id")))
	m_pw = InsertText(LCase(UploadForm("m_pw")))
	m_name = InsertText(UploadForm("m_name"))
	m_jumin = InsertText(UploadForm("m_jumin"))
	m_email = InsertText(UploadForm("m_email"))
	m_mailing = UploadForm("m_mailing")
	m_tel1 = UploadForm("m_tel1")
	m_tel2 = UploadForm("m_tel2")
	m_tel3 = UploadForm("m_tel3")
	m_cell1 = UploadForm("m_cell1")
	m_cell2 = UploadForm("m_cell2")
	m_cell3 = UploadForm("m_cell3")
	m_fax1 = UploadForm("m_fax1")
	m_fax2 = UploadForm("m_fax2")
	m_fax3 = UploadForm("m_fax3")
	m_zip1 = UploadForm("m_zip1")
	m_zip2 = UploadForm("m_zip2")
	m_addr1 = InsertText(UploadForm("m_addr1"))
	m_addr2 = InsertText(UploadForm("m_addr2"))
	addtext1 = InsertText(UploadForm("addtext1"))
	addtext2 = InsertText(UploadForm("addtext2"))
	addtext3 = InsertText(UploadForm("addtext3"))
	addtext4 = InsertText(UploadForm("addtext4"))
	addtext5 = InsertText(UploadForm("addtext5"))
	addtext6 = InsertText(UploadForm("addtext6"))
	addtext7 = InsertText(UploadForm("addtext7"))
	addtext8 = InsertText(UploadForm("addtext8"))
	addtext9 = InsertText(UploadForm("addtext9"))
	addtext10 = InsertText(UploadForm("addtext10"))
	addtext11 = InsertText(UploadForm("addtext11"))
	addtext12 = InsertText(UploadForm("addtext12"))
	addtext13 = InsertText(UploadForm("addtext13"))
	addtext14 = InsertText(UploadForm("addtext14"))
	addtext15 = InsertText(UploadForm("addtext15"))
	addtext16 = InsertText(UploadForm("addtext16"))
	addtext17 = InsertText(UploadForm("addtext17"))
	addtext18 = InsertText(UploadForm("addtext18"))
	addtext19 = InsertText(UploadForm("addtext19"))
	addtext20 = InsertText(UploadForm("addtext20"))

	'회원등급 설정
	Set RsL = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member_level WHERE m_default='1' "
	RsL.Open Sql, Dbcon, 1
	If RsL.EOF=False Then
		m_lev = RsL("m_lev")
		m_sort = RsL("m_sort")
	End If
	RsL.Close
	Set RsL = Nothing

	'자동 등록 방지 체크
	If SpamChk(Trim(UploadForm("txtCaptcha")))=False Then
		Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); history.back();</script>"
		Response.End
	End If

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	'아이디 중복체크
	If IdDuplChk(m_id)=False Then
		Response.Write"<script>alert('현재 사용중인 아이디입니다.\n다른 아이디를 입력하세요.'); history.back();</script>"
		Response.End
	End If

	'파일 업로드
	If UploadForm("file1").FileName<>"" Then
		file1=UploadForm("file1").Save(, False)
		file1 = UploadForm("file1").LastSavedFileName
	End If

	'DB 인서트
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
	Sql = Sql & "addtext20, "
	Sql = Sql & "ip, "
	Sql = Sql & "file1) VALUES("
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
	Sql = Sql & "N'" & addtext20 & "', "
	Sql = Sql & "N'" & Request.ServerVariables("REMOTE_HOST") & "', "
	Sql = Sql & "N'" & file1 & "')"

	'Response.write sql
	Dbcon.Execute Sql

	'회원가입 포인트 적립
	If mc_point_use=True And mc_point_join>0 Then
		Call SetPoint(m_id, "+", mc_point_join, "회원 가입")
	End If

	'회원가입 쿠폰 발급
	If mc_coupon=True Then
		Call SetJoinCouponDownload(m_id)
	End If

	Response.Write "<script>alert('회원 가입 완료 되었습니다.'); location.href='/';</script>"
	Response.End


'회원 정보 수정
ElseIf mode="mod_p" Then

	Set UploadForm = Server.Createobject("DEXT.FileUpload")
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/member/")
	UploadForm.DefaultPath = UploadPath

	m_id = InsertText(LCase(UploadForm("m_id")))
	m_pw = InsertText(LCase(UploadForm("m_pw")))
	m_name = InsertText(UploadForm("m_name"))
	m_jumin = InsertText(UploadForm("m_jumin"))
	m_email = InsertText(UploadForm("m_email"))
	m_mailing = UploadForm("m_mailing")
	m_tel1 = UploadForm("m_tel1")
	m_tel2 = UploadForm("m_tel2")
	m_tel3 = UploadForm("m_tel3")
	m_cell1 = UploadForm("m_cell1")
	m_cell2 = UploadForm("m_cell2")
	m_cell3 = UploadForm("m_cell3")
	m_fax1 = UploadForm("m_fax1")
	m_fax2 = UploadForm("m_fax2")
	m_fax3 = UploadForm("m_fax3")
	m_zip1 = UploadForm("m_zip1")
	m_zip2 = UploadForm("m_zip2")
	m_addr1 = InsertText(UploadForm("m_addr1"))
	m_addr2 = InsertText(UploadForm("m_addr2"))
	addtext1 = InsertText(UploadForm("addtext1"))
	addtext2 = InsertText(UploadForm("addtext2"))
	addtext3 = InsertText(UploadForm("addtext3"))
	addtext4 = InsertText(UploadForm("addtext4"))
	addtext5 = InsertText(UploadForm("addtext5"))
	addtext6 = InsertText(UploadForm("addtext6"))
	addtext7 = InsertText(UploadForm("addtext7"))
	addtext8 = InsertText(UploadForm("addtext8"))
	addtext9 = InsertText(UploadForm("addtext9"))
	addtext10 = InsertText(UploadForm("addtext10"))
	addtext11 = InsertText(UploadForm("addtext11"))
	addtext12 = InsertText(UploadForm("addtext12"))
	addtext13 = InsertText(UploadForm("addtext13"))
	addtext14 = InsertText(UploadForm("addtext14"))
	addtext15 = InsertText(UploadForm("addtext15"))
	addtext16 = InsertText(UploadForm("addtext16"))
	addtext17 = InsertText(UploadForm("addtext17"))
	addtext18 = InsertText(UploadForm("addtext18"))
	addtext19 = InsertText(UploadForm("addtext19"))
	addtext20 = InsertText(UploadForm("addtext20"))

	'사용불가 문자 체크
	If disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	'회원 권한 설정
	m_levmxd = UploadForm("m_levmxd")
	If m_levmxd<>"" Then
		a_levmxd = Split(m_levmxd, ":")
		m_lev = a_levmxd(0)
		m_sort = a_levmxd(1)
	End If

	'기존 파일 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		o_file1 = Rs("file1")
	End If
	Rs.Close
	Set Rs = Nothing

	If UploadForm("file1").FileName<>"" Then
		If o_file1<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file1
		o_file1 = UploadForm("file1").Save(, False)
		o_file1 = UploadForm("file1").LastSavedFileName
		Dbcon.Execute "UPDATE tbl_member SET file1=N'" & o_file1  & "' WHERE m_id='" & m_id & "'"
	End If

	'DB업데이트
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
	Sql = Sql & "ip=N'" & Request.ServerVariables("REMOTE_HOST") & "', "
	Sql = Sql & "moddate=getdate() WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('회원 정보가 수정 되었습니다.'); location.href='" & Request.ServerVariables("HTTP_REFERER") & "';</script>"
	Response.End


'회원 삭제(탈퇴)
ElseIf mode="del_p" Then

	m_id = Request("m_id")

	Sql = "DELETE FROM tbl_member WHERE m_id='" & m_id & "' "
	Dbcon.Execute Sql

	If InStr(urlPath, "/site/manage") Then
		rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl
		Response.Write "<script>alert('탈퇴처리 되었습니다.'); location.href='" & rturl & "';</script>"
	Else
		Response.Cookies("W_ID")=""
		Response.Cookies("W_NAME")=""
		Response.Cookies("W_PW")=""
		Response.Cookies("W_EMAIL")=""
		Response.Cookies("W_LEVEL")=""

		Response.Write "<script>alert('탈퇴처리 되었습니다.'); location.href='/';</script>"
	End If
	Response.End


'로그인
ElseIf mode="login_p" Then


	m_id = LCase(Request("m_id"))
	m_pw = LCase(Request("m_pw"))

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_pw)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' AND m_lang='kr' "
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


	rturl = BASE64_DECODE(Request("rturl"))
	If rturl="" Then rturl="/"
	rturl = "http://" & Request.ServerVariables("SERVER_NAME") & rturl

	Response.Redirect rturl


'로그아웃
ElseIf mode="logout_p" Then

	Response.Cookies("W_ID")=""
	Response.Cookies("W_NAME")=""
	Response.Cookies("W_PW")=""
	Response.Cookies("W_EMAIL")=""
	Response.Cookies("W_LEVEL")=""
	
	Response.Redirect "/"


'아이디 찾기
ElseIf mode="id_p" Then

	m_name = InsertText(Request("m_name"))
	m_email = InsertText(Request("m_email"))

	'사용불가 문자 체크
	If disableChar(m_name)=False Or disableChar(m_email)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id FROM tbl_member WHERE m_name='" & m_name & "' AND m_email='" & m_email & "' AND m_lang='kr' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		mailTitle = sc_name & "에서 회원님의 아이디를 알려드립니다."
		mailContent = "안녕하세요. " & sc_name & " 입니다.<br />회원님의 아이디는 <b>" & Rs(0) & "</b> 입니다. <br />감사합니다. "
		mailContent = MailSkin(mailContent)

		MailSendReturnValue = eMailCDOSend (mailContent, mailTitle, sc_email, m_email, "", "")

		Response.Write "<script>alert('회원님의 아이디 정보가 " & m_email & " 메일로 발송되었습니다.'); location.href='/';</script>"
		Response.End
	Else		
		Response.Write "<script>alert('회원이 존재하지 않습니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing


'패스워드 찾기
ElseIf mode="pw_p" Then

	m_name = InsertText(Request("m_name"))
	m_id = InsertText(Request("m_id"))
	m_email = InsertText(Request("m_email"))

	'사용불가 문자 체크
	If disableChar(m_id)=False Or disableChar(m_name)=False Or disableChar(m_email)=False Then
		Response.Write "<script>alert('사용할 수 없는 문자가 있습니다.'); history.back();</script>"
		Response.End
	End If

	'임시비번생성
	m_newpass = Replace(Right(timer(), 5), ".", "")

	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id FROM tbl_member WHERE m_name='" & m_name & "' AND m_id='" & m_id & "' AND m_email='" & m_email & "' AND m_lang='kr' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		mailTitle = sc_name & "에서 회원님의 임시 비밀번호를 알려드립니다."
		mailContent = "안녕하세요. " & sc_name & " 입니다.<br />"
		mailContent = mailContent & "회원님의 임시 비밀번호는 <b>" & m_newpass & "</b> 입니다.<br />"
		mailContent = mailContent & "비밀번호를 변경하셔서 보안에 신경 써 주시길 바랍니다. <br />감사합니다. "
		mailContent = MailSkin(mailContent)

		Sql = "UPDATE tbl_member SET m_pw='" & AESEncrypt(m_newpass, "webmoa") & "' WHERE m_id='" & m_id & "' "
		Dbcon.Execute Sql

		MailSendReturnValue = eMailCDOSend (mailContent, mailTitle, sc_email, m_email, "", "")

		Response.Write "<script>alert('회원님의 임시 비밀번호 정보가 " & m_email & " 메일로 발송되었습니다.'); location.href='/';</script>"
		Response.End
	Else
		Response.Write "<script>alert('회원이 존재하지 않습니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close


'카카오/페이스북 로그인
ElseIf mode="sns_login_p" Then

	'회원등급 설정
	Set RsL = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member_level WHERE m_default='1' "
	RsL.Open Sql, Dbcon, 1
	If RsL.EOF=False Then
		m_lev = RsL("m_lev")
		m_sort = RsL("m_sort")
	End If
	RsL.Close
	Set RsL = Nothing

	m_id = Request("m_id")
	m_pw = Request("m_pw")
	m_name = Request("m_name")
	m_email = Request("m_email")

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

		'회원가입 쿠폰 발급
		If mc_coupon=True Then
			Call SetJoinCouponDownload(m_id)
		End If
	End If


	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT m_id, m_name, m_pw, m_email, m_lev FROM tbl_member WHERE m_id='" & m_id & "' AND m_pw='" & AESEncrypt(m_pw, "webmoa") & "' AND m_out='0' AND m_lang='kr' "
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

	Response.Redirect "/"


End If


%>