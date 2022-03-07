<%
p_num = Request("p_num")
com_idx = Request("com_idx")

Set UploadForm = Server.Createobject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadForm.DefaultPath = Server.MapPath(k_uploadfolder)
Uploadform.MaxFileLen =CDbl(1024*1024*20)	'20MB 용량제한

cate				= InsertText(UploadForm("cate"))
mem_name		= InsertText(UploadForm("name"))
mem_id			= W_ID
mem_pw			= UploadForm("pw")
mem_tel			= UploadForm("mem_tel")
mem_fax			= UploadForm("mem_fax")
mem_url			= InsertText(UploadForm("mem_url"))
addtext1			= InsertText(UploadForm("addtext1"))
addtext2			= InsertText(UploadForm("addtext2"))
addtext3			= InsertText(UploadForm("addtext3"))
addtext4			= InsertText(UploadForm("addtext4"))
addtext5			= InsertText(UploadForm("addtext5"))
addtext6			= InsertText(UploadForm("addtext6"))
addtext7			= InsertText(UploadForm("addtext7"))
addtext8			= InsertText(UploadForm("addtext8"))
addtext9			= InsertText(UploadForm("addtext9"))
addtext10			= InsertText(UploadForm("addtext10"))
addtext11			= InsertText(UploadForm("addtext11"))
addtext12			= InsertText(UploadForm("addtext12"))
addtext13			= InsertText(UploadForm("addtext13"))
addtext14			= InsertText(UploadForm("addtext14"))
addtext15			= InsertText(UploadForm("addtext15"))
addtext16			= InsertText(UploadForm("addtext16"))
addtext17			= InsertText(UploadForm("addtext17"))
addtext18			= InsertText(UploadForm("addtext18"))
addtext19			= InsertText(UploadForm("addtext19"))
addtext20			= InsertText(UploadForm("addtext20"))
mem_email		= InsertText(UploadForm("email"))
title				= InsertText(UploadForm("title"))
content			= InsertText(UploadForm("content"))
seo_title				= InsertText(UploadForm("seo_title"))
seo_keyword		= InsertText(UploadForm("seo_keyword"))
seo_description	= InsertText(UploadForm("seo_description"))
html				= UploadForm("html")
lock				= UploadForm("lock")
notice			= UploadForm("notice")
repmail			= UploadForm("repmail")
regdate			= UploadForm("regdate")

'불량단어 필터링
For Each badword In k_filter
	badword = Trim(badword)
	If InStr(content, badword)>0 Then
		'Response.Write "<script language='javascript'>alert('[" & badword & "] 단어는 불량단어로 차단되어있습니다.');</script>"
		title = Replace(title, badword, "♡")
		content = Replace(content, badword, "♡")
	End If
Next


