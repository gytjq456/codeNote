<%
'이전글 다음글 표시 (공지사항은 표시안함)
If k_prevnext=True Then

	If c_notice=False Then
		Set Rs = Server.CreateObject("ADODB.RecordSet")
		Sql = "SELECT TOP 1 idx, notice, title, comment_count, regdate, lock, mem_id FROM tbl_board_data WHERE idx<'" & idx & "' AND d_num=0 AND board_idx='" & bid & "' AND notice='0' ORDER BY idx desc"
		Rs.open Sql, Dbcon, 1
		If Rs.EOF=False Then
			bdp_idx = Rs(0)
			bdp_notice = Rs(1)
			bdp_title = Rs(2)
			bdp_comment_count = Rs(3)
			bdp_regdate = Rs(4)
			bdp_lock = Rs(5)
			bdp_mem_id = Rs(6)
		End If
		Rs.Close

		Sql = "SELECT TOP 1 idx, notice, title, comment_count, regdate, lock, mem_id FROM tbl_board_data WHERE idx>'" & idx & "' AND d_num=0 AND board_idx='" & bid & "' AND notice='0' ORDER BY idx asc"
		Rs.open Sql, Dbcon, 1
		If Rs.EOF=False Then
			bdn_idx = Rs(0)
			bdn_notice = Rs(1)
			bdn_title = Rs(2)
			bdn_comment_count = Rs(3)
			bdn_regdate = Rs(4)
			bdn_lock = Rs(5)
			bdn_mem_id = Rs(6)
		End If
		Rs.Close
		Set Rs = nothing
		%>

	<div class="ntb-tb-view-reply quick_start">

		<!--이전글 시작-->	
		<table width="<%=T_WIDTH%>" cellpadding="0" cellspacing="0" class="ntb-tb-view">
			<caption>게시판 이전/다음글</caption>
			<colgroup>
				<col width="25%" />
				<col />
			</colgroup>
			<%if bdp_idx<>"" Then%>
			<tr <%If bdp_lock=True Then
				If (W_ID<>"" And W_ID=bdp_mem_id) Or W_LEVEL="1" Or W_LEVEL="2" Then%>
					onclick="location.href='?mode=view&amp;<%=pLink%>&amp;idx=<%=bdp_idx%>&amp;page=<%=page%>'" 
				<%Else%>
					onclick="location.href='?mode=view_l&amp;<%=pLink%>&amp;idx=<%=bdp_idx%>&amp;page=<%=page%>'" 
				<%End If				
			Else%>
				onclick="location.href='?mode=view&amp;<%=pLink%>&amp;idx=<%=bdp_idx%>&amp;page=<%=page%>'" 
			<%End If%> class="pointer"> 
				<th>이전글</th>
				<td class="left"> 
					<%'비밀글 이미지
					If bdp_lock=true Then%>
					<img src="/site/images/board/lock.gif" class="vmiddle" alt="lock" />
					<%End If%>
					
					<%=TagText(bdp_title)%>

					<%If bdp_comment_count>0 and k_comment=True Then Response.Write " <span class='font_comment'>[" & bdp_comment_count & "]</span>"%>

					<%If DateDiff("h", bdp_regdate, now())<k_newicon Then%>
					<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
					<%End If%>
				</td>
			</tr>
			<%Else%>
			<tr> 
				<th>이전글</th>
				<td class="left font_gray">이전글이 없습니다.</td>
			</tr>
			<%End If%>	
			<!--다음글 시작-->
			<%if bdn_idx<>"" Then%>
			<tr <%If bdn_lock=true Then
				If (W_ID<>"" And W_ID=bdn_mem_id) Or W_LEVEL="1" Or W_LEVEL="2" Then%>
					onclick="location.href='?mode=view&amp;<%=pLink%>&amp;idx=<%=bdn_idx%>&amp;page=<%=page%>'" 
				<%Else%>
					onclick="location.href='?mode=view_l&amp;<%=pLink%>&amp;idx=<%=bdn_idx%>&amp;page=<%=page%>'" 
				<%End If				
			Else%>
				onclick="location.href='?mode=view&amp;<%=pLink%>&amp;idx=<%=bdn_idx%>&amp;page=<%=page%>'" 
			<%End If%> class="pointer"> 
				<th>다음글</th>
				<td class="left"> 
					<%If bdn_lock=true Then%>
					<img src="/site/images/board/lock.gif" class="vmiddle" alt="lock" />
					<%End If%>

					<%=TagText(bdn_title)%>

					<%if bdn_comment_count>0 and k_comment=True Then Response.Write " <span class='font_comment'>[" & bdn_comment_count & "]</span>"%>

					<%if DateDiff("h", bdn_regdate, Now())<k_newicon Then%>
					<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
					<%End If%>
				</td>
			</tr>
			<%Else%>
			<tr> 
				<th>다음글</th>
				<td class="left font_gray">다음글이 없습니다.</td>
			</tr>
			<%End If%>
		</table>
	</div>

	<%End If

End If	%>
