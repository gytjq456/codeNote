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
	<p>회원 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>회원 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<%
	b_lang = Request("m_lang")
	rturl = "/site/manage/sub-member/member.asp"
	m_id = Request("m_id")
	%>
	<!--#include virtual="/site/member/member.asp" -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>회원 관련 폼 삽입 방법</b><br />
			&lt;%b_lang="kr" '한국어:kr, 영어:en%&gt;<br />
			&lt;%mode="join" '가입:join, 정보수정:mod, 로그인:login, ID/PW찾기:idpw%&gt;<br />
			&lt;%rturl="/" 'DB처리 후 페이지 이동 주소%&gt;<br />
			&lt;!--#include virtual="/site/member/member.asp"--&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->