' ##################### 등록 #####################
If mode="reg_p" Then

	'자동 등록 방지 체크
	If Left(Session.SessionID,2)<>UploadForm("ssid") Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');history.back();</script>"
		Response.End
	End If

	'자동 등록 방지 체크2
	If k_spamcode=True Then
		If SpamChk(Trim(UploadForm("txtCaptcha")))=False Then
			Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); location.href='?" & pLink & "&idx=" & idx & "&page=" & page & "';</script>"
			Response.End
		End If
	End If

	ReDim nFile(15)
	For i=1 To 15
		If UploadForm("file" & i).FileName<>"" Then
			'업로드 가능 체크
			If UploadFileChk(UploadForm("file" & i).FileName)=False Then
				Response.Write "<script language='javascript'>alert('등록할 수 없는 파일형식입니다.');history.back();</script>"
				Response.End
			End If

			'20MB 이상 업로드 불가
			If UploadForm("file" & i).FileLen>UploadForm.MaxFileLen Then
				Response.Write "<script language='javascript'>alert('20MB이상의 파일은 업로드 할 수 없습니다.');history.back();</script>"
				Response.End
			End If

			'파일 저장
			nFile(i-1) = UploadForm("file" & i).Save(, False)
			nFile(i-1) = UploadForm("file" & i).LastSavedFileName

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & nFile(i-1)) Then
				thumbsave = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb\" & nFile(i-1), 440, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*440), False)
			End If
			Set ObjImage = Nothing
		End If
	Next

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 num FROM tbl_board_data WHERE board_idx='" & bid & "' ORDER BY num DESC"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=True Then
		num=1
	Else
		num=CInt(Rs(0))+1
	End If
	Rs.Close
	Set Rs = Nothing

	Sql = "INSERT INTO tbl_board_data("
	Sql = Sql & "board_idx, "
	Sql = Sql & "cate, "
	Sql = Sql & "num, "
	Sql = Sql & "p_num, "
	Sql = Sql & "r_num, "
	Sql = Sql & "d_num, "
	Sql = Sql & "mem_name, "
	Sql = Sql & "mem_id, "
	Sql = Sql & "mem_pw, "
	Sql = Sql & "mem_tel, "
	Sql = Sql & "mem_fax, "
	Sql = Sql & "mem_url, "
	Sql = Sql & "mem_email, "
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
	Sql = Sql & "title, "
	Sql = Sql & "content, "
	Sql = Sql & "seo_title, "
	Sql = Sql & "seo_keyword, "
	Sql = Sql & "seo_description, "
	Sql = Sql & "ip, "
	Sql = Sql & "file1, "
	Sql = Sql & "file2, "
	Sql = Sql & "file3, "
	Sql = Sql & "file4, "
	Sql = Sql & "file5, "
	Sql = Sql & "file6, "
	Sql = Sql & "file7, "
	Sql = Sql & "file8, "
	Sql = Sql & "file9, "
	Sql = Sql & "file10, "
	Sql = Sql & "file11, "
	Sql = Sql & "file12, "
	Sql = Sql & "file13, "
	Sql = Sql & "file14, "
	Sql = Sql & "file15, "
	Sql = Sql & "html, "
	Sql = Sql & "notice, "
	Sql = Sql & "repmail, "
	Sql = Sql & "lock, "
	Sql = Sql & "regdate) VALUES("
	Sql = Sql & "'" & bid & "',"
	Sql = Sql & "N'" & cate & "',"
	Sql = Sql & "'" & num & "',"
	Sql = Sql & "'" & num & "',"
	Sql = Sql & "'" & "0',"
	Sql = Sql & "'" & "0',"
	Sql = Sql & "N'" & mem_name & "',"
	Sql = Sql & "N'" & mem_id & "',"
	Sql = Sql & "N'" & AESEncrypt(mem_pw, "webmoa") & "',"
	Sql = Sql & "N'" & mem_tel & "',"
	Sql = Sql & "N'" & mem_fax & "',"
	Sql = Sql & "N'" & mem_url & "',"
	Sql = Sql & "N'" & mem_email & "',"
	Sql = Sql & "N'" & addtext1 & "',"
	Sql = Sql & "N'" & addtext2 & "',"
	Sql = Sql & "N'" & addtext3 & "',"
	Sql = Sql & "N'" & addtext4 & "',"
	Sql = Sql & "N'" & addtext5 & "',"
	Sql = Sql & "N'" & addtext6 & "',"
	Sql = Sql & "N'" & addtext7 & "',"
	Sql = Sql & "N'" & addtext8 & "',"
	Sql = Sql & "N'" & addtext9 & "',"
	Sql = Sql & "N'" & addtext10 & "',"
	Sql = Sql & "N'" & addtext11 & "',"
	Sql = Sql & "N'" & addtext12 & "',"
	Sql = Sql & "N'" & addtext13 & "',"
	Sql = Sql & "N'" & addtext14 & "',"
	Sql = Sql & "N'" & addtext15 & "',"
	Sql = Sql & "N'" & addtext16 & "',"
	Sql = Sql & "N'" & addtext17 & "',"
	Sql = Sql & "N'" & addtext18 & "',"
	Sql = Sql & "N'" & addtext19 & "',"
	Sql = Sql & "N'" & addtext20 & "',"
	Sql = Sql & "N'" & title & "',"
	Sql = Sql & "N'" & content & "',"
	Sql = Sql & "N'" & seo_title & "',"
	Sql = Sql & "N'" & seo_keyword & "',"
	Sql = Sql & "N'" & seo_description & "',"
	Sql = Sql & "'" & Request.ServerVariables("REMOTE_HOST") & "',"
	Sql = Sql & "N'" & InsertText(nFile(0)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(1)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(2)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(3)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(4)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(5)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(6)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(7)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(8)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(9)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(10)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(11)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(12)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(13)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(14)) & "',"
	Sql = Sql & "'" & html & "',"
	Sql = Sql & "'" & notice & "',"
	Sql = Sql & "'" & repmail & "',"
	Sql = Sql & "'" & lock & "',"
	If regdate<>"" Then
		Sql = Sql & "'" & regdate & "')"
	Else
		Sql = Sql & "getdate())"
	End If

	'Response.Write Sql
	DbCon.Execute Sql


	'새 게시물 등록 알림 메일 
	If k_regmail=True And sc_email<>"" Then
		Sendto = sc_email
		Sendfrom= sc_email
		mail_subject = "[" & sc_name& "] " & k_id & "에 새 게시물이 등록되었습니다."
		mail_content = "* 이름 : " & mem_name & "<br />"
		mail_content = mail_content & "* 연락처 : " & mem_tel & "<br />"
		mail_content = mail_content & "* 이메일 : " & mem_email & "<br />"
		mail_content = mail_content & "* 제목 : " & title & "<br />"
		mail_content = mail_content & content
		mail_content = MailSkin(mail_content)
		MailSendReturnValue = eMailCDOSend(mail_content, mail_subject, Sendfrom, Sendto, "", "")
	End If


	'새 게시물 등록 알림 SMS전송
	If k_regsms=True And sc_tel<>"" Then
		sms_from = sc_tel
		sms_to = sc_tel
		If k_counsel=True Then alert_txt = "접수 완료 되었습니다."
		Call SendSMS(sms_from, sms_to, "[" & sc_name& "] " & k_id & " - 새 글 등록 확인", alert_txt, "http://" & Request.ServerVariables("SERVER_NAME") & urlPath & "?" & pLink & "&idx=" & idx & "&page=" & page)
	Else		
		Response.Write "<script language='javascript'>"
		If k_counsel=True Then
			If InStr(urlPath, "/en") Then
				Response.Write "alert('Your inquiry has been submitted successfully.');"
			Else
				Response.Write "alert('접수 완료 되었습니다.');"
			End If
		End If
		Response.Write "location.href='?" & pLink & "&idx=" & idx & "&page=" & page & "';"
		Response.Write "</script>"
	End If

	Response.End


