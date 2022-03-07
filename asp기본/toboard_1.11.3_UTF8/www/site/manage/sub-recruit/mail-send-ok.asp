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
	mode				= Request("mode")
	
	Set UploadForm = Server.Createobject("DEXT.FileUpload")
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/recruit/")
	UploadForm.DefaultPath = UploadPath
	
	ms_from			= UploadForm("ms_from")
	ms_to				= UploadForm("ms_to")
	ms_subject	= InsertText(UploadForm("ms_subject"))
	ms_content	= InsertText(UploadForm("ms_content"))

	p_file	= UploadForm("p_file").Save(, False)
	p_file	= Mid(p_file, InstrRev(p_file, "\")+1)

	'사이트 기본 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	SQL = "SELECT sc_name, sc_url FROM tbl_site_config "
	Rs.Open SQL, Dbcon, 1
	If Rs.EOF Then
		Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
		Response.End
	Else
		sc_name	= Rs("sc_name")
		sc_url			= Rs("sc_url")
	End If
	Rs.Close

	'선택메일전송
	If mode = "sel_send" Then

		arr_to = Split(ms_to, ", ")

		num = 0
		For Each item In arr_to
			SQL = "SELECT mid, r_name, r_email FROM tbl_resume WHERE idx = '" & item & "' "
			Rs.Open SQL, Dbcon, 1
			m_id			= Rs("mid")
			m_name		= Rs("r_name")
			m_email	= Rs("r_email")

			'{MEM_ID} 받는회원아이디   {MEM_NAME} 받는회원이름   {MEM_EMAIL} 받는회원이름
			'{SITE_NAME} 사이트명   {SITE_URL} 사이트 주소

			ms_content_ch	= Replace(ms_content, "{MEM_ID}", m_id)
			ms_content_ch = Replace(ms_content_ch, "{MEM_NAME}", m_name)
			ms_content_ch = Replace(ms_content_ch, "{MEM_EMAIL}", m_email)
			ms_content_ch = Replace(ms_content_ch, "{SITE_NAME}", sc_name)
			ms_content_ch = Replace(ms_content_ch, "{SITE_URL}", sc_url)

			ms_subject_ch = Replace(ms_subject, "{MEM_ID}", m_id)
			ms_subject_ch = Replace(ms_subject_ch, "{MEM_NAME}", m_name)
			ms_subject_ch = Replace(ms_subject_ch, "{MEM_EMAIL}", m_email)
			ms_subject_ch = Replace(ms_subject_ch, "{SITE_NAME}", sc_name)
			ms_subject_ch = Replace(ms_subject_ch, "{SITE_URL}", sc_url)
			
			'메일 발송
			If m_email <> "" Then
				MailSendReturnValue = eMailCDOSend(ms_content_ch, ms_subject_ch, ms_from, m_email, "/upload/recruit/", p_file)
			End If

			Rs.Close
			num=num+1
		Next

		Response.Write "<script>alert('" & num & "건 전송 완료 되었습니다.'); location.href='application-list.asp';</script>"

	'단체메일전송
	ElseIf mode = "gro_send" Then

		s_keyword	= UploadForm("s_keyword")
		s_srdate		= UploadForm("s_srdate")
		s_erdate	= UploadForm("s_erdate")
		s_mailing	= UploadForm("s_mailing")
		s_sort			= UploadForm("s_sort")

		pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_mailing=" & s_mailing & "&s_sort=" & s_sort

		SQL = "SELECT * FROM tbl_member "
		SQL = SQL & " WHERE idx!='' "
		SQL = SQL & " AND m_lev>=3 "	'관리자를 제외한 회원만 검색

		If s_keyword <> "" Then
			SQL = SQL & " AND (m_name LIKE '%" & s_keyword & "%' "
			SQL = SQL & " OR m_id LIKE '%" & s_keyword & "%' "
			SQL = SQL & " OR m_email LIKE '%" & s_keyword & "%' "
			SQL = SQL & " OR m_addr1 LIKE '%" & s_keyword & "%' "
			SQL = SQL & " OR m_addr2 LIKE '%" & s_keyword & "%') "
		End If

		If s_mailing <> "" Then SQL = SQL & " AND m_mailing='" & s_mailing & "' "
		If s_sort <> "" Then SQL = SQL & " AND m_sort='" & s_sort & "' "

		If s_srdate <> "" And s_erdate <> "" Then SQL = SQL & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "

		Rs.Open SQL, Dbcon, 1

		If Rs.EOF=False Then
			If UploadForm("page") = "" Then
				page = 1
			Else
				page = UploadForm("page")
			End If

			Rs.PageSize = 500
			Rs.AbsolutePage = page
			RecordCount = Rs.RecordCount

			If Rs.RecordCount Mod Rs.PageSize > 0 Then
				maxpage = CInt(RecordCount/Rs.PageSize)+1
			Else
				maxpage = CInt(RecordCount/Rs.PageSize)
			End If
		End If

		If RecordCount<=page*500 Then
			Response.Write ((page-1)*500)+1 & "~" & RecordCount & "번째 회원 발송중"
			tmpbool=False
		Else
			Response.Write ((page-1)*500)+1 & "~" & page*500 & "번째 회원 발송중"
			tmpbool=True
		End If

		k=RecordCount - ((page - 1) * Rs.PageSize) - l 
		Do Until Rs.EOF Or l>=Rs.PageSize
			m_id			= Rs("m_id")
			m_pw			= Rs("m_pw")
			m_name		= Rs("m_name")
			m_email	= Rs("m_email")

			'{MEM_ID} 받는회원아이디   {MEM_NAME} 받는회원이름   {MEM_EMAIL} 받는회원이름
			'{SITE_NAME} 사이트명   {SITE_URL} 사이트 주소

			ms_content_ch = Replace(ms_content, "{MEM_ID}", m_id)
			ms_content_ch = Replace(ms_content_ch, "{MEM_NAME}", m_name)
			ms_content_ch = Replace(ms_content_ch, "{MEM_EMAIL}", m_email)
			ms_content_ch = Replace(ms_content_ch, "{SITE_NAME}", sc_name)
			ms_content_ch = Replace(ms_content_ch, "{SITE_URL}", sc_url)

			ms_subject_ch = Replace(ms_subject, "{MEM_ID}", m_id)
			ms_subject_ch = Replace(ms_subject_ch, "{MEM_NAME}", m_name)
			ms_subject_ch = Replace(ms_subject_ch, "{MEM_EMAIL}", m_email)
			ms_subject_ch = Replace(ms_subject_ch, "{SITE_NAME}", sc_name)
			ms_subject_ch = Replace(ms_subject_ch, "{SITE_URL}", sc_url)
			
			'메일 발송
			If m_email <> "" Then
				'Response.write ms_content_ch & " / " & ms_subject_ch & " / " & ms_from & " / " & m_email & Chr(13) & Chr(10)
				MailSendReturnValue = eMailCDOSend(ms_content_ch, ms_subject_ch, ms_from, m_email, "", "")
			End If

			num = num + 1
			Rs.Movenext
		Loop
		Rs.Close
		Set Rs = Nothing

		If tmpbool=True Then
%>
	<meta http-equiv="refresh" content="5;url=mail-send-ok.asp?mode=gro_send&<%=pLink%>&page=<%=page+1%>">
<%
		Else
			Response.Write "<script>alert('메일 전송 완료 되었습니다.'); location.href='group-mail-send.asp';</script>"
		End If
	
	End If
	Set Rs = Nothing
%>