<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
s_keyword = Request("s_keyword")
s_hide = Request("s_hide")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_hide=" & s_hide
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>E-Book 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>E-Book 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>E-Book 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="91px" />
				<col width="" />
				<col width="180px" />
				<col width="300px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">표지</th>
				<th class="bdr">제목</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.idx, A.e_title, A.regdate, "
			Sql = Sql & " (SELECT top 1 B.e_file FROM tbl_ebook_img B "
			Sql = Sql & " WHERE B.e_idx=A.idx ORDER BY B.e_lev ASC) AS e_file "
			Sql = Sql & " FROM tbl_ebook A "
			Sql = Sql & " WHERE A.idx!='' ORDER BY A.regdate DESC "
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 10
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
					e_title = Rs("e_title")
					e_file = Rs("e_file")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt"><img src="/upload/ebook/thumb/<%=e_file%>" style="width:80px" /></td>
						<td class="bdr bdt tit"><%=e_title%></td>
						<td class="bdr bdt"><%=Left(regdate, 10)%></td>
						<td class="bdt">
						<input type="button" value="미리보기" class="AXButtonSmall Red" onclick="open('/site/ebook/ebook.asp?idx=<%=idx%>', 'pop2', 'width=1220px, height=900px')">
						<!-- <input type="button" value="일괄다운로드" class="AXButtonSmall" style="background:#7bb9cb; color:#fff; border:1px solid #7bb9cb" onclick="location.href='ebook-download.asp?idx=<%=idx%>'">-->
						<input type="button" value="수정/페이지관리" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='ebook-reg.asp?mode=mod&idx=<%=idx%>&<%=pLink%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('컨텐츠를 삭제 하시겠습니까?')){ location.href='ebook-reg-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>' }">
						</td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="5" class="bdr bdt">데이터가 존재하지 않습니다.</td>
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
	<%Call pagelist("?" & pLink, CInt(page), 10, 10, Rs_RecordCount)%>
	<!-- //page -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
		</p>
		<p class="right">
			<span><input type="button" value="   등록   " class="AXButton Blue" onclick="location.href='ebook-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>E-Book 삽입 방법</b><br />
			E-Book 표시 영역에 아래의 코드 삽입<br />
			&lt;!--#include virtual="/site/ebook/index.asp"--&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<!-- #include virtual="/site/manage/inc/footer.asp" -->