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
	<p>검색엔진 최적화 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>검색엔진 최적화 설정</li>
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
	meta_keywords = Rs("meta_keywords")
	meta_description = Rs("meta_description")
	meta_author = Rs("meta_author")
	meta_subject = Rs("meta_subject")
	meta_copyright = Rs("meta_copyright")
	meta_content_language = Rs("meta_content_language")
End If
Rs.Close
%>

	<form name="regform" action="seo-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>공통 META 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">Title</th>
				<td class="bdt"><input type="text" name="sc_name" value="<%=sc_name%>" class="AXInput" style="width:220px" readonly />
				<span class="txt_small">- 사이트 명</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Keywords</th>
				<td class="bdt"><input type="text" name="meta_keywords" value="<%=meta_keywords%>" class="AXInput" style="width:95%" /><br />
				<span class="txt_small">- 키워드 / 콤마(,)로 구분</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Description</th>
				<td class="bdt"><input type="text" name="meta_description" value="<%=meta_description%>" class="AXInput" style="width:95%" /><br />
				<span class="txt_small">- 설명문 / 600자 이내</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Author</th>
				<td class="bdt"><input type="text" name="meta_author" value="<%=meta_author%>" class="AXInput" style="width:400px" />
				<span class="txt_small">- 사이트 제작자</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Subject</th>
				<td class="bdt"><input type="text" name="meta_subject" value="<%=meta_subject%>" class="AXInput" style="width:400px" />
				<span class="txt_small">- 사이트 주제</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Copyright</th>
				<td class="bdt"><input type="text" name="meta_copyright" value="<%=meta_copyright%>" class="AXInput" style="width:400px" />
				<span class="txt_small">- 저작권</span></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Content<br />Language</th>
				<td class="bdt"><input type="text" name="meta_content_language" value="<%=meta_content_language%>" class="AXInput" style="width:100px" />
				<span class="txt_small">- 컨텐츠 언어 / ko, en-us, ja, zh-cn 등</span></td>
			</tr>
				</table>
				</td>
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

	<br /><br />

	<!-- tb_list -->
	<div class="tb_list">
		<h4>디자인 페이지 META 설정</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="23%" />
				<col width="10%" />
				<col width="14%" />
				<col width="" />
				<col width="100px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">페이지경로 *</th>
				<th class="bdr">Title *</th>
				<th class="bdr">Keywords</th>
				<th class="bdr">Description</th>
				<th>관리</th>
			</tr>
			<%
			Sql = "SELECT * FROM tbl_site_seopage "
			Sql = Sql & " WHERE idx!='' "
			Sql = Sql & " ORDER BY m_path asc  "
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1
			If Rs.EOF=False Then
				num = 1
				Do Until Rs.EOF
					idx = Rs("idx")
					m_path = Rs("m_path")
					m_title = Rs("m_title")
					m_keywords = Rs("m_keywords")
					m_description = Rs("m_description")
					%>
			<form name="modform<%=idx%>" method="post" action="seo-ok.asp?mode=page-mod&idx=<%=idx%>" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt"><%=num%></td>
				<td class="bdr bdt">http://<%=Request.ServerVariables("SERVER_NAME")%><input type="text" name="m_path" value="<%=m_path%>" class="AXInput" style="width:50%" placeholder="페이지경로"></td>
				<td class="bdr bdt"><input type="text" name="m_title" value="<%=m_title%>" class="AXInput" style="width:90%" placeholder="Title"></td>
				<td class="bdr bdt"><input type="text" name="m_keywords" value="<%=m_keywords%>" class="AXInput" style="width:90%" placeholder="Keywords"></td>
				<td class="bdr bdt"><input type="text" name="m_description" value="<%=m_description%>" class="AXInput" style="width:95%" placeholder="Description"></td>
				<td class="bdt">
				<input type="submit" value=" 수정 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b">
				<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 항목을 삭제 하시겠습니까?')){location.href='seo-ok.asp?mode=page-del&idx=<%=idx%>'}"></td>
			</tr>
			</form>
				<%
				num=num+1
				Rs.MoveNext
			Loop
			Else
				%>
			<tr>
				<td colspan="6" class="bdr bdt">등록된 페이지가 없습니다.</td>
			</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
			<form name="regform" method="post" action="seo-ok.asp?mode=page-reg" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt">추가</td>
				<td class="bdr bdt">http://<%=Request.ServerVariables("SERVER_NAME")%><input type="text" name="m_path" value="" class="AXInput" style="width:50%" placeholder="페이지경로"></td>
				<td class="bdr bdt"><input type="text" name="m_title" value="" class="AXInput" style="width:90%" placeholder="Title"></td>
				<td class="bdr bdt"><input type="text" name="m_keywords" value="" class="AXInput" style="width:90%" placeholder="Keywords"></td>
				<td class="bdr bdt"><input type="text" name="m_description" value="" class="AXInput" style="width:95%" placeholder="Description"></td>
				<td class="bdt"><input type="submit" value=" 추가 " class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba"></td>
			</tr>
			</form>
		</table>
	</div>
	<!-- tb_list -->


	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
		<b>참고사항</b><br />
		1) 디자인 페이지 META 설정이 공통 META 설정보다 우선 적용 됩니다.<br />
		2) 게시판과 제품소개의 SEO 적용은 별도의 관리를 지원합니다.<br />
<!-- 		3) Keywords 항목은 현재 Google 검색엔진에서는 평가대상에서 제외되어 있으나, 타 검색엔진과 구글의 정책 변경 가능성을 고려하여 작성하기를 권장합니다. -->
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.m_path.value==""){ alert("페이지경로를 입력하세요"); obj.m_path.focus(); return false; }
	if(obj.m_title.value==""){ alert("Title을 입력하세요"); obj.m_title.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->