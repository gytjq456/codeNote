<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>관리자 계정설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>관리자 계정설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%	
mode = Request("mode")
m_id = Request("m_id")

If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "' AND m_lev<10"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF Then
		Response.Write "<script>alert('회원정보가 없거나 탈퇴한 회원입니다.'); location.href='/site/manage/';</script>"
		Response.End
	Else 
		m_id = Rs("m_id")
		m_pw = Rs("m_pw")	
		m_name = Rs("m_name")
		m_email = Rs("m_email")
		m_lev = Rs("m_lev")
		m_sort = Rs("m_sort")
		m_cell1 = Rs("m_cell1")
		m_cell2 = Rs("m_cell2")
		m_cell3 = Rs("m_cell3")
		a_auth = Rs("a_auth")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>


	<form name="regform" action="account-admin-reg-ok.asp?mode=<%=mode%>" method="post" onsubmit="return RegChk(this)">

		<!-- tb_info -->
		<div class="tb_info">
			<table>
				<colgroup>
					<col width="150px" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">회원등급</th>
					<td class="bdt">
						<%If W_LEVEL="1" Then%>
						<label><input type="radio" name="m_lev" value="2" <%If m_lev="2" Then Response.Write "checked"%>/>최고관리자</label>&nbsp;&nbsp;
						<label><input type="radio" name="m_lev" value="3" <%If m_lev="3" Then Response.Write "checked"%> />서브관리자</label>&nbsp;&nbsp;
						<%ElseIf W_LEVEL="2" Then%>
						<label><input type="radio" name="m_lev" value="3" <%If m_lev="3" Then Response.Write "checked"%> />서브관리자</label>&nbsp;&nbsp;
						<%End If%>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">아이디</th>
					<td class="bdt">
					<%If mode="mod" Then%>
						<input type="hidden" name="m_id" value="<%=m_id%>" /><%=m_id%>
					<%Else%>
						<input type="text" name="m_id" class="AXInput W100" value="" style="ime-mode:disabled" required />
						<input type="button" onclick="IdChk(this.form)" value="아이디 중복체크" class="AXButtonSmall Classic">
					<%End If%></td>
				</tr>
				<tr>
					<th class="title bdr bdt">패스워드</th>
					<td class="bdt">
						<input type="password" name="m_pw" value="" class="AXInput" style="width:120px" <%If mode="reg" Then Response.Write "required"%>>
						<span class="txt_small">패스워드는 숫자, 영문, 특수문자 포함 8자 이상 입니다</span>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">패스워드확인</th>
					<td class="bdt">
						<input type="password" name="m_pw2" value="" class="AXInput" style="width:120px" <%If mode="reg" Then Response.Write "required"%>>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">이름</th>
					<td class="bdt">
						<input type="text" name="m_name" value="<%=m_name%>" class="AXInput" style="width:120px" required >
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">휴대전화</th>
					<td class="bdt">
						<input type="text" name="m_cell1" value="<%=m_cell1%>" class="AXInput W40" maxlength="4"> -
						<input type="text" name="m_cell2" value="<%=m_cell2%>" class="AXInput W40" maxlength="4"> -
						<input type="text" name="m_cell3" value="<%=m_cell3%>" class="AXInput W40" maxlength="4">
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">이메일</th>
					<td class="bdt">
						<input type="text" name="m_email" value="<%=m_email%>" class="AXInput" style="width:310px" required >
					</td>
				</tr>
			</table>
		</div>
		<!-- tb_info -->

		<!-- tb_info -->
		<input type="hidden" name="a_auth" value="0-main" />
		<input type="hidden" name="a_auth" value="0-basic" />
		<input type="hidden" name="a_auth" value="1-admin" />
		<div class="tb_info">
			<h4>관리자 메뉴 노출 설정</h4>
			<table>
				<colgroup>
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-main" <%If InStr(a_auth, "0-main")>0 Then Response.Write "checked"%>/> <b>메인화면 노출</b></label></th>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="" value="" disabled <%If InStr(a_auth, "0-basic")>0 Then Response.Write "checked"%> /> <b>기본 설정</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="" value="" disabled <%If InStr(a_auth, "1-admin")>0 Then Response.Write "checked"%> /> 관리자 정보 (해제 불가)</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-site-info" disabled /> 사이트 설정 (설정 불가)</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-mall-info" <%If InStr(a_auth, "1-mall-info")>0 Then Response.Write "checked"%> /> 쇼핑몰 정보 설정</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-base-info" <%If InStr(a_auth, "1-base-info")>0 Then Response.Write "checked"%> /> 기본 정보 설정</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-account-admin" <%If InStr(a_auth, "1-account-admin")>0 Then Response.Write "checked"%> /> 관리자 계정 설정</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-site-favi" <%If InStr(a_auth, "1-site-favi")>0 Then Response.Write "checked"%> /> 파비콘 설정</label></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-member" <%If InStr(a_auth, "0-member")>0 Then Response.Write "checked"%>/> <b>회원 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-member-list" <%If InStr(a_auth, "1-member-list")>0 Then Response.Write "checked"%> /> 회원 목록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-member-reg" <%If InStr(a_auth, "1-member-reg")>0 Then Response.Write "checked"%> /> 회원 등록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-member-level" <%If InStr(a_auth, "1-member-level")>0 Then Response.Write "checked"%> /> 회원 등급 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-member-mail" <%If InStr(a_auth, "1-member-mail")>0 Then Response.Write "checked"%> /> 단체 메일 발송</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-recruit" <%If InStr(a_auth, "0-recruit")>0 Then Response.Write "checked"%>/> <b>채용 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-recruit-list" <%If InStr(a_auth, "1-recruit-list")>0 Then Response.Write "checked"%> /> 채용관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-recruit-reg" <%If InStr(a_auth, "1-recruit-reg")>0 Then Response.Write "checked"%> /> 채용 등록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-application-list" <%If InStr(a_auth, "1-application-list")>0 Then Response.Write "checked"%> /> 지원자 관리</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-product" <%If InStr(a_auth, "0-product")>0 Then Response.Write "checked"%>/> <b>제품 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-prod-list" <%If InStr(a_auth, "1-prod-list")>0 Then Response.Write "checked"%> /> 제품 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-prod-reg" <%If InStr(a_auth, "1-prod-reg")>0 Then Response.Write "checked"%> /> 제품 등록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-xlsreg" <%If InStr(a_auth, "1-xlsreg")>0 Then Response.Write "checked"%> /> 엑셀 일괄등록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-prod-cate" <%If InStr(a_auth, "1-prod-cate")>0 Then Response.Write "checked"%> /> 제품 카테고리 관리</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-order" <%If InStr(a_auth, "0-order")>0 Then Response.Write "checked"%>/> <b>주문 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-order-list" <%If InStr(a_auth, "1-order-list")>0 Then Response.Write "checked"%> /> 주문 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-order-stat" <%If InStr(a_auth, "1-order-stat")>0 Then Response.Write "checked"%> /> 매출 통계</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-order-coupon" <%If InStr(a_auth, "1-order-coupon")>0 Then Response.Write "checked"%> /> 쿠폰 관리</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-page" <%If InStr(a_auth, "0-page")>0 Then Response.Write "checked"%> /> <b>페이지 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-page-setting" <%If InStr(a_auth, "1-page-setting")>0 Then Response.Write "checked"%> /> 컨텐츠 페이지 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-page-list" <%If InStr(a_auth, "1-page-list")>0 Then Response.Write "checked"%> /> 컨텐츠 페이지 목록</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-page-cate" <%If InStr(a_auth, "1-page-cate")>0 Then Response.Write "checked"%> /> 페이지 카테고리 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-popup" <%If InStr(a_auth, "1-popup")>0 Then Response.Write "checked"%> /> 팝업 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-banner" <%If InStr(a_auth, "1-banner")>0 Then Response.Write "checked"%> /> 배너 관리</label></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-bbs" <%If InStr(a_auth, "0-bbs")>0 Then Response.Write "checked"%> /> <b>게시판 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-bbs-setting" <%If InStr(a_auth, "1-bbs-setting")>0 Then Response.Write "checked"%> /> 게시판 관리</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-bbs-list" <%If InStr(a_auth, "1-bbs-list")>0 Then Response.Write "checked"%> /> 게시판 목록</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-ebook" <%If InStr(a_auth, "0-ebook")>0 Then Response.Write "checked"%> /> <b>E-Book 관리</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-ebook" <%If InStr(a_auth, "1-ebook")>0 Then Response.Write "checked"%> /> E-Book 관리</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-stats" <%If InStr(a_auth, "0-stats")>0 Then Response.Write "checked"%> /> <b>접속자 통계</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-stats-d" <%If InStr(a_auth, "1-stats-d")>0 Then Response.Write "checked"%> /> 일별 통계</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-stats-w" <%If InStr(a_auth, "1-stats-w")>0 Then Response.Write "checked"%> /> 요일별 통계</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-stats-m" <%If InStr(a_auth, "1-stats-m")>0 Then Response.Write "checked"%> /> 월별 통계</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-stats-detail" <%If InStr(a_auth, "1-stats-detail")>0 Then Response.Write "checked"%> /> 세부 접속 로그</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-other" <%If InStr(a_auth, "0-other")>0 Then Response.Write "checked"%> /> <b>기타 설정</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-seo" <%If InStr(a_auth, "1-seo")>0 Then Response.Write "checked"%> /> 검색엔진 최적화 설정</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-smtp" <%If InStr(a_auth, "1-smtp")>0 Then Response.Write "checked"%> /> 메일 발송 서버 설정</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><label><input type="checkbox" name="a_auth" value="0-customer" <%If InStr(a_auth, "0-customer")>0 Then Response.Write "checked"%> /> <b>고객센터</b></label></th>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-wims" <%If InStr(a_auth, "1-wims")>0 Then Response.Write "checked"%> /> 통합관리 시스템 (WIMS)</label></td>
					<td class="bdr bdt"><label><input type="checkbox" name="a_auth" value="1-webmoa" <%If InStr(a_auth, "1-webmoa")>0 Then Response.Write "checked"%> /> (주)웹모아 홈페이지</label></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
					<td class="bdr bdt"></td>
				</tr>
			</table>
		</div>
		<!-- tb_info -->

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->	

	</form>

