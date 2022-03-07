<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%
	q="prod"
%>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
var fnObj = {
	pageStart: function(){
		$("#s_srdate").bindDate({align:"right", valign:"bottom", onChange:{
				earlierThan:"s_erdate", err:"종료일보다 빠른 날짜를 선택하세요",
				onChange:function(){
				}
			}
		});
		$("#s_erdate").bindDate({align:"right", valign:"bottom", onChange:{laterThan:"s_srdate", err:"시작일보다 느린 날짜를 선택하세요"}});
	}
};

$(document.body).ready(function(){
	setTimeout(fnObj.pageStart, 1);
});

$(function() {

	//인증서 팝업
	var popup = $(".popupBox");
	$(".certCon img").click(function(){
		var img = $(this).attr("src");
		popup.find("img").attr("src", img);
		popup.show();
	});
	popup.find("i").click(function(){
		popup.hide();
	});

});
</script>
</head>

<%
	resumeid	= Request("resumeid")
	r_idx			= Request("r_idx")
	m_id			= Request("m_id")
	per				= Request("per")
	
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
	
	idx		= Request("idx")
	mode	= Request("mode")
	If mode = "" Then mode = "reg"

	s_keyword	= Request("s_keyword")
	s_hide		= Request("s_hide")
	page			= Request("page")

	pLink = "s_keyword=" & s_keyword & "&s_cate1=" & s_cate1 & "&s_cate2=" & s_cate2 & "&s_cate3=" & s_cate3 & "&s_hide=" & s_hide & "&r_idx=" & r_idx & "&page=" & page

	If mode = "mod" Then
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT * FROM tbl_resume WHERE resumeid = '" & resumeid & "' "
		If W_ID = "webmoa" Then Response.write SQL
		Rs.Open SQL, Dbcon, 1
		If Rs.EOF=False Then
			resume_idx	= Rs("idx")
			r_idx				= Rs("r_idx")
			m_id				= Rs("mid")
			mpw				= Rs("mpw")
			r_title				= Rs("r_title")
			r_sort				= Rs("r_sort")
			r_pay				= Rs("r_pay")
			r_name			= Rs("r_name")
			r_birth1			= Rs("r_birth1")
			r_birth2			= Rs("r_birth2")
			r_birth3			= Rs("r_birth3")
			r_hp				= Rs("r_hp")
			r_addr				= Rs("r_addr")
			r_email			= Rs("r_email")
			r_file1				= Rs("r_file1")
			state				= Rs("state")
			regdate			= Rs("regdate")
		End If
		Rs.Close
		Set Rs = Nothing
	End If

	r_hp	=	split(r_hp&"--","-")
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>지원자 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>지원자 관리</li>
	</ul>
</div>
<!-- //location -->

