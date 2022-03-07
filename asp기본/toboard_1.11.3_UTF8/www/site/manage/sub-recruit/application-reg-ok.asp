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
	mode			= Request("mode")
	idx				= Request("idx")
	r_idx			= Request("r_idx")
	state			= InsertText(Request("state"))
	recruit			= InsertText(Request("recruit"))
	per				= InsertText(Request("per"))
	m_id			= InsertText(Request("m_id"))
	mpw			= InsertText(Request("mpw"))
	resumeid	= InsertText(Request("resumeid"))

	If mode = "mod" Then
	
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT * FROM tbl_recruit A LEFT JOIN tbl_resume_config B ON A.idx = B.r_idx WHERE A.idx = '"&r_idx&"' "
		Rs.Open SQL, Dbcon, 1
		If Rs.EOF=False Then
			recruit					= Rs("recruit")
			r_info					= Rs("r_info")
			r_education		= Rs("r_education")
			r_personal			= Rs("r_personal")
			r_army				= Rs("r_army")
			r_job					= Rs("r_job")
			r_disabled			= Rs("r_disabled")
			r_lower				= Rs("r_lower")
			r_body				= Rs("r_body")
			r_family				= Rs("r_family")
			r_license			= Rs("r_license")
			r_oa					= Rs("r_oa")
			r_language		= Rs("r_language")
			r_portfolio			= Rs("r_portfolio")
			r_skill					= Rs("r_skill")
			r_career				= Rs("r_career")
			r_experience		= Rs("r_experience")
			r_project				= Rs("r_project")
			r_prime				= Rs("r_prime")
			r_training			= Rs("r_training")
			r_complete		= Rs("r_complete")
			r_swot				= Rs("r_swot")
			r_strategy			= Rs("r_strategy")
			r_etc					= Rs("r_etc")
			r_introduction	= Rs("r_introduction")
		End If
		Rs.Close
		Set Rs = Nothing

		'db쿼리
		SQL = "UPDATE tbl_resume SET state='" & state & "' WHERE idx='" & idx & "'"
		Dbcon.Execute SQL

		'지원자정보
		r_title			= InsertText(Request("r_title"))
		r_sort			= InsertText(Request("r_sort"))
		r_pay			= InsertText(Request("r_pay"))

		SQL = "UPDATE tbl_resume SET "
		SQL = SQL & "r_title = N'" & r_title & "', "
		SQL = SQL & "r_sort = N'" & r_sort & "', "
		SQL = SQL & "r_pay = N'" & r_pay & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		'지원자 기본정보
		If r_info = "Y" Then
			r_name		= InsertText(Request("r_name"))
			r_birth1		= InsertText(Request("r_birth1"))
			r_birth2		= InsertText(Request("r_birth2"))
			r_birth3		= InsertText(Request("r_birth3"))
			r_hp1			= InsertText(Request("r_hp1"))
			r_hp2			= InsertText(Request("r_hp2"))
			r_hp3			= InsertText(Request("r_hp3"))
			r_hp			= r_hp1&"-"&r_hp2&"-"&r_hp3
			r_addr			= InsertText(Request("r_addr"))
			r_email		= InsertText(Request("r_email"))

			SQL = "UPDATE tbl_resume SET "
			SQL = SQL & "r_name = N'" & r_name & "', "
			SQL = SQL & "r_birth1 = N'" & r_birth1 & "', "
			SQL = SQL & "r_birth2 = N'" & r_birth2 & "', "
			SQL = SQL & "r_birth3 = N'" & r_birth3 & "', "
			SQL = SQL & "r_hp = N'" & r_hp & "', "
			SQL = SQL & "r_addr = N'" & r_addr & "', "
			SQL = SQL & "r_email = N'" & r_email & "' WHERE r_idx = '" & r_idx & "'  AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If
		
		'지원자 학력사항
		If r_education = "Y" Then
			school	= InsertText(Request("school"))
			If school <> "" And Not ISNULL(school) Then
				ReDim school_idx(school), rs_sdate(school), rs_edate(school), rs_school(school), rs_major(school), rs_score(school)
				For i = 1 To school
					rs_sdate(i-1)			= InsertText(Request("rs_sdate" & i))
					rs_edate(i-1)			= InsertText(Request("rs_edate" & i))
					rs_school(i-1)		= InsertText(Request("rs_school" & i))
					rs_major	(i-1)			= InsertText(Request("rs_major" & i))
					rs_score(i-1)			= InsertText(Request("rs_score" & i))
					rs_major_detail	= InsertText(Request("rs_major_detail"))
					school_idx(i-1)		= InsertText(Request("school_idx" & i))

					If rs_sdate(i-1) = "" And rs_edate(i-1) = "" And rs_school(i-1) = "" And rs_major	(i-1) = "" And rs_score(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_school WHERE r_idx = '"&r_idx&"' AND idx = '"&school_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_school SET "
						SQL = SQL & "rs_sdate = N'" & rs_sdate(i-1) & "', "
						SQL = SQL & "rs_edate = N'" & rs_edate(i-1) & "', "
						SQL = SQL & "rs_school = N'" & rs_school(i-1) & "', "
						SQL = SQL & "rs_major = N'" & rs_major	(i-1) & "', "
						SQL = SQL & "rs_score = N'" & rs_score(i-1) & "', "
						SQL = SQL & "rs_major_detail = N'" & rs_major_detail & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&school_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'지원자 개인 신상정보
		If r_personal = "Y" Then
			rp_marry				= InsertText(Request("rp_marry"))
			rp_blood			= InsertText(Request("rp_blood"))
			rp_hobby			= InsertText(Request("rp_hobby"))
			rp_specialty		= InsertText(Request("rp_specialty"))
			rp_religion		= InsertText(Request("rp_religion"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_marry = N'" & rp_marry & "', "
			SQL = SQL & "rp_hobby = N'" & rp_hobby & "', "
			SQL = SQL & "rp_blood = N'" & rp_blood & "', "
			SQL = SQL & "rp_religion = N'" & rp_religion & "', "
			SQL = SQL & "rp_specialty = N'" & rp_specialty & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 병역여부
		If r_army = "Y" Then
			rp_army1			= InsertText(Request("rp_army1"))
			rp_army2			= InsertText(Request("rp_army2"))
			rp_army3			= InsertText(Request("rp_army3"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_army1 = N'" & rp_army1 & "', "
			SQL = SQL & "rp_army2 = N'" & rp_army2 & "', "
			SQL = SQL & "rp_army3 = N'" & rp_army3 & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 취업지원대상자 여부
		If r_job = "Y" Then
			rp_bohun			= InsertText(Request("rp_bohun"))
			rp_bohun_num	= InsertText(Request("rp_bohun_num"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_bohun = N'" & rp_bohun & "', "
			SQL = SQL & "rp_bohun_num = N'" & rp_bohun_num & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 장애인 여부
		If r_disabled = "Y" Then
			rp_dp1				= InsertText(Request("rp_dp1"))
			rp_dp2				= InsertText(Request("rp_dp2"))
			rp_dp_num		= InsertText(Request("rp_dp_num"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_dp1 = N'" & rp_dp1 & "', "
			SQL = SQL & "rp_dp2 = N'" & rp_dp2 & "', "
			SQL = SQL & "rp_dp_num = N'" & rp_dp_num & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 저소득층 여부
		If r_lower = "Y" Then
			rp_li1					= InsertText(Request("rp_li1"))
			rp_li2					= InsertText(Request("rp_li2"))
			rp_li3					= InsertText(Request("rp_li3"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_li1 = N'" & rp_li1 & "', "
			SQL = SQL & "rp_li2 = N'" & rp_li2 & "', "
			SQL = SQL & "rp_li3 = N'" & rp_li3 & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 신체
		If r_body = "Y" Then
			rp_height			= InsertText(Request("rp_height"))
			rp_weight			= InsertText(Request("rp_weight"))
			rp_eye_l				= InsertText(Request("rp_eye_l"))
			rp_eye_r				= InsertText(Request("rp_eye_r"))
			rp_top					= InsertText(Request("rp_top"))
			rp_bottom			= InsertText(Request("rp_bottom"))
			rp_footsize		= InsertText(Request("rp_footsize"))

			SQL = "UPDATE tbl_resume_profile SET "
			SQL = SQL & "rp_height = N'" & rp_height & "', "
			SQL = SQL & "rp_weight = N'" & rp_weight & "', "
			SQL = SQL & "rp_eye_l = N'" & rp_eye_l & "', "
			SQL = SQL & "rp_eye_r = N'" & rp_eye_r & "', "
			SQL = SQL & "rp_top = N'" & rp_top & "', "
			SQL = SQL & "rp_bottom = N'" & rp_bottom & "', "
			SQL = SQL & "rp_footsize = N'" & rp_footsize & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'지원자 가족관계
		If r_family = "Y" Then
			ReDim rf_rela(5), rf_name(5), rf_age(5), rf_job(5), rf_tog(5), family_idx(5)
			For i = 1 To 5
				family_idx(i-1)	= InsertText(Request("family_idx" & i))
				rf_rela(i-1)			= InsertText(Request("rf_rela" & i))
				rf_name(i-1)		= InsertText(Request("rf_name" & i))
				rf_age(i-1)			= InsertText(Request("rf_age" & i))
				rf_job(i-1)			= InsertText(Request("rf_job" & i))
				rf_tog(i-1)			= InsertText(Request("rf_tog" & i))

				If family_idx(i-1) <> "" And Not ISNULL(family_idx(i-1)) Then
					SQL = "UPDATE tbl_resume_family SET "
					SQL = SQL & "rf_rela = N'" & rf_rela(i-1) & "', "
					SQL = SQL & "rf_name = N'" & rf_name(i-1) & "', "
					SQL = SQL & "rf_age = N'" & rf_age(i-1) & "', "
					SQL = SQL & "rf_job = N'" & rf_job(i-1) & "', "
					SQL = SQL & "rf_tog = N'" & rf_tog(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&family_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					If rf_rela(i-1) <> "" Or rf_name(i-1) <> "" Or rf_age(i-1) <> "" Or rf_job(i-1) <> "" Or rf_tog(i-1) <> "" Then
						SQL = "INSERT INTO tbl_resume_family("
						SQL = SQL & "r_idx	, "
						SQL = SQL & "mid, "
						SQL = SQL & "mpw, "
						SQL = SQL & "rf_rela, "
						SQL = SQL & "rf_name, "
						SQL = SQL & "rf_age, "
						SQL = SQL & "rf_job, "
						SQL = SQL & "rf_tog) VALUES("
						SQL = SQL & "'" & r_idx & "',"
						SQL = SQL & "N'" & m_id & "',"
						SQL = SQL & "N'" & mpw & "',"
						SQL = SQL & "N'" & rf_rela(i-1) & "',"
						SQL = SQL & "N'" & rf_name(i-1) & "',"
						SQL = SQL & "N'" & rf_age(i-1) & "',"
						SQL = SQL & "N'" & rf_job(i-1) & "',"
						SQL = SQL & "N'" & rf_tog(i-1) & "')"
						DbCon.Execute SQL
					End If
				End If
			Next
		End If

		'지원자 자격증/면허증
		If r_license = "Y" Then
			licence				= InsertText(Request("licence"))
			If licence <> "" Then
				ReDim rl_licence(licence), rl_org(licence), rl_date(licence), licence_idx(licence)
				For i = 1 To licence
					licence_idx(i-1)	= InsertText(Request("licence_idx" & i))
					rl_licence(i-1)	= InsertText(Request("rl_licence" & i))
					rl_org(i-1)			= InsertText(Request("rl_org" & i))
					rl_date(i-1)		= InsertText(Request("rl_date" & i))

					If rl_licence(i-1) = "" And rl_org(i-1) = "" And rl_date(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_licence WHERE r_idx = '"&r_idx&"' AND idx = '"&licence_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_licence SET "
						SQL = SQL & "rl_licence = N'" & rl_licence(i-1) & "', "
						SQL = SQL & "rl_org = N'" & rl_org(i-1) & "', "
						SQL = SQL & "rl_date = N'" & rl_date(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&licence_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'OA능력
		If r_oa = "Y" Then
			rl_doc						= InsertText(Request("rl_doc"))
			rl_xls						= InsertText(Request("rl_xls"))
			rl_ppt						= InsertText(Request("rl_ppt"))
			rl_search				= InsertText(Request("rl_search"))

			SQL = "UPDATE tbl_resume_oa SET "
			SQL = SQL & "rl_doc = N'" & rl_doc & "', "
			SQL = SQL & "rl_xls = N'" & rl_xls & "', "
			SQL = SQL & "rl_ppt = N'" & rl_ppt & "', "
			SQL = SQL & "rl_search = N'" & rl_search & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'어학점수
		If r_language = "Y" Then
			language				= InsertText(Request("language"))
			If language <> "" Then
				ReDim rl_lang(language), rl_test(language), rl_score(language), rl_acq(language), language_idx(language)
				For i = 1 To language
					language_idx(i-1)	= InsertText(Request("language_idx" & i))
					rl_lang(i-1)			= InsertText(Request("rl_lang" & i))
					rl_test(i-1)				= InsertText(Request("rl_test" & i))
					rl_score(i-1)			= InsertText(Request("rl_score" & i))
					rl_acq(i-1)				= InsertText(Request("rl_acq" & i))

					If rl_lang(i-1) = "" And rl_test(i-1) = "" And rl_score(i-1) = "" And rl_acq(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_language WHERE r_idx = '"&r_idx&"' AND idx = '"&language_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_language SET "
						SQL = SQL & "rl_lang = N'" & rl_lang(i-1) & "', "
						SQL = SQL & "rl_test = N'" & rl_test(i-1) & "', "
						SQL = SQL & "rl_score = N'" & rl_score(i-1) & "', "
						SQL = SQL & "rl_acq = N'" & rl_acq(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&language_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'포트폴리오
		If r_portfolio = "Y" Then
			portfolio					= InsertText(Request("portfolio"))
			If portfolio <> "" Then
				ReDim port_folio(portfolio), portfolio_idx(portfolio)
				For i = 1 To portfolio
					portfolio_idx(i-1)	= InsertText(Request("portfolio_idx" & i))
					port_folio(i-1)		= InsertText(Request("portfolio" & i))

					If port_folio(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&portfolio_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_career SET "
						SQL = SQL & "rc_port1 = N'" & port_folio(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&portfolio_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'보유기술 및 능력
		If r_skill = "Y" Then
			skill						= InsertText(Request("skill"))
			If skill <> "" Then
			ReDim rc_skill1(skill), rc_skill_level(skill), rc_skill_detail(skill), skill_idx(skill)
			For i = 1 To skill
				skill_idx(i-1)				= InsertText(Request("skill_idx" & i))
				rc_skill1(i-1)				= InsertText(Request("rc_skill1" & i))
				rc_skill_level(i-1)		= InsertText(Request("rc_skill_level" & i))
				rc_skill_detail(i-1)	= InsertText(Request("rc_skill3" & i))

				If rc_skill1(i-1) = "" And rc_skill_level(i-1) = "" And rc_skill_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&skill_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_career SET "
					SQL = SQL & "rc_skill1 = N'" & rc_skill1(i-1) & "', "
					SQL = SQL & "rc_skill2 = N'" & rc_skill_level(i-1) & "', "
					SQL = SQL & "rc_skill3 = N'" & rc_skill_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&skill_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'경력사항
		If r_career = "Y" Then
			career						= InsertText(Request("career"))
			If career <> "" Then
			ReDim rc_career_sdate(career), rc_career_edate(career), rc_career_org(career), rc_career_detail(career), career_idx(career)
			For i = 1 To career
				career_idx(i-1)				= InsertText(Request("career_idx" & i))
				rc_career_sdate(i-1)	= InsertText(Request("rc_career_sdate" & i))
				rc_career_edate(i-1)	= InsertText(Request("rc_career_edate" & i))
				rc_career_org(i-1)			= InsertText(Request("rc_career_org" & i))
				rc_career_detail(i-1)	= InsertText(Request("rc_career_detail" & i))

				If rc_career_sdate(i-1) = "" And rc_career_edate(i-1) = "" And rc_career_org(i-1) = "" And rc_career_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&career_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_career SET "
					SQL = SQL & "rc_career_sdate = N'" & rc_career_sdate(i-1) & "', "
					SQL = SQL & "rc_career_edate = N'" & rc_career_edate(i-1) & "', "
					SQL = SQL & "rc_career_org = N'" & rc_career_org(i-1) & "', "
					SQL = SQL & "rc_career_detail = N'" & rc_career_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&career_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'사회경험
		If r_experience = "Y" Then
			society					= InsertText(Request("society"))
			If society <> "" Then
			ReDim rc_soc_sdate(society), rc_soc_edate(society), rc_soc_org(society), rc_soc_detail(society), society_idx(society)
			For i = 1 To society
				society_idx(i-1)		= InsertText(Request("society_idx" & i))
				rc_soc_sdate(i-1)	= InsertText(Request("rc_soc_sdate" & i))
				rc_soc_edate(i-1)	= InsertText(Request("rc_soc_edate" & i))
				rc_soc_org(i-1)		= InsertText(Request("rc_soc_org" & i))
				rc_soc_detail(i-1)	= InsertText(Request("rc_soc_detail" & i))

				If rc_soc_sdate(i-1) = "" And rc_soc_edate(i-1) = "" And rc_soc_org(i-1) = "" And rc_soc_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&society_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_career SET "
					SQL = SQL & "rc_soc_sdate = N'" & rc_soc_sdate(i-1) & "', "
					SQL = SQL & "rc_soc_edate = N'" & rc_soc_edate(i-1) & "', "
					SQL = SQL & "rc_soc_org = N'" & rc_soc_org(i-1) & "', "
					SQL = SQL & "rc_soc_detail = N'" & rc_soc_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&society_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'참여프로젝트
		If r_project = "Y" Then
			project					= InsertText(Request("project"))
			If project <> "" Then
			ReDim rc_proj_sdate(project), rc_proj_edate(project), rc_proj_name(project), rc_proj_detail(project), project_idx(project)
			For i = 1 To project
				project_idx(i-1)			= InsertText(Request("project_idx" & i))
				rc_proj_sdate(i-1)		= InsertText(Request("rc_proj_sdate" & i))
				rc_proj_edate(i-1)	= InsertText(Request("rc_proj_edate" & i))
				rc_proj_name(i-1)		= InsertText(Request("rc_proj_name" & i))
				rc_proj_detail(i-1)	= InsertText(Request("rc_proj_detail" & i))

				If rc_proj_sdate(i-1) = "" And rc_proj_edate(i-1) = "" And rc_proj_name(i-1) = "" And rc_proj_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&project_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_career SET "
					SQL = SQL & "rc_proj_sdate = N'" & rc_proj_sdate(i-1) & "', "
					SQL = SQL & "rc_proj_edate = N'" & rc_proj_edate(i-1) & "', "
					SQL = SQL & "rc_proj_name = N'" & rc_proj_name(i-1) & "', "
					SQL = SQL & "rc_proj_detail = N'" & rc_proj_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&project_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'수상내역/공모전
		If r_prime = "Y" Then
			prize						= InsertText(Request("prize"))
			If prize <> "" Then
			ReDim rc_pz_name(prize), rc_pz_org(prize), rc_pz_date(prize), prize_idx(prize)
			For i = 1 To prize
				prize_idx(i-1)			= InsertText(Request("prize_idx" & i))
				rc_pz_name(i-1)	= InsertText(Request("rc_pz_name" & i))
				rc_pz_org(i-1)		= InsertText(Request("rc_pz_org" & i))
				rc_pz_date(i-1)		= InsertText(Request("rc_pz_date" & i))

				If rc_pz_name(i-1) = "" And rc_pz_org(i-1) = "" And rc_pz_date(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND idx = '"&prize_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_career SET "
					SQL = SQL & "rc_pz_name = N'" & rc_pz_name(i-1) & "', "
					SQL = SQL & "rc_pz_org = N'" & rc_pz_org(i-1) & "', "
					SQL = SQL & "rc_pz_date = N'" & rc_pz_date(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&prize_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'해외연수 및 해외경험
		If r_training = "Y" Then
			training					= InsertText(Request("training"))
			If training <> "" Then
			ReDim re_os_sdate(training), re_os_edate(training), re_os_country(training), re_os_org(training), re_os_purpose(training), re_os_detail(training), training_idx(training)
			For i = 1 To training
				training_idx(i-1)		= InsertText(Request("training_idx" & i))
				re_os_sdate(i-1)		= InsertText(Request("re_os_sdate" & i))
				re_os_edate(i-1)		= InsertText(Request("re_os_edate" & i))
				re_os_country(i-1)	= InsertText(Request("re_os_country" & i))
				re_os_org(i-1)			= InsertText(Request("re_os_org" & i))
				re_os_purpose(i-1)	= InsertText(Request("re_os_purpose" & i))
				re_os_detail(i-1)		= InsertText(Request("re_os_detail" & i))

				If re_os_sdate(i-1) = "" And re_os_edate(i-1) = "" And re_os_country(i-1) = "" And re_os_org(i-1) = "" And re_os_purpose(i-1) = "" And re_os_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_education WHERE r_idx = '"&r_idx&"' AND idx = '"&training_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_education SET "
					SQL = SQL & "re_os_sdate = N'" & re_os_sdate(i-1) & "', "
					SQL = SQL & "re_os_edate = N'" & re_os_edate(i-1) & "', "
					SQL = SQL & "re_os_country = N'" & re_os_country(i-1) & "', "
					SQL = SQL & "re_os_org = N'" & re_os_org(i-1) & "', "
					SQL = SQL & "re_os_purpose = N'" & re_os_purpose(i-1) & "', "
					SQL = SQL & "re_os_detail = N'" & re_os_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&training_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'교육이수
		If r_complete = "Y" Then
			education				= InsertText(Request("education"))
			If education <> "" Then
			ReDim re_edu_sdate(education), re_edu_edate(education), re_edu_name(education), re_edu_org(education), re_edu_detail(education), education_idx(education)
			For i = 1 To education
				education_idx(i-1)	= InsertText(Request("education_idx" & i))
				re_edu_sdate(i-1)	= InsertText(Request("re_edu_sdate" & i))
				re_edu_edate(i-1)	= InsertText(Request("re_edu_edate" & i))
				re_edu_name(i-1)	= InsertText(Request("re_edu_name" & i))
				re_edu_org(i-1)			= InsertText(Request("re_edu_org" & i))
				re_edu_detail(i-1)	= InsertText(Request("re_edu_detail" & i))

				If re_edu_sdate(i-1) = "" And re_edu_edate(i-1) = "" And re_edu_name(i-1) = "" And re_edu_org(i-1) = "" And re_edu_detail(i-1) = "" Then
					SQL = " DELETE FROM tbl_resume_education WHERE r_idx = '"&r_idx&"' AND idx = '"&education_idx(i-1)&"' "
					DbCon.Execute SQL
				Else
					SQL = "UPDATE tbl_resume_education SET "
					SQL = SQL & "re_edu_sdate = N'" & re_edu_sdate(i-1) & "', "
					SQL = SQL & "re_edu_edate = N'" & re_edu_edate(i-1) & "', "
					SQL = SQL & "re_edu_name = N'" & re_edu_name(i-1) & "', "
					SQL = SQL & "re_edu_org = N'" & re_edu_org(i-1) & "', "
					SQL = SQL & "re_edu_detail = N'" & re_edu_detail(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&education_idx(i-1)&"' "
					DbCon.Execute SQL
				End If
			Next
			End If
		End If

		'SWOT 자기분석
		If r_swot = "Y" Then
			rs_s							= InsertText(Request("rs_s"))
			rs_w						= InsertText(Request("rs_w"))
			rs_o							= InsertText(Request("rs_o"))
			rs_t							= InsertText(Request("rs_t"))

			SQL = "UPDATE tbl_resume_swot SET "
			SQL = SQL & "rs_s = N'" & rs_s & "', "
			SQL = SQL & "rs_w = N'" & rs_w & "', "
			SQL = SQL & "rs_o = N'" & rs_o & "', "
			SQL = SQL & "rs_t = N'" & rs_t & "' WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'전략 (Strategy)
		If r_strategy = "Y" Then
			rs_so						= InsertText(Request("rs_so"))
			rs_st						= InsertText(Request("rs_st"))
			rs_wo						= InsertText(Request("rs_wo"))
			rs_wt						= InsertText(Request("rs_wt"))

			SQL = "UPDATE tbl_resume_swot SET "
			SQL = SQL & "rs_so = N'" & rs_so & "', "
			SQL = SQL & "rs_st = N'" & rs_st & "', "
			SQL = SQL & "rs_wo = N'" & rs_wo & "', "
			SQL = SQL & "rs_wt = N'" & rs_wt & "'WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
			DbCon.Execute SQL
		End If

		'기타 파일 첨부 (증명서 등)
		If r_etc = "Y" Then
			url							= InsertText(Request("url"))
			If url <> "" Then
				ReDim url_idx(url), urlT(url)
				For i = 1 To url
					url_idx(i-1)		= InsertText(Request("url_idx" & i))
					urlT(i-1)			= InsertText(Request("ri_url" & i))

					If urlT(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND idx = '"&url_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_intro SET "
						SQL = SQL & "ri_url = N'" & urlT(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&url_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'추가삽입용
		If r_add_cnt > 0 Then
			add							= InsertText(Request("add"))
			If add <> "" Then
				ReDim add_idx(add), ri_add_title(add), ri_add_content(add)
				For i = 1 To add
					add_idx(i-1)				= InsertText(Request("add_idx" & i))
					ri_add_title(i-1)		= InsertText(Request("ri_add_title" & i))
					ri_add_content(i-1)	= InsertText(Request("ri_add_content" & i))

					If ri_add_title(i-1) = "" And ri_add_content(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND idx = '"&add_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_intro SET "
						SQL = SQL & "ri_add_title = N'" & ri_add_title(i-1) & "', "
						SQL = SQL & "ri_add_content = N'" & ri_add_content(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&add_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

		'자기소개서
		If r_introduction = "Y" Then
			intro							= InsertText(Request("intro"))
			If intro <> "" Then
				ReDim intro_idx(intro), ri_intro_title(intro), ri_intro_content(intro)
				For i = 1 To intro
					intro_idx(i-1)					= InsertText(Request("intro_idx" & i))
					ri_intro_title(i-1)			= InsertText(Request("ri_intro_title" & i))
					ri_intro_content(i-1)	= InsertText(Request("ri_intro_content" & i))

					If ri_intro_title(i-1) = "" And ri_intro_content(i-1) = "" Then
						SQL = " DELETE FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND idx = '"&intro_idx(i-1)&"' "
						DbCon.Execute SQL
					Else
						SQL = "UPDATE tbl_resume_intro SET "
						SQL = SQL & "ri_intro_title = N'" & ri_intro_title(i-1) & "', "
						SQL = SQL & "ri_intro_content = N'" & ri_intro_content(i-1) & "' WHERE r_idx = '" & r_idx & "' AND idx = '"&intro_idx(i-1)&"' "
						DbCon.Execute SQL
					End If
				Next
			End If
		End If

	ElseIf mode = "del" Then

		'기본정보
		SQL = "DELETE FROM tbl_resume WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_career WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_education WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_family WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_intro WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_language WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_licence WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_oa WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_profile WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_school WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

		SQL = "DELETE FROM tbl_resume_swot WHERE r_idx = '" & r_idx & "' AND resumeid = '"&resumeid&"' "
		DbCon.Execute SQL

	End If

	If per = "ALL" Then
		Response.Write "<script>alert('완료 되었습니다.'); location.href='application-list.asp';</script>"
	Else
		Response.Write "<script>alert('완료 되었습니다.'); location.href='application.asp?r_idx=" & r_idx & "&recruit=" & recruit & "';</script>"
	End If
%>