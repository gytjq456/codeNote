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
	<p>사이트 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>사이트 설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_site_config "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('사이트 정보가 없습니다.'); history.back();</script>"
	Response.End
Else
	sc_name=Rs("sc_name")
	sc_lang=Rs("sc_lang")
	sc_url=Rs("sc_url")
	sc_email=Rs("sc_email")
	sc_tel=Rs("sc_tel")
	sc_agree1=Rs("sc_agree1")
	sc_agree2=Rs("sc_agree2")
	sc_analy=Rs("sc_analy")
End If
Rs.Close

Sql = "SELECT TOP 1 * FROM tbl_member WHERE m_lev='2' ORDER BY idx ASC"
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	a_auth =Rs("a_auth")
End If
Set Rs = Nothing
%>

	<form name="regform" action="site-info-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>기본 설정</h4>
		<table>
			<colgroup>
				<col width="180px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">사이트명</th>
				<td class="bdt"><input type="text" name="sc_name" value="<%=sc_name%>" class="AXInput" style="width:220px"></td>
			</tr>
			<tr>
				<th class="title bdr bdt">다국어 설정</th>
				<td class="bdt"><input type="text" name="sc_lang" value="<%=sc_lang%>" class="AXInput W300" /><br />
				<span class="txt_small">언어별 구분은 '|' 기호입니다.</span><br />
				<span class="txt_small">다국어 설정은 팝업관리, 제품관리에 적용됩니다..</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">사이트URL</th>
				<td class="bdt"><input type="text" name="sc_url" value="<%=sc_url%>" class="AXInput" style="width:220px" placeholder="http://">
				<span class="txt_small">예) http://webmoa.co.kr</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">대표메일</th>
				<td class="bdt"><input type="text" name="sc_email" value="<%=sc_email%>" class="AXInput" style="width:220px">
				<span class="txt_small">자동메일 발송 등에 사용됩니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">대표휴대전화</th>
				<td class="bdt"><input type="text" name="sc_tel" value="<%=sc_tel%>" class="AXInput" style="width:100px">
				<span class="txt_small">SMS 발송 등에 사용됩니다. '-'를 빼고 입력 해 주세요. </span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">회원가입약관</th>
				<td class="bdt">
				<textarea name="sc_agree1" id="sc_agree1" class="AXInput" style="width:98%; height:100px"><%=sc_agree1%></textarea>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">개인정보보호정책</th>
				<td class="bdt">
				<textarea name="sc_agree2" id="sc_agree2" class="AXInput" style="width:98%; height:100px"><%=sc_agree2%></textarea>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">헤더 스크립트 삽입</th>
				<td class="bdt">
				<textarea name="sc_analy" id="sc_analy" class="AXInput" style="width:98%; height:100px"><%=sc_analy%></textarea><br />
				<span class="txt_small">로그 분석 스크립트 및 구글 애너리틱스 코드 등 입력할 수 있습니다.</span>
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
		<h4>고객 관리자(2) 메뉴 노출 설정</h4>
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
			<span><input type="button" value="   취소   " class="AXButton"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>


	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>기본 설정 코드 삽입 방법</b><br />
			head 태그 내부에 아래 코드 추가<br />
			&lt;!--#include virtual="/site/setting.asp" --&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.sc_name.value==""){ alert("사이트명을 입력하세요"); obj.sc_name.focus(); return false; }
	if(obj.sc_url.value==""){ alert("사이트URL을 입력하세요"); obj.sc_url.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->