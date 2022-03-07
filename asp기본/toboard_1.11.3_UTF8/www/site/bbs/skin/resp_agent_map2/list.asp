<div class="ntb-search-area">
	<!-- store -->
	<div class="store">
		<!-- map_area -->
		<div class="map_area">
			<img src="/site/bbs/skin/resp_agent_map2/images/store.gif" alt="store" />
			<span class="map01"><a href="?bid=<%=bid%>&s_cate=서울">서울</a></span>
			<span class="map02"><a href="?bid=<%=bid%>&s_cate=인천">인천</a></span>
			<span class="map03"><a href="?bid=<%=bid%>&s_cate=경기">경기도</a></span>
			<span class="map04"><a href="?bid=<%=bid%>&s_cate=강원">강원도</a></span>
			<span class="map05"><a href="?bid=<%=bid%>&s_cate=대전">대전</a></span>
			<span class="map06"><a href="?bid=<%=bid%>&s_cate=세종">세종</a></span>
			<span class="map07"><a href="?bid=<%=bid%>&s_cate=충북">충청북도</a></span>
			<span class="map08"><a href="?bid=<%=bid%>&s_cate=충남">충청남도</a></span>
			<span class="map09"><a href="?bid=<%=bid%>&s_cate=대구">대구</a></span>
			<span class="map10"><a href="?bid=<%=bid%>&s_cate=경북">경상북도</a></span>
			<span class="map11"><a href="?bid=<%=bid%>&s_cate=울산">울산</a></span>
			<span class="map12"><a href="?bid=<%=bid%>&s_cate=부산">부산</a></span>
			<span class="map13"><a href="?bid=<%=bid%>&s_cate=경남">경상남도</a></span>
			<span class="map14"><a href="?bid=<%=bid%>&s_cate=전북">전라북도</a></span>
			<span class="map15"><a href="?bid=<%=bid%>&s_cate=전남">전라남도</a></span>
			<span class="map16"><a href="?bid=<%=bid%>&s_cate=광주">광주</a></span>
			<span class="map17"><a href="?bid=<%=bid%>&s_cate=제주">제주도</a></span>
		</div>
		<!-- //map_area -->

		<!-- search_area -->
		<div class="search_area">
			<span class="tit">매장 검색</span>
			<ul>
			<form name="search_form" action="?bid=<%=bid%>&amp;s_type=addtext1&amp;category=<%=category%>" method="post">
				<li><span>주소</span><input type="text" name="s_keyword" class="AXInput" />&nbsp;<input type="submit" class="AXButton" value="검색" style="background:#1b4381;color:#fff;border:1px solid #1b4381" /></li>
			</form>
			<form name="search_form2" action="?bid=<%=bid%>&amp;s_type=title&amp;category=<%=category%>" method="post">
				<li><span>매장명</span><input type="text" name="s_keyword" class="AXInput" />&nbsp;<input type="submit" class="AXButton" value="검색"style="background:#1b4381;color:#fff;border:1px solid #1b4381" /></li>
			</form>
			</ul>
			<p class="txt">좌측 지도위에 표시된 지역을 선택하시거나 찾으시는지역 혹은 매장명을 입력해주세요. </p>
			<p class="txt">가까운 지역에 있는 매장의 상세한 정보를 알려드립니다.</p>
		</div>
		<!-- //search_area -->
	</div>
	<!-- //store -->
</div>
<br />
<br />

