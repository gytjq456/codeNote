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
Set UploadForm = Server.Createobject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadPath = Server.MapPath("/upload/favicon/")
UploadForm.DefaultPath = UploadPath

'기존 파일 정보 취득
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT favicon FROM tbl_site_config"
Rs.Open Sql, DbCon, 1
If Rs.EOF=False Then
	o_favicon = Rs("favicon")
End If
Rs.Close
Set Rs = Nothing

'이미지 삭제
If UploadForm("favicon_del")="1" then
	If o_favicon<>"" Then
		If o_favicon<>"" Then UploadForm.Deletefile UploadPath & "\" & o_favicon
		Dbcon.Execute "UPDATE tbl_site_config SET favicon=''"
	End If
End If

'이미지 수정
If UploadForm("favicon").FileName<>"" Then
	'기존 파일 삭제
	If o_favicon<>"" Then UploadForm.Deletefile UploadPath & "\" & o_favicon
	favicon = UploadForm("favicon").Save(, False)
	favicon = Mid(favicon, InstrRev(favicon, "\")+1)

	Dbcon.Execute "UPDATE tbl_site_config SET favicon=N'" & favicon & "'"
End If

Response.Write "<script>alert('파비콘이 수정되었습니다.');location.href='favicon.asp';</script>"
%>