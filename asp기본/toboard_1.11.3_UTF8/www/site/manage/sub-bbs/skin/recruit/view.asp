<%
'게시물 정보 취득
ReDim c_file(15)

Set Rs = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM tbl_board_data WHERE board_idx='" & bid & "' AND idx='" & idx & "'"
Rs.open Sql, Dbcon, 1
If Rs.EOF=False Then
	c_idx = Rs("idx")
	c_board_idx = Rs("board_idx")
	c_cate = Rs("cate")
	c_e1_idx = Rs("e1_idx")
	c_e2_idx = Rs("e2_idx")
	c_num = Rs("num")
	c_p_num = Rs("p_num")
	c_r_num = Rs("r_num")
	c_d_num = Rs("d_num")
	c_mem_name = Rs("mem_name")
	c_mem_id = Rs("mem_id")
	c_mem_pw = AESDecrypt(Rs("mem_pw"), "webmoa")
	c_mem_tel = Rs("mem_tel")
	c_mem_fax = Rs("mem_fax")
	c_mem_url = Rs("mem_url")
	c_mem_email = Rs("mem_email")
	c_addtext1 = Rs("addtext1")
	c_addtext2 = Rs("addtext2")
	c_addtext3 = Rs("addtext3")
	c_addtext4 = Rs("addtext4")
	c_addtext5 = Rs("addtext5")
	c_addtext6 = Rs("addtext6")
	c_addtext7 = Rs("addtext7")
	c_addtext8 = Rs("addtext8")
	c_addtext9 = Rs("addtext9")
	c_addtext10 = Rs("addtext10")
	c_addtext11 = Rs("addtext11")
	c_addtext12 = Rs("addtext12")
	c_addtext13 = Rs("addtext13")
	c_addtext14 = Rs("addtext14")
	c_addtext15 = Rs("addtext15")
	c_addtext16 = Rs("addtext16")
	c_addtext17 = Rs("addtext17")
	c_addtext18 = Rs("addtext18")
	c_addtext19 = Rs("addtext19")
	c_addtext20 = Rs("addtext20")
	c_title = Rs("title")
	c_content = Rs("content")
	c_seo_title = Rs("seo_title")
	c_seo_keyword = Rs("seo_keyword")
	c_seo_description = Rs("seo_description")
	c_comment_count = Rs("comment_count")
	c_read_count = Rs("read_count")
	c_ip = Rs("ip")
	For fc=1 To k_upload-1
		c_file(fc) = Rs("file" & fc+1)
	Next
	c_html = Rs("html")
	c_notice = Rs("notice")
	c_repmail = Rs("repmail")
	c_lock = Rs("lock")
	c_popup = Rs("popup")
	c_regdate = Rs("regdate")
Else
	Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing
%>

