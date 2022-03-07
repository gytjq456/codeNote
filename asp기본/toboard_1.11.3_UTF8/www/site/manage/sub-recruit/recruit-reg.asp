<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="prod"%>
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

	'If mode = "mod" Then
	'	Set Rs = Server.Createobject("ADODB.Recordset")
	'	SQL = "SELECT * FROM tbl_recruit WHERE idx = '" & idx & "' "
	'	Rs.Open SQL, Dbcon, 1
	'	If Rs.EOF=False Then
	'		idx				= Rs("idx")
	'		com_NM		= Rs("com_NM")
	'		work_NM	= Rs("work_NM")
	'		sdate			= Rs("sdate")
	'		edate			= Rs("edate")
	'		recruit			= Rs("recruit")
	'		s_hide		= Rs("s_hide")
	'		state			= Rs("state")
	'		s_lev			= Rs("s_lev")
	'		p_image1	= Rs("p_image1")
	'		file1				= Rs("file1")
	'		regdate		= Rs("regdate")
	'	End If
	'	Rs.Close
	'	Set Rs = Nothing
	'End If
ReDim r_intro_nm(5), r_add_nm(5)
	If mode = "mod" Then
		Set Rs = Server.Createobject("ADODB.Recordset")
		SQL = "SELECT * FROM tbl_recruit A LEFT JOIN tbl_resume_config B ON A.idx = B.r_idx WHERE A.idx = '" & idx & "' "
		Rs.Open SQL, Dbcon, 1
		If Rs.EOF=False Then
			
			resume_idx		= Rs("idx")
			com_NM				= Rs("com_NM")
			work_NM			= Rs("work_NM")
			sdate					= Rs("sdate")
			edate					= Rs("edate")
			recruit					= Rs("recruit")
			s_hide				= Rs("s_hide")
			state					= Rs("state")
			s_lev					= Rs("s_lev")
			p_image1			= Rs("p_image1")
			file1						= Rs("file1")
			r_top					= Rs("r_top")
			regdate				= Rs("regdate")

			r_idx					= Rs("idx")
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
			r_add					= Rs("r_add")
			r_intro_cnt			= Rs("r_intro_cnt")
			r_add_cnt			= Rs("r_add_cnt")
			For i = 1 To 5
			r_intro_nm(i)		= Rs("r_intro_nm"&i)
			r_add_nm(i)		= Rs("r_add_nm"&i)
			Next

		End If
		Rs.Close
		Set Rs = Nothing
	End If

	If mode = "reg" Then
		r_info				= "Y"
		r_education	= "Y"
		r_personal		= "Y"
		r_army			= "Y"
		r_family			= "Y"
		r_license		= "Y"
	End If
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

	<form name="regform" method="post" action="recruit-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>&r_idx=<%=r_idx%>" onsubmit="return RegChk(this)" enctype="multipart/form-data">

		<div class="tb_info">
			<h4>채용 기본 정보</h4>
			<table>
				<caption>채용 기본 정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">상 태</span></th>
					<td colspan="3" class="bdt">
						<select name="state" id="state" class="AXSelect">
							<option value="0"<% If state = "0" Then Response.write " selected" %>>대기중</option>
							<option value="1"<% If state = "1" Then Response.write " selected" %>>모집중</option>
							<option value="2"<% If state = "2" Then Response.write " selected" %>>완료</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">이력서</span></th>
					<td colspan="3" class="bdt">
						<select name="recruit" id="recruit" class="AXSelect" onchange="recru(this.value)">
							<option value="0"<% If recruit = "0" Then Response.write " selected" %>>일반이력서</option>
							<option value="1"<% If recruit = "1" Then Response.write " selected" %>>간편이력서</option>
							<option value="2"<% If recruit = "2" Then Response.write " selected" %>>변동이력서</option>
						</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">최상단</span></th>
					<td colspan="3" class="bdt"><input type="checkbox" name="r_top" value="1" <% If r_top = 1 Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">업체명</span></th>
					<td colspan="3" class="bdt"><input type="text" name="com_NM" class="AXInput" value="<%=com_NM%>" style="width:70%" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">직무명</span></th>
					<td colspan="3" class="bdt"><input type="text" name="work_NM" class="AXInput W130" value="<%=work_NM%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">모집기간</span></th>
					<td colspan="3" class="bdt">
						<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=sdate%>" class="AXInput W90" /></div> ~
						<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=edate%>" class="AXInput W90" /></div>
					</td>
				</tr>
			</table>
		</div>

		<div class="tb_info">
			<h4>업체 이미지</h4>
			<table>
				<caption>업체 이미지</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">이미지<%=i%></th>
					<td class="bdt bdr">
					<%If mode="mod" Then
						if p_image1="" Then%>
							현재 등록된 파일이 없습니다.<br />
						<%Else%>
							<img src="/upload/recruit/<%=p_image1%>" alt="<%=p_image1%>" style="width:60px" /><br />
							현재 <%=p_image1%> 파일이 등록되어 있습니다. (<input type="checkbox" name="p_image1_del" value="1" />삭제)<br />
						<%End If
					End If%><input type="file" name="p_image1" /></td>
				</tr>
			</table>
		</div>

		<div class="tb_info resume" style="display:<% If recruit <> "2" Then Response.write "none;"%>">
			<h4>업체 이력서</h4>
			<table>
				<caption>업체 이력서</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">이력서<%=i%></th>
					<td class="bdt bdr">
					<%If mode="mod" Then
						if file1="" Then%>
							현재 등록된 파일이 없습니다.<br />
						<%Else%>
							현재 <%=file1%> 파일이 등록되어 있습니다. (<input type="checkbox" name="file1_del" value="1" />삭제)<br />
						<%End If
					End If%><input type="file" name="file1" /></td>
				</tr>
			</table>
		</div>

		<div class="tb_info resume1" style="display:<% If recruit = "2" Then Response.write "none;"%>">
			<h4>이력서 설정</h4>
			<table>
				<caption>채용 기본 정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">기본정보</span></th>
					<td class="bdt bdr">&nbsp;<input type="hidden" name="r_idx" value="<%=r_idx%>"><input type="checkbox" id="chk" name="r_info" value="Y" <% If r_info = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">학력사항</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_education" value="Y" <% If r_education = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">개인 신상정보</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_personal" value="Y" <% If r_personal = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">병역여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_army" value="Y" <% If r_army = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">취업지원대상자 여부</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_job" value="Y" <% If r_job = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">장애인 여부</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_disabled" value="Y" <% If r_disabled = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">저소득층 여부</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_lower" value="Y" <% If r_lower = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">신체</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_body" value="Y" <% If r_body = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">가족관계</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_family" value="Y" <% If r_family = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">자격증/면허증</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_license" value="Y" <% If r_license = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">OA능력</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_oa" value="Y" <% If r_oa = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">어학점수</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_language" value="Y" <% If r_language = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">포트폴리오</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_portfolio" value="Y" <% If r_portfolio = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">보유기술 및 능력</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_skill" value="Y" <% If r_skill = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">경력사항</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_career" value="Y" <% If r_career = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">사회 경험</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_experience" value="Y" <% If r_experience = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">참여 프로젝트</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_project" value="Y" <% If r_project = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">수상내역/공모전</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_prime" value="Y" <% If r_prime = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">해외연수 및 해외경험</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_training" value="Y" <% If r_training = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">교육이수</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_complete" value="Y" <% If r_complete = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">SWOT 자기분석</span></th>
					<td class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_swot" value="Y" <% If r_swot = "Y" Then Response.Write "checked"%>/></td>
					<th class="title bdr bdt"><span class="icon">전략</span></th>
					<td class="bdt">&nbsp;<input type="checkbox" id="chk" name="r_strategy" value="Y" <% If r_strategy = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">기타 파일 첨부 (증명서 등)</span></th>
					<td colspan="3" class="bdt bdr">&nbsp;<input type="checkbox" id="chk" name="r_etc" value="Y" <% If r_etc = "Y" Then Response.Write "checked"%>/></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">추가삽입용</span></th>
					<td class="bdt bdr" colspan="3">&nbsp;<select name="r_add_cnt" class="AXSelect" onchange="r_add(this.value)">
							<option value="0"<% If r_add_cnt = "0" Then Response.write " selected"%>>선택</option>
							<option value="1"<% If r_add_cnt = "1" Then Response.write " selected"%>>1</option>
							<option value="2"<% If r_add_cnt = "2" Then Response.write " selected"%>>2</option>
							<option value="3"<% If r_add_cnt = "3" Then Response.write " selected"%>>3</option>
							<option value="4"<% If r_add_cnt = "4" Then Response.write " selected"%>>4</option>
							<option value="5"<% If r_add_cnt = "5" Then Response.write " selected"%>>5</option>
						</select>
					</td>
				</tr>
				<% For i = 1 To 5 %>
				<tr id="r_add<%=i%>" style="display:<% If r_add_cnt < i Then Response.write "none;"%>">
					<th class="title bdr bdt"><span class="icon">추가삽입용 제목<%=i%></span></th>
					<td class="bdt bdr" colspan="3">&nbsp;<input type="text" name="r_add_nm<%=i%>" class="AXInput" value="<%=r_add_nm(i)%>" style="width:70%"/>
					</td>
				</tr>
				<% Next %>
				<tr>
					<th class="title bdr bdt"><span class="icon">자기소개서</span></th>
					<td class="bdt bdr" colspan="3">&nbsp;<select name="r_intro_cnt" class="AXSelect" onchange="r_intro(this.value)">
							<option value="0"<% If r_intro_cnt = "0" Then Response.write " selected"%>>선택</option>
							<option value="1"<% If r_intro_cnt = "1" Then Response.write " selected"%>>1</option>
							<option value="2"<% If r_intro_cnt = "2" Then Response.write " selected"%>>2</option>
							<option value="3"<% If r_intro_cnt = "3" Then Response.write " selected"%>>3</option>
							<option value="4"<% If r_intro_cnt = "4" Then Response.write " selected"%>>4</option>
							<option value="5"<% If r_intro_cnt = "5" Then Response.write " selected"%>>5</option>
						</select>
					</td>
				</tr>
				<% For i = 1 To 5 %>
				<tr id="r_intro<%=i%>" style="display:<% If r_intro_cnt < i Then Response.write "none;"%>">
					<th class="title bdr bdt"><span class="icon">자기소개서 제목<%=i%></span></th>
					<td class="bdt bdr" colspan="3">&nbsp;<input type="text" name="r_intro_nm<%=i%>" class="AXInput" value="<%=r_intro_nm(i)%>" style="width:70%"/>
					</td>
				</tr>
				<% Next %>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="location.href='recruit.asp'"></span>
				<span><input type="button" value="   미리보기   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="OpenPrint()"></span>
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
	if ( pval1 == '0' || pval1 == '1') {
		$(".resume").hide();
		$(".resume1").show();
	} else {
		$(".resume").show();
		$(".resume1").hide();
	}
}

function r_intro(pval1) {
	for (i=1; i <= 5 ;i++ ) {
		intro = eval("regform.r_intro_nm"+i);
		if (i <= pval1) {
			$("#r_intro"+i).css("display","");
		} else {
			$("#r_intro"+i).css("display","none");
			intro.value='';
		}
	}
}

function r_add(pval1) {
	for (i=1; i <= 5 ;i++ ) {
		add = eval("regform.r_add_nm"+i);
		if (i <= pval1) {
			$("#r_add"+i).css("display","");
		} else {
			$("#r_add"+i).css("display","none");
			add.value='';
		}
	}
}

function OpenPrint() {

	var gsWin = window.open("about:blank", "winName");
	var fr = document.regform;
	fr.action = "http://humancore.webmoa21.co.kr/sub/epm/list.asp?mode=pre";
	regform.target = "winName";
	regform.submit();
	fr.action = "recruit-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>&r_idx=<%=r_idx%>"

}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->