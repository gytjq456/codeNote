<%@CodePage = 65001%>
<%
'이미지 파일 체크
Function UploadImgChk(filename)
	If filename<>"" Then
		If (Right(LCase(filename),3)="jpg" Or _
		Right(LCase(filename),3)="gif" Or _
		Right(LCase(filename),3)="png" Or _
		Right(LCase(filename),3)="bmp" Or _
		Right(LCase(filename),4)="jpeg") And _
		InStr(filename, "%")=0 And _
		InStr(filename, "?")=0 And _
		InStr(filename, ";")=0 Then
			UploadImgChk=True
		Else
			UploadImgChk=False
		End If
	Else
		UploadImgChk=False
	End If
End Function

'회원만 이미지 첨부 가능
If Request.Cookies("W_ID")="" Then
	Response.Write "<script language='javascript'>alert('업로드 오류[1]'); window.close();</script>"
	Response.End
End If

Set UploadForm = Server.CreateObject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadForm.DefaultPath=Server.MapPath("/upload/smartupload/")

uploadInputBox = UploadForm("uploadInputBox")
callback_func = UploadForm("callback_func")

'파일명 확장자 체크
If UploadImgChk(UploadForm("uploadInputBox").FileName)=False Then
	Response.Write "<script language='javascript'>alert('업로드 오류[2]'); window.close();</script>"
	Response.End
End If

'mime type 체크
If UploadForm("uploadInputBox").MimeType<>"image/jpeg" And _
UploadForm("uploadInputBox").MimeType<>"image/pjpeg" And _
UploadForm("uploadInputBox").MimeType<>"image/gif" And _
UploadForm("uploadInputBox").MimeType<>"image/png" And _
UploadForm("uploadInputBox").MimeType<>"image/bmp" Then 
	Response.Write "<script language='javascript'>alert('업로드 오류[3]'); window.close();</script>"
	Response.End
End If

'유니크한 파일명으로 저장
sDate = Hour(Now()) & Minute(Now()) & Second(Now())
fileExtension = UploadForm("uploadInputBox").FileExtension
FileName = UploadForm("uploadInputBox").SaveAs(sDate & "_" & Session.Sessionid & "." & fileExtension, False)
FileName = Mid(FileName, InStrRev(FileName, "\")+1)
FileURL = "/upload/smartupload/" & FileName

Set UploadForm = Nothing

Response.Redirect "callback.html?callback_func=" & callback_func & "&bNewLine=true&sFileName=" & FileName
%>