<%
s_cate=Request("s_cate")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_keyword = Request("s_keyword")
s_lock = Request("s_lock")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "bid=" & bid & "&s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_lock=" & s_lock
%>

<script>
$( function() {
	$("#s_srdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#s_erdate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>

<form name="searchform" method="post" action="?mode=list&amp;bid=<%=bid%>">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<%If k_category<>"" Then%>
				<col width="120px" />
				<col width="" />
				<%End If%>
				<col width="120px" />
				<col width="" />
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<%If k_category<>"" Then%>
					<th class="bdb bdr">카테고리</th>
					<td class="bdb bdr">
						<select name="s_cate" class="AXSelect" onchange="location.href='?mode=list&amp;bid=<%=bid%>&amp;s_cate='+this.value">
							<option value="">------전체------</option>
							<%
							a_category = Split(k_category, "|")
							For Each cate_item In a_category
							%>
								<option value="<%=cate_item%>" <%If Trim(s_cate)=Trim(cate_item) Then Response.Write "selected"%>><%=cate_item%></option>
							<%
							Next
							%>
						</select>
					</td>
				<%End If%>
				<th class="bdb bdr">작성일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div>
				</td>
				<th class="bdb bdr">검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="키워드를 입력하세요"></td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" onclick="location.href='?mode=list&amp;bid=<%=bid%>'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

</form>

<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_board_data WHERE idx!='' AND board_idx='" & bid & "' "
If s_keyword<>"" Then
	Sql = Sql & " AND (mem_name LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR title LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR content LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext1 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext2 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext3 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext4 LIKE '%" & s_keyword & "%' "
	Sql = Sql & " OR addtext5 LIKE '%" & s_keyword & "%') "
End If

If s_srdate<>"" And s_erdate<>"" Then
	Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
ElseIf s_srdate<>"" Then
	Sql = Sql & "AND regdate>'" & s_srdate & "' "
ElseIf s_erdate<>"" Then
	Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
End If

If s_cate<>"" Then Sql = Sql & "AND cate like '" & s_cate & "' "
If e1_idx<>"" Then Sql = Sql & "AND e1_idx like '" & e1_idx & "' "

Sql = Sql & " ORDER BY notice DESC, p_num DESC, r_num ASC"

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

%>

<!-- tb_list -->
<div class="tb_list">
	<h4>게시물 관리</h4>
	<form name="delform" action="?<%=pLink%>&amp;mode=seldel_p" method="post" enctype="multipart/form-data">
		<table>
			<colgroup>
				<col width="50px" />
				<col width="60px" />
				<col width="" />
				<col width="140px" />
				<col width="140px" />
				<col width="160px" />
				<col width="200px" />
				<col width="200px" />
				<!-- <col width="80px" /> -->
				<col width="160px" />
			</colgroup>
			<tr>
				<th class="bdr"><input type="checkbox" name="allchk" id="allchk" /></th>
				<th class="bdr">번호</th>
				<th class="bdr">제목</th>
				<th class="bdr">회사명</th>
				<th class="bdr">이름</th>
				<th class="bdr">연락처</th>
				<th class="bdr">이메일</th>
				<th class="bdr">작성일</th>
				<!-- <th class="bdr">진열레벨</th> -->
				<th>관리</th>
			</tr>
			<%
			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					b_idx = Rs("idx")
					b_board_idx = Rs("board_idx")
					b_cate = Rs("cate")
					b_e1_idx = Rs("e1_idx")
					b_e2_idx = Rs("e2_idx")
					b_num = Rs("num")
					b_p_num = Rs("p_num")
					b_r_num = Rs("r_num")
					b_d_num = Rs("d_num")
					b_mem_name = Rs("mem_name")
					b_mem_id = Rs("mem_id")
					b_mem_pw = Rs("mem_pw")
					b_mem_tel = Rs("mem_tel")
					b_mem_url = Rs("mem_url")
					b_mem_email = Rs("mem_email")
					b_addtext1 = Rs("addtext1")
					b_addtext2 = Rs("addtext2")
					b_addtext3 = Rs("addtext3")
					b_addtext4 = Rs("addtext4")
					b_addtext5 = Rs("addtext5")
					b_addtext6 = Rs("addtext6")
					b_addtext7 = Rs("addtext7")
					b_addtext8 = Rs("addtext8")
					b_addtext9 = Rs("addtext9")
					b_addtext10 = Rs("addtext10")
					b_addtext11 = Rs("addtext11")
					b_addtext12 = Rs("addtext12")
					b_addtext13 = Rs("addtext13")
					b_addtext14 = Rs("addtext14")
					b_addtext15 = Rs("addtext15")
					b_title = Rs("title")
					b_content = Rs("content")
					b_comment_count = Rs("comment_count")
					b_read_count = Rs("read_count")
					b_ip = Rs("ip")
					b_file1 = Rs("file1")
					b_notice = Rs("notice")
					b_lock = Rs("lock")
					b_regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt">
						<input type="checkbox" name="delidx" value="<%=b_idx%>">
						</td>
						<td class="bdr bdt">
						<%If b_notice=True Then%>
							<img src="/site/images/board/icon_notice.gif" class="vmiddle" alt="notice" />
						<%Else%>
							<%=num%>
						<%End If%></td>
						<td class="bdr bdt tit">						
						<%If b_d_num>0 Then
							For dCnt=1 To b_d_num%>&nbsp;&nbsp;&nbsp;&nbsp;<%Next%>
							<img src="/site/images/board/re.gif" class="vmiddle" alt="reply" />
						<%End If%>
						<%
						'카테고리
						If k_category<>"" And b_cate<>"" Then
							Response.Write "<span style='color:#1e73e7'>[" & b_cate & "]</span> "
						End If

						'비밀글 이미지
						If b_lock=True Then%>
							<img src="/site/images/board/lock.gif" class="vmiddle" alt="lock" />
						<%End If%>

						<%=b_title%>

						<%
						'덧글 갯수 출력
						If k_comment=true Then
							Set RsC = Server.CreateObject("ADODB.Recordset")
							Sql = "SELECT COUNT(*) FROM tbl_board_comment WHERE board_idx='" & bid & "' AND dat_idx='" & b_idx & "'"
							RsC.Open Sql, Dbcon, 1
							If RsC(0)<>0 Then Response.Write " <span style='color:#dd4444'>[" & RsC(0) & "]</span>"
							RsC.Close
							Set RsC = Nothing
						End If

						'일정 이내에 작성한 글에는 new 표시
						If DateDiff("h", b_regdate, Now())<k_newicon Then%>
							<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
						<%End If%>
						</td>
						<td class="bdr bdt"><%=b_addtext1%></td>
						<td class="bdr bdt"><%=b_mem_name%></td>
						<td class="bdr bdt"><%=b_mem_tel%></td>
						<td class="bdr bdt"><%=b_mem_email%></td>
						<td class="bdr bdt"><%=b_regdate%></td>
						<!-- <td class="bdr bdt"><%Call MovePost(bid, b_idx, b_num)%></td> -->
						<td class="bdt">
						<input type="button" value=" 보기" class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b" onclick="location.href='?mode=view&idx=<%=b_idx%>&<%=pLink%>&page=<%=page%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="location.href='?<%=pLink%>&amp;mode=del_l&amp;idx=<%=b_idx%>&amp;page=<%=page%>'">				
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
					<td colspan="9" class="bdr bdt">No data</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</form>
</div>
<!-- tb_list -->

<!-- btn_left_right -->
<div class="btn_left_right">
	<p class="left">
		<span><input type="button" value="   삭제   " class="AXButton" onclick="SelChk();"></span>
<!-- 		<span><input type="button" value=" 엑셀다운로드 " class="AXButton Green" onclick="location.href='bbs-excel.asp?<%=pLink%>'"></span> -->
	</p>
</div>
<!-- //btn_left_right -->

<!-- page -->
<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
<!-- //page -->

<script>
//리스트 선택 삭제
function SelChk(){
	var cnt = $("input[name=delidx]:checked").length;
	if (cnt < 1) {
		alert("하나 이상 체크 해 주세요.");
		return;
	}
	document.delform.submit();
}

$(function(){
	//전체선택 체크박스 클릭
	$("#allchk").click(function(){
		if($("#allchk").prop("checked")) {
			$("input[type=checkbox]").prop("checked",true);
		} else {
			$("input[type=checkbox]").prop("checked",false);
		}
	})
})
</script>