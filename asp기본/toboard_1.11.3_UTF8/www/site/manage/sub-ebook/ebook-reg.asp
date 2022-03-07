<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<%
idx = Request("idx")
mode = Request("mode")
If mode="" Then mode="reg"

page = Request("page")

pLink = "s_keyword=" & s_keyword

If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_ebook WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		e_title=Rs("e_title")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>E-Book 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>E-Book 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="ebook-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>" onsubmit="return RegChk(this)">

		<div class="tb_info">
			<h4>E-Book 기본 정보</h4>
			<table>
				<caption>E-Book 기본 정보</caption>
				<colgroup>
					<col width="15%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">제목</span></th>
					<td class="bdt"><input type="text" name="e_title" class="AXInput" value="<%=e_title%>" style="width:70%" required /></td>
				</tr>
				<!--tr>
					<th class="title bdr bdt"><span class="icon">내용</span></th>
					<td class="bdt"><textarea name="e_content" id="e_content" class="AXInput" style="height:80px" ><%=e_content%></textarea></td>
				</tr-->
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='ebook.asp'"></span>
			</p>
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>

	<br />
	<br />

	<%
	If mode="mod" Then
	%>

	<div class="tb_list">
		<h4>E-Book 이미지 관리</h4>

		<table>
			<colgroup>
				<col width="50px" />
				<col width="90px" />
				<col width="" />
				<col width="80px" />
				<col width="190px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">이미지</th>
				<th class="bdr">파일</th>
				<th class="bdr">진열레벨</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_ebook_img "
			Sql = Sql & " WHERE e_idx='" & idx & "' "
			Sql = Sql & " ORDER BY e_lev ASC"
			Rs.Open Sql, Dbcon, 1
			num=1
			If Rs.EOF=False Then
				Do Until Rs.EOF
					ei_idx = Rs("idx")
					ei_file = Rs("e_file")
					ei_lev = Rs("e_lev")
					%>
					<form name="imgmodform<%=num%>" method="post" action="ebook-img-ok.asp?mode=mod&e_idx=<%=idx%>&idx=<%=ei_idx%>" enctype="multipart/form-data">
						<tr>
							<td class="bdr bdt"><%=num%></td>
							<td class="bdr bdt"><img src="/upload/ebook/thumb/<%=ei_file%>" style="width:80px" /></td>
							<td class="bdr bdt tit"><%=ei_file%><br />
							<input type="file" name="e_file" />
							</td>
							<td class="bdr bdt tit"><input type="text" name="e_lev" class="AXInput W30" value="<%=ei_lev%>" /></td>
							<td class="bdt">
							<input type="submit" value=" 수정 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
							<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('삭제 하시겠습니까?')){ location.href='ebook-img-ok.asp?mode=del&e_idx=<%=idx%>&idx=<%=ei_idx%>' }">
							</td>
						</tr>
					</form>
					<%
					num=num+1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			End If
			Rs.Close
			Set Rs = Nothing%>
			<form name="imgregform" method="post" action="ebook-img-ok.asp?mode=reg&e_idx=<%=idx%>" enctype="multipart/form-data">
				<tr>
					<td class="bdr bdt">추가</td>
					<td class="bdr bdt">-</td>
					<td class="bdr bdt tit">
					<input type="file" name="e_file" required multiple style="width:99%; height:100px; background:#f3f3f3; border:5px dotted #ccc"/><br />
					<span class="txt_small">- 권장 이미지 사이즈 : 500 x 690px</span><br />
					<span class="txt_small">- 드래그 앤 드롭으로 멀티 파일 업로드가 가능합니다.</span>
					</td>
					<td class="bdr bdt tit"><input type="text" name="e_lev" class="AXInput W30" value="<%=ei_lev+10%>" /></td>
					<td class="bdt">
					<input type="submit" value=" 추가 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
					</td>
				</tr>
			</form>
		</table>

		<%
		End If
		%>

	</div>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(obj){
	//oEditors.getById["e_content"].exec("UPDATE_CONTENTS_FIELD", []);
}

/*
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "e_content",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
*/
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->