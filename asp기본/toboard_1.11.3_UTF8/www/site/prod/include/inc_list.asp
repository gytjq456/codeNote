<link rel="stylesheet" type="text/css" href="/site/css/prod.css" />

<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_cate WHERE c_code LIKE '" & s_cate & "%' AND c_depth IN ('2', '3') AND c_hide='0' ORDER BY c_lev ASC"
Rs.Open Sql, Dbcon, 1

s_cate1 = Left(s_cate, 2)
s_cate2 = Left(s_cate, 4)
s_cate3 = Left(s_cate, 6)

If Rs.EOF=False Then
%>
	<!-- tb_search_gall -->
	<div class="tb_search_gall">
		<table>
			<colgroup>
				<col width="" />
			</colgroup>
			<%
			'중분류 표시
			If Len(s_cate)>=2 Then%>
				<tr>
					<th class="bdb bdr">
					<%
					Set Rs2 = Server.Createobject("ADODB.Recordset")
					Sql = "SELECT * FROM tbl_cate WHERE c_code LIKE '" & s_cate1 & "%' AND c_depth='2' AND c_hide='0' ORDER BY c_lev ASC"
					Rs2.Open Sql, Dbcon, 1
					Do Until Rs2.EOF
						c2_code = Rs2("c_code")
						c2_name = Rs2("c_name")
						%>
						<span class="title"><a href="?q=prod&mode=list&s_cate=<%=c2_code%>" <%If c2_code=s_cate2 Then Response.Write "class='on'"%>><%=c2_name%></a></span>		
						<%
						Rs2.Movenext
					Loop
					Set Rs2 = Nothing 
					%>	
					</th>
				</tr>
				<%
			End If

			'소분류 표시
			If Len(s_cate)>=4 Then
				Set Rs2 = Server.Createobject("ADODB.Recordset")
				Sql = "SELECT * FROM tbl_cate WHERE c_code LIKE '" & s_cate2 & "%' AND c_depth='3' AND c_hide='0' ORDER BY c_lev ASC"
				Rs2.Open Sql, Dbcon, 1
				If Rs2.EOF=False Then%>
				<tr>
					<td class="bdr">
					<%
					Do Until Rs2.EOF
						c3_code = Rs2("c_code")
						c3_name = Rs2("c_name")
						%>
						<span class="title"><a href="?q=prod&mode=list&s_cate=<%=c3_code%>" <%If c3_code=s_cate3 Then Response.Write "class='on'"%>><%=c3_name%></a></span>
						<%
						Rs2.Movenext
					Loop
					%>	
					</td>
				</tr>
				<%
				End If
				Rs2.Close
				Set Rs2 = Nothing 
			End If
			%>
		</table>
	</div>
	<!-- tb_search_gall -->
<%
End If
Rs.Close
%>


<%
'제품 목록 취득
Sql = "SELECT A.*, B.c_name FROM tbl_prod A "
Sql = Sql & " INNER JOIN tbl_cate B ON A.p_cate=B.c_code "
Sql = Sql & " WHERE A.p_hide='0' "
If s_cate<>"" Then Sql = Sql & " AND (A.p_cate LIKE '" & s_cate & "%' OR A.p_cate2 LIKE '" & s_cate & "%' OR A.p_cate3 LIKE '" & s_cate & "%') "

If s_display<>"" Then Sql = Sql & " AND A.p_display LIKE '%" & s_display & "%' "

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

Select Case s_align
	Case "0"
		Sql = Sql & " ORDER BY A.p_lev DESC"
	Case "1"
		Sql = Sql & " ORDER BY A.p_price ASC"
	Case "2"
		Sql = Sql & " ORDER BY A.p_price DESC"
	Case Else
		Sql = Sql & " ORDER BY A.p_lev DESC"
End Select
'Response.Write Sql
Rs.Open Sql, Dbcon, 1

'페이지 설정
If Rs.EOF=False Then
	Rs.PageSize = pc_pagelist
	Rs.AbsolutePage = page
	Rs_RecordCount = Rs.RecordCount
	If Rs_RecordCount Mod Rs.PageSize>0 Then
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
	Else
		maxpage = CInt(Rs_RecordCount/Rs.PageSize)
	End If
Else
	Rs_RecordCount=0
End If
%>

<div class="pd_wrap quick_start">
	<div class="top_box clear">
		<p>선택하신 항목으로 총 <span><%=Rs_RecordCount%>개</span>의 제품이 검색되었습니다.</p>
		<ul class="btn_box">
			<li><a href="?s_keyword=<%=s_keyword%>&s_cate=<%=s_cate%>&s_display=<%=s_display%>&s_align=0" <%If s_align="0" Then Response.Write "class=""on"""%>>신상품순</a></li>
			<li><a href="?s_keyword=<%=s_keyword%>&s_cate=<%=s_cate%>&s_display=<%=s_display%>&s_align=1" <%If s_align="1" Then Response.Write "class=""on"""%>>낮은가격순</a></li>
			<li><a href="?s_keyword=<%=s_keyword%>&s_cate=<%=s_cate%>&s_display=<%=s_display%>&s_align=2" <%If s_align="2" Then Response.Write "class=""on"""%>>높은가격순</a></li>
			<!--li><a href="javascript:;">인기상품순</a></li-->
		</ul>
	</div>
	<ul class="list">
	<%
	If Rs.EOF=False Then
		cnt=0
		num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
		Do Until Rs.EOF Or cnt>=Rs.pagesize
			idx = Rs("idx")
			p_name = Rs("p_name")
			p_memo = Rs("p_memo")
			p_c_name = Rs("c_name")
			p_code = Rs("p_code")
			p_price = Rs("p_price")
			p_o_price = Rs("p_o_price")
			p_image1 = Rs("p_image1")

			Response.Write ProdListType2(idx, p_image1, p_c_name, p_name, p_memo, p_price, p_o_price)

			num=num-1
			cnt=cnt+1
			Rs.MoveNext
		Loop
	Else
	%>
			<li>제품이 없습니다.</li>
	<%
	End If
	Rs.Close
	Set Rs = Nothing%>
	</ul>

	<!--페이징-->
	<div class="page">
		<ul>
			<%Call Pagelist("?mode=list&" & pLink, CInt(page), pc_pagelist, 5, Rs_RecordCount)%>
		</ul>
	</div>
</div>
<%
Set Rs = Nothing
%>
