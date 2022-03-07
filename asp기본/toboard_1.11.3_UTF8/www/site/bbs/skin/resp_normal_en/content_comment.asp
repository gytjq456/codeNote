<%
'덧글
If k_comment=True Then
	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT * FROM tbl_board_comment WHERE board_idx='" & bid & "' AND dat_idx='" & idx & "'"
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		Rs_RecordCount = Rs.RecordCount
	Else
		Rs_RecordCount = 0
	End If
	%>
	<form name="regform" action="?mode=comment_reg_p&amp;<%=pLink%>&amp;idx=<%=idx%>&amp;page=<%=page%>" method="post" enctype="multipart/form-data">
		<div class="ntb-tb-view-comment quick_start">
			<table width="<%=T_WIDTH%>" cellpadding="0" cellspacing="0" class="ntb-tb-view-comment">
				<caption>게시판 덧글</caption>
				<colgroup>
					<col width="" />
					<col width="12%" />
				</colgroup>
				<thead>
					<tr>
						<th colspan="2" class="left r_none">Comments <span class="font_comcnt"><%=Rs_RecordCount%></span></th>
					</tr>
				</thead>
				<tbody>
				<%
				'덧글 표시
				Do Until Rs.EOF
					bc_idx = Rs("idx")
					bc_mem_name = Rs("mem_name")
					bc_content = Rs("content")
					bc_regdate = Rs("regdate")%>
					<tr>
						<td class="left b_none">
							<%=TagText(bc_mem_name)%>
							<span class="font_ip"><%=bc_regdate%></span>
							<%if DateDiff("h", bc_regdate, now())<k_newicon Then%><img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" /><%End If%>
						</td>
						<td class="right b_none"><a href="?mode=comment_del_l&amp;<%=pLink%>&amp;idx=<%=idx%>&amp;com_idx=<%=bc_idx%>"><img src="/site/images/board/x.gif" class="vmiddle" alt="delete" /></a></td>
					</tr>
					<tr>
						<td class="content-area" colspan="2"><%=TagText(bc_content)%></td>
					</tr>
					<%
					Rs.MoveNext
				Loop
				Rs.Close
				Set Rs = Nothing

				'덧글 등록
				If CInt(a_comment)>=CInt(W_LEVEL) Then%>
					<tr>
						<td colspan="2" class="left b_none">
							<p style="float:left; margin-bottom:10px">
								<%If W_ID="" Then%>
									<input type="text" name="name" size="20" maxlength="20" class="inp AXInput" placeholder="Name" required />
									<input type="password" name="pw" size="20" maxlength="20" class="inp AXInput" placeholder="Password" required />
								<%Else%>
									<input type="hidden" name="name" value="<%=W_NAME%>" />
									<input type="hidden" name="pw" value="<%=W_PW%>" />
								<%End If%>
							</p>
							<textarea style="width:100%; height:130px; margin:0; padding:0" cols="" rows="" name="content" class="AXInput" required></textarea>
							<p style="float:right">
								<%If k_spamcode=True Then%>
									<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" />
									<!-- <input type="button" value="새로고침" class="AXButton Classic" onclick="RefreshImage('imgCaptcha');" /> -->
									<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput vmiddle" style="width:100px" maxlength="5" autocomplete="off" required />
								<%End If%>
								<input type="submit" value=" OK " class="AXButton Classic">
							</p>
						</td>
					</tr>
				<%End If%>
				</tbody>
			</table>
		</div>
	</form>
<%End If%>