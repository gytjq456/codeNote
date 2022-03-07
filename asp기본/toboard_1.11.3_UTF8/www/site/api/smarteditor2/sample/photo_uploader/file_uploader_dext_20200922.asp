<%@CodePage = 65001%>
<!--#include virtual="/site/common/function.asp" -->
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

Set UploadForm = Server.CreateObject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadForm.DefaultPath=Server.MapPath("/upload/smartupload/")

uploadInputBox = UploadForm("uploadInputBox")
callback_func = UploadForm("callback_func")

'이미지 확장자 체크
If UploadImgChk(UploadForm("uploadInputBox").FileName)=False Then
	Response.Write "<script language='javascript'>alert('등록할 수 없는 형식의 파일입니다.'); window.close();</script>"
	Response.End
End If

'mime type 체크
If UploadForm("uploadInputBox").MimeType<>"image/jpeg" And _
UploadForm("uploadInputBox").MimeType<>"image/pjpeg" And _
UploadForm("uploadInputBox").MimeType<>"image/gif" And _
UploadForm("uploadInputBox").MimeType<>"image/png" And _
UploadForm("uploadInputBox").MimeType<>"image/bmp" Then 
	Response.Write "<script language='javascript'>alert('등록할 수 없는 형식의 파일입니다.'); window.close();</script>"
	Response.End
End If

FileName = UploadForm("uploadInputBox").Save(, False)
fileExtension = UploadForm("uploadInputBox").FileExtension
FileName = Mid(FileName, InStrRev(FileName, "\")+1)
FileURL = "/upload/smartupload/" & FileName

Set UploadForm = Nothing

Response.Redirect "callback.html?callback_func=" & callback_func & "&bNewLine=true&sFileName=" & FileName
%>