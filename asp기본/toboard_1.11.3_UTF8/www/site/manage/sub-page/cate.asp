<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
mode = Request("mode")
depth = Request("depth")
p_code = Request("p_code")
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>페이지 카테고리 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>페이지 카테고리 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

	<!-- cate-wrap -->
	<div class="cate-wrap">

		<!-- tb_list -->
		<div class="tb_list cate-list">
			<div class="cate-scroll">
			<table>
				<colgroup>
					<col width="70px" />
					<col width="70px" />
					<col width="" />
					<col width="70px" />
					<col width="80px" />
				</colgroup>
				<tr>
					<th class="bdr bdb">언어</th>
					<th class="bdr bdb">코드</th>
					<th class="bdr bdb">카테고리명</th>
					<th class="bdr bdb">진열순서</th>
					<th class="bdb"><input type="button" value="대분류추가" class="AXButtonSmall Blue" onclick="location.href='?mode=reg&depth=1&p_code='" /></th>
				</tr>
	<%
	'대분류
	Set Rs1 = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_page_cate WHERE c_depth='1' ORDER BY c_lev ASC"
	Rs1.Open Sql, Dbcon, 1
	num1=1

	If Rs1.EOf=False Then
	c1_rmax = Rs1.RecordCount
	Do Until Rs1.EOF
		c1_lang = Rs1("c_lang")
		c1_code = Rs1("c_code")
		c1_name = Rs1("c_name")
		c1_hide = Rs1("c_hide")
		c1_lev = Rs1("c_lev")
		%>
				<tr style="background-color:#f2f7fa">
					<td class="bdr bdt"><%=c1_lang%></td>
					<td class="bdr bdt tit"><%=c1_code%></td>
					<td class="bdr bdt tit"><span class="ui-icon ui-icon-folder-open" style="float:left"></span>
					<a href="?mode=mod&c_code=<%=c1_code%>">
					<span <%If c1_hide=True Then Response.Write "style='text-decoration:line-through'"%>><%=c1_name%></span></a></td>
					<td class="bdr bdt">
					<%If num1>1 Then%>
					<a href="cate-ok.asp?mode=up&c_code=<%=c1_code%>&c_lev=<%=c1_lev%>"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최상위 입니다.');"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%End If%>
					<%If num1<c1_rmax Then%>
					<a href="cate-ok.asp?mode=down&c_code=<%=c1_code%>&c_lev=<%=c1_lev%>"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최하위 입니다.');"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%End If%></td>
					<td class="bdt">
					<input type="button" value="중분류추가" class="AXButtonSmall Red" onclick="location.href='?mode=reg&depth=2&p_code=<%=c1_code%>'"></td>
				</tr>
		<%
		'중분류
		Set Rs2 = Server.Createobject("ADODB.Recordset")
		Sql = "SELECT * FROM tbl_page_cate WHERE c_depth='2' AND c_code LIKE '" & c1_code & "%' ORDER BY c_lev ASC"
		Rs2.Open Sql, Dbcon, 1
		If Rs2.EOf=False Then c2_rmax = Rs2.RecordCount
		num2=1
		Do Until Rs2.EOF
			c2_code = Rs2("c_code")
			c2_name = Rs2("c_name")
			c2_hide = Rs2("c_hide")
			c2_lev = Rs2("c_lev")
			%>
				<tr class="ct<%=c1_code%>" style="background-color:#faf7f2">
					<td class="bdr bdt"></td>
					<td class="bdr bdt tit"><%=c2_code%></td>
					<td class="bdr bdt tit" style="padding-left:30px"><span class="ui-icon ui-icon-folder-open" style="float:left"></span>
					<a href="?mode=mod&c_code=<%=c2_code%>">
					<span <%If c2_hide=True Then Response.Write "style='text-decoration:line-through'"%>><%=c2_name%></span></a></td>
					<td class="bdr bdt">
					<%If num2>1 Then%>
					<a href="cate-ok.asp?mode=up&c_code=<%=c2_code%>&c_lev=<%=c2_lev%>"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최상위 입니다.');"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%End If%>
					<%If num2<c2_rmax Then%>
					<a href="cate-ok.asp?mode=down&c_code=<%=c2_code%>&c_lev=<%=c2_lev%>"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최하위 입니다.');"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%End If%>
					</td>
					<td class="bdt">
					<input type="button" value="소분류추가" class="AXButtonSmall Green" onclick="location.href='?mode=reg&depth=3&p_code=<%=c2_code%>'"></td>
				</tr>
			<%
			'소분류
			Set Rs3 = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_page_cate WHERE c_depth='3' AND c_code LIKE '" & c2_code & "%' ORDER BY c_lev ASC"
			Rs3.Open Sql, Dbcon, 1
			If Rs3.EOf=False Then c3_rmax = Rs3.RecordCount
			num3=1
			Do Until Rs3.EOF
				c3_code = Rs3("c_code")
				c3_name = Rs3("c_name")
				c3_hide = Rs3("c_hide")
				c3_lev = Rs3("c_lev")
				%>
				<tr class="ct<%=c2_code%>">
					<td class="bdr bdt"></td>
					<td class="bdr bdt tit"><%=c3_code%></td>
					<td class="bdr bdt tit" style="padding-left:60px"><span class="ui-icon ui-icon-document" style="float:left"></span>
					<a href="?mode=mod&c_code=<%=c3_code%>">
					<span <%If c3_hide=True Then Response.Write "style='text-decoration:line-through'"%>><%=c3_name%></span></a></td>
					<td class="bdr bdt">
					<%If num3>1 Then%>
					<a href="cate-ok.asp?mode=up&c_code=<%=c3_code%>&c_lev=<%=c3_lev%>"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최상위 입니다.');"><img src="/site/manage/images/btn/btn_up.gif" /></a>
					<%End If%>
					<%If num3<c3_rmax Then%>
					<a href="cate-ok.asp?mode=down&c_code=<%=c3_code%>&c_lev=<%=c3_lev%>"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%Else%>
					<a href="javascript:alert('최하위 입니다.');"><img src="/site/manage/images/btn/btn_down.gif" /></a>
					<%End If%></td>
					<td class="bdt"></td>
				</tr>
				<%
				num3=num3+1
				Rs3.Movenext
			Loop
			Set Rs3 = Nothing
			num2=num2+1
			Rs2.Movenext
		Loop
		Set Rs2 = Nothing
		num1=num1+1
		Rs1.Movenext
	Loop
	Else
	%>
				<tr>
					<td class="bdt" colspan="5">등록된 카테고리가 없습니다. 대분류를 먼저 등록하세요.</td>
				</tr>
	<%
	End If
	%>
			</table>
			</div>
		</div>
		<!-- tb_list -->

		<!-- tb_list -->
		<div class="tb_list" style="width:49%; float:right; height:500px">
			<%
			If mode="reg" Or mode="mod" Then
				'등록
				If mode="reg" Then

					Set RsP = Server.Createobject("ADODB.Recordset")

					Sql = "SELECT TOP 1 c_lev FROM tbl_page_cate WHERE c_code!='' "
					Sql = Sql & " AND c_code LIKE '" & p_code & "%' "
					Sql = Sql & " AND c_depth='" & depth & "' "
					Sql = Sql & " ORDER BY c_lev DESC"
					RsP.Open Sql, Dbcon, 1
					If RsP.EOF=False Then
						c_lev = CInt(RsP("c_lev"))+10
					Else
						c_lev =10
					End If
					RsP.Close

					Sql = "SELECT TOP 1 c_code FROM tbl_page_cate WHERE c_code!='' "
					Sql = Sql & " AND c_code LIKE '" & p_code & "%' "
					Sql = Sql & " AND c_depth='" & depth & "' "
					Sql = Sql & " ORDER BY c_code DESC"
					RsP.Open Sql, Dbcon, 1
					'Response.write sql & "<br />"

					If RsP.EOF=False Then
						'카테고리 생성 제한
						If CInt(Right(RsP("c_code"), 2))="99" Then
							Response.Write "<script>alert('더이상 추가 할 수 없습니다.'); hidtory.back();</script>"
							Response.End
						End If

						c_code = p_code & CInt(Right(RsP("c_code"), 2))+1
					Else
						c_code = p_code & "10"
					End If
					RsP.Close

					'언어정보 취득
					Sql = "SELECT * FROM tbl_page_cate WHERE c_code='" & p_code & "' "
					RsP.Open Sql, Dbcon, 1
					If RsP.EOf=False Then
						c_lang = RsP("c_lang")
					End If
					RsP.Close
					Set RsP = Nothing

				'수정
				Else
					c_code = Request("c_code")

					Set RsP = Server.Createobject("ADODB.Recordset")
					Sql = "SELECT * FROM tbl_page_cate WHERE c_code='" & c_code & "' "
					RsP.Open Sql, Dbcon, 1
					If RsP.EOf=False Then
						c_lang = RsP("c_lang")
						c_code = RsP("c_code")
						c_depth = RsP("c_depth")
						c_name = RsP("c_name")
						c_image = RsP("c_image")
						c_hide = RsP("c_hide")
						c_lev = RsP("c_lev")
					Else
						Response.Write "<script>alert('잘못된 접근입니다.'); hidtory.back();</script>"
						Response.End
					End If
					RsP.Close
					Set RsP = Nothing

				End If
				%>

				<form name="regform" method="post" action="cate-ok.asp?mode=<%=mode%>" onsubmit="return RegChk(this)" enctype="multipart/form-data">
					<input type="hidden" name="c_code" value="<%=c_code%>" />
					<input type="hidden" name="c_depth" value="<%=depth%>" />

					<table>
						<caption>카테고리 정보</caption>
						<colgroup>
							<col width="25%">
							<col width="">
						</colgroup>
						<tbody>
							<tr>
								<th class="title bdr bdt"><span class="icon">코드</span></th>
								<td class="bdt tit"><%=c_code%></td>
							</tr>
							<tr>
								<th class="title bdr bdt"><span class="icon">언어설정</span></th>
								<td class="bdt tit">
								<%
								If Len(c_code)=2 And mode="reg" Then
								%>
									<select name="c_lang" id="c_lang" class="AXSelect">
									<%
									arr_sc_lang = Split(sc_lang, "|")
									For Each item In arr_sc_lang
										Response.Write "<option value=""" & item & """ "
										If item=c_lang Then Response.Write "selected"
										Response.Write ">" & item & "</option>"
									Next
									%>
									</select>
								<%
								Else
								%>
									<%=c_lang%>
									<input type="hidden" name="c_lang" value="<%=c_lang%>">
								<%
								End If
								%></td>
							</tr>
							<tr>
								<th class="title bdr bdt"><span class="icon">카테고리명</span></th>
								<td class="bdt tit"><input type="text" name="c_name" id="c_name" value="<%=c_name%>" placeholder="카테고리명을 입력하세요" class="AXInput" style="width:90%"/></td>
							</tr>
							<tr>
								<th class="title bdr bdt"><span class="icon">카테고리이미지</span></th>
								<td class="bdt tit">
								<%If mode="mod" Then
									if c_image="" Then%>
										현재 등록된 파일이 없습니다.<br />
									<%Else%>
										<img src="/upload/cate/<%=c_image%>" alt="<%=c_image%>" style="max-width:300px" /><br />
										현재 <%=c_image%> 파일이 등록되어 있습니다.<br />
									<%End If
								End If%>
								<input type="file" name="c_image" class="W300" />
								</td>
							</tr>
							<tr>
								<th class="title bdr bdt"><span class="icon">숨김</span></th>
								<td class="bdt tit"><label><input type="checkbox" name="c_hide" value="1" <%If c_hide Then Response.Write "checked"%>/> 해당 카테고리를 노출 시키지 않습니다.</label></td>
							</tr>
							<tr>
								<th class="title bdr bdt"><span class="icon">진열레벨</span></th>
								<td class="bdt tit"><input type="text" name="c_lev" id="c_lev" value="<%=c_lev%>" class="AXInput W50" readonly /></td>
							</tr>
						</tbody>
					</table>

					<!-- btn_left_right -->
					<div class="btn_left_right">
						<p class="right">
							<span><input type="submit" value=" 확인 " class="AXButton Blue"></span>
							<%If mode="mod" Then%>
							<span><input type="button" value=" 삭제 " class="AXButton Classic" onclick="if(confirm('삭제 하시겠습니까?')){location.href='cate-ok.asp?mode=del&c_code=<%=c_code%>'}"></span>
							<%End If%>
						</p>
					</div>
					<!-- //btn_left_right -->

				</form>

			<%End If%>
		</div>

	</div>
	<!-- //cate-wrap-->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.c_name.value==""){ alert('카테고리명을 입력하세요'); obj.c_name.focus(); return false; }
	return true;
}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->