</div>
<!-- //contents -->

<iframe src="" name="bframe" style="width:0; height:0; border:0;"></iframe>

<script type="text/javascript">
function IdChk(obj){
	if (obj.m_id.value=="")	{
		alert('아이디를 입력하세요');
	}else{
		var idReg = /^[a-z]{1}[a-z0-9]{3,11}$/;
		if( !idReg.test( $("#m_id").val() ) ) {
			alert("아이디는 영문자로 시작하는 4~12자 영문 또는 숫자이어야 합니다.");
			return;
		}
		bframe.location.href='/site/member/include/id-chk.asp?m_lang=kr&m_id='+obj.m_id.value;
	}
	obj.m_id.focus();
}

function RegChk(obj){
	if(obj.idchk.value=="0"){ alert('아이디 중복체크를 해주세요'); obj.m_id.focus(); return false; }
	if(obj.m_pw.value!=""){
		var regExpPwd = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,50}$/; //패스워드 체크
		if (!regExpPwd.test(obj.m_pw.value)){
			alert ("패스워드는 숫자, 영문, 특수문자 포함 8자 이상 입니다" );
			obj.m_pw.focus();
			return false;
		}
	}
	if(obj.m_pw.value != obj.m_pw2.value){
		alert('비밀번호가 일치하지 않습니다.');
		obj.m_pw.value="";
		obj.m_pw2.value="";
		obj.m_pw.focus();
		return false;
	}
}
<%If mode="mod" Then%>
$("#idchk").val("1");
<%End If%>
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->