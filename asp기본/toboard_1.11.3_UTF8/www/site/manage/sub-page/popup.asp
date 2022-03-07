<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
s_keyword = Request("s_keyword")

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.');history.back();</script>"
	Response.End
End If

Set Rs = Server.CreateObject("ADODB.Recordset")

Sql = "SELECT * FROM tbl_popup "
Sql = Sql & " WHERE idx!='' "
If s_keyword<>"" Then Sql = Sql & " AND p_title like '%" & s_keyword & "%' "
Sql = Sql & " ORDER BY regdate desc"

pLink = "s_keyword=" & s_keyword

'Response.Write Sql
Rs.Open Sql, Dbcon, 1

If Request("page") = "" Then
	page = 1
Else
	page = Request("page")
End If

If Rs.EOF=False then

	Rs.pagesize = 30
	Rs.absolutepage = page
	recordcount = Rs.recordcount

	if Rs.recordcount mod Rs.pagesize > 0 then
		maxpage = CInt(recordcount/Rs.pagesize)+1
	Else
		maxpage = CInt(recordcount/Rs.pagesize)
	End If

Else
	recordcount = 0
End If

%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>팝업 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>팝업 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>팝업 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="80px" />
				<col width="" />
				<col width="80px" />
				<col width="200px" />
				<col width="120px" />
				<col width="120px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">언어</th>
				<th class="bdr">제목</th>
				<th class="bdr">공개여부</th>
				<th class="bdr">게시기간</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
			i=0
			k=Rs.recordcount - ((page - 1) * Rs.pagesize) - i
			If Rs.EOF=False Then
				Do Until Rs.eof or i >= Rs.pagesize
					idx = Rs("idx")
					p_lang = Rs("p_lang")
					p_title = Rs("p_title")
					p_site = Rs("p_site")
					p_hide = Rs("p_hide")
					p_sdate = Rs("p_sdate")
					p_edate = Rs("p_edate")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=k%></td>
						<td class="bdr bdt"><%=p_lang%></td>
						<td class="bdr bdt tit"><%=p_title%></a></td>
						<td class="bdr bdt"><%If p_hide Then : Response.Write "비공개" : Else : Response.Write "공개" : End If%></td>
						<td class="bdr bdt"><%=p_sdate & " ~ " & p_edate%></td>
						<td class="bdr bdt"><%=Left(regdate,10)%></td>
						<td class="bdt">
						<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b" onclick="location.href='popup-reg.asp?mode=mod&idx=<%=idx%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('삭제 하시겠습니까?')){ location.href='popup-reg-ok.asp?mode=del&idx=<%=idx%>' }"></td>
					</tr>
					<%
					k=k-1
					i=i+1
					Rs.MoveNext
				Loop
			Else
				%>
				<tr>
					<td colspan="7" class="bdt">등록된 자료가 없습니다</td>
				</tr>
				<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="button" value="   등록   " class="AXButton Blue" onclick="location.href='popup-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->	

	<!-- page -->
	<%Call pagelist("popup.asp?" & pLink, CInt(page), 30, 10, recordcount)%>
	<!-- //page -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>팝업창 코드 삽입 방법</b><br />
			* 메인 페이지의 하단에 아래의 코드 삽입<br />
			&lt;%pop_lang="한국어"%&gt;<br />
			&lt;!-- #include virtual="/site/popup.asp" --&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>

<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->