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
e_idx = Request("e_idx")
idx = Request("idx")

pLink = "s_keyword=" & s_keyword

Set UploadForm = Server.Createobject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadPath = Server.MapPath("/upload/ebook/")
UploadForm.DefaultPath = UploadPath

'등록
If mode="reg" Then

	e_lev=UploadForm("e_lev")	
	e_file_count = UploadForm("e_file").Count

	For n=1 To e_file_count
		If UploadForm("e_file")(n).FileName<>"" Then
			e_file=UploadForm("e_file")(n).Save(, False)
			e_file = Mid(e_file, InstrRev(e_file, "\")+1)

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & e_file) Then
				thumb = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb\" & e_file, 120, 180, False)
			End If
			Set ObjImage = Nothing

			'db쿼리
			Sql = "INSERT INTO tbl_ebook_img("
			Sql = Sql & "e_idx, "
			Sql = Sql & "e_file, "
			Sql = Sql & "e_lev) VALUES("
			Sql = Sql & "N'" & e_idx & "', "
			Sql = Sql & "N'" & e_file & "', "
			Sql = Sql & "N'" & e_lev & "')"
			'response.write Sql
			Dbcon.Execute Sql

			e_lev=e_lev+10
		End If
	Next

	Response.Redirect "ebook-reg.asp?mode=mod&idx=" & e_idx


'수정
ElseIf mode="mod" Then

	e_lev=UploadForm("e_lev")

	'기존 파일 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_ebook_img WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		o_file = Rs("e_file")
	End If
	Rs.Close
	Set Rs = Nothing

	If UploadForm("e_file").FileName<>"" Then
		'기존 파일 삭제
		If o_file<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file
		If o_file<>"" Then UploadForm.Deletefile UploadPath & "\thumb\" & o_file
		e_file = UploadForm("e_file").Save(, False)
		e_file = Mid(e_file, InstrRev(e_file, "\")+1)

		'썸네일 생성
		Set ObjImage = Server.CreateObject("DEXT.ImageProc")
		If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & e_file) Then
			thumb_s = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb\" & e_file, 120, 180, False)
		End If
		Set ObjImage = Nothing

		Dbcon.Execute "UPDATE tbl_ebook_img SET e_file=N'" & e_file  & "' WHERE idx='" & idx & "'"
	End If

	Sql = "UPDATE tbl_ebook_img SET "
	Sql = Sql & "e_lev=N'" & e_lev & "' "
	Sql = Sql & " WHERE idx='" & idx & "' "
	'response.write Sql
	Dbcon.Execute Sql

	Response.Redirect "ebook-reg.asp?mode=mod&idx=" & e_idx


'삭제
ElseIf mode="del" Then

	'기존 파일 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_ebook_img WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		o_file = Rs("e_file")
	End If
	Rs.Close
	Set Rs = Nothing

	'기존 파일 삭제
	If o_file<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file
	If o_file<>"" Then UploadForm.Deletefile UploadPath & "\thumb\" & o_file

	Sql = "DELETE FROM tbl_ebook_img WHERE idx='" & idx & "';" & Chr(10) & Chr(10)
	Dbcon.Execute Sql

	Response.Redirect "ebook-reg.asp?mode=mod&idx=" & e_idx


End If
%>