<div class="tb_info">
	<h4>게시물 관리</h4>
	<table>
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<%If c_cate<>"" Then%>
		<tr>
			<th class="title bdr bdt">카테고리</th>
			<td class="bdt bdr"><%=c_cate%></td>
		</tr>
		<%End If%>
		<tr>
			<th class="title bdr bdt">제목</th>
			<td class="bdt bdr"><%=TagText(c_title)%></td>
		</tr>
		<%If c_addtext1<>"" Then%>
		<tr>
			<th class="title bdr bdt">모집기간</th>
			<td class="bdt bdr"><%=c_addtext1 & " ~ " & c_addtext2%></td>
		</tr>
		<%End If%>
		<%If c_mem_tel<>"" Then%>
		<tr>
			<th class="title bdr bdt">연락처</th>
			<td class="bdt bdr"><%=c_mem_tel%></td>
		</tr>
		<%End If%>
		<%If c_mem_fax<>"" Then%>
		<tr>
			<th class="title bdr bdt">FAX</th>
			<td class="bdt bdr"><%=c_mem_fax%></td>
		</tr>
		<%End If%>
		<%If c_mem_url<>"" Then%>
		<tr>
			<th class="title bdr bdt">링크URL</th>
			<td class="bdt bdr"><a href="<%If Left(c_mem_url, 4)<>"http" Then Response.Write "http://"%><%=c_mem_url%>" target="_blank"><%=c_mem_url%></a></td>
		</tr>
		<%End If%>
		<tr>
			<th class="title bdr bdt">내용</th>
			<td class="bdt bdr"><%
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
			End If%>

			</td>
		</tr>

		<!-- 파일첨부 -->
		<%For fc=1 To k_upload-1
			If c_file(fc)<>"" Then%>
			<tr>
				<th class="title bdr bdt">파일첨부<%=fc%></th>
				<td class="bdt bdr">
				<%
				If ImgCheck(c_file(fc)) Then Response.Write "<img src=""" & k_uploadfolder & "/" & c_file(fc) & """ style=""max-width:60px"" data-lightbox=""ntb-lb-set"" /><br />"
				%>
				<a href="/site/download.asp?bid=<%=bid%>&amp;file=<%=Server.UrlEncode(c_file(fc))%>"><%=c_file(fc)%></a></td>
			</tr>
			<%
			End If
		Next%>
		<!-- //파일첨부 -->

		<tr>
			<th class="title bdr bdt">등록일</th>
			<td class="bdt bdr"><%=c_regdate%></td>
		</tr>
		<tr>
			<th class="title bdr bdt">조회수</th>
			<td class="bdt bdr"><%=c_read_count%></td>
		</tr>
		<tr>
			<th class="title bdr bdt">작성자</th>
			<td class="bdt bdr"><%=c_mem_name%></td>
		</tr>
		<tr style="display:none">
			<th class="title bdr bdt">이메일</th>
			<td class="bdt bdr"><%=c_mem_email%></td>
		</tr>
		<%If c_mem_id<>"" Then%>
		<tr>
			<th class="title bdr bdt">작성자 ID</th>
			<td class="bdt bdr"><%=c_mem_id%></td>
		</tr>
		<%End If%>
		<tr>
			<th class="title bdr bdt">작성자 IP</th>
			<td class="bdt bdr"><%=c_ip%></td>
		</tr>
	</table>
</div>
<!-- tb_info -->

<!-- btn_left_right -->
<div class="btn_left_right">
	<p class="left">
		<span><input type="button" value=" 목록 " class="AXButton Blue" onclick="location.href='?<%=pLink%>&amp;mode=list&amp;page=<%=page%>'"></span>
	</p>
	<p class="right">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<!--수정-->
		<%If W_ID<>"" And (W_ID=c_mem_id or W_LEVEL="1" Or W_LEVEL="2") Then%>
			<span><input type="button" value=" 수정 " class="AXButton Blue" onclick="location.href='?<%=pLink%>&amp;mode=mod&amp;idx=<%=idx%>&amp;page=<%=page%>'"></span>
		<%Else%>
			<span><input type="button" value=" 수정 " class="AXButton Blue" onclick="location.href='?<%=pLink%>&amp;mode=mod_l&amp;idx=<%=idx%>&amp;page=<%=page%>'"></span>
		<%End If%>
		<!--답변-->
		<%If CInt(a_reply)>=CInt(W_LEVEL) And c_notice=False Then%>
			<span><input type="button" value=" 답변 " class="AXButton Blue" onclick="location.href='?<%=pLink%>&amp;mode=rep&amp;idx=<%=idx%>&amp;page=<%=page%>'"></span>
		<%End If%>
		<!--삭제-->
		<span><input type="button" value=" 삭제 " class="AXButton" onclick="location.href='?<%=pLink%>&amp;mode=del_l&amp;idx=<%=idx%>&amp;page=<%=page%>'"></span>
	<%End If%>
	</p>
</div>
<!-- //btn_left_right -->


<%
'덧글
If k_comment=True Then
	Set RsC = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT * FROM tbl_board_comment WHERE board_idx='" & bid & "' AND dat_idx='" & idx & "'"
	RsC.Open Sql, Dbcon, 1
	If RsC.EOF=False Then
		RsC_RecordCount = RsC.RecordCount
	Else
		RsC_RecordCount = 0
	End If
	%>

	<br /><br /><br />
	<div class="tb_info">
		<h4>관련 덧글 (<%=RsC_RecordCount%>)</h4>
		<table>
			<caption>게시판 덧글</caption>
			<colgroup>
				<col width="20%" />
				<col width="" />
				<col width="10%" />
			</colgroup>
			<%
			'덧글 표시
			Do Until RsC.EOF
				bc_idx = RsC("idx")
				bc_mem_name = RsC("mem_name")
				bc_content = RsC("content")
				bc_regdate = RsC("regdate")%>
				<tr>
					<th class="title bdr bdt">
						<%=TagText(bc_mem_name)%>
						<%if DateDiff("h", bc_regdate, now())<k_newicon Then%><img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" /><%End If%>
					</th>
					<td class="bdr bdt"><%=bc_regdate%></td>
					<th class="title bdr bdt">
						<span><input type="button" value=" 삭제 " class="AXButton" onclick="location.href='?mode=comment_del_l&amp;<%=pLink%>&amp;idx=<%=idx%>&amp;com_idx=<%=bc_idx%>'"></span>
					</th>
				</tr>
				<tr>
					<td class="bdt bdr" colspan="3" style="padding:20px"><%=TagText(bc_content)%></td>
				</tr>
				<%
				RsC.MoveNext
			Loop
			RsC.Close
			Set RsC = Nothing

			'덧글 등록
			If CInt(a_comment)>=CInt(W_LEVEL) Then%>
				<tr>
					<td colspan="3" class="title bdr bdt">
						<form name="regform" action="?mode=comment_reg_p&amp;<%=pLink%>&amp;idx=<%=idx%>&amp;page=<%=page%>" method="post" enctype="multipart/form-data">
							<p style="float:left; margin-bottom:10px">
								<%If W_ID="" Then%>
									<input type="text" name="name" size="20" maxlength="20" class="inp AXInput" placeholder="이름" required />
									<input type="password" name="pw" size="20" maxlength="20" class="inp AXInput" placeholder="비밀번호" required />
								<%Else%>
									<input type="hidden" name="name" value="<%=W_NAME%>" />
									<input type="hidden" name="pw" value="<%=W_PW%>" />
								<%End If%>
							</p>
							<textarea style="width:100%; height:130px; margin:0; padding:0" cols="" rows="" name="content" class="AXInput" required></textarea>
							<p style="float:right">
								<%If k_spamcode=True Then%>
									<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" style="height:35px" />
									<input type="button" value="새로고침" class="AXButton Classic" onclick="RefreshImage('imgCaptcha');" />
									<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput vmiddle" style="width:100px" maxlength="5" placeholder="코드입력" autocomplete="off" required />
								<%End If%>
								<input type="submit" value=" 등록 " class="AXButton Blue">
							</p>
						</form>
					</td>
				</tr>
			<%End If%>
		</table>
	</div>
<%End If%>
