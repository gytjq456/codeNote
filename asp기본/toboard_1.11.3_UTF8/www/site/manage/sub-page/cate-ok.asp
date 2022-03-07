<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")

'카테고리 등록
If mode="reg" Then

	Set UploadForm = Server.Createobject("DEXT.FileUpload") 
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/cate/")
	UploadForm.DefaultPath = UploadPath

	c_code = UploadForm("c_code")
	c_lang = UploadForm("c_lang")
	c_depth = UploadForm("c_depth")
	c_name = InsertText(UploadForm("c_name"))
	c_hide = UploadForm("c_hide")
	c_lev = UploadForm("c_lev")

	c_image = UploadForm("c_image").Save(, False)

	Sql = "INSERT INTO tbl_page_cate("
	Sql = Sql & "c_lang, "
	Sql = Sql & "c_code, "
	Sql = Sql & "c_depth, "
	Sql = Sql & "c_name, "
	Sql = Sql & "c_image, "
	Sql = Sql & "c_hide, "
	Sql = Sql & "c_lev) VALUES("
	Sql = Sql & "'" & c_lang & "', "
	Sql = Sql & "'" & c_code & "', "
	Sql = Sql & "'" & c_depth & "', "
	Sql = Sql & "N'" & c_name & "', "
	Sql = Sql & "N'" & Mid(c_image, InstrRev(c_image, "\")+1) & "', "
	Sql = Sql & "'" & c_hide & "', "
	Sql = Sql & "'" & c_lev & "')"

	Dbcon.Execute Sql

	Response.Write "<script>alert('생성 되었습니다.');location.href='cate.asp';</script>"


'수정
ElseIf mode="mod" Then 

	Set UploadForm = Server.Createobject("DEXT.FileUpload") 
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/cate/")
	UploadForm.DefaultPath = UploadPath

	c_code = UploadForm("c_code")
	c_lang = UploadForm("c_lang")
	c_depth = UploadForm("c_depth")
	c_name = InsertText(UploadForm("c_name"))
	c_hide = UploadForm("c_hide")
	c_lev = UploadForm("c_lev")

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT c_image FROM tbl_page_cate WHERE c_code='" & c_code & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then		
		Oldfile1 = Rs(0)
	End If
	Rs.Close
	Set Rs = Nothing

	'파일 수정
	If UploadForm("c_image").FileName<>"" Then
		If Oldfile1<>"" Then UploadForm.Deletefile UploadPath & "\" & Oldfile1
		c_image = UploadForm("c_image").Save(, False)
		Dbcon.Execute "UPDATE tbl_page_cate SET c_image='" & Mid(c_image, InstrRev(c_image, "\")+1)  & "' WHERE c_code='" & c_code & "'"
	End If

	Sql = "UPDATE tbl_page_cate SET "
	Sql = Sql & "c_name='" & c_name & "', "
	Sql = Sql & "c_hide='" & c_hide & "', "
	Sql = Sql & "c_lev='" & c_lev & "' "
	Sql = Sql & "WHERE c_code='" & c_code & "' "

	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.');location.href='cate.asp';</script>"


'삭제
ElseIf mode="del" Then 

	c_code = Request("c_code")

	Set UploadForm = Server.Createobject("DEXT.FileUpload") 
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/cate/")
	UploadForm.DefaultPath = UploadPath

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT c_image FROM tbl_page_cate WHERE c_code='" & c_code & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then 
		If Rs(0)<>"" Then UploadForm.Deletefile UploadPath & "\" & Rs(0)
	End If
	Rs.Close
	Set Rs = Nothing

	Sql = "DELETE FROM tbl_page_cate WHERE c_code LIKE '" & c_code & "%';"

	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.');location.href='cate.asp';</script>"


'위로 이동
ElseIf mode="up" Then 

	c_code = Request("c_code")
	c_lev = Request("c_lev")
	c_depth = Len(c_code)/2
	If c_depth>1 Then p_code = Left(c_code, (c_depth-1)*2)

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 c_code, c_lev FROM tbl_page_cate WHERE c_lev<" & c_lev & ""
	If c_depth>1 Then Sql = Sql & " AND c_code LIKE '" & p_code & "%' "
	If c_depth<>"" Then Sql = Sql & " AND c_depth='" & c_depth & "' "
	Sql = Sql & " ORDER BY c_lev DESC"
	Response.write sql
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		tg_code = Rs("c_code")
		tg_lev = Rs("c_lev")
		Sql = "UPDATE tbl_page_cate SET c_lev='" & c_lev & "' WHERE c_code='" & tg_code & "';" & Chr(13) & Chr(10)
		Sql = Sql & "UPDATE tbl_page_cate SET c_lev='" & tg_lev & "' WHERE c_code='" & c_code & "';"
		Dbcon.Execute Sql
	End If

	Response.Redirect "cate.asp"


'아래로 이동
ElseIf mode="down" Then 

	c_code = Request("c_code")
	c_lev = Request("c_lev")
	c_depth = Len(c_code)/2
	If c_depth>1 Then p_code = Left(c_code, (c_depth-1)*2)

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 c_code, c_lev FROM tbl_page_cate WHERE c_lev>" & c_lev & ""
	If c_depth>1 Then Sql = Sql & " AND c_code LIKE '" & p_code & "%' "
	If c_depth<>"" Then Sql = Sql & " AND c_depth='" & c_depth & "' "
	Sql = Sql & " ORDER BY c_lev ASC"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		tg_code = Rs("c_code")
		tg_lev = Rs("c_lev")
		Sql = "UPDATE tbl_page_cate SET c_lev='" & c_lev & "' WHERE c_code='" & tg_code & "';" & Chr(13) & Chr(10)
		Sql = Sql & "UPDATE tbl_page_cate SET c_lev='" & tg_lev & "' WHERE c_code='" & c_code & "';"
		Dbcon.Execute Sql
	End If

	Response.Redirect "cate.asp"

End If
%>