' ##################### 수정 #####################
ElseIf mode="mod_p" Then

	'자동 등록 방지 체크
	If Left(Session.SessionID,2)<>UploadForm("ssid") Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');history.back();</script>"
		Response.End
	End If

	'자동 등록 방지 체크2
	If k_spamcode=True Then
		If SpamChk(Trim(UploadForm("txtCaptcha")))=False Then
			Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); location.href='?" & pLink & "&idx=" & idx & "&page=" & page & "';</script>"
			Response.End
		End If
	End If

	ReDim nFile(15), RsUpfile(15)
	Set RsF = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_board_data WHERE idx='" & idx & "'"
	RsF.Open Sql, DbCon, 1
		RsMemId = RsF("mem_id")
		RsMemPw = RsF("mem_pw")
		For fc=1 To 15
			RsUpfile(fc-1) = RsF("file" & fc)
		Next
	RsF.Close
	Set RsF = Nothing

	Sql = ""
	If (RsMemId<>"" And RsMemId=W_ID) Or RsMemPw=AESEncrypt(mem_pw, "webmoa") Then
		'첨부파일 삭제
		For i=1 To 15
			If UploadForm("file" & i & "_del")="1" then
				If RsUpfile(i-1)<>"" Then
					UploadForm.Deletefile UploadForm.DefaultPath & "\" & RsUpfile(i-1)
					UploadForm.Deletefile UploadForm.DefaultPath & "\thumb\" & RsUpfile(i-1)
					Sql = "UPDATE tbl_board_data SET file" & i & "='' WHERE idx='" & idx & "'" & Chr(10) & Chr(13)
					DbCon.Execute Sql
				End If
			End If
		Next

		'첨부파일 수정
		For i=1 To 15
			If UploadForm("file" & i).FileName<>"" Then

				'업로드 가능 체크
				If UploadFileChk(UploadForm("file" & i).FileName)=False Then
					Response.Write "<script language='javascript'>alert('등록할 수 없는 파일형식입니다.');history.back();</script>"
					Response.End
				End If

				'20MB 이상 업로드 불가
				If UploadForm("file" & i).FileLen>UploadForm.MaxFileLen Then
					Response.Write "<script language='javascript'>alert('20MB이상의 파일은 업로드 할 수 없습니다.');history.back();</script>"
					Response.End
				End If

				'기존파일 삭제
				If RsUpfile(i-1)<>"" Then
					UploadForm.Deletefile UploadForm.DefaultPath & "\" & RsUpfile(i-1)
					UploadForm.Deletefile UploadForm.DefaultPath & "\thumb\" & RsUpfile(i-1)
				End If

				'파일 저장
				nFile(i-1) = UploadForm("file" & i).Save(, False)
				nFile(i-1) = UploadForm("file" & i).LastSavedFileName

				'썸네일 생성
				Set ObjImage = Server.CreateObject("DEXT.ImageProc")
				If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & nFile(i-1)) Then
					thumbsave = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb\" & nFile(i-1), 440, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*440), False)
				End If
				Set ObjImage = Nothing

				Sql = "UPDATE tbl_board_data SET file" & i & "='" & InsertText(nFile(i-1)) & "' WHERE board_idx='" & bid & "' AND idx='" & idx & "'" & Chr(10) & Chr(13)
				DbCon.Execute Sql
			End If
		Next

		'DB수정
		Sql = Sql & "UPDATE tbl_board_data SET "
		Sql = Sql & "cate=N'" & cate & "', "
		Sql = Sql & "mem_name=N'" & mem_name & "', "
		Sql = Sql & "mem_tel=N'" & mem_tel & "', "
		Sql = Sql & "mem_fax=N'" & mem_fax & "', "
		Sql = Sql & "mem_url=N'" & mem_url & "', "
		Sql = Sql & "mem_email=N'" & mem_email & "', "
		Sql = Sql & "addtext1=N'" & addtext1 & "', "
		Sql = Sql & "addtext2=N'" & addtext2 & "', "
		Sql = Sql & "addtext3=N'" & addtext3 & "', "
		Sql = Sql & "addtext4=N'" & addtext4 & "', "
		Sql = Sql & "addtext5=N'" & addtext5 & "', "
		Sql = Sql & "addtext6=N'" & addtext6 & "', "
		Sql = Sql & "addtext7=N'" & addtext7 & "', "
		Sql = Sql & "addtext8=N'" & addtext8 & "', "
		Sql = Sql & "addtext9=N'" & addtext9 & "', "
		Sql = Sql & "addtext10=N'" & addtext10 & "', "
		Sql = Sql & "addtext11=N'" & addtext11 & "', "
		Sql = Sql & "addtext12=N'" & addtext12 & "', "
		Sql = Sql & "addtext13=N'" & addtext13 & "', "
		Sql = Sql & "addtext14=N'" & addtext14 & "', "
		Sql = Sql & "addtext15=N'" & addtext15 & "', "
		Sql = Sql & "addtext16=N'" & addtext16 & "', "
		Sql = Sql & "addtext17=N'" & addtext17 & "', "
		Sql = Sql & "addtext18=N'" & addtext18 & "', "
		Sql = Sql & "addtext19=N'" & addtext19 & "', "
		Sql = Sql & "addtext20=N'" & addtext20 & "', "
		If regdate<>"" Then Sql = Sql & "regdate='" & regdate & "', "
		Sql = Sql & "title=N'" & title & "', "
		Sql = Sql & "content=N'" & content & "', "
		Sql = Sql & "seo_title=N'" & seo_title & "', "
		Sql = Sql & "seo_keyword=N'" & seo_keyword & "', "
		Sql = Sql & "seo_description=N'" & seo_description & "', "
		Sql = Sql & "html='" & html & "', "
		Sql = Sql & "notice='" & notice & "', "
		Sql = Sql & "repmail='" & repmail & "', "
		Sql = Sql & "lock='" & lock & "' "
		Sql = Sql & " WHERE idx='" & idx & "'"

		DbCon.Execute Sql

		Response.Write "<script language='javascript'>location.href='?" & pLink & "&mode=list&idx=" & idx & "&page=" & page & "';</script>"

	Else
		Response.Write "<script language='javascript'>alert('게시물 수정 권한이 없습니다.');history.back();</script>"
	End If

	Response.End


