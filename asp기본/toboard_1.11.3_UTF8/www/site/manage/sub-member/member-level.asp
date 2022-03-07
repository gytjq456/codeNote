<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>회원 등급 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>회원 등급 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>회원 등급 관리</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="100px" />
				<col width="23%" />
				<col width="" />
				<col width="60px" />
				<col width="80px" />
				<col width="100px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">등급레벨 *</th>
				<th class="bdr">등급명 *</th>
				<th class="bdr">메모</th>
				<th class="bdr">기본값</th>
				<th class="bdr">회원보기</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_member_level "
			Sql = Sql & " WHERE m_lev!='' "
			Sql = Sql & " ORDER BY m_lev, m_sort  "
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1
			If Rs.EOF=False Then
				num = 1
				Do Until Rs.EOF
					idx = Rs("idx")
					m_lev = Rs("m_lev")
					m_sort = Rs("m_sort")
					m_memo = Rs("m_memo")
					m_default = Rs("m_default")
					%>
			<form name="modform<%=idx%>" method="post" action="member-level-ok.asp?mode=mod&idx=<%=idx%>" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt"><%=num%></td>
				<td class="bdr bdt">
				<select name="m_lev" id="m_lev" class="AXSelect">
				<%For mc=99 To 10 Step -1%>
					<option value="<%=mc%>" <%If m_lev=mc Then Response.Write "selected"%>><%=mc%></option>
				<%Next%>
				</select>
				</td>
				<td class="bdr bdt"><input type="text" name="m_sort" value="<%=m_sort%>" class="AXInput" style="width:90%" placeholder="등급명"></td>
				<td class="bdr bdt"><input type="text" name="m_memo" value="<%=m_memo%>" class="AXInput" style="width:90%" placeholder="메모"></td>
				<td class="bdr bdt"><input type="radio" name="m_default" onclick="location.href='member-level-ok.asp?mode=df&idx=<%=idx%>'" <%If m_default=True Then Response.Write "checked"%>></td>
				<td class="bdr bdt"><input type="button" value=" 회원보기 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='member.asp?s_sort=<%=m_sort%>'"></td>
				<td class="bdt">
				<input type="submit" value=" 수정 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b">
				<%If m_default=False Then%>
				<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 등급으로 설정된 회원은 등급 재설정이 필요합니다. 삭제 하시겠습니까?')){location.href='member-level-ok.asp?mode=del&idx=<%=idx%>'}">
				<%End If%></td>
			</tr>
			</form>
				<%
				num=num+1
				Rs.MoveNext
			Loop
			Else
				%>
			<tr>
				<td colspan="6" class="bdr bdt">등록된 등급이 없습니다.</td>
			</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
			<form name="regform" method="post" action="member-level-ok.asp?mode=reg" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt">추가</td>
				<td class="bdr bdt">
				<select name="m_lev" id="m_lev" class="AXSelect">
				<%For mc=99 To 10 Step -1%>
					<option value="<%=mc%>" <%If m_lev=mc Then Response.Write "selected"%>><%=mc%></option>
				<%Next%>
				</select></td>
				<td class="bdr bdt"><input type="text" name="m_sort" value="" class="AXInput" style="width:90%" placeholder="등급명"></td>
				<td class="bdr bdt"><input type="text" name="m_memo" value="" class="AXInput" style="width:90%" placeholder="메모"></td>
				<td class="bdr bdt">-</td>
				<td class="bdr bdt">-</td>
				<td class="bdt"><input type="submit" value=" 추가 " class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba"></td>
			</tr>
			</form>
		</table>
	</div>
	<!-- tb_list -->


	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
		<b>참고사항</b><br />
		1) 회원 등급은 1~99까지 설정 가능하며, 숫자가 작을수록 상위등급에 해당됩니다.<br />
		2) 회원 등급 1~9는 관리자 등급이므로 설정할 수 없습니다.<br />
		3) 기본값은 회원가입시 적용되는 등급입니다.<br />
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.m_sort.value==""){ alert("등급명을 입력하세요"); obj.m_sort.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->