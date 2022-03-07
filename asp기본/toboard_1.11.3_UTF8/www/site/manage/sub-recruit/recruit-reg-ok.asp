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
	strRefer = Request.ServerVariables("HTTP_REFERER") 
	
	mode			= Request("mode")
	idx				= Request("idx")
	r_idx			= Request("r_idx")

	s_keyword	= Request("s_keyword")
	s_hide		= Request("s_hide")
	page			= Request("page")

	pLink = "s_keyword=" & s_keyword & "&s_cate1=" & s_cate1 & "&s_cate2=" & s_cate2 & "&s_cate3=" & s_cate3 & "&s_hide=" & s_hide

	Set UploadForm = Server.Createobject("DEXT.FileUpload")
	UploadForm.CodePage = 65001
	UploadForm.AutoMakeFolder = True
	UploadPath = Server.MapPath("/upload/recruit/")
	UploadForm.DefaultPath = UploadPath

	ReDim p_item(10), p_item_text(10), p_image(8), o_image(8), p_file(6), o_file(6), p_content(6), p_addtext(5), r_intro_nm(5), r_add_nm(5)


	'제품 등록
	If mode = "reg" Then

		com_NM				= InsertText(UploadForm("com_NM"))
		work_NM			= InsertText(UploadForm("work_NM"))
		sdate					= InsertText(UploadForm("s_srdate"))
		edate					= InsertText(UploadForm("s_erdate"))
		recruit					= InsertText(UploadForm("recruit"))
		s_hide				= InsertText(UploadForm("s_hide"))
		state					= InsertText(UploadForm("state"))
		s_lev					= InsertText(UploadForm("s_lev"))
		r_top					= InsertText(UploadForm("r_top"))

		r_info					= UploadForm("r_info")
		r_education		= UploadForm("r_education")
		r_personal			= UploadForm("r_personal")
		r_army				= UploadForm("r_army")
		r_job					= UploadForm("r_job")
		r_disabled			= UploadForm("r_disabled")
		r_lower				= UploadForm("r_lower")
		r_body				= UploadForm("r_body")
		r_family				= UploadForm("r_family")
		r_license			= UploadForm("r_license")
		r_oa					= UploadForm("r_oa")
		r_language		= UploadForm("r_language")
		r_portfolio			= UploadForm("r_portfolio")
		r_skill					= UploadForm("r_skill")
		r_career				= UploadForm("r_career")
		r_experience		= UploadForm("r_experience")
		r_project				= UploadForm("r_project")
		r_prime				= UploadForm("r_prime")
		r_training			= UploadForm("r_training")
		r_complete		= UploadForm("r_complete")
		r_swot				= UploadForm("r_swot")
		r_etc					= UploadForm("r_etc")
		r_introduction	= UploadForm("r_introduction")
		r_add					= UploadForm("r_add")
		r_intro_cnt			= UploadForm("r_intro_cnt")
		r_add_cnt			= UploadForm("r_add_cnt")

		For i=1 To 5
			r_intro_nm(i)=InsertText(UploadForm("r_intro_nm" & i))
			r_add_nm(i)=InsertText(UploadForm("r_add_nm" & i))
		Next

		'이미지 등록
		If UploadForm("p_image1").FileName <> "" Then
			p_image1	= UploadForm("p_image1").Save(, False)
			p_image1	= Mid(p_image1, InstrRev(p_image1, "\")+1)
		End If

		'첨부파일/설명
		p_file1=UploadForm("file1").Save(, False)
		p_file1 = Mid(p_file1, InstrRev(p_file1, "\")+1)

		'최상위 진열레벨 취득
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT TOP 1 s_lev FROM tbl_recruit ORDER BY s_lev DESC"
		Rs.Open SQL, Dbcon, 1
		If Rs.EOF=False Then
			s_lev = CDbl(Rs(0))+10
		Else
			s_lev = 10
		End If
		Rs.Close
		Set Rs = Nothing

		'db쿼리
		SQL = "INSERT INTO tbl_recruit("
		SQL = SQL & "com_NM, "
		SQL = SQL & "work_NM, "
		SQL = SQL & "sdate, "
		SQL = SQL & "edate, "
		SQL = SQL & "recruit, "
		SQL = SQL & "s_hide, "
		SQL = SQL & "state, "
		SQL = SQL & "s_lev, "
		SQL = SQL & "file1, "
		SQL = SQL & "r_top, "
		SQL = SQL & "p_image1) VALUES("
		SQL = SQL & "N'" & com_NM & "', "
		SQL = SQL & "N'" & work_NM & "', "
		SQL = SQL & "N'" & sdate & "', "
		SQL = SQL & "N'" & edate & "', "
		SQL = SQL & "'" & recruit & "', "
		SQL = SQL & "'" & s_hide & "', "
		SQL = SQL & "'" & state & "', "
		SQL = SQL & "'" & s_lev & "', "
		SQL = SQL & "'" & p_file1 & "', "
		SQL = SQL & "'" & r_top & "', "
		SQL = SQL & "N'" & p_image1 & "')"
		Dbcon.Execute SQL

		SQL = "SELECT idx FROM tbl_recruit ORDER BY idx DESC"
		Set Rs1 = Dbcon.Execute(SQL)
		If Rs1.EOF = False Then
		r_idx = Rs1(0)
		Else
		r_idx = 0
		End If

		If recruit = "0" Or recruit = "1" Then

			SQL = "INSERT INTO tbl_resume_config("
			SQL = SQL & "r_idx, "
			SQL = SQL & "r_info, "
			SQL = SQL & "r_education, "
			SQL = SQL & "r_personal, "
			SQL = SQL & "r_army, "
			SQL = SQL & "r_job, "
			SQL = SQL & "r_disabled, "
			SQL = SQL & "r_lower, "
			SQL = SQL & "r_body, "
			SQL = SQL & "r_family, "
			SQL = SQL & "r_license, "
			SQL = SQL & "r_oa, "
			SQL = SQL & "r_language, "
			SQL = SQL & "r_portfolio, "
			SQL = SQL & "r_skill, "
			SQL = SQL & "r_career, "
			SQL = SQL & "r_experience, "
			SQL = SQL & "r_project, "
			SQL = SQL & "r_prime, "
			SQL = SQL & "r_training, "
			SQL = SQL & "r_complete, "
			SQL = SQL & "r_swot, "
			SQL = SQL & "r_etc, "
			SQL = SQL & "r_add, "
			SQL = SQL & "r_intro_cnt, "
			For i = 1 To 5
			SQL = SQL & "r_intro_nm" & i & ", "
			Next
			SQL = SQL & "r_add_cnt, "
			For i = 1 To 5
			SQL = SQL & "r_add_nm" & i & ", "
			Next
			SQL = SQL & "r_introduction) VALUES("
			SQL = SQL & "N'" & r_idx & "', "
			SQL = SQL & "N'" & r_info & "', "
			SQL = SQL & "N'" & r_education & "', "
			SQL = SQL & "N'" & r_personal & "', "
			SQL = SQL & "N'" & r_army & "', "
			SQL = SQL & "'" & r_job & "', "
			SQL = SQL & "'" & r_disabled & "', "
			SQL = SQL & "'" & r_lower & "', "
			SQL = SQL & "'" & r_body & "', "
			SQL = SQL & "'" & r_family & "', "
			SQL = SQL & "N'" & r_license & "', "
			SQL = SQL & "N'" & r_oa & "', "
			SQL = SQL & "N'" & r_language & "', "
			SQL = SQL & "N'" & r_portfolio & "', "
			SQL = SQL & "N'" & r_skill & "', "
			SQL = SQL & "N'" & r_career & "', "
			SQL = SQL & "N'" & r_experience & "', "
			SQL = SQL & "N'" & r_project & "', "
			SQL = SQL & "N'" & r_prime & "', "
			SQL = SQL & "N'" & r_training & "', "
			SQL = SQL & "N'" & r_complete & "', "
			SQL = SQL & "N'" & r_swot & "', "
			SQL = SQL & "N'" & r_etc & "', "
			SQL = SQL & "N'" & r_add & "', "
			SQL = SQL & "N'" & r_intro_cnt & "', "
			For i = 1 To 5
			SQL = SQL & "N'" & r_intro_nm(i) & "', "
			Next
			SQL = SQL & "N'" & r_add_cnt & "', "
			For i = 1 To 5
			SQL = SQL & "N'" & r_add_nm(i) & "', "
			Next
			SQL = SQL & "N'" & r_introduction & "')"
			Dbcon.Execute SQL

		End If

		Response.Write "<script>alert('등록 되었습니다.'); location.href='recruit.asp';</script>"

	'수정
	ElseIf mode = "mod" Then

		com_NM				= InsertText(UploadForm("com_NM"))
		work_NM			= InsertText(UploadForm("work_NM"))
		sdate					= InsertText(UploadForm("s_srdate"))
		edate					= InsertText(UploadForm("s_erdate"))
		recruit					= InsertText(UploadForm("recruit"))
		s_hide				= InsertText(UploadForm("s_hide"))
		state					= InsertText(UploadForm("state"))
		s_lev					= InsertText(UploadForm("s_lev"))
		r_top					= InsertText(UploadForm("r_top"))

		r_info					= UploadForm("r_info")
		r_education		= UploadForm("r_education")
		r_personal			= UploadForm("r_personal")
		r_army				= UploadForm("r_army")
		r_job					= UploadForm("r_job")
		r_disabled			= UploadForm("r_disabled")
		r_lower				= UploadForm("r_lower")
		r_body				= UploadForm("r_body")
		r_family				= UploadForm("r_family")
		r_license			= UploadForm("r_license")
		r_oa					= UploadForm("r_oa")
		r_language		= UploadForm("r_language")
		r_portfolio			= UploadForm("r_portfolio")
		r_skill					= UploadForm("r_skill")
		r_career				= UploadForm("r_career")
		r_experience		= UploadForm("r_experience")
		r_project				= UploadForm("r_project")
		r_prime				= UploadForm("r_prime")
		r_training			= UploadForm("r_training")
		r_complete		= UploadForm("r_complete")
		r_swot				= UploadForm("r_swot")
		r_etc					= UploadForm("r_etc")
		r_introduction	= UploadForm("r_introduction")
		r_add					= UploadForm("r_add")
		r_intro_cnt			= UploadForm("r_intro_cnt")
		r_add_cnt			= UploadForm("r_add_cnt")

		For i=1 To 5
			r_intro_nm(i)=InsertText(UploadForm("r_intro_nm" & i))
			r_add_nm(i)=InsertText(UploadForm("r_add_nm" & i))
		Next

		'기존 파일 정보 취득
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT * FROM tbl_recruit WHERE idx = '" & idx & "'"
		Rs.Open SQL, DbCon, 1
		If Rs.EOF=False Then
			o_image1	= Rs("p_image1")
			o_file1		= Rs("file1")
		End If
		Rs.Close
		Set Rs = Nothing

		'이미지 삭제
		If UploadForm("p_image1_del") = "1" Then
			If o_image1 <> "" Then
				If o_image1 <> "" Then UploadForm.Deletefile UploadPath & "\" & o_image1
				Dbcon.Execute "UPDATE tbl_recruit SET p_image1 = '' WHERE idx = '" & idx & "'"
			End If
		End If

		'이미지 수정
		If UploadForm("p_image1").FileName <> "" Then
			'기존 파일 삭제
			If o_image1 <> "" Then UploadForm.Deletefile UploadPath & "\" & o_image1
			p_image1 = UploadForm("p_image1").Save(, False)
			p_image1 = Mid(p_image1, InstrRev(p_image1, "\")+1)

			Dbcon.Execute "UPDATE tbl_recruit SET p_image1 = N'" & Mid(p_image1, InstrRev(p_image1, "\")+1)  & "' WHERE idx = '" & idx & "'"
		End If

		'첨부파일 삭제
		If UploadForm("file1_del")="1" then
			If o_file1<>"" Then
				If o_file1<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file1
				Dbcon.Execute "UPDATE tbl_recruit SET file1 = '' WHERE idx = '" & idx & "'"
			End If
		End If

	'첨부파일 수정
		If UploadForm("file1").FileName<>"" Then
			'기존 파일 삭제
			If o_file1<>"" Then UploadForm.Deletefile UploadPath & "\" & o_file1
			p_file1 = UploadForm("file1").Save(, False)
			p_file1 = Mid(p_file1, InstrRev(p_file1, "\")+1)

			Dbcon.Execute "UPDATE tbl_recruit SET file1 = N'" & Mid(p_file1, InstrRev(p_file1, "\")+1)  & "' WHERE idx = '" & idx & "'"
		End If

		'db쿼리
		SQL = "UPDATE tbl_recruit SET "
		SQL = SQL & "com_NM=N'" & com_NM & "', "
		SQL = SQL & "work_NM=N'" & work_NM & "', "
		SQL = SQL & "sdate=N'" & sdate & "', "
		SQL = SQL & "edate=N'" & edate & "', "
		SQL = SQL & "recruit='" & recruit & "', "
		SQL = SQL & "s_hide='" & s_hide & "', "
		SQL = SQL & "state='" & state & "', "
		SQL = SQL & "s_lev='" & s_lev & "', "
		SQL = SQL & "r_top='" & r_top & "', "
		SQL = SQL & "moddate=getdate() "
		SQL = SQL & " WHERE idx='" & idx & "'"
		Dbcon.Execute SQL

		If recruit = "2" Then
			SQL = "DELETE FROM tbl_resume_config WHERE idx = '"&r_idx&"'"
			Dbcon.Execute SQL
		Else
			SQL = "UPDATE tbl_resume_config SET "
			SQL = SQL & "r_info='" & r_info & "', "
			SQL = SQL & "r_education='" & r_education & "', "
			SQL = SQL & "r_personal='" & r_personal & "', "
			SQL = SQL & "r_army='" & r_army & "', "
			SQL = SQL & "r_job='" & r_job & "', "
			SQL = SQL & "r_disabled='" & r_disabled & "', "
			SQL = SQL & "r_lower='" & r_lower & "', "
			SQL = SQL & "r_body='" & r_body & "', "
			SQL = SQL & "r_family='" & r_family & "', "
			SQL = SQL & "r_license='" & r_license & "', "
			SQL = SQL & "r_oa='" & r_oa & "', "
			SQL = SQL & "r_language='" & r_language & "', "
			SQL = SQL & "r_portfolio='" & r_portfolio & "', "
			SQL = SQL & "r_skill='" & r_skill & "', "
			SQL = SQL & "r_career='" & r_career & "', "
			SQL = SQL & "r_experience='" & r_experience & "', "
			SQL = SQL & "r_project='" & r_project & "', "
			SQL = SQL & "r_prime='" & r_prime & "', "
			SQL = SQL & "r_training='" & r_training & "', "
			SQL = SQL & "r_complete='" & r_complete & "', "
			SQL = SQL & "r_swot='" & r_swot & "', "
			SQL = SQL & "r_etc='" & r_etc & "', "
			SQL = SQL & "r_add='" & r_add & "', "
			SQL = SQL & "r_intro_cnt='" & r_intro_cnt & "', "
			For i = 1 To 5
			SQL = SQL & "r_intro_nm" & i & "=N'" & r_intro_nm(i) & "', "
			Next
			SQL = SQL & "r_add_cnt='" & r_add_cnt & "', "
			For i = 1 To 5
			SQL = SQL & "r_add_nm" & i & "=N'" & r_add_nm(i) & "', "
			Next
			SQL = SQL & "r_introduction='" & r_introduction & "' "
			SQL = SQL & " WHERE idx = '" & r_idx & "'"
		Dbcon.Execute SQL
		End If

		Response.Write "<script>alert('수정 되었습니다.'); location.href='recruit.asp?" & pLink & "&page=" & page & "';</script>"

	'삭제
	ElseIf mode = "del" Then

		'기존 파일 정보 취득
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT * FROM tbl_recruit WHERE idx = '" & idx & "'"
		Rs.Open SQL, DbCon, 1
		If Rs.EOF=False Then
			o_image1	= Rs("p_image1")
			o_file1		= Rs("file1")
		End If
		Rs.Close
		Set Rs = Nothing

		'이미지 삭제
		If o_image1 <> "" Then
			If o_image1 <> "" Then UploadForm.Deletefile UploadPath & "\" & o_image1
		End If

		'첨부파일 삭제
		If o_file1 <> "" Then
			If o_file1 <> "" Then UploadForm.Deletefile UploadPath & "\" & o_file1
		End If

		'db쿼리
		SQL = "DELETE FROM tbl_recruit WHERE idx = '" & idx & "'"
		Dbcon.Execute SQL

		SQL = "DELETE FROM tbl_resume_config WHERE r_idx = '"&r_idx&"'"
		Dbcon.Execute SQL

		Response.Write "<script>alert('삭제 되었습니다.'); location.href='"&strRefer&"';</script>"


	'정렬레벨 수정
	ElseIf mode = "levmod" Then

		SQL = "UPDATE tbl_recruit SET "
		SQL = SQL & "s_lev='" & InsertText(Request("s_lev")) & "' WHERE idx='" & idx & "' "

		Dbcon.Execute SQL

		Response.Write "<script>alert('수정 되었습니다.'); location.href='recruit.asp?" & pLink & "&page=" & page & "';</script>"

	End If
%>