' ##################### 답변 #####################
ElseIf mode="rep_p" Then

	'자동 등록 방지 체크
	If left(Session.SessionID,2)<>UploadForm("ssid") Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');history.back();</script>"
		Response.End
	End If

	'자동 등록 방지 체크2
	If k_spamcode=True Then
		If SpamChk(Trim(UploadForm("txtCaptcha")))=False Then
			Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); location.href='?" & pLink & "&idx=" & idx & "&page=" & page & "';</script>"
			Response.End
		End If
	End If

	ReDim nFile(15)
	For i=1 To 15
		If UploadForm("file" & i).FileName<>"" Then
			If UploadFileChk(UploadForm("file" & i).FileName)=False Then
				Response.Write "<script language='javascript'>alert('등록할 수 없는 파일형식입니다.');history.back();</script>"
				Response.End
			End If

			'20MB 이상 업로드 불가
			If UploadForm("file" & i).FileLen>UploadForm.MaxFileLen Then
				Response.Write "<script language='javascript'>alert('20MB이상의 파일은 업로드 할 수 없습니다.');history.back();</script>"
				Response.End
			End If

			'파일 저장
			nFile(i-1) = UploadForm("file" & i).Save(, False)
			nFile(i-1) = UploadForm("file" & i).LastSavedFileName

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & nFile(i-1)) Then
				thumbsave = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb\" & nFile(i-1), 440, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*440), False)
			End If
			Set ObjImage = Nothing
		End If
	Next

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT num, p_num, d_num, r_num, mem_email, mem_tel, repmail FROM tbl_board_data WHERE board_idx='" & bid & "' AND idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		p_num = Rs("p_num")
		d_num = Rs("d_num") + 1
		r_num = Rs("r_num") + 1
		rep_mail = Rs("repmail")
		rep_mem_email = Rs("mem_email")
		rep_tel = Rs("mem_tel")
		Sql = "UPDATE tbl_board_data SET r_num=r_num+1 WHERE p_num='" & p_num & "' AND r_num>'" & Rs("r_num") & "' AND board_idx='" & bid & "'" & Chr(10) & Chr(13)
	Else
		Response.Write "<script language='javascript'>alert('알 수 없는 오류입니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing

	Sql = Sql & "INSERT INTO tbl_board_data("
	Sql = Sql & "board_idx, "
	Sql = Sql & "cate, "
	Sql = Sql & "num, "
	Sql = Sql & "p_num, "
	Sql = Sql & "r_num, "
	Sql = Sql & "d_num, "
	Sql = Sql & "mem_name, "
	Sql = Sql & "mem_id, "
	Sql = Sql & "mem_pw, "
	Sql = Sql & "mem_tel, "
	Sql = Sql & "mem_fax, "
	Sql = Sql & "mem_url, "
	Sql = Sql & "mem_email, "
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
	Sql = Sql & "title, "
	Sql = Sql & "content, "
	Sql = Sql & "seo_title, "
	Sql = Sql & "seo_keyword, "
	Sql = Sql & "seo_description, "
	Sql = Sql & "ip, "
	Sql = Sql & "file1, "
	Sql = Sql & "file2, "
	Sql = Sql & "file3, "
	Sql = Sql & "file4, "
	Sql = Sql & "file5, "
	Sql = Sql & "file6, "
	Sql = Sql & "file7, "
	Sql = Sql & "file8, "
	Sql = Sql & "file9, "
	Sql = Sql & "file10, "
	Sql = Sql & "file11, "
	Sql = Sql & "file12, "
	Sql = Sql & "file13, "
	Sql = Sql & "file14, "
	Sql = Sql & "file15, "
	Sql = Sql & "html, "
	Sql = Sql & "notice, "
	Sql = Sql & "lock) VALUES("
	Sql = Sql & "'" & bid & "',"
	Sql = Sql & "'" & cate & "',"
	Sql = Sql & "'" & num & "',"
	Sql = Sql & "'" & p_num & "',"
	Sql = Sql & "'" & r_num & "',"
	Sql = Sql & "'" & d_num & "',"
	Sql = Sql & "N'" & mem_name & "',"
	Sql = Sql & "N'" & mem_id & "',"
	Sql = Sql & "N'" & AESEncrypt(mem_pw, "webmoa") & "',"
	Sql = Sql & "N'" & mem_tel & "',"
	Sql = Sql & "N'" & mem_fax & "',"
	Sql = Sql & "N'" & mem_url & "',"
	Sql = Sql & "N'" & mem_email & "',"
	Sql = Sql & "N'" & addtext1 & "',"
	Sql = Sql & "N'" & addtext2 & "',"
	Sql = Sql & "N'" & addtext3 & "',"
	Sql = Sql & "N'" & addtext4 & "',"
	Sql = Sql & "N'" & addtext5 & "',"
	Sql = Sql & "N'" & addtext6 & "',"
	Sql = Sql & "N'" & addtext7 & "',"
	Sql = Sql & "N'" & addtext8 & "',"
	Sql = Sql & "N'" & addtext9 & "',"
	Sql = Sql & "N'" & addtext10 & "',"
	Sql = Sql & "N'" & addtext11 & "',"
	Sql = Sql & "N'" & addtext12 & "',"
	Sql = Sql & "N'" & addtext13 & "',"
	Sql = Sql & "N'" & addtext14 & "',"
	Sql = Sql & "N'" & addtext15 & "',"
	Sql = Sql & "N'" & addtext16 & "',"
	Sql = Sql & "N'" & addtext17 & "',"
	Sql = Sql & "N'" & addtext18 & "',"
	Sql = Sql & "N'" & addtext19 & "',"
	Sql = Sql & "N'" & addtext20 & "',"
	Sql = Sql & "N'" & title & "',"
	Sql = Sql & "N'" & content & "',"
	Sql = Sql & "N'" & seo_title & "',"
	Sql = Sql & "N'" & seo_keyword & "',"
	Sql = Sql & "N'" & seo_description & "',"
	Sql = Sql & "'" & Request.ServerVariables("REMOTE_HOST") & "',"
	Sql = Sql & "N'" & InsertText(nFile(0)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(1)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(2)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(3)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(4)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(5)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(6)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(7)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(8)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(9)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(10)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(11)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(12)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(13)) & "',"
	Sql = Sql & "N'" & InsertText(nFile(14)) & "',"
	Sql = Sql & "'" & html & "',"
	Sql = Sql & "'" & notice & "',"
	Sql = Sql & "'" & lock & "')"

	DbCon.Execute Sql

	'답변 메일 발송
	If mem_name<>"" And mem_email<>"" And rep_mem_email<>"" And rep_mail=True Then
		Sendto = rep_mem_email
		Sendfrom= mem_name & "<" & mem_email & ">"
		mail_subject = "[Re]" & title
		mail_content = Replace(content, Chr(13), "<br>")
		MailSendReturnValue = eMailCDOSend(mail_content, mail_subject, Sendfrom, Sendto, "", "")
	End If

	'답변 SMS전송
	If k_regsms=True And sc_tel<>"" Then
		sms_from = sc_tel
		sms_to = rep_tel
		Call SendSMS(sms_from, sms_to, "[" & sc_name& "] " & k_id & " - 답변이 등록 되었습니다.", "", "http://" & Request.ServerVariables("SERVER_NAME") & urlPath & "?" & pLink & "&idx=" & idx & "&page=" & page)
	Else		
		Response.Write "<script language='javascript'>"
		Response.Write "location.href='?" & pLink & "&idx=" & idx & "&page=" & page & "';"
		Response.Write "</script>"
	End If

	Response.End


