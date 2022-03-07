<%@CodePage = 65001%>
<%
Response.AddHeader "Cache-Control","no-cache,no-store,must-revalidate"
Response.AddHeader "Pragma","no-cache"
Response.Expires = -1
%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<%
If W_LEVEL="3" Then
	Response.Write "<script>alert('접근 권한이 없습니다.'); history.back();</script>"
	Response.End
End If
%>
</head>

<%
s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_mailing = Request("s_mailing")
s_sort = Request("s_sort")

s_align = Request("s_align")
If s_align="" Then s_align="0"

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_mailing=" & s_mailing & "&s_sort=" & s_sort & "&s_align=" & s_align
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>관리자 계정설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>관리자 계정설정</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="listform" method="post" action="?">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>회원 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="" />
				<col width="7%" />
				<col width="16%" />
				<col width="10%" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">등급</th>
				<th class="bdr">아이디</th>
				<th class="bdr">이름</th>
				<th class="bdr">이메일</th>
				<th class="bdr">로그인 수</th>
				<th class="bdr">가입일</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_member "
			Sql = Sql & " WHERE idx!='' "
			If W_LEVEL="1" Then
				Sql = Sql & " AND m_lev IN (2, 3, 4) "
			ElseIf W_LEVEL="2" Then
				Sql = Sql & " AND m_lev='3' "
			End If

			If s_keyword<>"" Then
				Sql = Sql & " AND (m_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_id LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_email LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr2 LIKE '%" & s_keyword & "%') "
			End If

			If s_mailing<>"" Then Sql = Sql & " AND m_mailing='" & s_mailing & "' "
			If s_sort<>"" Then Sql = Sql & " AND m_sort='" & s_sort & "' "

			If s_srdate<>"" And s_erdate<>"" Then Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "

			Select Case s_align
				Case "0"
					Sql = Sql & " ORDER BY regdate DESC"
				Case "1"
					Sql = Sql & " ORDER BY regdate"
				Case "2"
					Sql = Sql & " ORDER BY m_name DESC"
				Case "3"
					Sql = Sql & " ORDER BY m_name"
				Case "4"
					Sql = Sql & " ORDER BY m_id DESC"
				Case "5"
					Sql = Sql & " ORDER BY m_id"
				Case "6"
					Sql = Sql & " ORDER BY m_logcount DESC"
				Case "7"
					Sql = Sql & " ORDER BY m_logcount"
			End Select
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 20
				Rs.AbsolutePage = page
				Rs_RecordCount = Rs.RecordCount
				If Rs_RecordCount Mod Rs.PageSize>0 Then
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
				Else
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)
				End If
			End If

			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					idx = Rs("idx")
					m_id = Rs("m_id")
					m_name = Rs("m_name")
					m_email = Rs("m_email")
					m_mailing = Rs("m_mailing")
					m_lev=Rs("m_lev")
					m_sort=Rs("m_sort")
					m_cell1 = Rs("m_cell1")
					m_cell2 = Rs("m_cell2")
					m_cell3 = Rs("m_cell3")
					m_logcount = Rs("m_logcount")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt">
						<%If m_lev="2" Then
							Response.Write "최고관리자"
						ElseIf m_lev="3" Then
							Response.Write "서브관리자"
						End If%></td>
						<td class="bdr bdt"><%=m_id%></td>
						<td class="bdr bdt"><%=m_name%></td>
						<td class="bdr bdt"><%=m_email%></td>
						<td class="bdr bdt"><%=m_logcount%></td>
						<td class="bdr bdt"><%=regdate%></td>
						<td class="bdt">
						<input type="button" value=" 보기 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='account-admin-reg.asp?mode=mod&m_id=<%=m_id%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 회원의 모든 정보가 삭제됩니다. 진행하시겠습니까?')){ location.href='account-admin-reg-ok.asp?mode=del&m_id=<%=m_id%>' }"></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="8" class="bdr bdt">회원이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<!-- page -->
	<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
	<!-- //page -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="button" value=" 관리자 등록 " class="AXButton Blue" onclick="location.href='account-admin-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->


</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->