<%
'뷰 페이지를 사용 하지 않는 경우 활성화
'Response.Redirect "?bid=" & bid & "&mode=mod&idx=" & idx
%>

<!-- lightbox2 -->
<script src="/site/api/lightbox/js/lightbox-plus-jquery.min.js"></script>
<link rel="stylesheet" href="/site/api/lightbox/css/lightbox.min.css" media="screen"/>
<!-- //lightbox2 -->

<!--내용 테이블-->
<table class="ntb-tb-view" style="width:<%=T_WIDTH%>" cellpadding="0" cellspacing="0">
	<caption>게시판 내용</caption>
	<colgroup>
		<col width="20%" />
		<col width="" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="2" class="r_none"><%=TagText(c_title)%></th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<th>분류</th>
		<td class="left"><%=c_cate%></td>
	</tr>
	<tr>
		<th>주문번호</th>
		<td class="left"><%=c_addtext1%></td>
	</tr>
	<tr>
		<th>이름</th>
		<td class="left"><%=c_mem_name%></td>
	</tr>
	<%If c_mem_tel<>"" Then%>
	<tr>
		<th>연락처</th>
		<td class="left"><%=c_mem_tel%></td>
	</tr>
	<%End If%>
	<tr>
		<th>E-mail</th>
		<td class="left"><%=c_mem_email%>&nbsp;</td>
	</tr>

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

	<tr>
		<th>내용</th>
		<td class="left"><%=TagText(c_content)%></td>
	</tr>

	<!-- 파일첨부 -->
	<%For fc=0 To k_upload-1
		If c_file(fc)<>"" Then%>
		<tr>
			<th>첨부파일<%=fc+1%></th>
			<td class="left"><img src="/site/images/board/file.gif" class="vmiddle" alt="file<%=fc%>" />
			<a href="/site/download.asp?bid=<%=bid%>&amp;file=<%=Server.UrlEncode(c_file(fc))%>"><%=c_file(fc)%></a></td>
		</tr>
		<%End If
	Next%>
	<!-- //파일첨부 -->
	<tr>
		<th>접수일</th>
		<td class="left"><%=c_regdate%></td>
	</tr>

	</tbody>
</table>

<!--버튼-->
<div class="ntb-tb-view-btn" style="width:<%=T_WIDTH%>">
	<input type="button" value=" 목록 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=list&amp;page=<%=page%>'">
	<div class="btnr">
		<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
			<!--쓰기-->
			<!--input type="button" value=" 쓰기 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=reg&amp;page=<%=page%>'"-->
			<!--수정-->
			<!--
			<%If W_ID<>"" And (W_ID=c_mem_id or W_LEVEL="1" Or W_LEVEL="2") Then%>
				<input type="button" value=" 수정 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%Else%>
				<input type="button" value=" 수정 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=mod_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
			<%End If%>
			-->
			<!--삭제-->
			<input type="button" value=" 삭제 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=del_l&amp;idx=<%=idx%>&amp;page=<%=page%>'">
		<%End If%>

	</div>
</div>

<!--#include file="content_comment.asp"-->
<!--#include file="content_prevnext.asp"-->