' ##################### 삭제 #####################
ElseIf mode="del_p" Then

	ReDim RsUpfile(15)
	Set RsF = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_board_data WHERE idx='" & idx & "'"
	RsF.Open Sql, DbCon, 1
		RsMemId = RsF("mem_id")
		RsMemPw = RsF("mem_pw")
		For fc=1 To 15
			RsUpfile(fc-1) = RsF("file" & fc)
		Next
	RsF.Close
	Set RsF = Nothing

	If (RsMemId<>"" And RsMemId=W_ID) Or RsMemPw=AESEncrypt(mem_pw, "webmoa") Then

		For i=1 To 15
			'기존파일 삭제
			If RsUpfile(i-1)<>"" Then
				UploadForm.Deletefile UploadForm.DefaultPath & "\" & RsUpfile(i-1)
				UploadForm.Deletefile UploadForm.DefaultPath & "\thumb\" & RsUpfile(i-1)
			End If
		Next

		'게시물 DB del
		Sql = "DELETE FROM tbl_board_data WHERE board_idx='" & bid & "' and idx='" & idx & "'" & Chr(10) & Chr(13)
		'코멘트 DB del
		Sql = Sql & "DELETE FROM tbl_board_comment WHERE board_idx='" & bid & "' and dat_idx='" & idx & "'"
		DbCon.Execute Sql

		Response.Write "<script language='javascript'>location.href='?" & pLink & "&mode=list&idx=" & idx & "&page=" & page & "';</script>"
		Response.End

	Else

		Response.Write "<script language='javascript'>alert('게시물 삭제 권한이 없습니다.');history.back();</script>"
		Response.End

	End If


