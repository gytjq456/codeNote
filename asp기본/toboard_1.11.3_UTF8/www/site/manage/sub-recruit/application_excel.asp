<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp"-->
<!--#include virtual="/site/common/function.asp"-->
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.xl2225652{
	mso-ignore:padding;
	mso-generic-font-family:auto;
	mso-font-charset:129;
	mso-number-format:"\@";
	mso-background-source:auto;
	mso-pattern:auto;
}
.tblhead1{
	background-color:#FFAA99
}
.tblhead2{
	background-color:#CCAAFF
}
</style>
</head>
<%
	Response.CacheControl = "public" 
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-disposition","attachment;filename=전체지원자리스트_" & Date() & ".xls"
	
	sel_idx		= Request("sel_idx")
	r_birth1		= Request("s_r_birth1")
	birth			= Request("s_birth")
	r_addr			= Request("s_r_addr")
	rs_school	= Request("s_rs_school")
	r_name		= Request("s_r_name")
%>

<table>
	<tr>
		<th class="tblhead1">공고 명</th>
		<th class="tblhead1">지원 명</th>
		<th class="tblhead1">지원분야</th>
		<th class="tblhead1">희망연봉</th>
		<th class="tblhead1">사진</th>
		<th class="tblhead1">이름</th>
		<th class="tblhead1">생년월일</th>
		<th class="tblhead1">핸드폰</th>
		<th class="tblhead1">주소</th>
		<th class="tblhead1">이메일</th>
		<% For i = 1 To 10 %>
		<th class="tblhead1">재학기간<%=i%></th>
		<th class="tblhead1">학력사항<%=i%></th>
		<th class="tblhead1">전공<%=i%></th>
		<th class="tblhead1">학점<%=i%></th>
		<% Next %>
		<th class="tblhead1">결혼여부</th>
		<th class="tblhead1">혈액형</th>
		<th class="tblhead1">취 미</th>
		<th class="tblhead1">특 기</th>
		<th class="tblhead1">종 교</th>
		<th class="tblhead1">병역여부</th>
		<th class="tblhead1">면제사유</th>
		<th class="tblhead1">보훈대상</th>
		<th class="tblhead1">보훈번호</th>
		<th class="tblhead1">장애종별</th>
		<th class="tblhead1">등급</th>
		<th class="tblhead1">장애인 등록번호</th>
		<th class="tblhead1">지원자 저소득층 여부</th>
		<th class="tblhead1">「국민기초생활보장법」상 수급자</th>
		<th class="tblhead1">장애인 「한부모가족지원법」상 보호대상자</th>
		<th class="tblhead1">신 장</th>
		<th class="tblhead1">체 중</th>
		<th class="tblhead1">시 력</th>
		<th class="tblhead1">상 의</th>
		<th class="tblhead1">하 의</th>
		<th class="tblhead1">신발사이즈</th>
		<% For i = 1 To 10 %>
		<th class="tblhead1">관계<%=i%></th>
		<th class="tblhead1">성명<%=i%></th>
		<th class="tblhead1">연령<%=i%></th>
		<th class="tblhead1">현재직업<%=i%></th>
		<th class="tblhead1">동거여부<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">자격증/면허증<%=i%></th>
		<th class="tblhead1">발행처/발행기관<%=i%></th>
		<th class="tblhead1">취득일<%=i%></th>
		<% Next %>
		<th class="tblhead1">문서작성</th>
		<th class="tblhead1">스프레드시트(엑셀)</th>
		<th class="tblhead1">프리젠테이션</th>
		<th class="tblhead1">정보검색</th>
		<% For i = 1 To 10 %>
		<th class="tblhead1">언어<%=i%></th>
		<th class="tblhead1">어학시험<%=i%></th>
		<th class="tblhead1">시험점수(등급)<%=i%></th>
		<th class="tblhead1">취득일<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">포트폴리오 URL<%=i%></th>
		<th class="tblhead1">포트폴리오 파일<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">보유기술 및 능력<%=i%></th>
		<th class="tblhead1">수준<%=i%></th>
		<th class="tblhead1">상세내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">경력사항 기간<%=i%></th>
		<th class="tblhead1">경력사항 기관명<%=i%></th>
		<th class="tblhead1">경력사항 세부 내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">사회 경험 기간<%=i%></th>
		<th class="tblhead1">사회 경험 기관 및 장소<%=i%></th>
		<th class="tblhead1">사회 경험 세부 내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">프로젝트 기간<%=i%></th>
		<th class="tblhead1">프로젝트명<%=i%></th>
		<th class="tblhead1">프로젝트 세부 내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">수상명<%=i%></th>
		<th class="tblhead1">수여기관<%=i%></th>
		<th class="tblhead1">수상일자<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">해외연수 및 해외경험 기간<%=i%></th>
		<th class="tblhead1">해외연수 및 해외경험 국가명<%=i%></th>
		<th class="tblhead1">해외연수 및 해외경험 연수기관(학교) 및 단체<%=i%></th>
		<th class="tblhead1">해외연수 및 해외경험 목적<%=i%></th>
		<th class="tblhead1">해외연수 및 해외경험 세부 내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 10 %>
		<th class="tblhead1">교육이수 기간<%=i%></th>
		<th class="tblhead1">교육이수 교육명<%=i%></th>
		<th class="tblhead1">교육이수 교육기관명<%=i%></th>
		<th class="tblhead1">교육이수 세부 내용<%=i%></th>
		<% Next %>
		<th class="tblhead1">강점 (Strength)</th>
		<th class="tblhead1">약점 (Weakness)</th>
		<th class="tblhead1">기회 (Opportunities)</th>
		<th class="tblhead1">위협 (Threats)</th>
		<th class="tblhead1">SO전략 (강점-기회전략)</th>
		<th class="tblhead1">ST전략 (강점-위협전략)</th>
		<th class="tblhead1">WO전략 (약점-기회전략)</th>
		<th class="tblhead1">WT전략 (약점-위협전략)</th>
		<% For i = 1 To 10 %>
		<th class="tblhead1">기타 URL<%=i%></th>
		<th class="tblhead1">기타 파일<%=i%></th>
		<% Next %>
		<% For i = 1 To 5 %>
		<th class="tblhead1">추가등록 제목<%=i%></th>
		<th class="tblhead1">추가등록 내용<%=i%></th>
		<% Next %>
		<% For i = 1 To 5 %>
		<th class="tblhead1">자기소개서 제목<%=i%></th>
		<th class="tblhead1">자기소개서 내용<%=i%></th>
		<% Next %>
	</tr>
	<%
		ArrId			= Split(sel_idx, ", ")

		m_id_txt = "('"
		For Each b In ArrId
			m_id_txt = m_id_txt & b & "', '"
		Next
		m_id_txt = m_id_txt & "')"
		
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT A.idx, A.recruit, A.com_NM, A.work_NM, B.idx AS ridx, B.r_idx, B.r_title, B.r_sort, B.r_pay, B.mid, B.r_name, B.r_hp, B.r_birth1, B.r_birth2, B.r_birth3, B.r_addr, B.r_email, B.r_file1, B.r_file, B.state, B.regdate FROM tbl_recruit A LEFT JOIN tbl_resume B ON A.idx = B.r_idx WHERE B.r_idx != '' "

		If sel_idx <> "" Then
			SQL = SQL & " AND (B.idx IN " & m_id_txt & ") "
		End If
		
		If r_birth1 <> "" Then
			If birth = "up" Then
				SQL = SQL & " AND (B.r_birth1 >= '" & r_birth1 & "') "
			ElseIf birth = "down" Then
				SQL = SQL & " AND (B.r_birth1 <= '" & r_birth1 & "') "
			Else
				SQL = SQL & " AND (B.r_birth1 LIKE '%" & r_birth1 & "%') "
			End If
		End If

		If r_addr <> "" Then
			SQL = SQL & " AND (B.r_addr LIKE '%" & r_addr & "%') "
		End If

		If rs_school <> "" Then
			SQL = SQL & " AND B.mid = (SELECT mid FROM tbl_resume_school WHERE rs_school LIKE '%"&rs_school&"%') "
		End If

		If r_name <> "" Then
			SQL = SQL & " AND (B.r_name LIKE '%" & r_name & "%') "
		End If

		SQL = SQL & " ORDER BY B.idx DESC"

		Rs.Open SQL, Dbcon, 1

		Do Until Rs.EOF

			r_idx		= Rs("idx")
			com_NM	= Rs("com_NM")
			r_mid		= Rs("mid")
			r_title		= Rs("r_title")
			r_sort		= Rs("r_sort")
			r_pay		= Rs("r_pay")
			r_file1		= Rs("r_file1")
			r_name	= Rs("r_name")
			r_birth1	= Rs("r_birth1")
			r_birth2	= Rs("r_birth2")
			r_birth3	= Rs("r_birth3")
			r_hp		= Rs("r_hp")
			r_addr		= Rs("r_addr")
			r_email	= Rs("r_email")
			r_file		= Rs("r_file")
			state		= Rs("state")
	%>
	<tr>
		<td class="xl2225652"><%=com_NM%></td>
		<td class="xl2225652"><%=r_title%></td>
		<td class="xl2225652"><%=r_sort%></td>
		<td class="xl2225652"><%=r_pay%></td>
		<td class="xl2225652"><% If r_file1 <> "" And Not ISNULL(r_file1) Then %><img src="http://humancore.webmoa21.co.kr/upload/recruit/<%=r_file1%>" width="50"><% End If %></td>
		<td class="xl2225652"><%=r_name%></td>
		<td class="xl2225652"><%=r_birth1&"-"&r_birth2&"-"&r_birth3%></td>
		<td class="xl2225652"><%=r_hp%></td>
		<td class="xl2225652"><%=r_addr%></td>
		<td class="xl2225652"><%=r_email%></td>
		<%
			'학력사항
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_school WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rs_sdate					= objview("rs_sdate")
					rs_edate				= objview("rs_edate")
					rs_school				= objview("rs_school")
					rs_major					= objview("rs_major")
					rs_score					= objview("rs_score")
					rs_major_detail	= objview("rs_major_detail")
		%>
		<td class="xl2225652"><%=rs_sdate%> ~ <%=rs_edate%></td>
		<td class="xl2225652"><%=rs_school%></td>
		<td class="xl2225652"><%=rs_major%></td>
		<td class="xl2225652"><%=rs_score%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_profile WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			If objview.EOF = False Then
				m_id					= objview("mid")
				rp_marry				= objview("rp_marry")
				rp_hobby			= objview("rp_hobby")
				rp_blood			= objview("rp_blood")
				rp_religion		= objview("rp_religion")
				rp_specialty		= objview("rp_specialty")
				rp_army1			= objview("rp_army1")
				rp_army2			= objview("rp_army2")
				rp_army3			= objview("rp_army3")
				rp_bohun			= objview("rp_bohun")
				rp_bohun_num	= objview("rp_bohun_num")
				rp_dp1				= objview("rp_dp1")
				rp_dp2				= objview("rp_dp2")
				rp_dp_num		= objview("rp_dp_num")
				rp_li1					= objview("rp_li1")
				rp_li2					= objview("rp_li2")
				rp_li3					= objview("rp_li3")
				rp_height			= objview("rp_height")
				rp_weight			= objview("rp_weight")
				rp_eye_l				= objview("rp_eye_l")
				rp_eye_r				= objview("rp_eye_r")
				rp_top					= objview("rp_top")
				rp_bottom			= objview("rp_bottom")
				rp_footsize		= objview("rp_footsize")
			End If
			objview.Close
			Set objview = Nothing
		%>
		<td class="xl2225652"><%=rp_marry%></td>
		<td class="xl2225652"><%=rp_blood%></td>
		<td class="xl2225652"><%=rp_hobby%></td>
		<td class="xl2225652"><%=rp_specialty%></td>
		<td class="xl2225652"><%=rp_religion%></td>
		<td class="xl2225652"><%=rp_army1%>(<%=rp_army2%>)</td>
		<td class="xl2225652"><%=rp_army3%></td>
		<td class="xl2225652"><%=rp_bohun%></td>
		<td class="xl2225652"><%=rp_bohun_num%></td>
		<td class="xl2225652"><%=rp_dp1%></td>
		<td class="xl2225652"><%=rp_dp2%></td>
		<td class="xl2225652"><%=rp_dp_num%></td>
		<td class="xl2225652"><%=rp_li1%></td>
		<td class="xl2225652"><%=rp_li2%></td>
		<td class="xl2225652"><%=rp_li3%></td>
		<td class="xl2225652"><%=rp_height%></td>
		<td class="xl2225652"><%=rp_weight%></td>
		<td class="xl2225652">좌 : <%=rp_eye_l%> 우 : <%=rp_eye_r%></td>
		<td class="xl2225652"><%=rp_top%></td>
		<td class="xl2225652"><%=rp_bottom%></td>
		<td class="xl2225652"><%=rp_footsize%></td>
		<%
			'가족관계
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_family WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rf_rela	= objview("rf_rela")
					rf_name	= objview("rf_name")
					rf_age		= objview("rf_age")
					rf_job		= objview("rf_job")
					rf_tog		= objview("rf_tog")
		%>
		<td class="xl2225652"><%=rf_rela%></td>
		<td class="xl2225652"><%=rf_name%></td>
		<td class="xl2225652"><%=rf_age%></td>
		<td class="xl2225652"><%=rf_job%></td>
		<td class="xl2225652"><%=rf_tog%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'자격증/면허증
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_licence WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rl_licence	= objview("rl_licence")
					rl_org			= objview("rl_org")
					rl_date		=	 objview("rl_date")
		%>
		<td class="xl2225652"><%=rl_licence%></td>
		<td class="xl2225652"><%=rl_org%></td>
		<td class="xl2225652"><%=rl_date%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_oa WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			If objview.EOF=False Then
				rl_doc			= objview("rl_doc")
				rl_xls			= objview("rl_xls")
				rl_ppt			= objview("rl_ppt")
				rl_search	= objview("rl_search")
			End If
			objview.Close
			Set objview = Nothing
		%>
		<td class="xl2225652"><%=rl_doc%></td>
		<td class="xl2225652"><%=rl_xls%></td>
		<td class="xl2225652"><%=rl_ppt%></td>
		<td class="xl2225652"><%=rl_search%></td>
		<%
			'어학점수
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_language WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rl_lang	= objview("rl_lang")
					rl_test		= objview("rl_test")
					rl_score	= objview("rl_score")
					rl_acq		= objview("rl_acq")
		%>
		<td class="xl2225652"><%=rl_lang%></td>
		<td class="xl2225652"><%=rl_test%></td>
		<td class="xl2225652"><%=rl_score%></td>
		<td class="xl2225652"><%=rl_acq%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'포트폴리오 URL
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'portfolio' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_port1			= objview("rc_port1")
		%>
		<td class="xl2225652"><%=rc_port1%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'포트폴리오 FILE
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'file' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_port2	= objview("rc_port2")
		%>
		<td class="xl2225652"><%=rc_port2%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'보유기술 및 능력
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'skill' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_skill1	= objview("rc_skill1")
					rc_skill2	= objview("rc_skill2")
					rc_skill3	= objview("rc_skill3")
		%>
		<td class="xl2225652"><%=rc_skill1%></td>
		<td class="xl2225652"><%=rc_skill2%></td>
		<td class="xl2225652"><%=rc_skill3%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'경력사항
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'career' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_career_sdate	= objview("rc_career_sdate")
					rc_career_edate	= objview("rc_career_edate")
					rc_career_org		= objview("rc_career_org")
					rc_career_detail	= objview("rc_career_detail")
		%>
		<td class="xl2225652"><%=rc_career_sdate&" ~ "&rc_career_edate%></td>
		<td class="xl2225652"><%=rc_career_org%></td>
		<td class="xl2225652"><%=rc_career_detail%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'사회 경험
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'society' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_soc_sdate		= objview("rc_soc_sdate")
					rc_soc_edate		= objview("rc_soc_edate")
					rc_soc_org			= objview("rc_soc_org")
					rc_soc_detail	= objview("rc_soc_detail")
		%>
		<td class="xl2225652"><%=rc_soc_sdate&" ~ "&rc_soc_edate%></td>
		<td class="xl2225652"><%=rc_soc_org%></td>
		<td class="xl2225652"><%=rc_soc_detail%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'참여 프로젝트
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'project' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_proj_sdate	= objview("rc_proj_sdate")
					rc_proj_edate	= objview("rc_proj_edate")
					rc_proj_name	= objview("rc_proj_name")
					rc_proj_detail	= objview("rc_proj_detail")
		%>
		<td class="xl2225652"><%=rc_proj_sdate&" ~ "&rc_proj_edate%></td>
		<td class="xl2225652"><%=rc_proj_name%></td>
		<td class="xl2225652"><%=rc_proj_detail%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'수상내역/공모전
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND rc_title = 'prize' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					rc_pz_name	= objview("rc_pz_name")
					rc_pz_org		= objview("rc_pz_org")
					rc_pz_date		= objview("rc_pz_date")
		%>
		<td class="xl2225652"><%=rc_pz_name%></td>
		<td class="xl2225652"><%=rc_pz_org%></td>
		<td class="xl2225652"><%=rc_pz_date%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'해외연수 및 해외경험
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_education WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND re_title = 'training' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					re_os_sdate		= objview("re_os_sdate")
					re_os_edate		= objview("re_os_edate")
					re_os_country	= objview("re_os_country")
					re_os_org			= objview("re_os_org")
					re_os_purpose	= objview("re_os_purpose")
					re_os_detail		= objview("re_os_detail")
		%>
		<td class="xl2225652"><%=re_os_sdate&" ~ "&re_os_edate%></td>
		<td class="xl2225652"><%=re_os_country%></td>
		<td class="xl2225652"><%=re_os_org%></td>
		<td class="xl2225652"><%=re_os_purpose%></td>
		<td class="xl2225652"><%=re_os_detail%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'교육이수
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_education WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND re_title = 'education' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					re_edu_sdate	= objview("re_edu_sdate")
					re_edu_edate	= objview("re_edu_edate")
					re_edu_name	= objview("re_edu_name")
					re_edu_org		= objview("re_edu_org")
					re_edu_detail	= objview("re_edu_detail")
		%>
		<td class="xl2225652"><%=re_edu_sdate&" ~ "&re_edu_edate%></td>
		<td class="xl2225652"><%=re_edu_name%></td>
		<td class="xl2225652"><%=re_edu_org%></td>
		<td class="xl2225652"><%=re_edu_detail%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_swot WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' "
			objview.Open SQL, Dbcon, 1
			If objview.EOF=False Then
				rs_s		= objview("rs_s")
				rs_w	= objview("rs_w")
				rs_o		= objview("rs_o")
				rs_t		= objview("rs_t")
				rs_so	= objview("rs_so")
				rs_st	= objview("rs_st")
				rs_wo	= objview("rs_wo")
				rs_wt	= objview("rs_wt")
			End If
			objview.Close
			Set objview = Nothing
		%>
		<td class="xl2225652"><%=rs_s%></td>
		<td class="xl2225652"><%=rs_w%></td>
		<td class="xl2225652"><%=rs_o%></td>
		<td class="xl2225652"><%=rs_t%></td>
		<td class="xl2225652"><%=rs_so%></td>
		<td class="xl2225652"><%=rs_st%></td>
		<td class="xl2225652"><%=rs_wo%></td>
		<td class="xl2225652"><%=rs_wt%></td>
		<%
			'기타 URL
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND ri_title = 'url' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					ri_url	= objview("ri_url")
		%>
		<td class="xl2225652"><%=ri_url%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'기타 파일
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND ri_title = 'e_file' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					ri_file	= objview("ri_url")
		%>
		<td class="xl2225652"><%=ri_file%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 10 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 10
		%>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'추가삽입용
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND ri_title = 'add' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					ri_add_title		= objview("ri_add_title")
					ri_add_content	= objview("ri_add_content")
		%>
		<td class="xl2225652"><%=ri_add_title%></td>
		<td class="xl2225652"><%=ri_add_content%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 5 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 5
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
		<%
			'자기소개서
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE r_idx = '"&r_idx&"' AND mid = '"&r_mid&"' AND mid <> '' AND ri_title = 'intro' "
			objview.Open SQL, Dbcon, 1
			r_num = 0
			If objview.EOF=False Then
				r_num = 1
				Do Until objview.EOF
					ri_intro_title			= objview("ri_intro_title")
					ri_intro_content	= objview("ri_intro_content")
		%>
		<td class="xl2225652"><%=ri_intro_title%></td>
		<td class="xl2225652"><%=ri_intro_content%></td>
		<%
					r_num = r_num + 1
				objview.MoveNext
				Loop
			End If
			objview.Close
			Set objview = Nothing

			If r_num-1 < 5 Then
				If r_num = 0 Then r_num = 1
				For t = r_num To 5
		%>
		<td class="xl2225652"></td>
		<td class="xl2225652"></td>
		<%
				Next
			End If
		%>
	</tr>
	<%
		Rs.MoveNext
		Loop
		Rs.Close
		Set Rs = Nothing
	%>
</table>