<!--팝업-->
		<div class="popupBox">
			<div>
				<i>CLOSE</i>
				<img src="#;" alt="">
			</div>
		</div>
		<!--//팝업-->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="application-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>&recruit=<%=recruit%>" onsubmit="return RegChk(this)" >
	<input type="hidden" name="recruit" value="<%=recruit%>">
	<input type="hidden" name="idx" value="<%=resume_idx%>">
	<input type="hidden" name="per" value="<%=per%>">
	<input type="hidden" name="m_id" value="<%=m_id%>">
	<input type="hidden" name="mpw" value="<%=mpw%>">
	<input type="hidden" name="r_idx" value="<%=r_idx%>">
	<input type="hidden" name="resumeid" value="<%=resumeid%>">
		<div class="tb_info">
			<h4>지원자 진행여부</h4>
			<table>
				<caption>진행여부</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">진행여부</span></th>
					<td colspan="3" class="bdt">
						<select name="state" class="AXSelect">
							<option value="0"<% If state = "0" Then Response.write " selected"%>>서류전형</option>
							<option value="1"<% If state = "1" Then Response.write " selected"%>>서류합격</option>
							<option value="2"<% If state = "2" Then Response.write " selected"%>>서류불합격</option>
							<option value="3"<% If state = "3" Then Response.write " selected"%>>면접합격</option>
							<option value="4"<% If state = "4" Then Response.write " selected"%>>면접불합격</option>
							<option value="5"<% If state = "5" Then Response.write " selected"%>>최종합격</option>
							<option value="6"<% If state = "6" Then Response.write " selected"%>>지원취소</option>
							<option value="8"<% If state = "8" Then Response.write " selected"%>>삭제요청</option>
							<option value="9"<% If state = "9" Then Response.write " selected"%>>임시저장</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		
		<% If recruit <> "1" Then %>
		<div class="tb_info">
			<h4>지원자 지원 정보</h4>
			<table>
				<caption>지원분야</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">지원 명</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_title" class="AXInput W1000" value="<%=r_title%>"  style="width:70%"/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">지원분야</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_sort" class="AXInput W200" value="<%=r_sort%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">희망연봉</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_pay" class="AXInput W130" value="<%=r_pay%>" /> 만원</td>
				</tr>
			</table>
		</div>
		<% End if %>
		
		<% If r_info = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 기본 정보</h4>
			<table>
				<caption>지원자 기본 정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">사진</span></th>
					<td colspan="3" class="bdt certCon"><%If r_file1 <> "" And Not ISNULL(r_file1) Then %><a href="javascript:;"><img src="/upload/recruit/<%=r_file1%>" width="100px" border="0"></a><% End If %></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">이름</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_name" class="AXInput W130" value="<%=r_name%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">생년월일</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_birth1" class="AXInput W100" value="<%=r_birth1%>" /> - <input type="text" name="r_birth2" class="AXInput W100" value="<%=r_birth2%>" /> - <input type="text" name="r_birth3" class="AXInput W100" value="<%=r_birth3%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">핸드폰</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_hp1" class="AXInput W100" value="<%=r_hp(0)%>" /> - <input type="text" name="r_hp2" class="AXInput W100" value="<%=r_hp(1)%>" /> - <input type="text" name="r_hp3" class="AXInput W100" value="<%=r_hp(2)%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">주소</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_addr" class="AXInput " value="<%=r_addr%>" style="width:70%"/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">이메일</span></th>
					<td colspan="3" class="bdt"><input type="text" name="r_email" class="AXInput W300" value="<%=r_email%>" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<%
			If r_education = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_school WHERE resumeid = '" & resumeid & "' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 학력사항</h4>
			<table>
				<colgroup>
					<col width="250px" />
					<col width="" />
					<col width="300px" />
					<col width="200px" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">재학기간</th>
					<th class="title bdr bdt">학력사항</th>
					<th class="title bdr bdt">전공</th>
					<th class="title bdr bdt">학점</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							school_idx				= objview("idx")
							r_idx						= objview("r_idx")
							m_id						= objview("mid")
							rs_sdate					= objview("rs_sdate")
							rs_edate				= objview("rs_edate")
							rs_school				= objview("rs_school")
							rs_major					= objview("rs_major")
							rs_score					= objview("rs_score")
							rs_major_detail	= objview("rs_major_detail")
				%>
				<tr>
					<td class="title bdr bdt">
						<input type="hidden" name="school_idx<%=num%>" value="<%=school_idx%>">
						<input type="text" value="<%=rs_sdate%>" name="rs_sdate<%=num%>" class="AXInput W70" />
						<span class="middle">~</span>
						<input type="text" value="<%=rs_edate%>" name="rs_edate<%=num%>" class="AXInput W70" />
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=rs_school%>" name="rs_school<%=num%>" class="AXInput W300" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rs_major%>" name="rs_major<%=num%>" class="AXInput W200" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rs_score%>" name="rs_score<%=num%>" class="AXInput w70" /> /4.0</td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="school" value="<%=num-1%>">
				<tr>
					<th class="title bdr bdt">세부전공</th>
					<td colspan="3" class="title bdr bdt"><input name="rs_major_detail" class="AXInput" style="width:98%" type="text" placeholder="석사 / 박사의 경우만 해당" value="<%=rs_major_detail%>"></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<%
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_profile WHERE resumeid = '" & resumeid & "' "
			objview.Open SQL, Dbcon, 1
			If objview.EOF = False Then
				profile_idx			= objview("idx")
				r_idx					= objview("r_idx")
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

		<% If r_personal = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 개인 신상정보</h4>
			<table>
				<caption>지원자 개인 신상정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">결혼여부</span></th>
					<td colspan="3" class="bdt">
						<select class="AXSelect" name="rp_marry">
							<option value="N"<% If rp_marry = "N" Then Response.write " selected"%>>미혼</option>
							<option value="Y"<% If rp_marry = "Y" Then Response.write " selected"%>>기혼</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">혈액형</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_blood%>" name="rp_blood" class="AXInput w100" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">취 미</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_hobby%>" name="rp_hobby" class="AXInput W200" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">특 기</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_specialty%>" name="rp_specialty" class="AXInput W200" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">종 교</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_religion%>" name="rp_religion" class="AXInput w100" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<% If r_army = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 병역여부</h4>
			<table>
				<caption>지원자 병역여부</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">병역여부</span></th>
					<td colspan="3" class="bdt">
						<select class="AXSelect" name="rp_army1" class="AXSelect">
							<option value="군필"<% If rp_army1 = "군필" Then Response.write " selected"%>>군필</option>
							<option value="미필"<% If rp_army1 = "미필" Then Response.write " selected"%>>미필</option>
							<option value="해당없음"<% If rp_army1 = "해당없음" Then Response.write " selected"%>>해당없음</option>
						</select>
						<input type="text" value="<%=rp_army2%>" name="rp_army2" class="AXInput" placeholder="0000/00 ~ 0000/00 | 육군 | 병장 | 만기제대" style="width:70%"/>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">면제사유</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_army3%>" name="rp_army3" class="AXInput" placeholder="면제 대상자 / 만기 이전 전역시 이유 명시" style="width:70%"/></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<% If r_job = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 취업지원대상자 여부</h4>
			<table>
				<caption>지원자 취업지원대상자 여부</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">보훈대상</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_bohun%>" name="rp_bohun" class="AXInput W130" placeholder="해당 여부" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">보훈번호</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_bohun_num%>" name="rp_bohun_num" class="AXInput W130" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<% If r_disabled = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 장애인 여부</h4>
			<table>
				<caption>지원자 장애인 여부</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">장애종별</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_dp1%>" name="rp_dp1" class="AXInput W130" placeholder="해당 여부" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">등급</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_dp2%>" name="rp_dp2" class="AXInput W130" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">장애인 등록번호</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_dp_num%>" name="rp_dp_num" class="AXInput W130" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<% If r_lower = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 저소득층 여부</h4>
			<table>
				<caption>지원자 저소득층 여부</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">구 분</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_li1%>" name="rp_li1" class="AXInput W130" placeholder="해당 여부" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">「국민기초생활보장법」상 수급자</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_li2%>" name="rp_li2" class="AXInput W130" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">장애인 「한부모가족지원법」상 보호대상자</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_li3%>" name="rp_li3" class="AXInput W130" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<% If r_body = "Y" Then %>
		<div class="tb_info">
			<h4>지원자 신체</h4>
			<table>
				<caption>지원자 신체</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">신 장</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_height%>" name="rp_height" class="AXInput W130" placeholder="해당 여부" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">체 중</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_weight%>" name="rp_weight" class="AXInput W130" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">시 력</span></th>
					<td colspan="3" class="bdt">좌: <input type="text" value="<%=rp_eye_l%>" name="rp_eye_l" class="AXInput W130" />&nbsp;&nbsp;&nbsp;우: <input type="text" value="<%=rp_eye_r%>" name="rp_eye_r" class="AXInput W130" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">상 의</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_top%>" name="rp_top" class="AXInput W130" placeholder="해당 여부" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">하 의</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_bottom%>" name="rp_bottom" class="AXInput W130" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">신발사이즈</span></th>
					<td colspan="3" class="bdt"><input type="text" value="<%=rp_footsize%>" name="rp_footsize" class="AXInput W130" /></td>
				</tr>
			</table>
		</div>
		<% End If  %>

		<%
			If r_family = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_family WHERE resumeid = '" & resumeid & "' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 가족관계</h4>
			<table>
				<caption>가족관계</caption>
				<colgroup>
					<col width="35%" />
					<col width="" />
					<col width="35%" />
					<col width="" />
				</colgroup>
			</table>

		<table class="tableStyle1 mt0">
			<caption>가족관계</caption>
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th class="title bdr bdt">관계</th>
					<th class="title bdr bdt">성명</th>
					<th class="title bdr bdt">연령</th>
					<th class="title bdr bdt">현재직업</th>
					<th class="title bdr bdt">동거여부</th>
				</tr>
			</thead>
			<tbody id="family_line">
			<%
				If objview.EOF=False Then
					f_num = 1
					Do Until objview.EOF
						family_idx	= objview("idx")
						r_idx			= objview("r_idx")
						m_id			= objview("mid")
						rf_f1			= objview("rf_f1")
						rf_f2			= objview("rf_f2")
						rf_rela		= objview("rf_rela")
						rf_name		= objview("rf_name")
						rf_age			= objview("rf_age")
						rf_job			= objview("rf_job")
						rf_tog			= objview("rf_tog")
			%>
				<tr id="family_line<%=f_num%>">
					<td class="title bdr bdt"><input type="hidden" name="family_idx<%=f_num%>" value="<%=family_idx%>"><input type="text" value="<%=rf_rela%>" name="rf_rela<%=f_num%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rf_name%>" name="rf_name<%=f_num%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rf_age%>" name="rf_age<%=f_num%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rf_job%>" name="rf_job<%=f_num%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rf_tog%>" name="rf_tog<%=f_num%>" class="input" /></td>
				</tr>
			<%
					f_num = f_num + 1
					objview.MoveNext
					Loop
				End If
				objview.Close
				Set objview = Nothing
			%>
			<%
				If f_num < 5 Then
					For t = f_num To 5
			%>
				<tr id="family_line<%=t%>">
					<td class="title bdr bdt"><input type="hidden" name="family_idx<%=t%>" value=""><input type="text" value="" name="rf_rela<%=t%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="" name="rf_name<%=t%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="" name="rf_age<%=t%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="" name="rf_job<%=t%>" class="input" /></td>
					<td class="title bdr bdt"><input type="text" value="" name="rf_tog<%=t%>" class="input" /></td>
				</tr>
			<%
					Next
				End If
			%>
			</tbody>
			</table>
		</div>
		<% End If  %>

		<%
			If r_license = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_licence WHERE resumeid = '" & resumeid & "' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 자격증/면허증</h4>
			<table>
				<colgroup>
					<col width="33%" />
					<col width="" />
					<col width="33%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">자격증/면허증</th>
					<th class="title bdr bdt">발행처/발행기관</th>
					<th class="title bdr bdt">취득일</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							licence_idx	= objview("idx")
							r_idx				= objview("r_idx")
							m_id				= objview("mid")
							rl_licence		= objview("rl_licence")
							rl_org				= objview("rl_org")
							rl_date			= objview("rl_date")

				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="licence_idx<%=num%>" value="<%=licence_idx%>"><input type="text" name="rl_licence<%=num%>" value="<%=rl_licence%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=rl_org%>" name="rl_org<%=num%>" class="AXInput" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rl_date%>" name="rl_date<%=num%>" class="AXInput" /></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
			</table>
			<input type="hidden" name="licence" value="<%=num-1%>">
		</div>
		<% End If  %>

		<%
			If r_oa = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_oa WHERE resumeid = '" & resumeid & "' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 OA능력</h4>
			<table>
				<colgroup>
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">문서작성</th>
					<th class="title bdr bdt">스프레드시트(엑셀)</th>
					<th class="title bdr bdt">프리젠테이션</th>
					<th class="title bdr bdt">정보검색</th>
				</tr>
				<%
					If objview.EOF=False Then
						idx				= objview("idx")
						r_idx			= objview("r_idx")
						m_id			= objview("mid")
						rl_doc			= objview("rl_doc")
						rl_xls			= objview("rl_xls")
						rl_ppt			= objview("rl_ppt")
						rl_search	= objview("rl_search")
				%>
				<tr>
					<td class="title bdr bdt">
						<select  class="AXSelect" name="rl_doc">
							<option value="상"<% If rl_doc = "상" Then Response.write " selected"%>>상</option>
							<option value="중"<% If rl_doc = "중" Then Response.write " selected"%>>중</option>
							<option value="하"<% If rl_doc = "하" Then Response.write " selected"%>>하</option>
						</select>
					</td>
					<td class="title bdr bdt">
						<select class="AXSelect" name="rl_xls">
							<option value="상"<% If rl_xls = "상" Then Response.write " selected"%>>상</option>
							<option value="중"<% If rl_xls = "중" Then Response.write " selected"%>>중</option>
							<option value="하"<% If rl_xls = "하" Then Response.write " selected"%>>하</option>
						</select>
					</td>
					<td class="title bdr bdt">
						<select class="AXSelect" name="rl_ppt">
							<option value="상"<% If rl_ppt = "상" Then Response.write " selected"%>>상</option>
							<option value="중"<% If rl_ppt = "중" Then Response.write " selected"%>>중</option>
							<option value="하"<% If rl_ppt = "하" Then Response.write " selected"%>>하</option>
						</select>
					</td>
					<td class="title bdr bdt">
						<select class="AXSelect" name="rl_search">
							<option value="상"<% If rl_search = "상" Then Response.write " selected"%>>상</option>
							<option value="중"<% If rl_search = "중" Then Response.write " selected"%>>중</option>
							<option value="하"<% If rl_search = "하" Then Response.write " selected"%>>하</option>
						</select>
					</td>
				</tr>
				<%
					End If
					objview.Close
					Set objview = Nothing
				%>
			</table>
		</div>
		<% End If  %>

		<%
			If r_language = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_language WHERE resumeid = '" & resumeid & "' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 어학점수</h4>
			<table>
				<colgroup>
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">언어</th>
					<th class="title bdr bdt">어학시험</th>
					<th class="title bdr bdt">시험점수(등급)</th>
					<th class="title bdr bdt">취득일</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							language_idx	= objview("idx")
							r_idx					= objview("r_idx")
							m_id					= objview("mid")
							rl_lang				= objview("rl_lang")
							rl_test					= objview("rl_test")
							rl_score				= objview("rl_score")
							rl_acq					= objview("rl_acq")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="language_idx<%=num%>" value="<%=language_idx%>"><input type="text" name="rl_lang<%=num%>" value="<%=rl_lang%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=rl_test%>" name="rl_test<%=num%>" class="AXInput" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rl_score%>" name="rl_score<%=num%>" class="AXInput" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rl_acq%>" name="rl_acq<%=num%>" class="AXInput w70" /></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<tr>
					<td colspan="4" class="title bdr bdt" align="center">등록 된 데이타가 없습니다.</td>
				</tr>
				<input type="hidden" name="language" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_portfolio = "Y" Then

			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND (rc_title = 'portfolio' OR rc_title = 'file') "
			objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 포트폴리오</h4>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">URL</th>
					<th class="title bdr bdt">파일</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							portfolio_idx	= objview("idx")
							r_idx				= objview("r_idx")
							m_id				= objview("mid")
							rc_port1			= objview("rc_port1")
							rc_port2	= objview("rc_port2")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="portfolio_idx<%=num%>" value="<%=portfolio_idx%>"><input type="text" value="<%=rc_port1%>" class="input" name="portfolio<%=num%>"></td>
					<td class="title bdr bdt"><a href="/site/Down.asp?fileName=<%=rc_port2%>"><%=rc_port2%></a></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
			</table>
			<input type="hidden" name="portfolio" value="<%=num-1%>">
		</div>
		<% End If  %>

		<%
			If r_skill = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND rc_title = 'skill' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 보유기술 및 능력</h4>
			<table>
				<colgroup>
					<col width="33%" />
					<col width="" />
					<col width="33%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">보유기술 및 능력</th>
					<th class="title bdr bdt">수준</th>
					<th class="title bdr bdt">상세내용</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							skill_idx	= objview("idx")
							r_idx		= objview("r_idx")
							m_id		= objview("mid")
							rc_skill1	= objview("rc_skill1")
							rc_skill2	= objview("rc_skill2")
							rc_skill3	= objview("rc_skill3")

				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="skill_idx<%=num%>" value="<%=skill_idx%>"><input type="text" name="rc_skill1<%=num%>" value="<%=rc_skill1%>" class="AXInput W300"></td>
					<td class="title bdr bdt">
						<select class="AXSelect" name="rc_skill_level<%=num%>">
							<option value="상"<% If rc_skill2 = "상" Then Response.write " selected"%>>상</option>
							<option value="중"<% If rc_skill2 = "중" Then Response.write " selected"%>>중</option>
							<option value="하"<% If rc_skill2 = "하" Then Response.write " selected"%>>하</option>
						</select>
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_skill3%>" name="rc_skill3<%=num%>" class="AXInput" STYLE="WIDTH:95%"/></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="skill" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_career = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND rc_title = 'career' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 경력사항</h4>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">기간</th>
					<th class="title bdr bdt">기관명</th>
					<th class="title bdr bdt">세부 내용</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							career_idx				= objview("idx")
							r_idx						= objview("r_idx")
							m_id						= objview("mid")
							rc_career_sdate	= objview("rc_career_sdate")
							rc_career_edate	= objview("rc_career_edate")
							rc_career_org		= objview("rc_career_org")
							rc_career_detail	= objview("rc_career_detail")
				%>
				<tr>
					<td class="title bdr bdt">
						<input type="hidden" name="career_idx<%=num%>" value="<%=career_idx%>">
						<input type="text" value="<%=rc_career_sdate%>" name="rc_career_sdate<%=num%>" class="AXInput W100" />
						<span class="middle">~</span>
						<input type="text" value="<%=rc_career_edate%>" name="rc_career_edate<%=num%>" class="AXInput W100" />
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_career_org%>" name="rc_career_org<%=num%>" class="AXInput W300" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_career_detail%>" name="rc_career_detail<%=num%>" class="AXInput" STYLE="WIDTH:95%"/></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="career" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_experience = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND rc_title = 'society' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 사회 경험</h4>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">기간</th>
					<th class="title bdr bdt">기관 및 장소</th>
					<th class="title bdr bdt">세부 내용</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							society_idx		= objview("idx")
							r_idx					= objview("r_idx")
							m_id					= objview("mid")
							rc_soc_sdate		= objview("rc_soc_sdate")
							rc_soc_edate		= objview("rc_soc_edate")
							rc_soc_org			= objview("rc_soc_org")
							rc_soc_detail	= objview("rc_soc_detail")
				%>
				<tr>
					<td class="title bdr bdt">
						<input type="hidden" name="society_idx<%=num%>" value="<%=society_idx%>">
						<input type="text" value="<%=rc_soc_sdate%>" name="rc_soc_sdate<%=num%>" class="AXInput W100" />
						<span class="middle">~</span>
						<input type="text" value="<%=rc_soc_edate%>" name="rc_soc_edate<%=num%>" class="AXInput W100" />
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_soc_org%>" name="rc_soc_org<%=num%>" class="AXInput W300" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_soc_detail%>" name="rc_soc_detail<%=num%>" class="AXInput" STYLE="WIDTH:95%" /></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="society" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_project = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND rc_title = 'project' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 참여 프로젝트</h4>
			<table>
				<colgroup>
					<col width="20%" />
					<col width="30%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">기간</th>
					<th class="title bdr bdt">프로젝트명</th>
					<th class="title bdr bdt">세부 내용</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							project_idx			= objview("idx")
							r_idx					= objview("r_idx")
							m_id					= objview("mid")
							rc_proj_sdate	= objview("rc_proj_sdate")
							rc_proj_edate	= objview("rc_proj_edate")
							rc_proj_name	= objview("rc_proj_name")
							rc_proj_detail	= objview("rc_proj_detail")
				%>
				<tr>
					<td class="title bdr bdt">
						<input type="hidden" name="project_idx<%=num%>" value="<%=project_idx%>">
						<input type="text" value="<%=rc_proj_sdate%>" name="rc_proj_sdate<%=num%>" class="AXInput W100" />
						<span class="middle">~</span>
						<input type="text" value="<%=rc_proj_edate%>" name="rc_proj_edate<%=num%>" class="AXInput W100" />
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_proj_name%>" name="rc_proj_name<%=num%>" class="AXInput W300" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_proj_detail%>" name="rc_proj_detail<%=num%>" class="AXInput"  STYLE="WIDTH:95%"/></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="project" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_prime = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_career WHERE resumeid = '" & resumeid & "' AND rc_title = 'prize' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 수상내역/공모전</h4>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">수상명</th>
					<th class="title bdr bdt">수여기관</th>
					<th class="title bdr bdt">수상일자</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							prize_idx		= objview("idx")
							r_idx				= objview("r_idx")
							m_id				= objview("mid")
							rc_pz_name	= objview("rc_pz_name")
							rc_pz_org		= objview("rc_pz_org")
							rc_pz_date		= objview("rc_pz_date")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="prize_idx<%=num%>" value="<%=prize_idx%>"><input type="text" name="rc_pz_name<%=num%>" value="<%=rc_pz_name%>" class="AXInput W500"></td>
					<td class="title bdr bdt"><input type="text" name="rc_pz_org<%=num%>" value="<%=rc_pz_org%>" class="AXInput W200"></td>
					<td class="title bdr bdt"><input type="text" value="<%=rc_pz_date%>" name="rc_pz_date<%=num%>" class="AXInput" /></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="prize" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_training = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_education WHERE resumeid = '" & resumeid & "' AND re_title = 'training' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 해외연수 및 해외경험</h4>
			<table>
			<colgroup>
				<col width="220">
				<col width="250">
				<col width="400">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th class="title bdr bdt">기간</th>
					<th class="title bdr bdt">국가명</th>
					<th class="title bdr bdt">연수기관(학교) 및 단체</th>
					<th class="title bdr bdt">목적</th>
				</tr>
			</thead>
			<tbody>
			<%
				If objview.EOF=False Then
					num = 1
					Do Until objview.EOF
						training_idx		= objview("idx")
						r_idx					= objview("r_idx")
						m_id					= objview("mid")
						re_os_sdate		= objview("re_os_sdate")
						re_os_edate		= objview("re_os_edate")
						re_os_country	= objview("re_os_country")
						re_os_org			= objview("re_os_org")
						re_os_purpose	= objview("re_os_purpose")
						re_os_detail		= objview("re_os_detail")
			%>
				<tr>
					<td rowspan="2" class="title bdr bdt">
						<input type="hidden" name="training_idx<%=num%>" value="<%=training_idx%>">
						<input type="text" value="<%=re_os_sdate%>" class="AXInput W80" name="re_os_sdate<%=num%>">
						<span class="middle">~</span>
						<input type="text" value="<%=re_os_edate%>" class="AXInput W80" name="re_os_edate<%=num%>">
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=re_os_country%>" class="AXInput W200" name="re_os_country<%=num%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=re_os_org%>" class="AXInput W200" name="re_os_org<%=num%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=re_os_purpose%>" class="AXInput W200" name="re_os_purpose<%=num%>"></td>
				</tr>
				<tr id="training_line1">
					<th scope="row" class="title bdr bdt">세부 내용</th>
					<td class="title bdr bdt" colspan="2"><input type="text" value="<%=re_os_detail%>" class="AXInput" name="re_os_detail<%=num%>" STYLE="WIDTH:95%"></td>
				</tr>
			<%
					num = num + 1
					objview.MoveNext
					Loop
				End If
				objview.Close
				Set objview = Nothing
			%>
			<input type="hidden" name="training" value="<%=num-1%>">
			</tbody>
		</table>
		</div>
		<% End If  %>

		<%
			If r_complete = "Y" Then

				Set objview = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_resume_education WHERE resumeid = '" & resumeid & "' AND re_title = 'education' "
				objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 교육이수</h4>
			<table class="tableStyle1">
			<caption>교육이수</caption>
			<colgroup>
				<col width="220">
				<col width="250">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th class="title bdr bdt">기간</th>
					<th class="title bdr bdt">교육명</th>
					<th class="title bdr bdt">교육기관명</th>
				</tr>
			</thead>
			<tbody>
			<%
				If objview.EOF=False Then
					num = 1
					Do Until objview.EOF
						education_idx	= objview("idx")
						r_idx					= objview("r_idx")
						m_id					= objview("mid")
						re_edu_sdate	= objview("re_edu_sdate")
						re_edu_edate	= objview("re_edu_edate")
						re_edu_name	= objview("re_edu_name")
						re_edu_org		= objview("re_edu_org")
						re_edu_detail	= objview("re_edu_detail")
			%>
				<tr>
					<td rowspan="2" class="title bdr bdt">
						<input type="hidden" name="education_idx<%=num%>" value="<%=education_idx%>">
						<input type="text" value="<%=re_edu_sdate%>" class="AXInput W80" name="re_edu_sdate<%=num%>">
						<span class="middle">~</span>
						<input type="text" value="<%=re_edu_edate%>" class="AXInput W80" name="re_edu_edate<%=num%>">
					</td>
					<td class="title bdr bdt"><input type="text" value="<%=re_edu_name%>" class="AXInput W200" name="re_edu_name<%=num%>" /></td>
					<td class="title bdr bdt"><input type="text" value="<%=re_edu_org%>" class="AXInput W200" name="re_edu_org<%=num%>" /></td>
				</tr>
				<tr id="education_line1">
					<th scope="row" class="title bdr bdt">세부 내용</th>
					<td class="td_left" class="title bdr bdt"><input type="text" value="<%=re_edu_detail%>" class="AXInput" name="re_edu_detail<%=num%>" STYLE="WIDTH:95%"></td>
				</tr>
			<%
					num = num + 1
					objview.MoveNext
					Loop
				End If
				objview.Close
				Set objview = Nothing
			%>
			<input type="hidden" name="education" value="<%=num-1%>">
			</tbody>
		</table>
		</div>
		<% End If  %>

		<%
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_swot WHERE resumeid = '" & resumeid & "' "
			objview.Open SQL, Dbcon, 1

			If r_swot = "Y" Then
		%>
		<div class="tb_info">
			<h4>지원자 SWOT 자기분석</h4>
			<table>
				<colgroup>
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">강점 (Strength)</th>
					<th class="title bdr bdt">약점 (Weakness)</th>
					<th class="title bdr bdt">기회 (Opportunities)</th>
					<th class="title bdr bdt">위협 (Threats)</th>
				</tr>
				<%
					If objview.EOF=False Then
						swot_idx	= objview("idx")
						r_idx			= objview("r_idx")
						m_id			= objview("mid")
						rs_s				= objview("rs_s")
						rs_w			= objview("rs_w")
						rs_o				= objview("rs_o")
						rs_t				= objview("rs_t")
						rs_so			= objview("rs_so")
						rs_st			= objview("rs_st")
						rs_wo			= objview("rs_wo")
						rs_wt			= objview("rs_wt")
				%>
				<tr>
					<td class="title bdr bdt">
						<textarea name="rs_s" style="width:98%;height:100px"><%=rs_s%></textarea>
					</td>
					<td class="title bdr bdt">
						<textarea name="rs_w" style="width:98%;height:100px"><%=rs_w%></textarea>
					</td>
					<td class="title bdr bdt">
						<textarea name="rs_o" style="width:98%;height:100px"><%=rs_o%></textarea>
					</td>
					<td class="title bdr bdt">
						<textarea name="rs_t" style="width:98%;height:100px"><%=rs_t%></textarea>
					</td>
				</tr>
				<%
					End If
					objview.Close
					Set objview = Nothing
				%>
			</table>
		</div>
		<% End If  %>

		<%
			If r_strategy = "Y" Then
		%>
		<div class="tb_info">
			<h4>지원자 전략 (Strategy)</h4>
			<table class="tableStyle1 style2 td_left">
			<colgroup>
				<col width="350">
				<col width="">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="title bdr bdt">SO전략 (강점-기회전략)</th>
					<td class="title bdr bdt"><input type="text" value="<%=rs_so%>" class="AXInput" name="rs_so" style="width:99%"></td>
				</tr>
				<tr>
					<th scope="row" class="title bdr bdt">ST전략 (강점-위협전략)</th>
					<td class="title bdr bdt"><input type="text" value="<%=rs_st%>" class="AXInput" name="rs_st" style="width:99%"></td>
				</tr>
				<tr>
					<th scope="row" class="title bdr bdt">WO전략 (약점-기회전략)</th>
					<td class="title bdr bdt"><input type="text" value="<%=rs_wo%>" class="AXInput" name="rs_wo" style="width:99%"></td>
				</tr>
				<tr>
					<th scope="row" class="title bdr bdt">WT전략 (약점-위협전략)</th>
					<td class="title bdr bdt"><input type="text" value="<%=rs_wt%>" class="AXInput" name="rs_wt" style="width:99%"></td>
				</tr>
			</tbody>
		</table>
		</div>
		<% End If  %>

		<%
			If r_etc = "Y" Then

			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE resumeid = '" & resumeid & "' AND (ri_title = 'url' OR ri_title = 'file') "
			objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>지원자 기타 파일 첨부 (증명서 등)</h4>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">URL</th>
					<th class="title bdr bdt">파일</th>
				</tr>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							url_idx	= objview("idx")
							r_idx		= objview("r_idx")
							m_id		= objview("mid")
							ri_url		= objview("ri_url")
							ri_file		= objview("ri_file")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="url_idx<%=num%>" value="<%=url_idx%>"><input type="text" value="<%=ri_url%>" class="input" name="ri_url<%=num%>"></td>
					<td class="title bdr bdt"><a href="/site/Down.asp?fileName=<%=ri_file%>"><%=ri_file%></a></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="url" value="<%=num-1%>">
			</table>
		</div>
		<% End If %>

		<%
			If r_add_cnt > 0 Then

			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE resumeid = '" & resumeid & "' AND ri_title = 'add' "
			objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>추가등록</h4>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							add_idx				= objview("idx")
							r_idx					= objview("r_idx")
							m_id					= objview("mid")
							ri_add_title		= objview("ri_add_title")
							ri_add_content	= objview("ri_add_content")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="add_idx<%=num%>" value="<%=add_idx%>"><input type="text" value="<%=ri_add_title%>" class="input" name="ri_add_title<%=num%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=ri_add_content%>" class="input" name="ri_add_content<%=num%>"></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="add" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<%
			If r_introduction = "Y" Then
			
			Set objview = Server.Createobject("ADODB.Recordset")
			SQL = "SELECT * FROM tbl_resume_intro WHERE resumeid = '" & resumeid & "' AND ri_title = 'intro' "
			objview.Open SQL, Dbcon, 1
		%>
		<div class="tb_info">
			<h4>자기소개서</h4>
			<table>
				<colgroup>
					<col width="50%" />
					<col width="50%" />
				</colgroup>
				<%
					If objview.EOF=False Then
						num = 1
						Do Until objview.EOF
							intro_idx				= objview("idx")
							r_idx						= objview("r_idx")
							m_id						= objview("mid")
							ri_intro_title			= objview("ri_intro_title")
							ri_intro_content	= objview("ri_intro_content")
				%>
				<tr>
					<td class="title bdr bdt"><input type="hidden" name="intro_idx<%=num%>" value="<%=intro_idx%>"><input type="text" value="<%=ri_intro_title%>" class="input" name="ri_intro_title<%=num%>"></td>
					<td class="title bdr bdt"><input type="text" value="<%=ri_intro_content%>" class="input" name="ri_intro_content<%=num%>"></td>
				</tr>
				<%
						num = num + 1
						objview.MoveNext
						Loop
					End If
					objview.Close
					Set objview = Nothing
				%>
				<input type="hidden" name="intro" value="<%=num-1%>">
			</table>
		</div>
		<% End If  %>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="javascript:history.back()"></span>
			</p>
			<p class="right">
				<span><input type="button" value="   인쇄   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="OpenPrint()"></span>
				<span><input type="submit" value="   확인   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(obj){
	if(obj.com_NM.value==""){ alert('업체명을 입력하세요'); obj.com_NM.focus(); return false; }
	if(obj.work_NM.value==""){ alert('직무명을 입력하세요'); obj.work_NM.focus(); return false; }
	//oEditors.getById["p_content1"].exec("UPDATE_CONTENTS_FIELD", []);
}

//	var oEditors = [];
//	nhn.husky.EZCreator.createInIFrame({
//	oAppRef: oEditors,
//	elPlaceHolder: "p_content1",
//	sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
//	fCreator: "createSEditor2"
//});

function recru(pval1) {
	if (pval1 == '0' || pval1 == '1') {
		$(".resume").hide();
	} else {
		$(".resume").show();
	}
}


function OpenPrint() {

	var gsWin = window.open("about:blank", "winName");
	var fr = document.regform;
	fr.action = "/site/recruit/include/inc_pri.asp";
	regform.target = "winName";
	regform.submit();
	fr.action = "application-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>&recruit=<%=recruit%>"

}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->