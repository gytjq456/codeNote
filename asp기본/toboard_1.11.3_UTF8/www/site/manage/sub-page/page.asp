<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>페이지 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>페이지 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

<%
idx = Request("idx")
mode = Request("mode")
If mode="" Then mode="reg"

If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_page WHERE idx='" & idx & "'"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		idx = Rs("idx")
		p_cate = Rs("p_cate")
		p_page1 = Rs("p_page1")
		p_page2 = Rs("p_page2")
		p_page3 = Rs("p_page3")
		p_content = Rs("p_content")
		head_title = Rs("head_title")
		meta_keywords = Rs("meta_keywords")
		meta_description = Rs("meta_description")
	End If
	Rs.Close
	Set Rs = Nothing
Else
		head_title = ""
		meta_keywords = ""
		meta_description = ""
End If
%>

	<form name="regform" action="page-ok.asp?mode=<%=mode%>&idx=<%=idx%>" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>컨텐츠 페이지 편집</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">카테고리</th>
				<td class="bdt"><%=PageCateSelect("p_cate", p_cate)%> </td>
			</tr>
			<tr>
				<th class="title bdr bdt">메뉴명</th>
				<td class="bdt"><input type="text" name="p_page1" value="<%=p_page1%>" class="AXInput W300" placeholder="대메뉴명" /></td>
			</tr>
			<tr>
				<th class="title bdr bdt">내용</th>
				<td class="bdt"><textarea cols="" rows="" name="p_content" id="p_content" style="width:100%; height:250px"><%=p_content%></textarea></td>
			</tr>
		</table>
	</div>
	<!-- //tb_info -->

	<!-- tb_info -->
	<div class="tb_info">
		<h4>검색엔진 최적화</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">Title</th>
				<td class="bdt"><input type="text" name="head_title" value="<%=head_title%>" class="AXInput" style="width:220px" /></td>
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
		</table>
	</div>
	<!-- //tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='index.asp'"></span>
		</p>
		<p class="right">
			<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
			<%If idx<>"" Then%>
<!-- 			<span><input type="button" value="   삭제   " class="AXButton Blue" onclick="if(confirm('정말로 삭제하시겠습니까?')){ location.href='page-ok.asp?mode=del&idx=<%=idx%>'; }"></span> -->
			<%End If%>
			<span><input type="button" value="   취소   " class="AXButton"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>

	<%If W_LEVEL="1" And idx<>"" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>컨텐츠 페이지 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%q="page"%&gt;<br />
			&lt;%idx=<%=idx%>%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 컨텐츠 표시 영역에 아래의 코드 삽입<br />
			&lt;%=pg_content%&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents -->

<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(obj){
	oEditors.getById["p_content"].exec("UPDATE_CONTENTS_FIELD", []);
}

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "p_content",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->