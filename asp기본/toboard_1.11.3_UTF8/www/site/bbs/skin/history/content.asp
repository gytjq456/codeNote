<%
'뷰 페이지를 사용 하지 않는 경우 활성화
'Response.Redirect "?bid=" & bid & "&mode=mod&idx=" & idx
%>

<!-- lightbox2 -->
<script src="/site/api/lightbox/js/lightbox-plus-jquery.min.js"></script>
<link rel="stylesheet" href="/site/api/lightbox/css/lightbox.min.css" media="screen"/>
<!-- //lightbox2 -->

<script type="text/javascript">
function sendSNS(type){
	var title = '<%=Replace(c_title, "'", "&#39;")%>';
	title = title.replace('"', '&quot;'); // 글 제목의 "(큰따옴표)를 변환시키기
	title = title.replace('"', '&quot;'); // javascript  의 경우는 큰따옴표가 2개이면 두번 명령문을 줘야한다.
	if (type=="twitter"){
		sitelink = "http://twitter.com/home?status=";
		sitelink = sitelink + encodeURIComponent(title) + ' <%=Server.URLEncode(urlNowFull)%>';
	}else if(type=="facebook"){
		sitelink = "http://www.facebook.com/sharer.php?u=<%=Server.URLEncode(urlNowFull)%>&amp;t=" + encodeURIComponent(title);
	}else if(type=="googleplus"){
		sitelink = "https://plus.google.com/share?url=<%=Server.URLEncode(urlNowFull)%>";
	}
	window.open(sitelink);
}
</script>

<!--내용 테이블-->
<table class="ntb-tb-view" style="width:<%=T_WIDTH%>" cellpadding="0" cellspacing="0">
	<caption>게시판 내용</caption>
	<colgroup>
		<col width="12%" />
		<col width="" />
		<col width="12%" />
		<col width="15%" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="4" class="r_none"><%=TagText(c_title)%></th>
		</tr>
	</thead>
	<tbody>

	<tr>
		<th>년월일</th>
		<td colspan="3" class="left"><%=c_addtext1%>
		<%If c_addtext2<>"" Then Response.Write " / " & c_addtext2%>
		<%If c_addtext3<>"" Then Response.Write " / " & c_addtext3%></td>
	</tr>

	</tbody>
</table>

<!--버튼-->
<div class="ntb-tb-view-btn" style="width:<%=T_WIDTH%>">
	<input type="button" value=" 목록 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=list&amp;page=<%=page%>'">
	<div class="btnr">
		<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
			<!--수정-->
			<%If W_ID<>"" And (W_ID=c_mem_id or W_LEVEL="1" Or W_LEVEL="2") Then%>
				<input type="button" value=" 수정 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%Else%>
				<input type="button" value=" 수정 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%End If%>
			<!--삭제-->
			<input type="button" value=" 삭제 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=del_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
		<%End If%>
	</div>
</div>