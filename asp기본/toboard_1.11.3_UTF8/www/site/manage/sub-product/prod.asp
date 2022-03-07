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
s_cate=Request("s_cate")
s_keyword = Request("s_keyword")
s_hide = Request("s_hide")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_cate=" & s_cate & "&s_hide=" & s_hide
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>제품 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>제품 관리</li>
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
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">분류</th>
				<td class="bdb bdr"><%=CateSelect("s_cate", s_cate)%></td>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="제품명, 제품코드, 설명, 추가항목 등"></td>
				<th class="bdb bdr">숨김여부</th>
				<td class="bdb">
				<select name="s_hide" id="s_hide" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="0" <%If s_hide="0" Then Response.Write "selected"%>>표시</option>
					<option value="1" <%If s_hide="1" Then Response.Write "selected"%>>숨김</option>
				</select></td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<!-- tb_list -->
	<div class="tb_list">
		<h4>제품 리스트</h4>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="59px" />
				<col width="" />
				<%If mc_use=True Then%>
				<col width="110px" />
				<%End If%>
				<col width="70px" />
				<col width="70px" />
				<col width="110px" />
				<col width="90px" />
				<col width="150px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">사진</th>
				<th class="bdr">제품코드 / 제품명</th>
				<%If mc_use=True Then%>
				<th class="bdr">가격</th>
				<%End If%>
				<th class="bdr">조회수</th>
				<th class="bdr">숨김여부</th>
				<th class="bdr">진열레벨</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.*, B.c_name FROM tbl_prod A "
			Sql = Sql & " LEFT JOIN tbl_cate B ON A.p_cate=B.c_code "
			Sql = Sql & " WHERE A.idx!='' "
			If s_cate<>"" Then Sql = Sql & " AND (A.p_cate LIKE '" & s_cate & "%' OR A.p_cate2 LIKE '" & s_cate & "%' OR A.p_cate3 LIKE '" & s_cate & "%') "
			If s_keyword<>"" Then
				Sql = Sql & " AND (A.p_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_code LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text2 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text3 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text4 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text5 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text6 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text7 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text8 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text9 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_item_text10 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_addtext1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_addtext2 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_addtext3 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_addtext4 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_addtext5 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content2 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content3 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content4 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content5 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.p_content6 LIKE '%" & s_keyword & "%') "
			End If

			If s_hide<>"" Then Sql = Sql & " AND A.p_hide='" & s_hide & "' "

			Select Case s_align
				Case "0"
					Sql = Sql & " ORDER BY A.p_lev DESC"
				Case "1"
					Sql = Sql & " ORDER BY A.p_lev"
				Case Else
					Sql = Sql & " ORDER BY A.p_lev DESC"
			End Select
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
					p_c_name = Rs("c_name")
					p_name = Rs("p_name")
					p_cate = Rs("p_cate")
					p_code = Rs("p_code")
					p_price = Rs("p_price")
					p_image1 = Rs("p_image1")
					p_lev = Rs("p_lev")
					p_hide = Rs("p_hide")
					p_hit = Rs("p_hit")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt">
						<%If p_image1<>"" Then%>
							<img src="/upload/prod/thumb_s/<%=p_image1%>" alt="<%=p_image1%>" style="width:50px; height:50px" />
						<%Else%>
							<img src="http://placehold.it/50X50/?text=No image" alt="<%=b_idx%>" class="gallery-image" />
						<%End If%></td>
						<td class="bdr bdt tit">
						<%If p_c_name<>"" Then Response.Write "<span class='txt_small'>[" & p_c_name & "]</span><br />"%>
						<%If p_code<>"" Then Response.Write "<span class='txt_small'>" & p_code & "</span>"%>
						<%=p_name%> </td>
						<%If mc_use=True Then%>
						<td class="bdr bdt"><%=FormatNumber(p_price, 0)%></td>
						<%End If%>
						<td class="bdr bdt"><%=p_hit%></td>
						<td class="bdr bdt"><%
						Select Case p_hide
							Case True
								Response.Write "<span class='red'>숨김</span>"
							Case False
								Response.Write "표시"
						End Select%></td>
						<td class="bdr bdt">
						<form name="modform<%=idx%>" method="post" action="prod-reg-ok.asp?<%=pLink%>&mode=levmod&idx=<%=idx%>&page=<%=page%>">
						<input type="text" name="p_lev" class="AXInput W50" value="<%=p_lev%>" numberOnly />
						<input type="submit" value="수정" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
						</form></td>
						<td class="bdr bdt"><%=Left(regdate, 10)%></td>
						<td class="bdt">
						<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='prod-reg.asp?mode=mod&idx=<%=idx%>&<%=pLink%>&page=<%=page%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 제품을 삭제 하시겠습니까?')){ location.href='prod-reg-ok.asp?mode=del&idx=<%=idx%>&<%=pLink%>&page=<%=page%>' }">
						<input type="button" value=" 복사 " class="AXButtonSmall Red" onclick="if(confirm('해당 제품을 복사하시겠습니까?')){location.href='prod-reg-ok.asp?<%=pLink%>&mode=copy&idx=<%=idx%>&page=<%=page%>'}">
						<%If pc_naverblog=True And nb_id<>"" And nb_apikey<>"" And (W_LEVEL="1" Or W_LEVEL="2") Then%>
						<input type="button" value="블로그등록" class="AXButtonSmall Classic" onclick="if(confirm('해당 게시물을 네이버 블로그에 포스팅 하시겠습니까? ')){location.href='/site/api/naverblog/blog-prod-reg.asp?idx=<%=idx%>'}">
						<%End If%>
						
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
					<td colspan="8" class="bdr bdt">제품이 존재하지 않습니다.</td>
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
		<p class="left">
			<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='prod-excel.asp?<%=pLink%>'"></span>
			<!--span><input type="button" value="  엑셀일괄등록  " class="AXButton Green" onclick="location.href='prod-excel-reg.asp'"></span-->
		</p>
		<p class="right">
			<span><input type="button" value="   제품등록   " class="AXButton Blue" onclick="location.href='prod-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>제품 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%q="prod"%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 제품 표시 영역에 아래의 코드 삽입<br />
			&lt;!--#include virtual="/site/prod/prod.asp" --&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->


<script type="text/javascript">
CateSet(1, '', '<%=s_cate1%>');
CateSet(2, '<%=s_cate1%>', '<%=s_cate2%>');
CateSet(3, '<%=s_cate2%>', '<%=s_cate3%>');
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->