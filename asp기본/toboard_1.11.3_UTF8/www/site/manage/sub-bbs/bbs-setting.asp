<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
s_group = Request("s_group")
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>게시판 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>게시판 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<select name="s_group" class="AXSelect" onchange="location.href='?s_group='+this.value">
				<option value="">---그룹 전체---</option>
				<%
				Set Rs = Server.CreateObject("ADODB.Recordset")
				Sql = "SELECT DISTINCT k_group FROM tbl_board_id WHERE k_group!='' ORDER BY k_group"
				Rs.Open Sql, Dbcon, 1
				Do Until Rs.EOF
					k_group = Rs("k_group")
					%>
					<option value="<%=k_group%>" <%If Trim(k_group)=Trim(s_group) Then Response.Write "selected"%>><%=k_group%></option>
					<%
					Rs.Movenext
				Loop
				Rs.Close
				%>
			</select>
		</p>
	</div>
	<!-- //btn_left_right -->

	<!-- tb_list -->
	<div class="tb_list">
		<table>
			<colgroup>
				<col width="50px" />
				<col width="60px" />
				<col width="90px" />
				<col width="" />
				<col width="60px" />
				<col width="150px" />
				<col width="120px" />
				<col width="50px" />
				<col width="50px" />
				<col width="50px" />
				<col width="50px" />
				<col width="50px" />
				<col width="110px" />
				<col width="90px" />
				<col width="190px" />
			</colgroup>
			<tr>
				<th class="bdr title" rowspan="2">번호</th>
				<th class="bdr title" rowspan="2">게시판<br />ID</th>
				<th class="bdr title" rowspan="2">그룹</th>
				<th class="bdr title" rowspan="2">게시판 명</th>
				<th class="bdr title" rowspan="2">업로드</th>
				<th class="bdr title" rowspan="2">스킨(사용자)</th>
				<th class="bdr title" rowspan="2">스킨(관리자)</th>
				<th class="bdr title bdb" colspan="5">권한</th>
				<th class="bdr title" rowspan="2">진열레벨</th>
				<th class="bdr title" rowspan="2">생성일</th>
				<th class="bdr title" rowspan="2">관리</th>
			</tr>
			<tr>
				<th class="bdr title">목록</th>
				<th class="bdr title">쓰기</th>
				<th class="bdr title">답변</th>
				<th class="bdr title">보기</th>
				<th class="bdr title">덧글</th>
			</tr>
			<%
			Sql = "SELECT * FROM tbl_board_id "
			Sql = Sql & " WHERE idx!='' "
			If s_group<>"" Then
				Sql = Sql & " AND k_group='" & s_group & "' "
			End If
			Sql = Sql & " ORDER BY p_lev  "
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1
			If Rs.EOF=False Then
				num = 1
				Do Until Rs.EOF
					idx = Rs("idx")
					k_group = Rs("k_group")
					k_id = Rs("k_id")
					k_upload = Rs("k_upload")
					k_mode = Rs("k_mode")
					k_mode_mobile = Rs("k_mode_mobile")
					k_mode_admin = Rs("k_mode_admin")
					a_list = Rs("a_list")
					a_write = Rs("a_write")
					a_reply = Rs("a_reply")
					a_content = Rs("a_content")
					a_comment = Rs("a_comment")
					p_lev = Rs("p_lev")
					regdate = Left(Rs("regdate"), 10)
					%>
				<tr>
					<td class="bdr bdt"><%=num%></td>
					<td class="bdr bdt"><%=idx%></td>
					<td class="bdr bdt"><%=k_group%></td>
					<td class="bdr bdt tit"><%=k_id%></td>
					<td class="bdr bdt"><%=k_upload%></td>
					<td class="bdr bdt"><%=k_mode%></td>
					<td class="bdr bdt"><%=k_mode_admin%></td>
					<td class="bdr bdt"><%=a_list%></td>
					<td class="bdr bdt"><%=a_write%></td>
					<td class="bdr bdt"><%=a_reply%></td>
					<td class="bdr bdt"><%=a_content%></td>
					<td class="bdr bdt"><%=a_comment%></td>
					<td class="bdr bdt">
					<form name="modform<%=idx%>" method="post" action="bbs-setting-reg-ok.asp?mode=levmod&idx=<%=idx%>">
					<input type="text" name="p_lev" class="AXInput W30" value="<%=p_lev%>" numberOnly />
					<input type="submit" value="수정" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
					</form></td>
					<td class="bdr bdt"><%=regdate%></td>
					<td class="bdt">
					<input type="button" value="보기" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='bbs.asp?bid=<%=idx%>'">
					<input type="button" value="설정" class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b" onclick="location.href='bbs-setting-reg.asp?mode=mod&idx=<%=idx%>'">
					<input type="button" value="복사" class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba" onclick="if(confirm('<%=k_id%>의 설정을 그대로 복사하여 새 게시판을 생성하시겠습니까?')){location.href='bbs-setting-reg-ok.asp?mode=copy&idx=<%=idx%>'}">
					<input type="button" value="삭제" class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('게시판과 모든 게시물을 삭제 하시겠습니까?')){location.href='bbs-setting-reg-ok.asp?mode=del&idx=<%=idx%>'}">
					<input type="button" value="xls" class="AXButtonSmall Green" onclick="location.href='bbs-excel.asp?bid=<%=idx%>'"></td>
				</tr>
				<%
				num=num+1
				Rs.MoveNext
			Loop
			Else
				%>
			<tr>
				<td colspan="13" class="bdr">게시판이 존재하지 않습니다.</td>
			</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>

			<form name="regform" method="post" action="bbs-setting-reg-ok.asp?mode=reg" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt" colspan="2">게시판 생성</td>
				<td class="bdr bdt"><input type="text" name="k_group" value="" class="AXInput W70" placeholder="게시판 그룹"></td>
				<td class="bdr bdt tit"><input type="text" name="k_id" value="" class="AXInput" style="width:95%" placeholder="게시판 명"></td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt"><%=BbsSkinSelect("normal")%></td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt"><input type="text" name="p_lev" class="AXInput W30" value="<%=p_lev+10%>" /></td>
				<td class="bdr bdt">-</td>
				<td class="bdt"><input type="submit" value=" 생성 " class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba"></td>
			</tr>
			</form>
		</table>
	</div>
	<!-- tb_list -->

</div>

<script type="text/javascript">
function RegChk(obj){
	if(obj.k_id.value==""){ alert('게시판 명을 입력하세요'); obj.k_id.focus(); return false; }
	if(obj.p_lev.value==""){ alert('진열레벨을 입력하세요'); obj.p_lev.focus(); return false; }
}
</script>

<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->