' ##################### 덧글등록 #####################
ElseIf mode="comment_reg_p" Then

	'자동 등록 방지 체크2
	If k_spamcode=True Then
		If SpamChk(Trim(UploadForm("txtCaptcha")))=False Then
			Response.Write "<script language='javascript'>alert('자동 등록 방지가 잘못 입력되었습니다.'); location.href='?" & pLink & "&mode=view&idx=" & idx & "&page=" & page & "';</script>"
			Response.End
		End If
	End If

	Sql = "INSERT INTO tbl_board_comment("
	Sql = Sql & "board_idx, "
	Sql = Sql & "dat_idx, "
	Sql = Sql & "mem_name, "
	Sql = Sql & "mem_id, "
	Sql = Sql & "mem_pw, "
	Sql = Sql & "content, "
	Sql = Sql & "ip) VALUES("
	Sql = Sql & "'" & bid & "',"
	Sql = Sql & "'" & idx & "',"
	Sql = Sql & "N'" & mem_name & "',"
	Sql = Sql & "N'" & mem_id & "',"
	Sql = Sql & "N'" & AESEncrypt(mem_pw, "webmoa") & "',"
	Sql = Sql & "N'" & content & "',"
	Sql = Sql & "'" & Request.ServerVariables("REMOTE_HOST") & "')"
	'Response.Write Sql
	DbCon.Execute Sql

	'덧글 카운트 업데이트
	Sql = "UPDATE tbl_board_data SET comment_count=comment_count+1 WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script language='javascript'>location.href='?" & pLink & "&mode=view&idx=" & idx & "&page=" & page & "';</script>"
	Response.End


