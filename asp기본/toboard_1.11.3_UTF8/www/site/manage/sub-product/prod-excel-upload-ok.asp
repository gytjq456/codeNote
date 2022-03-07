<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
On Error Resume Next

Set UploadForm = Server.Createobject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadPath = Server.MapPath("/upload/prod/")
UploadForm.DefaultPath = UploadPath

p_file_type = UploadForm("p_file").MimeType

If p_file_type = "application/vnd.ms-excel" Or p_file_type = "application/octet-stream" Then 
	p_file = UploadForm("p_file").Save(, False)
	p_file_name = Mid(p_file, InstrRev(p_file, "\")+1)

	xlsFile = UploadPath & "\" & p_file_name

	Set XlsConn = Server.CreateObject("ADODB.Connection")
	XlsConn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & xlsFile & "; Extended Properties=Excel 8.0;"

	Set Rs = Server.CreateObject("ADODB.Recordset")	
	strSQL = "SELECT TOP 5000 * FROM [Sheet1$]"
	Rs.Open strSQL, XlsConn, 1, , 1
	num=1
	Do Until Rs.EOF
		Sql = "INSERT INTO tbl_prod("
		Sql = Sql & "p_name, "
		Sql = Sql & "p_cate, "
		Sql = Sql & "p_code, "
		Sql = Sql & "p_memo, "
		Sql = Sql & "p_item1, "
		Sql = Sql & "p_item_text1, "
		Sql = Sql & "p_item2, "
		Sql = Sql & "p_item_text2, "
		Sql = Sql & "p_item3, "
		Sql = Sql & "p_item_text3, "
		Sql = Sql & "p_item4, "
		Sql = Sql & "p_item_text4, "
		Sql = Sql & "p_item5, "
		Sql = Sql & "p_item_text5, "
		Sql = Sql & "p_item6, "
		Sql = Sql & "p_item_text6, "
		Sql = Sql & "p_item7, "
		Sql = Sql & "p_item_text7, "
		Sql = Sql & "p_item8, "
		Sql = Sql & "p_item_text8, "
		Sql = Sql & "p_item9, "
		Sql = Sql & "p_item_text9, "
		Sql = Sql & "p_item10, "
		Sql = Sql & "p_item_text10, "
		Sql = Sql & "p_content1, "
		Sql = Sql & "p_content2, "
		Sql = Sql & "p_content3, "
		Sql = Sql & "p_content4, "
		Sql = Sql & "p_content5, "
		Sql = Sql & "p_content6, "
		Sql = Sql & "p_image1, "
		Sql = Sql & "p_image2, "
		Sql = Sql & "p_image3, "
		Sql = Sql & "p_image4, "
		Sql = Sql & "p_image5, "
		Sql = Sql & "p_image6, "
		Sql = Sql & "p_image7, "
		Sql = Sql & "p_image8, "
		Sql = Sql & "p_file1, "
		Sql = Sql & "p_file2, "
		Sql = Sql & "p_file3, "
		Sql = Sql & "p_file4, "
		Sql = Sql & "p_file5, "
		Sql = Sql & "p_file6, "
		Sql = Sql & "p_price, "
		Sql = Sql & "p_lev, "
		Sql = Sql & "p_hit, "
		Sql = Sql & "head_title, "
		Sql = Sql & "meta_keywords, "
		Sql = Sql & "meta_description, "
		Sql = Sql & "p_hide) VALUES("
		For i=0 To 49
			Sql = Sql & "N'" & Rs(i) & "', "
		Next
		If Rs(50)="o" Then
			Sql = Sql & "1);" & Chr(13) & Chr(10)
		Else
			Sql = Sql & "0);" & Chr(13) & Chr(10)
		End If
		Dbcon.Execute Sql
		Response.Write num & " : " & Rs(0) & "<br />"  & Chr(13) & Chr(10)
		Response.Flush
		num=num+1
		Rs.MoveNext
	Loop

	Rs.Close
	Set Rs = Nothing
	Set XlsConn = Nothing

	'파일 삭제
	Set FSO = CreateObject("Scripting.FileSystemObject")
	If(FSO.FileExists(xlsFile)) Then FSO.DeleteFile(xlsFile)
	Set FSO = Nothing

	Response.Write "<script language='javascript'>alert('" & num-1 & "건 업로드 완료'); location.href='prod-excel-upload.asp'</script>"

Else 
	Set UploadForm = Nothing
	Response.Write "<script language='javascript'>alert('xls 파일만 업로드 가능합니다.'); history.back();</script>"
End If
%>