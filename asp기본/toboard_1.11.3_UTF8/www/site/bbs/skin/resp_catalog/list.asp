<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<!--검색폼-->
<div class="ntb-search">
	<form name="searchform" action="?bid=<%=bid%>&amp;mode=list&amp;category=<%=category%>" method="post">
		<select name="s_type" id="" class="sel_box">
			<option value="title" <%If s_type="title" Then Response.Write "selected"%>>제목</option>
		</select>
		<input type="text" name="s_keyword" value="<%=s_keyword%>" required="" placeholder="검색어를 입력해주세요">
		<input type="submit" name="검색" value="">
	</form>
</div>

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

<!-- gallery -->
<section class="catalog">
	<div class="cont_wrap">

	<%If Rs.EOF Then%>
	게시물이 없습니다.
	<%Else
		cnt=0
		num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
		Do Until Rs.EOF Or cnt>=Rs.pagesize
			b_idx = Rs("idx")
			b_cate = Rs("cate")
			b_mem_name = Rs("mem_name")
			b_addtext1 = Rs("addtext1")
			b_addtext2 = Rs("addtext2")
			b_addtext3 = Rs("addtext3")
			b_addtext4 = Rs("addtext4")
			b_addtext5 = Rs("addtext5")
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
			b_regdate = Rs("regdate")
			%>
			<div class="item">
				<div class="img">
					<%If b_file1<>"" Then%>
						<img src="<%=k_uploadfolder%>/thumb/<%=b_file1%>" alt="<%=b_idx%>" class="gallery-image" />
					<%Else%>
						<img src="http://placehold.it/270X380" alt="<%=b_idx%>" class="gallery-image" />
					<%End If%>
				</div>
				<p><%=TagText(b_title)%> <i class="xi-download"></i></p>
				<a href="/site/download.asp?bid=<%=bid%>&amp;file=<%=Server.UrlEncode(b_file2)%>"></a>
			</div>
			<%
			num=num-1
			cnt=cnt+1
			Rs.MoveNext
			Loop
		End If
		%>
	</div>
</section>
<!-- //gallery -->

<!--버튼-->
<!--
<div class="ntb-listbtn-area">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<input type="button" value="   쓰기   " class="AXButton" onclick="location.href='?<%=pLink%>&amp;mode=reg'">
	<%End If%>
</div>
-->

<!--페이징-->
<%Call Pagelist("?mode=list&" & pLink, CInt(page), k_pagelist, 5, Rs_RecordCount)%>
