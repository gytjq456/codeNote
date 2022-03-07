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
	<p>컨텐츠 페이지 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>컨텐츠 페이지 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<!-- tb_list -->
	<div class="tb_list">
		<table>
			<colgroup>
				<col width="50px" />
				<col width="75px" />
				<col width="55px" />
				<col width="" />
				<col width="110px" />
				<col width="90px" />
				<col width="110px" />
			</colgroup>
			<tr>
				<th class="bdr">번호</th>
				<th class="bdr">cate<br />code</th>
				<th class="bdr">page<br />code</th>
				<th class="bdr">메뉴명</th>
				<th class="bdr">진열레벨</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>

			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.*, B.c_name FROM tbl_page A "
			Sql = Sql & " INNER JOIN tbl_page_cate B ON A.p_cate=B.c_code "
			Sql = Sql & " ORDER BY A.p_lev ASC "
			Rs.Open Sql, Dbcon, 1
			If Rs.EOF=False Then
				num=1
				Do Until Rs.EOF
					l_idx = Rs("idx")
					c_code = Rs("p_cate")
					c_name = Rs("c_name")
					l_page1 = Rs("p_page1")
					l_page2 = Rs("p_page2")
					l_page3 = Rs("p_page3")
					l_content = Rs("p_content")
					l_lev = Rs("p_lev")
					l_regdate = Left(Rs("regdate"), 10)
					%>
					<tr>
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt"><%=c_code%></td>
						<td class="bdr bdt"><%=l_idx%></td>
						<td class="bdr bdt tit">						
						<%If c_name<>"" Then Response.Write c_name & " > "%>
						<%=l_page1%></td>
						<td class="bdr bdt">
						<form name="modform<%=idx%>" method="post" action="page-ok.asp?mode=levmod&idx=<%=l_idx%>">
						<input type="text" name="p_lev" class="AXInput W30" value="<%=l_lev%>" numberOnly />
						<input type="submit" value="수정" class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb">
						</form></td>
						<td class="bdr bdt"><%=l_regdate%></td>
						<td class="bdt">
						<input type="button" value=" 수정 " class="AXButtonSmall" style="background:#cb7b9b; color:#fff; border:1px solid #cb7b9b" onclick="location.href='page.asp?mode=mod&idx=<%=l_idx%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 페이지를 삭제 하시겠습니까?')){location.href='page-ok.asp?mode=del&idx=<%=l_idx%>'}"></td>
					</tr>
					<%
					num=num+1
					Rs.Movenext
				Loop
			Else
				%>
			<tr>
				<td colspan="7" class="bdr bdt">페이지가 존재하지 않습니다.</td>
			</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>

			<form name="regform" method="post" action="page-ok.asp?mode=reg" onsubmit="return RegChk(this)">
			<tr>
				<td class="bdr bdt" colspan="3">페이지 생성</td>
				<td class="bdr bdt tit"><%=PageCateSelect("p_cate", p_cate)%> > 
				<input type="text" name="p_page1" value="<%=p_page1%>" class="AXInput W200" placeholder="메뉴명" /></td>
				<td class="bdr bdt"><input type="text" name="p_lev" class="AXInput W30" value="<%=l_lev+10%>" numberOnly /></td>
				<td class="bdr bdt"><%=Date()%></td>
				<td class="bdt"><input type="submit" value=" 생성 " class="AXButtonSmall" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba"></td>
			</tr>
			</form>
		</table>
	</div>
	<!-- tb_list -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>컨텐츠 페이지 코드 삽입 방법</b><br />
			1) head 태그 내부에 아래 코드 추가<br />
			&lt;%q="page"%&gt;<br />
			&lt;%idx=Request("idx")%&gt;<br />
			<span style="color:#bbb">&lt;!--#include virtual="/site/setting.asp" --&gt;</span><br /><br />

			2) 컨텐츠 표시 영역에 아래의 코드 삽입<br />
			&lt;%=pg_content%&gt;
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>

<script type="text/javascript">
function RegChk(obj){
	if(obj.p_page1.value==""){ alert('대메뉴명은 필수입니다.'); obj.p_page1.focus(); return false; }
	if(obj.p_lev.value==""){ alert('진열레벨은 필수입니다.'); obj.p_lev.focus(); return false; }
}
</script>

<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->