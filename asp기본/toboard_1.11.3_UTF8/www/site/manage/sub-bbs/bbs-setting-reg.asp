<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
idx = Request("idx")

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_board_id WHERE idx='" & idx & "' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('잘못된 접근입니다.');location.href='/site/manage/';</script>"
	Response.End
Else
	k_id = Rs("k_id")
	k_group = Rs("k_group")
	k_pagelist = Rs("k_pagelist")
	k_upload = Rs("k_upload")
	k_category = Rs("k_category")
	k_comment = Rs("k_comment")
	k_replist = Rs("k_replist")
	k_prevnext = Rs("k_prevnext")
	k_regmail = Rs("k_regmail")
	k_repmail = Rs("k_repmail")
	k_regsms = Rs("k_regsms")
	k_repsms = Rs("k_repsms")
	k_uploadfolder = Rs("k_uploadfolder")
	k_newicon = Rs("k_newicon")
	k_mode = Rs("k_mode")
	k_mode_mobile = Rs("k_mode_mobile")
	k_mode_admin = Rs("k_mode_admin")
	k_counsel = Rs("k_counsel")
	k_filter = Rs("k_filter")
	k_rss = Rs("k_rss")
	k_sns = Rs("k_sns")
	k_spamcode = Rs("k_spamcode")
	k_seo = Rs("k_seo")
	k_naverblog = Rs("k_naverblog")
	k_thumbview = Rs("k_thumbview")
	k_editor= Rs("k_editor")

	u_tel = Rs("u_tel")
	u_fax = Rs("u_fax")
	u_url = Rs("u_url")
	u_privacy = Rs("u_privacy")
	u_privacy_txt = Rs("u_privacy_txt")

	a_list = Rs("a_list")
	a_write = Rs("a_write")
	a_reply = Rs("a_reply")
	a_content = Rs("a_content")
	a_comment = Rs("a_comment")
	regdate = Rs("regdate")
