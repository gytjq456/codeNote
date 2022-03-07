<!-- Lightbox2 소스-->
<script src="/site/api/lightbox/js/lightbox-2.6.min.js"></script>
<script src="/site/api/lightbox/js/modernizr.custom.js"></script>
<link rel="stylesheet" href="/site/api/lightbox/css/lightbox.css" media="screen"/>
<!-- //Lightbox2 소스-->

<script src="/site/bbs/skin/resp_gallery/js/imagesloaded.pkgd.min.js"></script>
<script src="/site/bbs/skin/resp_gallery/js/masonry.pkgd.min.js"></script>

<!--검색폼-->
<div class="ntb-search">
	<form name="searchform" action="?bid=<%=bid%>&amp;mode=list&amp;category=<%=category%>" method="post">
		<select name="s_type" id="" class="sel_box">
			<option value="title" <%If s_type="title" Then Response.Write "selected"%>>Title</option>
			<option value="mem_name" <%If s_type="mem_name" Then Response.Write "selected"%>>Name</option>
			<option value="content" <%If s_type="content" Then Response.Write "selected"%>>Content</option>
		</select>
		<input type="text" name="s_keyword" value="<%=s_keyword%>" required="" placeholder="Please enter keywords">
		<input type="submit" name="Search" value="">
	</form>
</div>

<!--카테고리-->
<div class="ntb-top-area">
<%
'카테고리 셀렉트
If k_category<>"" Then
	%>
	<select name="s_cate" class="AXSelect" onchange="location.href='?mode=list&amp;bid=<%=bid%>&amp;s_cate='+this.value">
		<option value="">------All------</option>
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


<div class="certifi">

	<div class="grid">
		<div class="grid-sizer"></div>
		<div class="gutter-sizer"></div>
		<%If Rs.EOF Then%>
			<li class="empty">There are no data.</li>
		<%Else%>
			<%
			num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
			Do Until Rs.EOF Or cnt>=Rs.pagesize
				b_idx = Rs("idx")
				b_board_idx = Rs("board_idx")
				b_cate = Rs("cate")
				b_num = Rs("num")
				b_mem_name = Rs("mem_name")
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
				b_file1 = Rs("file1")
				%>
				<div class="grid-item">
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
						<div class="img">
						<%If b_file1<>"" Then%>
							<img src="<%=k_uploadfolder%>/thumb/<%=b_file1%>" alt="<%=b_idx%>" class="gallery-image" />
						<%Else%>
							<img src="http://placehold.it/360X360/?text=No Image" alt="<%=b_idx%>" class="gallery-image" />
						<%End If%></div>
						<div class="tit"> <%=TagText(b_title)%></div>
					</a>
				</div>
				<%
				num=num-1
				cnt=cnt+1
				Rs.MoveNext
			Loop
		End If
		%>
	</div>

</div>

<!--버튼-->
<div class="ntb-listbtn-area">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<input type="button" value=" 쓰기 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=reg'">
	<%End If%>
</div>

<!--페이징-->
<%Call Pagelist("?mode=list&" & pLink, CInt(page), k_pagelist, 5, Rs_RecordCount)%>



<script>
// jQuery
$(document).ready(function() {
	$('.grid-item').each(function(index) {
		console.log(index);
		$(this).css({
			"transition-delay": (0.2 * index) + "s"
		})
	})

	setTimeout(function() {
		$('.grid-item').addClass("on");
	}, 600)
	setTimeout(function() {
		$('.grid').masonry({
			fitWidth: true,
			gutter: ".gutter-sizer",
			columnWidth: '.grid-sizer',
			itemSelector: '.grid-item'
		});

	}, 800)

})
</script>