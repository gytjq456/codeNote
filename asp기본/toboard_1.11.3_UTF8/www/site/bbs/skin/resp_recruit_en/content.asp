<!-- Lightbox2 소스-->
<script src="/site/api/lightbox/js/lightbox-2.6.min.js"></script>
<script src="/site/api/lightbox/js/modernizr.custom.js"></script>
<link rel="stylesheet" href="/site/api/lightbox/css/lightbox.css" media="screen"/>
<!-- //Lightbox2 소스-->

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
	}else if(type=="kakaostory"){
		sitelink = "http://story.kakao.com/s/share?url=<%=Server.URLEncode(urlNowFull)%>";
	}else if(type=="linkedin"){
		sitelink = "https://www.linkedin.com/cws/share?url=<%=Server.URLEncode(urlNowFull)%>";
	}else if(type=="instagram"){
	}
	window.open(sitelink);
}
</script>

<!--내용 테이블-->
<table class="ntb-tb-view" style="width:<%=T_WIDTH%>" cellpadding="0" cellspacing="0">
	<caption>게시판 내용</caption>
	<colgroup>
		<col width="25%" />
		<col width="" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="2" class="view_tit r_none"><%
			If CDate(c_addtext1)>Date() Then
				Response.Write "<input type=""button"" value=""모집전"" class=""AXButtonSmall Classic""> "
			ElseIf CDate(c_addtext2)<Date() Then
				Response.Write "<input type=""button"" value=""End"" class=""AXButtonSmall Classic""> "
			Else
				Response.Write "<input type=""button"" value=""Recruiting"" class=""AXButtonSmall Blue""> "
			End If
			%>
			<%=TagText(c_title)%></th>
		</tr>
	</thead>
	<tbody>

	<%If c_mem_tel<>"" Then%>
	<tr>
		<th>Tel</th>
		<td class="left"><%=c_mem_tel%></td>
	</tr>
	<%End If%>

	<%If c_mem_fax<>"" Then%>
	<tr>
		<th>FAX</th>
		<td class="left"><%=c_mem_fax%></td>
	</tr>
	<%End If%>

	<%If c_mem_url<>"" Then%>
	<tr>
		<th>링크URL</th>
		<td class="left"><a href="<%If Left(c_mem_url, 4)<>"http" Then Response.Write "http://"%><%=c_mem_url%>" target="_blank"><%=c_mem_url%></a></td>
	</tr>
	<%End If%>

	<%If c_addtext1<>"" Then%>
	<tr>
		<th>Recruitment Period</th>
		<td class="left"><%=c_addtext1 & " ~ " & c_addtext2%></td>
	</tr>
	<%End If%>

	<tr>
		<td colspan="2" class="cont_txt">

		<%If k_sns=True Then%>
		<div class="sns-area">
			<img src="/site/images/board/icon_twitter1.gif" onclick="sendSNS('twitter')" alt="twitter" class="vmiddle pointer"  />
			<img src="/site/images/board/icon_facebook1.gif" onclick="sendSNS('facebook')" alt="facebook" class="vmiddle pointer"  />
			<img src="/site/images/board/icon_googleplus1.gif" onclick="sendSNS('googleplus')" alt="googleplus" class="vmiddle pointer"  />
			<img src="/site/images/board/icon_kakaostory1.png" onclick="sendSNS('kakaostory')" alt="kakaostory" class="vmiddle pointer"  />	
			<img src="/site/images/board/icon_linkedin1.png" onclick="sendSNS('linkedin')" alt="linkedin" class="vmiddle pointer"  />
			<span>
				<script type="text/javascript" src="http://share.naver.net/js/naver_sharebutton.js"></script>
				<script type="text/javascript">
					new ShareNaver.makeButton({"type": "c"});
				</script>
			</span>
			<a href="mailto:?subject=<%=Server.URLEncode(c_title)%>&amp;body=<%=Server.URLEncode(urlNowFull)%>" title="Share by Email"><img src="/site/images/board/icon_email1.png" alt="mail" class="vmiddle pointer" /></a>
		</div>
		<%End If%>

		<div class="content-area">
		<%
		If k_thumbview=True Then
			For fc=1 To 15
				If ImgCheck(c_file(fc-1)) Then Response.Write "<a href=""" & k_uploadfolder & "/" & c_file(fc-1) & """ data-lightbox=""ntb-lb-set""><img src=""" & k_uploadfolder & "/" & c_file(fc-1) & """ style=""max-width:600px"" data-lightbox=""ntb-lb-set"" /></a><br /><br />"
			Next
		End If

		'html체크에 따라 태그적용하기
		If c_html=True Then
			Response.Write c_content & "<br /><br />"
		Else
			Response.Write TagText(c_content) & "<br /><br />"
		End If
		%>
		</div>
		<%If W_LEVEL="1" Or W_LEVEL="2" Then%>
		<div class="ip-area">
			<span class="font_ip">IP Address : <%=c_ip%></span>
		</div>
		<%End If%>
		</td>
	</tr>
	<!-- 파일첨부 -->
	<%For fc=1 To k_upload-1
		If c_file(fc)<>"" Then%>
		<tr>
			<th class="W25">Attachment <%=fc%></th>
			<td class="left"><img src="/site/images/board/file.gif" class="vmiddle" alt="file<%=fc%>" />
			<a href="/site/download.asp?bid=<%=bid%>&amp;file=<%=Server.UrlEncode(c_file(fc))%>"><%=c_file(fc)%></a></td>
		</tr>
		<%End If
	Next%>
	<!-- //파일첨부 -->
	</tbody>
</table>

<!--버튼-->
<div class="ntb-tb-view-btn" style="width:<%=T_WIDTH%>">
	<input type="button" value=" List " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=list&amp;page=<%=page%>'">
	<div class="btnr">
		<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
			<!--Modify-->
			<%If W_ID<>"" And (W_ID=c_mem_id or W_LEVEL="1" Or W_LEVEL="2") Then%>
				<input type="button" value=" Modify " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%Else%>
				<input type="button" value=" Modify " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%End If%>
			<!--Delete-->
			<input type="button" value=" Delete " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=del_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
		<%End If%>
	</div>
</div>

<!--#include file="content_comment.asp"-->
<!--#include file="content_prevnext.asp"-->