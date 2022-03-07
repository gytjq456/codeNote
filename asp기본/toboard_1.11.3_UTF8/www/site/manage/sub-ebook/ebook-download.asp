<%@CodePage = 65001%>
<!--#include virtual="/site/setting.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/site/manage/inc/auth-chk.asp"-->
<%
idx = Request("idx")

'DEXTUpload Pro	4.1부터 지원
Set objCompressor = Server.CreateObject("DEXT.DEXTProCompressor") 
Compressor.CompFileSavePath = Server.MapPath("/upload/ebook/") & "\" & "Ebook_" & idx & ".zip"

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_ebook_img "
Sql = Sql & " WHERE e_idx='" & idx & "' "
Sql = Sql & " ORDER BY e_lev ASC"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	Do Until Rs.EOF
		ei_file = Server.MapPath("/upload/ebook/") & "\" & Rs("e_file")
		Compressor.AddFile(ei_file)
		Rs.MoveNext
	Loop
Else
	Response.Write "<script language='javascript'>alert('대상 파일이 없습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing

dl_file = Compressor.Compress(True)
Set objCompressor = Nothing 

Response.write dl_file

Response.ContentType = "application/unknown"
Response.AddHeader "Content-Disposition","attachment; filename=" & dl_file

Set ObjStream = Server.CreateObject("ADODB.Stream")
	ObjStream.Open
	ObjStream.Type = 1
	downpath = Server.MapPath(upfolder)
	ObjStream.LoadFromFile dl_file
	Response.BinaryWrite ObjStream.Read 
Set ObjStream = Nothing

'Response.Redirect "ebook.asp"
%>