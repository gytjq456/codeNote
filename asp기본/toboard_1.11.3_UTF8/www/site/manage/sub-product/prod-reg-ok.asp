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
idx = Request("idx")

s_cate=Request("s_cate")
s_keyword = Request("s_keyword")
s_hide = Request("s_hide")
page = Request("page")

pLink = "s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_hide=" & s_hide

Set UploadForm = Server.Createobject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadPath = Server.MapPath("/upload/prod/")
UploadForm.DefaultPath = UploadPath

ReDim p_item(10), p_item_text(10), p_image(8), o_image(8), p_file(6), o_file(6), p_content(6), p_addtext(5), p_option(4), p_option_val(4)


'제품 등록
If mode="reg" Then

	p_name=InsertText(UploadForm("p_name"))
	p_cate=UploadForm("p_cate")
	p_cate2=UploadForm("p_cate2")
	p_cate3=UploadForm("p_cate3")
	'If p_cate="" Then p_cate=UploadForm("catcode2")
	'If p_cate="" Then p_cate=UploadForm("catcode1")
	p_code=InsertText(UploadForm("p_code"))
	p_memo=InsertText(UploadForm("p_memo"))
	p_hide=UploadForm("p_hide")
	p_main=UploadForm("p_main")
	p_display=UploadForm("p_display")
	p_o_price=UploadForm("p_o_price")
	p_price=UploadForm("p_price")
	p_point=UploadForm("p_point")
	If p_point="" Then p_point=0
	p_inquiry=UploadForm("p_inquiry")

	head_title=InsertText(UploadForm("head_title"))
	meta_keywords=InsertText(UploadForm("meta_keywords"))
	meta_description=InsertText(UploadForm("meta_description"))

	'추가항목
	For i=1 To 10
		p_item(i-1)=InsertText(UploadForm("p_item" & i))
		p_item_text(i-1)=InsertText(UploadForm("p_item_text" & i))
	Next

	For i=1 To 5
		p_addtext(i-1)=InsertText(UploadForm("p_addtext" & i))
	Next

	'이미지 등록
	For i=1 To 8
		If UploadForm("p_image" & i).FileName<>"" Then
			p_image(i-1)=UploadForm("p_image" & i).Save(, False)
			p_image(i-1) = UploadForm("p_image" & i).LastSavedFileName

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & p_image(i-1)) Then
				thumb_s = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_s\" & p_image(i-1), 70, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*70), False)
				thumb_m = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_m\" & p_image(i-1), 250, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*250), False)
				thumb_l = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_l\" & p_image(i-1), 500, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*500), False)
			End If
			Set ObjImage = Nothing
		End If
	Next

	'첨부파일/설명
	For i=1 To 6
		p_file(i-1)=UploadForm("p_file" & i).Save(, False)
		p_file(i-1) = UploadForm("p_file" & i).LastSavedFileName
		p_content(i-1)=InsertText(UploadForm("p_content" & i))
	Next

	'옵션
	For i=1 To 4
		p_option(i-1)=InsertText(UploadForm("p_option" & i))
		p_option_val(i-1)=InsertText(UploadForm("p_option_val" & i))
	Next

	'최상위 진열레벨 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 1 p_lev FROM tbl_prod ORDER BY p_lev DESC"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_lev = CDbl(Rs(0))+10
	Else
		p_lev = 10
	End If
	Rs.Close
	Set Rs = Nothing

	'db쿼리
	Sql = "INSERT INTO tbl_prod("
	Sql = Sql & "p_name, "
	Sql = Sql & "p_cate, "
	Sql = Sql & "p_cate2, "
	Sql = Sql & "p_cate3, "
	Sql = Sql & "p_code, "
	For i=1 To 10
		Sql = Sql & "p_item" & i & ", "
		Sql = Sql & "p_item_text" & i & ", "
	Next
	For i=1 To 8
		Sql = Sql & "p_image" & i & ", "
	Next
	For i=1 To 6
		Sql = Sql & "p_file" & i & ", "
		Sql = Sql & "p_content" & i & ", "
	Next
	For i=1 To 5
		Sql = Sql & "p_addtext" & i & ", "
	Next
	For i=1 To 4
		Sql = Sql & "p_option" & i & ", "
		Sql = Sql & "p_option_val" & i & ", "
	Next
	Sql = Sql & "p_memo, "
	Sql = Sql & "p_o_price, "
	Sql = Sql & "p_price, "
	Sql = Sql & "p_point, "
	Sql = Sql & "p_inquiry, "
	Sql = Sql & "p_hide, "
	Sql = Sql & "p_main, "
	Sql = Sql & "p_display, "
	Sql = Sql & "p_lev, "
	Sql = Sql & "head_title, "
	Sql = Sql & "meta_keywords, "
	Sql = Sql & "meta_description) VALUES("
	Sql = Sql & "N'" & p_name & "', "
	Sql = Sql & "'" & p_cate & "', "
	Sql = Sql & "'" & p_cate2 & "', "
	Sql = Sql & "'" & p_cate3 & "', "
	Sql = Sql & "N'" & p_code & "', "
	For i=1 To 10
		Sql = Sql & "N'" & p_item(i-1) & "', "
		Sql = Sql & "N'" & p_item_text(i-1) & "', "
	Next
	For i=1 To 8
		Sql = Sql & "N'" & p_image(i-1) & "', "
	Next
	For i=1 To 6
		Sql = Sql & "N'" & p_file(i-1) & "', "
		Sql = Sql & "N'" & p_content(i-1) & "', "
	Next
	For i=1 To 5
		Sql = Sql & "N'" & p_addtext(i-1) & "', "
	Next
	For i=1 To 4
		Sql = Sql & "N'" & InsertText(p_option(i-1)) & "', "
		Sql = Sql & "N'" & InsertText(p_option_val(i-1)) & "', "
	Next
	Sql = Sql & "N'" & p_memo & "', "
	Sql = Sql & "'" & p_o_price & "', "
	Sql = Sql & "'" & p_price & "', "
	Sql = Sql & "'" & p_point & "', "
	Sql = Sql & "'" & p_inquiry & "', "
	Sql = Sql & "'" & p_hide & "', "
	Sql = Sql & "'" & p_main & "', "
	Sql = Sql & "'" & p_display & "', "
	Sql = Sql & "'" & p_lev & "', "
	Sql = Sql & "N'" & head_title & "', "
	Sql = Sql & "N'" & meta_keywords & "', "
	Sql = Sql & "N'" & meta_description & "')"

	'response.write Sql
	Dbcon.Execute Sql
	Response.Write "<script>alert('등록 되었습니다.'); location.href='prod.asp';</script>"


