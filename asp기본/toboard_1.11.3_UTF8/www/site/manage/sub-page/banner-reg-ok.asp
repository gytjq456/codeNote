<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
mode = Request("mode")
idx = Request("idx")
s_bc_name = Request("s_bc_name")

pLink = "s_bc_name=" & s_bc_name

Set UploadForm = Server.Createobject("DEXT.FileUpload") 
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadPath = Server.MapPath("/upload/banner/")
UploadForm.DefaultPath = UploadPath

If mode="reg" Then 

	b_file = UploadForm("b_file").Save(, False)

	'최상위 진열레벨 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 p_lev FROM tbl_banner ORDER BY p_lev DESC"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_lev = CDbl(Rs(0))+10
	Else
		p_lev = 10
	End If
	Rs.Close
	Set Rs = Nothing

	Sql = "INSERT INTO tbl_banner("
	Sql = Sql & "b_sort, "
	Sql = Sql & "b_title, "
	Sql = Sql & "b_file, "
	Sql = Sql & "b_url, "
	Sql = Sql & "b_url_target, "
	Sql = Sql & "p_lev, "
	Sql = Sql & "b_addtext1, "
	Sql = Sql & "b_addtext2, "
	Sql = Sql & "b_addtext3, "
	Sql = Sql & "b_addtext4, "
	Sql = Sql & "b_addtext5) VALUES("
	Sql = Sql & "N'" & InsertText(UploadForm("b_sort")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_title")) & "', "
	Sql = Sql & "N'" & UploadForm("b_file").LastSavedFileName & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_url")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_url_target")) & "', "
	Sql = Sql & "'" & p_lev & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_addtext1")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_addtext2")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_addtext3")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_addtext4")) & "', "
	Sql = Sql & "N'" & InsertText(UploadForm("b_addtext5")) & "')"
	Dbcon.Execute Sql

	Response.Write "<script>alert('등록 되었습니다.'); location.href='banner.asp?s_bc_name=" & s_bc_name & "';</script>"


ElseIf mode="mod" Then

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT b_file FROM tbl_banner WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then		
		Oldfile1 = Rs(0)
	End If
	Rs.Close
	Set Rs = Nothing

	'파일 수정
	If UploadForm("b_file").FileName<>"" Then
		If Oldfile1<>"" Then UploadForm.Deletefile UploadPath & "\" & Oldfile1
		b_file = UploadForm("b_file").Save(, False)
		Dbcon.Execute "UPDATE tbl_banner SET b_file=N'" & UploadForm("b_file").LastSavedFileName & "' WHERE idx='" & idx & "'"
	End If

	Sql = "UPDATE tbl_banner SET "
	Sql = Sql & "b_sort=N'" & InsertText(UploadForm("b_sort")) & "', "
	Sql = Sql & "b_title=N'" & InsertText(UploadForm("b_title")) & "', "
	Sql = Sql & "b_url=N'" & InsertText(UploadForm("b_url")) & "', "
	Sql = Sql & "b_url_target=N'" & InsertText(UploadForm("b_url_target")) & "', "
	Sql = Sql & "b_addtext1=N'" & InsertText(UploadForm("b_addtext1")) & "', "
	Sql = Sql & "b_addtext2=N'" & InsertText(UploadForm("b_addtext2")) & "', "
	Sql = Sql & "b_addtext3=N'" & InsertText(UploadForm("b_addtext3")) & "', "
	Sql = Sql & "b_addtext4=N'" & InsertText(UploadForm("b_addtext4")) & "', "
	Sql = Sql & "b_addtext5=N'" & InsertText(UploadForm("b_addtext5")) & "' "
	Sql = Sql & "WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='banner.asp?s_bc_name=" & s_bc_name & "';</script>"


ElseIf mode="del" Then

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT b_file FROM tbl_banner WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then 
		If Rs(0)<>"" Then UploadForm.Deletefile UploadPath & "\" & Rs(0)
	End If
	Rs.Close
	Set Rs = Nothing

	Sql = "DELETE FROM tbl_banner WHERE idx='" & idx & "' "
	Dbcon.Execute Sql

	Response.Write "<script>alert('삭제 되었습니다.'); location.href='banner.asp';</script>"


'정렬레벨 수정
ElseIf mode="levmod" Then	

	Sql = "UPDATE tbl_banner SET "
	Sql = Sql & "p_lev='" & InsertText(Request("p_lev")) & "' WHERE idx='" & idx & "' "

	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='banner.asp?s_bc_name=" & s_bc_name & "';</script>"


End If
%>