' ##################### 덧글삭제 #####################
ElseIf mode="comment_del_p" Then

	Set RsComment = DbCon.Execute("SELECT mem_id, mem_pw FROM tbl_board_comment WHERE board_idx='" & bid & "' and dat_idx='" & idx & "' and idx='" & com_idx & "'", , 1)
		RsMemId = RsComment(0)
		RsMemPw = RsComment(1)
	RsComment.Close
	Set RsComment = Nothing

	If (RsMemId<>"" And RsMemId=W_ID) Or RsMemPw=AESEncrypt(mem_pw, "webmoa") Then
		DbCon.Execute "DELETE FROM tbl_board_comment WHERE board_idx='" & bid & "' and dat_idx='" & idx & "' and idx='" & com_idx & "'"

		'덧글 카운트 업데이트
		Sql = "UPDATE tbl_board_data SET comment_count=comment_count-1 WHERE idx='" & idx & "' "
		Dbcon.Execute Sql

		Response.Write "<script language='javascript'>location.href='?" & pLink & "&mode=view&idx=" & idx & "&page=" & page & "';</script>"
		Response.end
	Else
		Response.Write "<script language='javascript'>alert('덧글을 삭제할 권한이 없습니다.');history.back();</script>"
		Response.end
	End If


' ##################### 선택삭제 #####################
ElseIf mode="seldel_p" Then

	ArrIdx = Split(UploadForm("delidx"), ", ")

	If UploadForm("delidx")="" Then
		Response.Write "<script language='javascript'>alert('삭제할 대상이 지정되지 않았습니다.');history.back();</script>"
		Response.End
	End If

	ReDim RsUpfile(15)
	For Each b In ArrIdx

		Set RsF = Server.Createobject("ADODB.Recordset")
		Sql = "SELECT * FROM tbl_board_data WHERE idx='" & b & "'"
		RsF.Open Sql, DbCon, 1
			RsMemId = RsF("mem_id")
			RsMemPw = RsF("mem_pw")
			For fc=1 To 15
				RsUpfile(fc-1) = RsF("file" & fc)
			Next
		RsF.Close
		Set RsF = Nothing

		For i=1 To 5
			If RsUpfile(i-1)<>"" Then UploadForm.Deletefile UploadForm.DefaultPath & "\" & RsUpfile(i-1)
		Next

		'게시물 DB del
		Sql = "DELETE FROM tbl_board_data WHERE board_idx='" & bid & "' and idx='" & b & "'" & Chr(10) & Chr(13)

		'코멘트 DB del
		Sql = Sql & "DELETE FROM tbl_board_comment WHERE board_idx='" & bid & "' and dat_idx='" & b & "'"
		DbCon.Execute Sql

	Next

	Response.Write "<script language='javascript'>location.href='?" & pLink & "&page=" & page & "&mode=list';</script>"
	Response.End

End If
%>

