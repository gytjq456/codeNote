<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script>
$( function() {
	$("#s_srdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#s_erdate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
</head>

<%
s_m_id = Request("s_m_id")
s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_m_id=" & s_m_id & "&s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate


Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_member WHERE m_id='" & s_m_id & "' "
Rs.Open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_name = Rs("m_name")
	m_point = Rs("m_point")
Else
	Response.Write "<script>alert('회원정보가 없거나 탈퇴한 회원입니다.');window.close();</script>"
	Response.End
End If
Rs.Close
Set Rs = Nothing
%>

<body style="background-color:#fff">

<!-- location -->
<div class="location">
	<p>포인트 내역</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>포인트 내역</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="searchform" method="post" action="?s_m_id=<%=s_m_id%>">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">조회 계정</th>
				<td class="bdb bdr"><%=m_name & " (" & s_m_id & ")"%></td>
				<th class="bdb bdr">현재 포인트</th>
				<td class="bdb bdr"><%=FormatNumber(m_point, 0)%>p</td>
			</tr>
			<tr>
				<th class="bdb bdr">등록일</th>
				<td class="bdb bdr" colspan="3">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div>
				</td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" style="color:#fff;background:#c4c5c9;border:1px solid #c4c5c9" onclick="location.href='?s_m_id=<%=s_m_id%>'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<!-- tb_list -->
	<div class="tb_list">
		<h4>포인트 적립 및 사용 내역</h4>
		<table>
			<colgroup>
				<col width="180px" />
				<col width="150px" />
				<col width="180px" />
				<col width="" />
				<col width="70px" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">날짜</th>
				<th class="title bdr bdt">아이디</th>
				<th class="title bdr bdt">금액</th>
				<th class="title bdr bdt">비고</th>
				<th class="title bdr bdt">관리</th>
			</tr>
			<form name="regform" method="post" action="point-ok.asp?mode=reg&s_m_id=<%=s_m_id%>">
				<tr>
					<th class="bdr bdt">추가</th>
					<th class="bdr bdt"><%=s_m_id%></th>
					<th class="bdr bdt">
					<select name="mp_pm" class="AXSelect">
						<option value="+">+</option>				
						<option value="-">-</option>				
					</select>
					<input type="text" name="mp_point" id="mp_point" class="AXInput W100" numberOnly required />p</th>
					<th class="bdr bdt">
					<input type="text" name="mp_bigo" id="mp_bigo" class="AXInput" style="width:90%" /></th>
					<th class="bdt"><input type="submit" value=" 추가 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb"></th>
				</tr>
			</form>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_member_point "
			Sql = Sql & " WHERE idx!='' AND m_id='" & s_m_id & "' "

			If s_srdate<>"" And s_erdate<>"" Then
				Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
			ElseIf s_srdate<>"" Then
				Sql = Sql & "AND regdate>'" & s_srdate & "' "
			ElseIf s_erdate<>"" Then
				Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
			End If

			Sql = Sql & " ORDER BY idx DESC "
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 50
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
					mp_point = Rs("mp_point")
					mp_pm = Rs("mp_pm")
					mp_bigo = Rs("mp_bigo")
					regdate = Rs("regdate")

					If InStr(mp_pm, "+")>0 Then
						txtcolor="style='color:#4286f4'"
					Else
						txtcolor="style='color:#f44141'"
					End If
					%>
					<tr>
						<td class="bdr bdt"><%=regdate%></td>
						<td class="bdr bdt"><%=m_id%></td>
						<td class="bdr bdt" <%=txtcolor%>><%=mp_pm & FormatNumber(mp_point, 0)%>p</td>
						<td class="bdr bdt"><%=mp_bigo%></td>
						<td class="bdt"><input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 내역을 삭제하시겠습니까?')){ location.href='point-ok.asp?mode=del&idx=<%=idx%>&s_m_id=<%=s_m_id%>' }"></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="5" class="bdr bdt">포인트 내역이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	<!-- page -->
	<div class="page">
		<ul>
			<%Call pagelist("?" & pLink, CInt(page), 50, 10, Rs_RecordCount)%>
		</ul>
	</div>
	<!-- //page -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>포인트 내역 페이지 삽입 방법</b><br />
			&lt;%mode="point"%&gt;<br />
			&lt;!--#include virtual="/site/member/member.asp"--&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->


</body>
</html>