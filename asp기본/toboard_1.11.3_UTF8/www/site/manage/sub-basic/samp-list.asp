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
	<p>관리자 정보</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>관리자정보</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">키워드검색</th>
				<td class="bdb bdr"><input type="text" name="" value="" class="AXInput" style="width:170px"></td>
				<th class="bdb bdr">접수일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="" id="AXInputDate_earlier" class="AXInput" style="width:73px;font-size:10px"></div> ~
					<div class="inlineBlock"><input type="text" name="" id="AXInputDate_later" class="AXInput" style="width:73px;font-size:10px"></div>
				</td>
				<th class="bdb bdr">키워드검색</th>
				<td class="bdb">
					<input type="radio" id="all" />&nbsp;<label for="all">전체</label>&nbsp;
					<input type="radio" id="s_request" />&nbsp;<label for="s_request">서비스요청</label>&nbsp;
					<input type="radio" id="wait" />&nbsp;<label for="wait">입금대기</label>
				</td>
			</tr>
			<tr>
				<th class="bdr">처리상태</th>
				<td class="bdr">
					<select name="" id="" class="s_box" style="width:180px">
						<option value="">처리상태</option>
						<option value="">aaaaaaaaa</option>
						<option value=""></option>
						<option value=""></option>
						<option value=""></option>
					</select>
				</td>
				<th class="bdr">영업담당자</th>
				<td class="bdr">
					<input type="checkbox" id="all" />&nbsp;<label for="all">전체</label>&nbsp;
					<input type="checkbox" id="s_request" />&nbsp;<label for="s_request">서비스요청</label>&nbsp;
					<input type="checkbox" id="wait" />&nbsp;<label for="wait">입금대기</label>
				</td>
				<th class="bdr">처리상태</th>
				<td><input type="text" name="" value="" class="AXInput" style="width:170px"></td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="   취소   " class="AXButton"></li>&nbsp;
				<li><input type="button" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	<!-- tip_box -->
	<div class="tip_box">
		<p>
			웹사이트의 관리자 정보입니다. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
			비밀번호와 이름, 이메일 주소를 입력해 주세요. <br />
		</p>
	</div>
	<!-- //tip_box -->

	<!-- tb_list -->
	<div class="tb_list">
		<h4>매출관리리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="" />
				<col width="135px" />
				<col width="9%" />
				<col width="9%" />
				<col width="8%" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">제목</th>
				<th class="bdr">매장명</th>
				<th class="bdr">작성자</th>
				<th class="bdr">등록일</th>
				<th>조회수</th>
			</tr>

			<tr>
				<td class="bdr bdt">11111</td>
				<td class="bdr bdt tit">제목이 들어갑니다.제목이 들어갑니다.</td>
				<td class="bdr bdt">
					<select name="" id="" class="s_box" style="width:120px">
						<option value="">선택하세요</option>
						<option value="">aaaaaaaaa</option>
						<option value=""></option>
						<option value=""></option>
						<option value=""></option>
					</select>
				</td>
				<td class="bdr bdt">웹모아</td>
				<td class="bdr bdt">2013-12-12</td>
				<td class="bdt"><input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#95a1ba;color:#fff;border:1px solid #95a1ba"></td>
			</tr>
			<tr>
				<td class="bdr bdt">1</td>
				<td class="bdr bdt tit">매출관리 리스트 제목입니다.</td>
				<td class="bdr bdt">
					<select name="" id="" class="s_box" style="width:120px">
						<option value="">선택하세요</option>
						<option value="">aaaaaaaaa</option>
						<option value=""></option>
						<option value=""></option>
						<option value=""></option>
					</select>
				</td>
				<td class="bdr bdt">웹모아</td>
				<td class="bdr bdt">2013-12-12</td>
				<td class="bdt"><input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#95a1ba;color:#fff;border:1px solid #95a1ba"></td>
			</tr>
			<tr>
				<td class="bdr bdt">1</td>
				<td class="bdr bdt tit">매출현황 리스트</td>
				<td class="bdr bdt">
					<select name="" id="" class="s_box" style="width:120px">
						<option value="">선택하세요</option>
						<option value="">aaaaaaaaa</option>
						<option value=""></option>
						<option value=""></option>
						<option value=""></option>
					</select>
				</td>
				<td class="bdr bdt">웹모아</td>
				<td class="bdr bdt">2013-12-12</td>
				<td class="bdt"><input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#95a1ba;color:#fff;border:1px solid #95a1ba"></td>
			</tr>

		</table>
	</div>
	<!-- tb_list -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
		</p>
		<p class="right">
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
			<span><input type="button" value="   검색   " class="AXButton Blue"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<!-- page -->
	<div class="page">

		<ul>
			<li><a href="">&lt;&lt;</a></li>
			<li><a href="">&lt;</a></li>
			<li class="on"><a href="">1</a></li>
			<li><a href="">2</a></li>
			<li><a href="">3</a></li>
			<li><a href="">&gt;</a></li>
			<li><a href="">&gt;&gt;</a></li>
		</ul>
	</div>
	<!-- //page -->




	<p class="btns">
	<br />
	<br />
	<br />
	<input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
	<input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b">
	<input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b">
	<input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba">
	<input type="button" value=" 준비중 " class="AXButtonSmall" style="background:#7bb9cb; color:#fff; border:1px solid #7bb9cb">
	<br />
	<br />
	<br />
	</p>
</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->