<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$( function() {
	$("#p_sdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#p_edate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
</head>

<%
mode = Request("mode")
If mode="" Then mode="reg"
idx = Request("idx")

If mode="reg" Then
	p_left = 0
	p_top = 0
	p_width = 250
	p_height = 300
ElseIf mode="mod" Then
	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_popup WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_lang = Rs("p_lang")
		p_title = Rs("p_title")
		p_left = Rs("p_left")
		p_top = Rs("p_top")
		p_width = Rs("p_width")
		p_height = Rs("p_height")
		p_content = Rs("p_content")
		p_site = Rs("p_site")
		p_file = Rs("p_file")
		p_hide = Rs("p_hide")
		p_sdate = Rs("p_sdate")
		p_edate = Rs("p_edate")
		p_link = Rs("p_link")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>팝업 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>팝업 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="popup-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>" onsubmit="return RegChk(this)">

		<div class="tb_info">
			<h4>팝업 설정</h4>
			<table>
				<caption>팝업 설정</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">언어설정</span></th>
					<td colspan="3" class="bdt">
					<select name="p_lang" id="p_lang" class="AXSelect">
					<%
					arr_sc_lang = Split(sc_lang, "|")
					For Each item In arr_sc_lang
						Response.Write "<option value=""" & item & """ "
						If item=p_lang Then Response.Write "selected"
						Response.Write ">" & item & "</option>"
					Next
					%>
					</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">제목</span></th>
					<td colspan="3" class="bdt"><input type="text" name="p_title" class="AXInput" size="70" value="<%=p_title%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt">창크기</th>
					<td class="bdt bdr">
						Width : <input type="text" name="p_width" class="AXInput" size="4" maxlength="4" value="<%=p_width%>" numberOnly />px&nbsp;
						Height : <input type="text" name="p_height" class="AXInput" size="4" maxlength="4" value="<%=p_height%>" numberOnly />px&nbsp;
						<span class="txt_small">- 숫자만 입력하세요</span>
					</td>
					<th class="title bdr bdt">창위치</th>
					<td class="bdt">
						Left : <input type="text" name="p_left" class="AXInput" size="4" maxlength="4" value="<%=p_left%>" numberOnly />px&nbsp;
						Top : <input type="text" name="p_top" class="AXInput" size="4" maxlength="4" value="<%=p_top%>" numberOnly />px&nbsp;
						<span class="txt_small">- 숫자만 입력하세요</span>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">표시기간</th>
					<td class="bdt" colspan="3">
					<div class="inlineBlock"><input type="text" name="p_sdate" id="p_sdate" class="AXInput W100" autocomplete="off" maxlength="10" value="<%=p_sdate%>" /></div> ~
					<div class="inlineBlock"><input type="text" name="p_edate" id="p_edate" class="AXInput W100" autocomplete="off" maxlength="10" value="<%=p_edate%>" /></div></td>
				</tr>
				<tr>
					<th class="title bdr bdt">내용</th>
					<td class="bdt" colspan="3"><textarea cols="" rows="" name="p_content" id="p_content" style="width:100%; height:250px"><%=p_content%></textarea></td>
				</tr>
				<!--
				<tr>
					<th class="title bdr bdt">이미지</th>
					<td colspan="3" class="bdt">
						<%
							If p_file<>"" Then
								Response.Write p_file & "파일이 등록되어 있습니다. <br />"
							End If
							%>
						<input type="file" name="p_file" class="inp_file" size="25" /><br />
						<span class="txt_small">- 팝업창 사이즈는 이미지 크기에 맞게 자동 조정 됩니다.</span>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">링크URL</th>
					<td colspan="3" class="bdt"><input type="text" name="p_link" class="AXInput" size="70" value="<%=p_link%>" placeholder="http://" /><br />
						<span class="txt_small">- 팝업창을 클릭시 입력한 링크URL로 이동합니다.</span>
					</td>
				</tr>
				-->

				<tr>
					<th class="title bdr bdt">숨김</th>
					<td colspan="3" class="bdt"><label><input type="checkbox" name="p_hide" class="vmidle" value="1" <%If p_hide Then Response.Write "checked"%>/> 팝업창을 숨깁니다</label>
					</td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='popup.asp'"></span>
			</p>
			<p class="right">
				<span><input type="submit" value="   적용   " class="AXButton Blue"></span>
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

<!-- #include virtual="/site/manage/inc/footer.asp" -->