<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="prod"%>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
</script>
</head>

<%
	idx		= Request("idx")
	mode	= Request("mode")
	If mode = "" Then mode = "reg"

	s_keyword	= Request("s_keyword")
	s_hide		= Request("s_hide")
	page			= Request("page")

	pLink = "s_keyword=" & s_keyword & "&s_cate1=" & s_cate1 & "&s_cate2=" & s_cate2 & "&s_cate3=" & s_cate3 & "&s_hide=" & s_hide

	Set Rs = Server.Createobject("ADODB.Recordset")
	SQL = "SELECT * FROM tbl_resume_config "
	Rs.Open SQL, Dbcon, 1
	If Rs.EOF=False Then
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
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>채용 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>채용 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="resume-reg-ok.asp?mode=mod_p&idx=<%=idx%>&<%=pLink%>" onsubmit="return RegChk(this)">

		<div class="tb_info">
			<h4>채용 기본 정보</h4>
			<table>
				<caption>채용 기본 정보</caption>
				<colgroup>
					<col width="15%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">기본정보</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_info" value="Y" <% If r_info = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">학력사항</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_education" value="Y" <% If r_education = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">개인 신상정보</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_personal" value="Y" <% If r_personal = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">병역여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_army" value="Y" <% If r_army = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">취업지원대상자 여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_job" value="Y" <% If r_job = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">장애인 여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_disabled" value="Y" <% If r_disabled = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">저소득층 여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_lower" value="Y" <% If r_lower = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">신체</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_body" value="Y" <% If r_body = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">가족관계</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_family" value="Y" <% If r_family = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">자격증/면허증</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_license" value="Y" <% If r_license = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">OA능력</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_oa" value="Y" <% If r_oa = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">어학점수</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_language" value="Y" <% If r_language = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">포트폴리오</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_portfolio" value="Y" <% If r_portfolio = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">보유기술 및 능력</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_skill" value="Y" <% If r_skill = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">경력사항</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_career" value="Y" <% If r_career = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">사회 경험</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_experience" value="Y" <% If r_experience = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">참여 프로젝트</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_project" value="Y" <% If r_project = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">수상내역/공모전</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_prime" value="Y" <% If r_prime = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">해외연수 및 해외경험</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_training" value="Y" <% If r_training = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">교육이수</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_complete" value="Y" <% If r_complete = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">SWOT 자기분석</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_swot" value="Y" <% If r_swot = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">전략</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_strategy" value="Y" <% If r_strategy = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">기타 파일 첨부 (증명서 등)</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_etc" value="Y" <% If r_etc = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">자기소개서</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" name="r_introduction" value="Y" <% If r_introduction = "Y" Then Response.Write "checked"%>/></td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
			</p>
			<p class="right">
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
}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->