End If
Rs.Close
Set Rs = Nothing
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>게시판 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>게시판 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="bbs-setting-reg-ok.asp?mode=mod&idx=<%=idx%>" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>게시판 기본 설정</h4>
		<table>
			<colgroup>
				<col width="150px" />
				<col width="" />
				<col width="150px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">게시판 명</th>
				<td class="bdt bdr"><input type="text" name="k_id" value="<%=k_id%>" class="AXInput" style="width:250px"></td>
				<th class="title bdr bdt">게시판 그룹</th>
				<td class="bdt"><input type="text" name="k_group" value="<%=k_group%>" class="AXInput" style="width:250px"></td>
			</tr>
			<tr>
				<th class="title bdr bdt">한 페이지<br /> 최대 게시물 수</th>
				<td class="bdt bdr"><input type="text" name="k_pagelist" value="<%=k_pagelist%>" class="AXInput" style="width:40px" numberOnly>
				<span class="txt_small">- 숫자만 입력하세요.</span></td>
				<th class="title bdr bdt">파일업로드</th>
				<td class="bdt">
				<select name="k_upload" id="k_upload" class="AXSelect">
					<option value="0" <%If k_upload="0" Then Response.Write "selected"%>>사용안함</option>
					<%For fc=1 To 15%>
					<option value="<%=fc%>" <%If k_upload=fc Then Response.Write "selected"%>><%=fc%></option>
					<%Next%>
				</select>
				<span class="txt_small">- 파일첨부는 최대 15개까지 가능합니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">카테고리</th>
				<td class="bdt" colspan="3"><input type="text" name="k_category" value="<%=k_category%>" class="AXInput" style="width:95%"><br />
				<span class="txt_small">- 구분은 '|' 기호입니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">문의 폼</th>
				<td class="bdt bdr">
				<select name="k_counsel" id="k_counsel" class="AXSelect">
					<option value="0" <%If k_counsel=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_counsel=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 게시물 쓰기 페이지가 기본 페이지가 됩니다.</span></td>
				<th class="title bdr bdt">덧글 사용</th>
				<td class="bdt bdr">
				<select name="k_comment" id="k_comment" class="AXSelect">
					<option value="0" <%If k_comment=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_comment=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">답변리스트</th>
				<td class="bdt bdr">
				<select name="k_replist" id="k_replist" class="AXSelect">
					<option value="0" <%If k_replist=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_replist=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
				<th class="title bdr bdt">이전글/다음글</th>
				<td class="bdt bdr">
				<select name="k_prevnext" id="k_prevnext" class="AXSelect">
					<option value="0" <%If k_prevnext=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_prevnext=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">게시물등록메일</th>
				<td class="bdt bdr">
				<select name="k_regmail" id="k_regmail" class="AXSelect">
					<option value="0" <%If k_regmail=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_regmail=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 관리자에게 새 게시물 등록 알림 메일을 발송합니다.</td>
				<th class="title bdr bdt">답변메일</th>
				<td class="bdt">
				<select name="k_repmail" id="k_repmail" class="AXSelect">
					<option value="0" <%If k_repmail=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_repmail=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 답변시 원문글 작성자에게 답변 메일을 발송합니다.</span>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">게시물등록SMS</th>
				<td class="bdt bdr">
				<select name="k_regsms" id="k_regsms" class="AXSelect">
					<option value="0" <%If k_regsms=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_regsms=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<br />
				<span class="txt_small">- 관리자에게 SMS를 발송합니다.</span></td>
				<th class="title bdr bdt">답변SMS</th>
				<td class="bdt">
				<select name="k_repsms" id="k_repsms" class="AXSelect">
					<option value="0" <%If k_repsms=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_repsms=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<br />
				<span class="txt_small">- 연락처가 휴대전화로 입력된 경우 원문글 작성자에게 답변 SMS를 발송합니다.</span>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">파일 업로드 폴더</th>
				<td class="bdt bdr"><input type="text" name="k_uploadfolder" value="<%=k_uploadfolder%>" class="AXInput" style="width:250px"><br />
				<span class="txt_small">- 기본값 : /upload/</span></td>
				<th class="title bdr bdt">new 아이콘 표시</span></th>
				<td class="bdt">작성일로 부터 <input type="text" name="k_newicon" value="<%=k_newicon%>" class="AXInput" style="width:40px" numberOnly>시간 동안 표시<br />
				<span class="txt_small">- 기본값 : 24, 숫자만 입력하세요.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">게시판 스킨(사용자)</th>
				<td class="bdt bdr"><%=BbsSkinSelect(k_mode)%></td>
				<th class="title bdr bdt">게시판 스킨(관리자)</th>
				<td class="bdt bdr"><%=BbsSkinAdminSelect(k_mode_admin)%>
				<span class="txt_small">- 미설정인 경우 사용자 스킨이 적용됩니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">웹 에디터</th>
				<td class="bdt bdr">
				<select name="k_editor" id="k_editor" class="AXSelect">
					<option value="" <%If k_editor="" Then Response.Write "selected"%>>사용안함</option>
					<option value="smarteditor2" <%If k_editor="smarteditor2" Then Response.Write "selected"%>>smarteditor2</option>
				</select></td>
				<th class="title bdr bdt">첨부 이미지<br />뷰페이지 표시</th>
				<td class="bdt bdr">
				<select name="k_thumbview" id="k_thumbview" class="AXSelect">
					<option value="0" <%If k_thumbview=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_thumbview=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 파일 첨부로 올린 이미지가 뷰 페이지에 표시할 수 있습니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">불량단어 필터링</th>
				<td class="bdt" colspan="3">
				<textarea name="k_filter" id="k_filter" class="AXInput" style="width:98%; height:60px"><%=k_filter%></textarea><br />
				<span class="txt_small">- 구분은 ','기호입니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">RSS 피드</th>
				<td class="bdt bdr">
				<select name="k_rss" id="k_rss" class="AXSelect">
					<option value="0" <%If k_rss=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_rss=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
				<th class="title bdr bdt">SNS 공유</th>
				<td class="bdt">
				<select name="k_sns" id="k_sns" class="AXSelect">
					<option value="0" <%If k_sns=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_sns=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 게시물을 트위터, 페이스북 공유 할 수 있습니다.</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">자동등록 방지</th>
				<td class="bdt bdr">
				<select name="k_spamcode" id="k_spamcode" class="AXSelect">
					<option value="0" <%If k_spamcode=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_spamcode=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- CHAPTCHA 인증 후 게시물을 작성합니다.</span></td>
				<th class="title bdr bdt">검색엔진 최적화</th>
				<td class="bdt">
				<select name="k_seo" id="k_seo" class="AXSelect">
					<option value="0" <%If k_seo=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If k_seo=True Then Response.Write "selected"%>>사용함</option>
				</select>
				<span class="txt_small">- 타이틀 태그, 메타 키워드, 디스크립션 설정이 가능합니다.</span>
				</td>
			</tr>
		</table>
	</div>

	<div class="tb_info">
		<h4>추가 등록 필드</h4>
		<table>
			<colgroup>
				<col width="150px" />
				<col width="" />
				<col width="150px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">연락처</th>
				<td class="bdt bdr">
				<select name="u_tel" id="u_tel" class="AXSelect">
					<option value="0" <%If u_tel=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If u_tel=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
				<th class="title bdr bdt">FAX</th>
				<td class="bdt">
				<select name="u_fax" id="u_fax" class="AXSelect">
					<option value="0" <%If u_fax=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If u_fax=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">링크 URL</th>
				<td class="bdt bdr">
				<select name="u_url" id="u_url" class="AXSelect">
					<option value="0" <%If u_url=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If u_url=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
				<th class="title bdr bdt">개인정보 보호정책</th>
				<td class="bdt">
				<select name="u_privacy" id="u_privacy" class="AXSelect">
					<option value="0" <%If u_privacy=False Then Response.Write "selected"%>>사용안함</option>
					<option value="1" <%If u_privacy=True Then Response.Write "selected"%>>사용함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">개인정보 보호정책<br />편집</th>
				<td class="bdt" colspan="3">
				<textarea name="u_privacy_txt" id="u_privacy_txt" class="AXInput" style="width:98%; height:130px"><%=u_privacy_txt%></textarea></td>
			</tr>
		</table>
	</div>

	<div class="tb_info">
		<h4>회원 등급별 게시판 권한</h4>
		<table>
			<colgroup>
				<col width="150px" />
				<col width="" />
				<col width="150px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">리스트 보기</th>
				<td class="bdt bdr">
				<select name="a_list" id="a_list" class="AXSelect">
					<option value="100" <%If a_list="100" Then Response.Write "selected"%>>비회원</option>
					<%For mc=99 To 1 Step -1%>
						<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
						<%If a_list=mc Then Response.Write "selected"%>><%=mc%></option>
					<%Next%>
					<option value="0" <%If a_list="0" Then Response.Write "selected"%>>사용안함</option>
				</select></td>
				<th class="title bdr bdt">게시물 작성</th>
				<td class="bdt">
				<select name="a_write" id="a_write" class="AXSelect">
					<option value="100" <%If a_write="100" Then Response.Write "selected"%>>비회원</option>
					<%For mc=99 To 1 Step -1%>
						<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
						<%If a_write=mc Then Response.Write "selected"%>><%=mc%></option>
					<%Next%>
					<option value="0" <%If a_write="0" Then Response.Write "selected"%>>사용안함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">답변 작성</th>
				<td class="bdt bdr">
				<select name="a_reply" id="a_reply" class="AXSelect">
					<option value="100" <%If a_reply="100" Then Response.Write "selected"%>>비회원</option>
					<%For mc=99 To 1 Step -1%>
						<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
						<%If a_reply=mc Then Response.Write "selected"%>><%=mc%></option>
					<%Next%>
					<option value="0" <%If a_reply="0" Then Response.Write "selected"%>>사용안함</option>
				</select>
				<span class="txt_small">- 스킨에 따라 답변 작성이 불가능하기도 합니다..</span></td>
				<th class="title bdr bdt">게시물 보기</th>
				<td class="bdt">
				<select name="a_content" id="a_content" class="AXSelect">
					<option value="100" <%If a_content="100" Then Response.Write "selected"%>>비회원</option>
					<%For mc=99 To 1 Step -1%>
						<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
						<%If a_content=mc Then Response.Write "selected"%>><%=mc%></option>
					<%Next%>
					<option value="0" <%If a_content="0" Then Response.Write "selected"%>>사용안함</option>
				</select></td>
			</tr>
			<tr>
				<th class="title bdr bdt">덧글 작성</th>
				<td class="bdt" colspan="3">
				<select name="a_comment" id="a_comment" class="AXSelect">
					<option value="100" <%If a_comment="100" Then Response.Write "selected"%>>비회원</option>
					<%For mc=99 To 1 Step -1%>
						<option value="<%=mc%>" <%If mc<10 Then Response.Write "style=""color:red"""%>
						<%If a_comment=mc Then Response.Write "selected"%>><%=mc%></option>
					<%Next%>
					<option value="0" <%If a_comment="0" Then Response.Write "selected"%>>사용안함</option>
				</select>
				<span class="txt_small">- 덧글 사용으로 설정 되어야 적용됩니다.</span></td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='bbs-setting.asp'"></span>
		</p>
		<p class="right">
			<span><input type="submit" value="   적용   " class="AXButton Blue"></span>
			<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>게시판 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%bid="<%=idx%>"%&gt;<br />
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