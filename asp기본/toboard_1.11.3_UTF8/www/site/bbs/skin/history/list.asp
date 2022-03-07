
<!--카테고리-->
<div class="ntb-top-area">
<%
'카테고리 셀렉트
If k_category<>"" Then
	%>
	<select name="s_cate" class="AXSelect" onchange="location.href='?mode=list&amp;bid=<%=bid%>&amp;s_cate='+this.value">
		<option value="">------전체------</option>
		<%
		a_category = Split(k_category, "|")
		For Each cate_item In a_category
		%>
			<option value="<%=cate_item%>" <%If Trim(s_cate)=Trim(cate_item) Then Response.Write "selected"%>><%=cate_item%></option>
		<%
		Next
		%>
	</select>
	<%
End If

'RSS사용
If k_rss=True Then%>
<a href="/site/bbs/bbs_rss.asp?bid=<%=bid%>" target="_blank"><img src="/site/images/board/icon_rss.gif" border="0" alt="rss" class="vmiddle" /></a>
<%End If%>
</div>

<form name="delform" action="?<%=pLink%>&amp;mode=seldel_p" method="post" enctype="multipart/form-data">
<table class="ntb-tb" style="width:100%" cellpadding="0" cellspacing="0">
	<colgroup>
		<col width="9%" />
		<col width="18%" />
		<col width="" />
		<col width="14%" />
		<col width="14%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">년월일</th>
			<th scope="col">내용</th>
			<th scope="col">이름</th>
			<th scope="col" class="r_none">작성일</th>
		</tr>
	</thead>
	<tbody>
	<%If Rs.EOF Then%>
		<tr>
			<td colspan="5">게시물이 없습니다.</td>
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
					<%End If%>
					<%=num%>
				</td>
				<td><%=b_addtext1%>
				<%If b_addtext2<>"" Then Response.Write " / " & b_addtext2%>
				<%If b_addtext3<>"" Then Response.Write " / " & b_addtext3%></td>
				<td class="left">
					<%
					'카테고리
					If k_category<>"" And b_cate<>"" Then
						Response.Write "<span class='font_category'>[" & b_cate & "]</span> "
					End If

					'공지사항은 bold 처리
					If b_notice=True Then Response.Write "<span class='bold'>"
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
						</a>
					<%If b_notice=True Then Response.Write "</span>"

					'일정 이내에 작성한 글에는 new 표시
					If DateDiff("h", b_regdate, Now())<k_newicon Then%>
						<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
					<%End If%>
				</td>
				<td><%=b_mem_name%></td>
				<td><%=Left(b_regdate,10)%></td>
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
<div class="page">
	<ul>
		<%Call Pagelist("?mode=list&" & pLink, CInt(page), k_pagelist, 5, Rs_RecordCount)%>
	</ul>
</div>

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