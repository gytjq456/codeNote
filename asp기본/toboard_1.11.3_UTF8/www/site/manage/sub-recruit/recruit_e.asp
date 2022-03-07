<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="prod"%>
<!-- #include virtual="/site/manage/inc/head.asp" -->

<script type="text/javascript">
function CateSet(depth, p_code, s_code){
	var nTime = new Date().getTime();
	$.ajax({
		type: "GET",
		url : "cate-select.asp?_dc="+nTime+"&depth=" + depth + "&p_code=" + p_code + "&s_code=" + s_code,
		cache: false,
		success: function(resdata){
			$("div#catesel"+depth).html(resdata);
		},
		error: function(xhr, status, error) { 
			alert(error); 
		}
	});
}
</script>
</head>

<%
	recruit			= Request("recruit")
	s_keyword	= Request("s_keyword")
	s_hide		= Request("s_hide")

	page			= Request("page")
	If page = "" Then page = 1

	If InStr(s_keyword,"'") <> 0 Or InStr(s_keyword,"%") <> 0 Or InStr(s_keyword,",") <> 0 Then
		Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
		Response.End
	End If

	pLink = "s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_hide=" & s_hide
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>채용 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>채용 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="searchform" method="post" action="?">

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
				<th class="bdb bdr">이력서</th>
				<td class="bdb bdr">
					<select name="recruit" id="recruit" class="AXSelect">
						<option value="">---- 전체 ----</option>
						<option value="0" <% If recruit = "0" Then Response.Write "selected"%>>일반이력서</option>
						<option value="1" <% If recruit = "1" Then Response.Write "selected"%>>간편이력서</option>
						<option value="2" <% If recruit = "2" Then Response.Write "selected"%>>변동이력서</option>
					</select>
				</td>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="업체명, 직무명"></td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" style="color:#fff;background:#c4c5c9;border:1px solid #c4c5c9" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<!-- tb_list -->
	<div class="tb_list">
		<h4>채용 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="80px" />
				<col width="" />
				<col width="200px" />
				<col width="200px" />
				<col width="100px" />
				<col width="100px" />
				<col width="100px" />
				<col width="200px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">사진</th>
				<th class="bdr">업체명</th>
				<th class="bdr">모집내용</th>
				<th class="bdr">모집기간</th>
				<th class="bdr">이력서형태</th>
				<th class="bdr">등록일</th>
				<th class="bdr">지원자 수</th>
				<th>관리</th>
			</tr>
			<%
				Set Rs = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT * FROM tbl_recruit WHERE idx != '' AND edate < '"&Date()&"' OR state ='2' "
				
				If s_keyword <> "" Then
					SQL = SQL & " AND (com_NM LIKE '%" & s_keyword & "%' "
					SQL = SQL & " OR work_NM LIKE '%" & s_keyword & "%') "
				End If

				If recruit <> "" Then SQL = SQL & " AND recruit = '" & recruit & "' "

				If s_hide <> "" Then SQL = SQL & " AND s_hide = '" & s_hide & "' "

				Select Case s_align
					Case "0"
						SQL = SQL & " ORDER BY idx DESC"
					Case Else
						SQL = SQL & " ORDER BY idx DESC"
				End Select
				Rs.Open SQL, Dbcon, 1

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
						idx				= Rs("idx")
						com_NM		= Rs("com_NM")
						work_NM	= Rs("work_NM")
						sdate			= Rs("sdate")
						edate			= Rs("edate")
						recruit			= Rs("recruit")
						s_hide		= Rs("s_hide")
						state			= Rs("state")
						s_lev			= Rs("s_lev")
						p_image1	= Rs("p_image1")
						regdate		= Rs("regdate")

						SQL = "SELECT COUNT(idx) FROM tbl_resume WHERE r_idx = '"&idx&"'"
						Set objView = Dbcon.Execute(SQL)
						app_num	= objView(0)
			%>
			<tr>
				<td class="bdr bdt"><%=num%></td>
				<td class="bdr bdt"><% If p_image1 <> "" Then%><img src="/upload/recruit/<%=p_image1%>" alt="<%=p_image1%>" style="width:50px" /><% End If %></td>
				<td class="bdr bdt tit"><%=com_NM%></td>
				<td class="bdr bdt"><a href="application.asp?r_idx=<%=idx%>&recruit=<%=recruit%>"><%=work_NM%></a></td>
				<td class="bdr bdt"><%=sdate&" ~ "&edate%></td>
				<td class="bdr bdt">
				<%
					Select Case recruit
						Case "0" : Response.write "본사이력서"
						Case "1" : Response.write "간편이력서"
						Case "2" : Response.write "변동이력서"
					End Select
				%>
				</td>
				<td class="bdr bdt"><%=Left(regdate,10)%></td>
				<td class="bdr bdt"><%=app_num%> 명</td>
				<td class="bdt">
					<input type="button" value="지원자보기" class="AXButtonSmall Blue" onclick="location.href='application.asp?r_idx=<%=idx%>&recruit=<%=recruit%>'">
					<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='recruit-reg.asp?mode=mod&idx=<%=idx%>&<%=pLink%>'">
					<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 채용건을 삭제 하시겠습니까?')){ location.href='recruit-reg-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>' }">
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
					<td colspan="9" class="bdr bdt">등록된 채용건이 없습니다.</td>
				</tr>
			<%
				End If
				Rs.Close
				Set Rs = Nothing
			%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<!-- page -->
	<div class="page">
		<ul>
			<% Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount) %>
		</ul>
	</div>
	<!-- //page -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<!--<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='recruit-excel.asp?<%=pLink%>'"></span>-->
			<!--span><input type="button" value="  엑셀일괄등록  " class="AXButton Green" onclick="location.href='prod-excel-reg.asp'"></span-->
		</p>
		<p class="right">
			<span><input type="button" value="   채용등록   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="location.href='recruit-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<% If W_LEVEL="1" Then %>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>제품 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%q="recruit"%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 제품 표시 영역에 아래의 코드 삽입<br />
			&lt;!--#include virtual="/site/recruit/recruit.asp" --&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<% End If %>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<!-- #include virtual="/site/manage/inc/footer.asp" -->