<form name="delform" action="?<%=pLink%>&amp;mode=seldel_p" method="post" enctype="multipart/form-data">
<table class="ntb-tb" style="width:100%" cellpadding="0" cellspacing="0">
	<!--
	<colgroup>
		<col width="9%" />
		<col width="9%" />
		<col width="18%" />
		<col width="" />
		<col width="16%" />
		<col width="15%" />
	</colgroup>
	-->
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">지역</th>
			<th scope="col">매장명</th>
			<th scope="col">주소</th>
			<th scope="col" class="r_none">연락처</th>
		</tr>
	</thead>
	<tbody>
	<%If Rs.EOF Then%>
		<tr>
			<td colspan="5">매장이 없습니다.</td>
		</tr>
	<%Else%>
		<%
		num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
		Do Until Rs.EOF Or cnt>=Rs.pagesize
			b_idx = Rs("idx")
			b_board_idx = Rs("board_idx")
			b_cate = Rs("cate")
			b_e1_idx = Rs("e1_idx")
			b_e2_idx = Rs("e2_idx")
			b_num = Rs("num")
			b_p_num = Rs("p_num")
			b_r_num = Rs("r_num")
			b_d_num = Rs("d_num")
			b_mem_name = Rs("mem_name")
			b_mem_id = Rs("mem_id")
			b_mem_pw = Rs("mem_pw")
			b_mem_tel = Rs("mem_tel")
			b_mem_url = Rs("mem_url")
			b_mem_email = Rs("mem_email")
			b_addtext1 = Rs("addtext1")
			b_addtext2 = Rs("addtext2")
			b_addtext3 = Rs("addtext3")
			b_addtext4 = Rs("addtext4")
			b_addtext5 = Rs("addtext5")
			b_addtext6 = Rs("addtext6")
			b_addtext7 = Rs("addtext7")
			b_addtext8 = Rs("addtext8")
			b_addtext9 = Rs("addtext9")
			b_addtext10 = Rs("addtext10")
			b_addtext11 = Rs("addtext11")
			b_addtext12 = Rs("addtext12")
			b_addtext13 = Rs("addtext13")
			b_addtext14 = Rs("addtext14")
			b_addtext15 = Rs("addtext15")
			b_title = Rs("title")
			b_content = Rs("content")
			b_comment_count = Rs("comment_count")
			b_read_count = Rs("read_count")
			b_ip = Rs("ip")
			b_file1 = Rs("file1")
			b_file2 = Rs("file2")
			b_file3 = Rs("file3")
			b_file4 = Rs("file4")
			b_file5 = Rs("file5")
			b_html = Rs("html")
			b_notice = Rs("notice")
			b_repmail = Rs("repmail")
			b_lock = Rs("lock")
			b_popup = Rs("popup")
			b_regdate = Rs("regdate")
			%>
			<tr>
				<td>
					<%
					'게시물 삭제 체크박스
					If W_LEVEL="1" Or W_LEVEL="2" Then%>
						<input type="checkbox" name="delidx" value="<%=b_idx%>">
					<%End If

					'게시물 아이콘
					If b_notice=True Then%>
						<img src="/site/images/board/icon_notice.gif" class="vmiddle" alt="notice" />
					<%Else%>
						<%=num%>
					<%End If%>
				</td>
				<td><%
				'카테고리
				If b_cate<>"" Then
					Response.Write b_cate
				End If%></td>
				<td>
				<%
				'비밀글 이미지
				If b_lock=True Then%>
					<img src="/site/images/board/lock.gif" class="vmiddle" alt="lock" />
				<%End If%>
				<span class='bold'>
				<%
				If b_lock=True Then
					If (W_ID<>"" And W_ID=b_mem_id) Or W_LEVEL="1" Or W_LEVEL="2" Then%>
						<a href="?mode=view&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
					<%Else%>
						<a href="?mode=view_l&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
					<%End If
				Else%>
					<a href="?mode=view&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
				<%End If%>
				<%=TagText(b_title)%>
				</a></span>
				<%
				'덧글 갯수 출력
				If k_comment=true Then
					Set RsC = Server.CreateObject("ADODB.Recordset")
					Sql = "SELECT COUNT(*) FROM tbl_board_comment WHERE board_idx='" & bid & "' AND dat_idx='" & b_idx & "'"
					RsC.Open Sql, Dbcon, 1
					If RsC(0)<>0 Then Response.Write "<span class='font_comment'>[" & RsC(0) & "]</span>"
					RsC.Close
					Set RsC = Nothing
				End If

				'일정 이내에 작성한 글에는 new 표시
				If DateDiff("h", b_regdate, Now())<k_newicon Then%>
					<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
				<%End If%>
				</td>
				<td class="left"><%=b_addtext1 & " " & b_addtext2%></td>
				<td><%=b_mem_tel%></td>
			</tr>
		<%
		num=num-1
		cnt=cnt+1
		Rs.MoveNext
		Loop
	End If
	%>
	</tbody>
</table>
</form>

<!--버튼-->
<div class="ntb-listbtn-area">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<input type="button" value=" 쓰기 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=reg'">
	<%End If%>
	<%If W_LEVEL="1" Or W_LEVEL="2" And bid<>"" And b_idx<>"" Then%>
		<input type="button" value=" 삭제 " class="AXButton Classic" onclick="BoardSelChk();">
	<%End If%>
</div>

<!--페이징-->
<%Call Pagelist("?mode=list&" & pLink, CInt(page), k_pagelist, 5, Rs_RecordCount)%>

<script type="text/javascript">
//리스트 선택 삭제
function BoardSelChk(){
	var obj = document.delform;
	var tmpb = false;
	if(document.getElementsByName("delidx").length==1){
		if(obj.delidx.checked){
			tmpb=true;
		}
	}else{
		for (i=0; i<document.getElementsByName("delidx").length; i++){
			if(document.getElementsByName("delidx")[i].checked){
				tmpb=true;
			}
		}
	}
	if(tmpb==false){
		alert('하나이상 체크해주세요.');
		return;
	}
	obj.submit();
}
</script>