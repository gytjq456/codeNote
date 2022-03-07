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
	<p>엑셀 일괄등록</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>엑셀 일괄등록</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="prod-excel-upload-ok.asp" onsubmit="return RegChk(this)" enctype="multipart/form-data">

		<div class="tb_info">
			<table>
				<colgroup>
					<col width="120px" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">엑셀파일</th>
					<td class="bdt"><input type="file" name="p_file" value="<%=p_file%>" class="W200"  /><br />
					<span class="txt_small">- 반드시 양식에 맞는 xls파일로 올려주세요. (xlsx는 미지원)</span></td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<!--span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='prod.asp'"></span-->
			</p>
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>

	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
				1) <input type="button" value=" 엑셀샘플다운로드 " class="AXButtonSmall Green" onclick="location.href='PRODUCT_SAMPLE.xls'"> 를 클릭하여 파일을 다운로드합니다.<br />
				2) 해당 양식에 맞게 데이터를 정리합니다. 이미지와 첨부파일 항목은 실제 파일명과 동일하게 입력하도록 합니다.<br />
				3) 카테고리는 카테고리 관리에서 코드를 확인 한 후 입력합니다.<br />
				4) 엑셀파일을 첨부하여 확인버튼을 눌러 업로드를 진행합니다.<br />
				5) FTP에 접속하여 /upload/prod/ 폴더에 이미지와 첨부파일을 업로드합니다. 이미지의 경우 썸네일폴더(thumb_l, thumb_m, thumb_s)에도 사이즈를 맞춰서 올려주세요.<br /><br />
				* 최대 5,000건까지 한번에 올릴 수 있습니다.<br />
				* 썸네일 사이즈 : thumb_l : 500x500px, thumb_m : 250x250px, thumb_s : 70x70px
		</p>
	</div>
	<!-- //tip_box -->



</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(obj){
	if(obj.p_file.value==""){ alert('업로드할 파일을 선택하세요'); obj.p_file.focus(); return false; }
}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->