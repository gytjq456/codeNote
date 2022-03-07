<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p><%=k_id%></p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li><%=k_id%></li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<%
	'리스트 스킨
	If mode="list" Then%>
		<%If k_mode_admin="basic" Then%><!--#include virtual="/site/manage/sub-bbs/skin/basic/list.asp" -->
		<%ElseIf k_mode_admin="photo" Then%><!--#include virtual="/site/manage/sub-bbs/skin/photo/list.asp" -->
		<%ElseIf k_mode_admin="inquiry" Then%><!--#include virtual="/site/manage/sub-bbs/skin/inquiry/list.asp" -->
		<%ElseIf k_mode_admin="recruit" Then%><!--#include virtual="/site/manage/sub-bbs/skin/recruit/list.asp" -->
		<%ElseIf k_mode_admin="video" Then%><!--#include virtual="/site/manage/sub-bbs/skin/video/list.asp" -->
		<%ElseIf k_mode_admin="history" Then%><!--#include virtual="/site/manage/sub-bbs/skin/history/list.asp" -->
		<%Else%><%Response.Redirect "/site/manage/sub-bbs/bbs.asp?bid=" & bid%>
		<%End If%>

	<%
	'쓰기 수정 폼 스킨
	ElseIf mode="reg" Or mode="mod" Or mode="rep" Then%>
		<%If k_mode_admin="basic" Then%><!--#include virtual="/site/manage/sub-bbs/skin/basic/reg.asp" -->
		<%ElseIf k_mode_admin="photo" Then%><!--#include virtual="/site/manage/sub-bbs/skin/photo/reg.asp" -->
		<%ElseIf k_mode_admin="inquiry" Then%><!--#include virtual="/site/manage/sub-bbs/skin/inquiry/reg.asp" -->
		<%ElseIf k_mode_admin="recruit" Then%><!--#include virtual="/site/manage/sub-bbs/skin/recruit/reg.asp" -->
		<%ElseIf k_mode_admin="video" Then%><!--#include virtual="/site/manage/sub-bbs/skin/video/reg.asp" -->
		<%ElseIf k_mode_admin="history" Then%><!--#include virtual="/site/manage/sub-bbs/skin/history/reg.asp" -->
		<%Else%><%Response.Redirect "/site/manage/sub-bbs/bbs.asp?bid=" & bid%>
		<%End If%>

	<%
	'뷰 스킨
	ElseIf mode="view" Then%>
		<%If k_mode_admin="basic" Then%><!--#include virtual="/site/manage/sub-bbs/skin/basic/view.asp" -->
		<%ElseIf k_mode_admin="photo" Then%><!--#include virtual="/site/manage/sub-bbs/skin/photo/view.asp" -->
		<%ElseIf k_mode_admin="inquiry" Then%><!--#include virtual="/site/manage/sub-bbs/skin/inquiry/view.asp" -->
		<%ElseIf k_mode_admin="recruit" Then%><!--#include virtual="/site/manage/sub-bbs/skin/recruit/view.asp" -->
		<%ElseIf k_mode_admin="video" Then%><!--#include virtual="/site/manage/sub-bbs/skin/video/view.asp" -->
		<%Else%><%Response.Redirect "/site/manage/sub-bbs/bbs.asp?bid=" & bid%>
		<%End If%>

	<%
	ElseIf mode="mod_l" Or mode="del_l" Or mode="view_l" Or mode="comment_del_l" Then%>
		<!--#include virtual="/site/bbs/include/inc_password.asp"-->

	<%
	ElseIf mode="reg_p" Or mode="mod_p" Or mode="rep_p" Or mode="del_p" Or mode="comment_reg_p" Or mode="comment_del_p" Or mode="seldel_p" Then%>
		<!--#include virtual="/site/bbs/include/reg_ok.asp"-->

	<%
	End If
	%>

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>게시판 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%bid="<%=bid%>"%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 게시판 영역에 아래의 코드 삽입<br />
			&lt;!--#include virtual="/site/bbs/bbs.asp" --&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->


<!-- #include virtual="/site/manage/inc/footer.asp" -->