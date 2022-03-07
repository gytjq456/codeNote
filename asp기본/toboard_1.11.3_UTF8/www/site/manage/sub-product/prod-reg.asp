<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="prod"%>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(function(){
	$("input[type=checkbox]").checkboxradio();
});
</script>
</head>

<%
idx = Request("idx")
mode = Request("mode")
If mode="" Then mode="reg"

s_cate=Request("s_cate")
s_keyword = Request("s_keyword")
s_hide = Request("s_hide")
page = Request("page")

pLink = "s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_hide=" & s_hide & "&page=" & page

ReDim p_item(10), p_item_text(10), p_image(8), p_file(6), p_content(6), p_addtext(5), p_option(4), p_option_val(4)

If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_prod WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		p_name=Rs("p_name")
		p_cate=Rs("p_cate")
		p_cate2=Rs("p_cate2")
		p_cate3=Rs("p_cate3")
		p_code=Rs("p_code")
		For i=1 To 10
			p_item(i-1)=Rs("p_item" & i)
			p_item_text(i-1)=Rs("p_item_text" & i)
		Next
		For i=1 To 8
			p_image(i-1)=Rs("p_image" & i)
		Next
		For i=1 To 6
			p_file(i-1)=Rs("p_file" & i)
			p_content(i-1)=Rs("p_content" & i)
		Next
		For i=1 To 5
			p_addtext(i-1)=Rs("p_addtext" & i)
		Next
		For i=1 To 4
			p_option(i-1)=Rs("p_option" & i)
			p_option_val(i-1)=Rs("p_option_val" & i)
		Next
		p_memo=Rs("p_memo")
		p_o_price=Rs("p_o_price")
		p_price=Rs("p_price")
		p_point=Rs("p_point")
		p_inquiry=Rs("p_inquiry")
		p_lev=Rs("p_lev")
		p_hit=Rs("p_hit")
		p_main=Rs("p_main")
		p_display=Rs("p_display")
		p_hide=Rs("p_hide")
		head_title=Rs("head_title")
		meta_keywords=Rs("meta_keywords")
		meta_description=Rs("meta_description")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>제품 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>제품 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="prod-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>" onsubmit="return RegChk(this)" enctype="multipart/form-data">
		<input type="hidden" name="p_addtext1" value="<%=p_addtext(0)%>" />
		<input type="hidden" name="p_addtext2" value="<%=p_addtext(1)%>" />
		<input type="hidden" name="p_addtext3" value="<%=p_addtext(2)%>" />
		<input type="hidden" name="p_addtext4" value="<%=p_addtext(3)%>" />
		<input type="hidden" name="p_addtext5" value="<%=p_addtext(4)%>" />

		<div class="tb_info">
			<h4>제품 기본 정보</h4>
			<table>
				<caption>제품 기본 정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">제품명</span></th>
					<td colspan="3" class="bdt"><input type="text" name="p_name" class="AXInput" value="<%=TagText(p_name)%>" style="width:70%" />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">제품 노출 체크</span></th>
					<td colspan="3" class="bdt">
					<!-- <label for="p_main">메인 노출</label><input type="checkbox" name="p_main" id="p_main" value="1" <%If p_main Then Response.Write "checked"%>/> -->
					<label for="p_display1">신상품</label><input type="checkbox" name="p_display" id="p_display1" value="신상품" <%If InStr(p_display, "신상품") Then Response.Write "checked"%>/>
					<label for="p_display2">베스트</label><input type="checkbox" name="p_display" id="p_display2" value="베스트" <%If InStr(p_display, "베스트") Then Response.Write "checked"%>/>
					<label for="p_display3">추천상품</label><input type="checkbox" name="p_display" id="p_display3" value="추천상품" <%If InStr(p_display, "추천상품") Then Response.Write "checked"%>/>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">숨김 체크</span></th>
					<td colspan="3" class="bdt">
					<label for="p_hide">숨김</label><input type="checkbox" name="p_hide" id="p_hide" value="1" <%If p_hide Then Response.Write "checked"%>/>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">카테고리</span></th>
					<td colspan="3" class="bdt">
					<div style="padding:3px 0;"><%=CateSelect("p_cate", p_cate)%> <span class="txt_small">- 기본 카테고리 (필수)</span></div>
					<div style="padding:3px 0;"><%=CateSelect("p_cate2", p_cate2)%> <span class="txt_small">- 추가 카테고리</span></div>
					<div style="padding:3px 0;"><%=CateSelect("p_cate3", p_cate3)%> <span class="txt_small">- 추가 카테고리</span></div>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">제품코드</th>
					<td colspan="3" class="bdt"><input type="text" name="p_code" class="AXInput W130" value="<%=p_code%>" /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">간단메모</span></th>
					<td colspan="3" class="bdt"><input type="text" name="p_memo" class="AXInput" value="<%=TagText(p_memo)%>" style="width:98%" /></td>
				</tr>
				<%For i=1 To 5%>
				<tr>
					<th class="title bdr bdt"><input type="text" name="p_item<%=(i*2)-1%>" class="AXInput W90" value="<%=p_item((i*2)-2)%>" placeholder="추가 항목명<%=(i*2)-1%>" /></th>
					<td class="bdt bdr"><input type="text" name="p_item_text<%=(i*2)-1%>" class="AXInput W300" value="<%=p_item_text((i*2)-2)%>" /></td>
					<th class="title bdr bdt"><input type="text" name="p_item<%=(i*2)%>" class="AXInput W90" value="<%=p_item((i*2)-1)%>" placeholder="추가 항목명<%=(i*2)%>" /></th>
					<td class="bdt"><input type="text" name="p_item_text<%=(i*2)%>" class="AXInput W300" value="<%=p_item_text((i*2)-1)%>" /></td>
				</tr>
				<%Next%>
				<tr>
					<th class="title bdr bdt"><span class="icon">설명</span></th>
					<td colspan="3" class="bdt"><textarea cols="" rows="" name="p_content1" id="p_content1" style="width:100%; height:250px"><%=p_content(0)%></textarea></td>
				</tr>
				<!--p_content5 까지 추가 가능-->
				<%If mc_use=True Then%>
					<!-- #include file="prod-reg-shop.asp" -->
				<%End If%>
			</table>
		</div>

		<div class="tb_info">
			<h4>제품 이미지</h4>
			<table>
				<caption>제품 이미지</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
				</colgroup>
				<%For i=1 To 8%>
				<tr <%If i>=9 Then Response.Write "style=""display:none"""%>>
					<th class="title bdr bdt">이미지<%=i%></th>
					<td class="bdt bdr">
					<%If mode="mod" Then
						if p_image(i-1)="" Then%>
							현재 등록된 파일이 없습니다.<br />
						<%Else%>
							<img src="/upload/prod/thumb_s/<%=p_image(i-1)%>" alt="<%=p_image(i-1)%>" style="width:60px" /><br />
							현재 <%=p_image(i-1)%> 파일이 등록되어 있습니다. (<input type="checkbox" name="p_image<%=i%>_del" value="1" />삭제)<br />
						<%End If
					End If%><input type="file" name="p_image<%=i%>" /></td>
				</tr>
				<%Next%>
			</table>
		</div>

		<div class="tb_info" style="display:none">
			<h4>다운로드용 첨부파일</h4>
			<table>
				<caption>다운로드용 첨부파일</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
				</colgroup>
				<%For i=1 To 6%>
				<tr>
					<th class="title bdr bdt">첨부파일<%=i%></th>
					<td class="bdt bdr">
					<%If mode="mod" Then
						if p_file(i-1)="" Then%>
							현재 등록된 파일이 없습니다.<br />
						<%Else%>
							현재 <%=p_file(i-1)%> 파일이 등록되어 있습니다. (<input type="checkbox" name="p_file<%=i%>_del" value="1" />삭제)<br />
						<%End If
					End If%>
					<input type="file" name="p_file<%=i%>" /></td>
				</tr>
				<%Next%>
			</table>
		</div>

		<%
		If pc_seo=True Then
		%>
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
		<%
		End If
		%>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='prod.asp'"></span>
			</p>
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
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
	if(obj.p_name.value==""){ alert('제품명을 입력하세요'); obj.p_name.focus(); return false; }
	if(obj.p_cate.value==""){ alert('카테고리를 선택하세요'); obj.p_cate.focus(); return false; }
	oEditors.getById["p_content1"].exec("UPDATE_CONTENTS_FIELD", []);

	<%If mc_use=True Then%>
	$("#p_option_val1 option").prop("selected", "selected");
	$("#p_option_val2 option").prop("selected", "selected");
	$("#p_option_val3 option").prop("selected", "selected");
	$("#p_option_val4 option").prop("selected", "selected");
	<%End If%>
}

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "p_content1",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->