'제품 복사
ElseIf mode="copy" Then

	ReDim new_p_image(8), new_p_file(6)

	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_name=Rs("p_name")
		p_cate=Rs("p_cate")
		p_cate2=Rs("p_cate2")
		p_cate3=Rs("p_cate3")
		p_code=Rs("p_code")
		For i=1 To 10
			p_item(i-1)=Rs("p_item" & i)
			p_item_text(i-1)=Rs("p_item_text" & i)
		Next
		For i=1 To 8
			p_image(i-1)=Rs("p_image" & i)
		Next
		For i=1 To 6
			p_file(i-1)=Rs("p_file" & i)
			p_content(i-1)=Rs("p_content" & i)
		Next
		For i=1 To 5
			p_addtext(i-1)=Rs("p_addtext" & i)
		Next
		For i=1 To 4
			p_option(i-1)=Rs("p_option" & i)
			p_option_val(i-1)=Rs("p_option_val" & i)
		Next
		p_memo=Rs("p_memo")
		p_o_price=Rs("p_o_price")
		p_price=Rs("p_price")
		p_point=Rs("p_point")
		p_inquiry=Rs("p_inquiry")
		p_lev=Rs("p_lev")
		p_hit=Rs("p_hit")
		p_main=Rs("p_main")
		p_display=Rs("p_display")
		p_hide=Rs("p_hide")
		head_title=Rs("head_title")
		meta_keywords=Rs("meta_keywords")
		meta_description=Rs("meta_description")
	End If
	Rs.Close
	Set Rs = Nothing

	'이미지 복사
	For i=1 To 8
		If p_image(i-1)<>"" Then
			new_filename = "cimg_" & Hour(Now()) & Minute(Now()) & Second(Now()) & Left(Timer(), 5) & "_" & i & "." & Right(p_image(i-1), Len(p_image(i-1))-InStrRev(p_image(i-1), "."))
			
			Call CopyFile(UploadForm.DefaultPath & "\" & p_image(i-1), UploadForm.DefaultPath & "\" & new_filename)

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & new_filename) Then
				thumb_s = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_s\" & new_filename, 70, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*70), False)
				thumb_m = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_m\" & new_filename, 250, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*250), False)
				thumb_l = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_l\" & new_filename, 500, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*500), False)
			End If
			Set ObjImage = Nothing

			new_p_image(i-1) = new_filename

		End If
	Next

	'첨부파일 복사
	For i=1 To 6
		If p_file(i-1)<>"" Then
			new_filename = "cfile_" & Hour(Now()) & Minute(Now()) & Second(Now()) & Left(Timer(), 5) & "_" & i & "." & Right(p_file(i-1), Len(p_file(i-1))-InStrRev(p_file(i-1), "."))
			
			Call CopyFile(UploadForm.DefaultPath & "\" & p_file(i-1), UploadForm.DefaultPath & "\" & new_filename)

			new_p_file(i-1) = new_filename

		End If
	Next

	'db쿼리
	Sql = "INSERT INTO tbl_prod("
	Sql = Sql & "p_name, "
	Sql = Sql & "p_cate, "
	Sql = Sql & "p_cate2, "
	Sql = Sql & "p_cate3, "
	Sql = Sql & "p_code, "
	For i=1 To 10
		Sql = Sql & "p_item" & i & ", "
		Sql = Sql & "p_item_text" & i & ", "
	Next
	For i=1 To 8
		Sql = Sql & "p_image" & i & ", "
	Next
	For i=1 To 6
		Sql = Sql & "p_file" & i & ", "
		Sql = Sql & "p_content" & i & ", "
	Next
	For i=1 To 5
		Sql = Sql & "p_addtext" & i & ", "
	Next
	For i=1 To 4
		Sql = Sql & "p_option" & i & ", "
		Sql = Sql & "p_option_val" & i & ", "
	Next
	Sql = Sql & "p_memo, "
	Sql = Sql & "p_o_price, "
	Sql = Sql & "p_price, "
	Sql = Sql & "p_point, "
	Sql = Sql & "p_inquiry, "
	Sql = Sql & "p_hide, "
	Sql = Sql & "p_main, "
	Sql = Sql & "p_display, "
	Sql = Sql & "p_lev, "
	Sql = Sql & "head_title, "
	Sql = Sql & "meta_keywords, "
	Sql = Sql & "meta_description) VALUES("
	Sql = Sql & "N'" & InsertText(p_name) & "', "
	Sql = Sql & "'" & p_cate & "', "
	Sql = Sql & "'" & p_cate2 & "', "
	Sql = Sql & "'" & p_cate3 & "', "
	Sql = Sql & "N'" & p_code & "', "
	For i=1 To 10
		Sql = Sql & "N'" & p_item(i-1) & "', "
		Sql = Sql & "N'" & p_item_text(i-1) & "', "
	Next
	For i=1 To 8
		Sql = Sql & "N'" & new_p_image(i-1) & "', "
	Next
	For i=1 To 6
		Sql = Sql & "N'" & new_p_file(i-1) & "', "
		Sql = Sql & "N'" & InsertText(p_content(i-1)) & "', "
	Next
	For i=1 To 5
		Sql = Sql & "N'" & InsertText(p_addtext(i-1)) & "', "
	Next
	For i=1 To 4
		Sql = Sql & "N'" & InsertText(p_option(i-1)) & "', "
		Sql = Sql & "N'" & InsertText(p_option_val(i-1)) & "', "
	Next
	Sql = Sql & "N'" & InsertText(p_memo) & "', "
	Sql = Sql & "'" & p_o_price & "', "
	Sql = Sql & "'" & p_price & "', "
	Sql = Sql & "'" & p_point & "', "
	Sql = Sql & "'" & p_inquiry & "', "
	Sql = Sql & "'" & p_hide & "', "
	Sql = Sql & "'" & p_main & "', "
	Sql = Sql & "'" & p_display & "', "
	Sql = Sql & "'" & p_lev & "', "
	Sql = Sql & "N'" & head_title & "', "
	Sql = Sql & "N'" & meta_keywords & "', "
	Sql = Sql & "N'" & meta_description & "')"

	'Response.write sql

	Dbcon.Execute Sql
	Response.Write "<script>alert('복사 되었습니다.'); location.href='prod.asp?" & pLink & "&page=" & page & "';</script>"


'수정
ElseIf mode="mod" Then

	p_name=InsertText(UploadForm("p_name"))
	p_cate=UploadForm("p_cate")
	p_cate2=UploadForm("p_cate2")
	p_cate3=UploadForm("p_cate3")
	p_code=InsertText(UploadForm("p_code"))
	p_memo=InsertText(UploadForm("p_memo"))
	p_hide=UploadForm("p_hide")
	p_main=UploadForm("p_main")
	p_display=UploadForm("p_display")
	p_o_price=UploadForm("p_o_price")
	p_price=UploadForm("p_price")
	p_point=UploadForm("p_point")
	If p_point="" Then p_point=0
	p_inquiry=UploadForm("p_inquiry")

	head_title=InsertText(UploadForm("head_title"))
	meta_keywords=InsertText(UploadForm("meta_keywords"))
	meta_description=InsertText(UploadForm("meta_description"))

	'추가항목
	For i=1 To 10
		p_item(i-1)=InsertText(UploadForm("p_item" & i))
		p_item_text(i-1)=InsertText(UploadForm("p_item_text" & i))
	Next

	For i=1 To 5
		p_addtext(i-1)=InsertText(UploadForm("p_addtext" & i))
	Next

	'옵션
	For i=1 To 4
		p_option(i-1)=InsertText(UploadForm("p_option" & i))
		p_option_val(i-1)=InsertText(UploadForm("p_option_val" & i))
	Next

	'기존 파일 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		For i=1 To 8
			o_image(i-1) = Rs("p_image" & i)
		Next
		For i=1 To 6
			o_file(i-1) = Rs("p_file" & i)
		Next
	End If
	Rs.Close
	Set Rs = Nothing

	'이미지 삭제
	For i=1 To 8
		If UploadForm("p_image" & i & "_del")="1" then
			If o_image(i-1)<>"" Then
				UploadForm.Deletefile UploadPath & "\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_l\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_m\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_s\" & o_image(i-1)
				Dbcon.Execute "UPDATE tbl_prod SET p_image" & i & "='' WHERE idx='" & idx & "'"
			End If
		End If
	Next

	'이미지 수정
	For i=1 To 8
		If UploadForm("p_image" & i).FileName<>"" Then
			'기존 파일 삭제
			If o_image(i-1)<>"" Then
				UploadForm.Deletefile UploadPath & "\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_l\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_m\" & o_image(i-1)
				UploadForm.Deletefile UploadPath & "\thumb_s\" & o_image(i-1)
			End If
			p_image(i-1) = UploadForm("p_image" & i).Save(, False)
			p_image(i-1) = UploadForm("p_image" & i).LastSavedFileName

			'썸네일 생성
			Set ObjImage = Server.CreateObject("DEXT.ImageProc")
			If ObjImage.SetSourceFile(UploadForm.DefaultPath & "\" & p_image(i-1)) Then
				thumb_s = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_s\" & p_image(i-1), 70, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*70), False)
				thumb_m = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_m\" & p_image(i-1), 250, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*250), False)
				thumb_l = ObjImage.SaveasThumbnail(UploadForm.DefaultPath & "\thumb_l\" & p_image(i-1), 500, CInt((ObjImage.ImageHeight/ObjImage.ImageWidth)*500), False)
			End If
			Set ObjImage = Nothing

			Dbcon.Execute "UPDATE tbl_prod SET p_image" & i & "=N'" & p_image(i-1)  & "' WHERE idx='" & idx & "'"
		End If
	Next

	'첨부파일 삭제
	For i=1 To 6
		If UploadForm("p_file" & i & "_del")="1" then
			If o_file(i-1)<>"" Then
				UploadForm.Deletefile UploadPath & "\" & o_file(i-1)
				Dbcon.Execute "UPDATE tbl_prod SET p_file" & i & "='' WHERE idx='" & idx & "'"
			End If
		End If
	Next

	'첨부파일 수정
	For i=1 To 6
		If UploadForm("p_file" & i).FileName<>"" Then
			'기존 파일 삭제
			If o_file(i-1)<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file(i-1)
			p_file(i-1) = UploadForm("p_file" & i).Save(, False)
			p_file(i-1) = UploadForm("p_file" & i).LastSavedFileName

			Dbcon.Execute "UPDATE tbl_prod SET p_file" & i & "=N'" & p_file(i-1)  & "' WHERE idx='" & idx & "'"
		End If
	Next

	'설명
	For i=1 To 6
		p_content(i-1)=InsertText(UploadForm("p_content" & i))
	Next

	'db쿼리
	Sql = "UPDATE tbl_prod SET "
	Sql = Sql & "p_name=N'" & p_name & "', "
	Sql = Sql & "p_cate='" & p_cate & "', "
	Sql = Sql & "p_cate2='" & p_cate2 & "', "
	Sql = Sql & "p_cate3='" & p_cate3 & "', "
	Sql = Sql & "p_code=N'" & p_code & "', "
	For i=1 To 10
		Sql = Sql & "p_item" & i & "=N'" & p_item(i-1) & "', "
		Sql = Sql & "p_item_text" & i & "=N'" & p_item_text(i-1) & "', "
	Next
	For i=1 To 6
		Sql = Sql & "p_content" & i & "=N'" & p_content(i-1) & "', "
	Next
	For i=1 To 5
		Sql = Sql & "p_addtext" & i & "=N'" & p_addtext(i-1) & "', "
	Next
	For i=1 To 4
		Sql = Sql & "p_option" & i & "=N'" & p_option(i-1) & "', "
		Sql = Sql & "p_option_val" & i & "=N'" & p_option_val(i-1) & "', "
	Next
	Sql = Sql & "p_memo=N'" & p_memo & "', "
	Sql = Sql & "p_o_price='" & p_o_price & "', "
	Sql = Sql & "p_price='" & p_price & "', "
	Sql = Sql & "p_point='" & p_point & "', "
	Sql = Sql & "p_inquiry='" & p_inquiry & "', "
	Sql = Sql & "p_hide='" & p_hide & "', "
	Sql = Sql & "p_main='" & p_main & "', "
	Sql = Sql & "p_display='" & p_display & "', "
	Sql = Sql & "head_title='" & head_title & "', "
	Sql = Sql & "meta_keywords='" & meta_keywords & "', "
	Sql = Sql & "meta_description='" & meta_description & "', "
	Sql = Sql & "moddate=getdate() "
	Sql = Sql & " WHERE idx='" & idx & "'"

	'response.write Sql
	Dbcon.Execute Sql


	'제품수정에 따른 장바구니 상품 초기화
	Sql = Sql & "DELETE FROM tbl_mall_cart "
	Sql = Sql & " WHERE o_code='' AND p_idx='" & idx & "'; "
	Dbcon.Execute Sql


	Response.Write "<script>alert('수정 되었습니다.'); location.href='prod.asp?" & pLink & "&page=" & page & "';</script>"


'삭제
ElseIf mode="del" Then

	'기존 파일 정보 취득
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "'"
	Rs.Open Sql, DbCon, 1
	If Rs.EOF=False Then
		For i=1 To 8
			o_image(i-1) = Rs("p_image" & i)
		Next
		For i=1 To 6
			o_file(i-1) = Rs("p_file" & i)
		Next
	End If
	Rs.Close
	Set Rs = Nothing

	'이미지 삭제
	For i=1 To 8
		If o_image(i-1)<>"" Then
			UploadForm.Deletefile UploadPath & "\" & o_image(i-1)
			UploadForm.Deletefile UploadPath & "\thumb_l\" & o_image(i-1)
			UploadForm.Deletefile UploadPath & "\thumb_m\" & o_image(i-1)
			UploadForm.Deletefile UploadPath & "\thumb_s\" & o_image(i-1)
		End If
	Next

	'첨부파일 삭제
	For i=1 To 6
		If o_file(i-1)<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file(i-1)
	Next

	'db쿼리
	Sql = "DELETE FROM tbl_prod "
	Sql = Sql & " WHERE idx='" & idx & "'"

	'response.write Sql
	Dbcon.Execute Sql
	Response.Write "<script>alert('삭제 되었습니다.'); location.href='prod.asp?" & pLink & "&page=" & page & "';</script>"


'정렬레벨 수정
ElseIf mode="levmod" Then	

	Sql = "UPDATE tbl_prod SET "
	Sql = Sql & "p_lev='" & InsertText(Request("p_lev")) & "' WHERE idx='" & idx & "' "

	Dbcon.Execute Sql

	Response.Write "<script>alert('수정 되었습니다.'); location.href='prod.asp?" & pLink & "&page=" & page & "';</script>"

End If

%>