<link rel="stylesheet" type="text/css" href="/site/bbs/skin/resp_recruit_en/style.css" />

<table class="ntb-tb-view" style="width:400px; " cellpadding="0" cellspacing="0">
	<tr>
		<th class="r_none"><%
		If mode="del_l" Then
			Response.Write "Delete post"
		ElseIf mode="comment_del_l" Then
			Response.Write "Delete comment"
		ElseIf mode="view_l" Then
			Response.Write "Secret post"
		ElseIf mode="mod_l" Then
			Response.Write "Modify post"
		End If%></th>
	</tr>
	<tr>
		<td style="padding:30px 0 30px 0;" class="vmiddle">
			<%
			Set Rs = Server.CreateObject("ADODB.Recordset")
			If mode="del_l" Then
				Sql = "SELECT mem_id, mem_pw FROM tbl_board_data WHERE idx='" & idx & "'"
				Rs.Open Sql, Dbcon, 1
				If Rs.EOF=False Then
					mem_id = Rs(0)
					mem_pw = AESDecrypt(Rs(1), "webmoa")
				End If
				Rs.Close
			ElseIf mode="comment_del_l" Then
				Sql = "SELECT mem_id, mem_pw FROM tbl_board_comment WHERE idx='" & com_idx & "'"
				Rs.Open Sql, Dbcon, 1
				If Rs.EOF=False Then
					mem_id = Rs(0)
					mem_pw = AESDecrypt(Rs(1), "webmoa")
				End If
				Rs.Close
			End If
			Set Rs = Nothing
			%>

			<form name="pwform" method="post"
			<%If mode="del_l" Then%>
				action="?<%=pLink%>&amp;mode=<%=Left(mode, Len(mode)-2) & "_p"%>&amp;idx=<%=idx%>&amp;page=<%=page%>"
			enctype="multipart/form-data"
			<%ElseIf mode="comment_del_l" Then%>
				action="?<%=pLink%>&amp;mode=<%=Left(mode, Len(mode)-2) & "_p"%>&amp;idx=<%=idx%>&amp;com_idx=<%=com_idx%>&amp;page=<%=page%>"
			enctype="multipart/form-data"
			<%ElseIf mode="view_l" Then%>
				action="?<%=pLink%>&amp;mode=<%=Left(mode, Len(mode)-2)%>&amp;idx=<%=idx%>&amp;com_idx=<%=com_idx%>&amp;page=<%=page%>"
			<%ElseIf mode="mod_l" Then%>
				action="?<%=pLink%>&amp;mode=<%=Left(mode, Len(mode)-2)%>&amp;idx=<%=idx%>&amp;com_idx=<%=com_idx%>&amp;page=<%=page%>"
			<%End If%>	>

			<%If (mode="del_l" Or mode="comment_del_l") And ((W_ID><"" And W_ID=mem_id) Or W_LEVEL="1" Or W_LEVEL="2") Then%>
				Do you really want to delete it?<br />
				<input type="hidden" name="pw" value="<%=mem_pw%>" />
			<%Else%>
				Please enter your password.<br />
				<input type="password" name="pw" size="15" maxlength="15" class="AXInput" /><br />
			<%End If%>

			<br />
			
			<input type="button" value=" Confirm " class="AXButton Classic" onclick="BoardPwChk()">
			<input type="button" value=" Cancel " class="AXButton" onclick="history.back();">

			</form>

		</td>
	</tr>
</table>

<script type="text/javascript">
//비번 체크
function BoardPwChk(){
	var a = document.pwform;
	if(a.pw.value==""){ alert('Please enter your password.'); a.pw.focus(); return; }
	a.submit();
}
</script>