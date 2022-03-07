<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<%
s_bc_name = Request("s_bc_name")

pLink = "s_bc_name=" & s_bc_name

mode = Request("mode")
If mode="" Then mode="reg"
idx = Request("idx")

If mode="mod" Then 
	Set Rs = Server.CreateObject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_banner WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then 
		b_sort = Rs("b_sort")
		b_title = Rs("b_title")
		b_file = Rs("b_file")
		b_url = Rs("b_url")
		b_url_target = Rs("b_url_target")
		b_addtext1 = Rs("b_addtext1")
		b_addtext2 = Rs("b_addtext2")
		b_addtext3 = Rs("b_addtext3")
		b_addtext4 = Rs("b_addtext4")
		b_addtext5 = Rs("b_addtext5")
	End If
	Rs.Close
	Set Rs = Nothing
Else
	b_sort = s_bc_name
End If 
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>배너 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>배너 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="banner-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>" enctype="multipart/form-data">

		<div class="tb_info">
			<h4>배너 설정</h4>
			<table>
				<caption>배너 설정</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">분류</span></th>
					<td colspan="3" class="bdt">
					<!-- 분류를 지정하여 주시기 바랍니다 -->
					<select name="b_sort" id="b_sort" class="AXSelect">
						<%
						Set RsL = Server.Createobject("ADODB.Recordset")
						Sql = "SELECT * FROM tbl_banner_config ORDER BY bc_name "
						RsL.Open Sql, Dbcon, 1
						l_num=0
						Do Until RsL.EOF
							bc_name = RsL("bc_name")
							bc_size = RsL("bc_size")
							Response.Write "<option value='" & bc_name & "' "
							If b_sort=bc_name Then Response.Write "selected"
							Response.Write ">" & bc_name & " (" & bc_size & ")</option>"
							RsL.MoveNext
						Loop
						RsL.Close
						Set RsL = Nothing
						%>
					</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">제목</span></th>
					<td colspan="3" class="bdt"><input type="text" name="b_title" class="AXInput" size="70" value="<%=b_title%>" required /></td>
				</tr>
				<tr>
					<th class="title bdr bdt">배너 이미지</th>
					<td colspan="3" class="bdt">
						<%
						If b_file<>"" Then
							Response.Write b_file & "파일이 등록되어 있습니다. <br />"
						End If
						%>
						<input type="file" name="b_file" class="inb_file" size="25" /><br />						
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">링크URL</th>
					<td colspan="3" class="bdt"><input type="text" name="b_url" class="AXInput" size="70" value="<%=b_url%>" placeholder="http://" /><br />
						<span class="txt_small">- 배너를 클릭시 입력한 링크URL로 이동합니다.</span><br />
						<label><input type="radio" name="b_url_target" value="_self" <%If b_url_target="" Or b_url_target="_self" Then Response.Write "checked"%>/> 현재 창 (_self)</label>&nbsp;&nbsp;
						<label><input type="radio" name="b_url_target" value="_blank" <%If b_url_target="_blank" Then Response.Write "checked"%>/> 새 창 (_blank)</label>&nbsp;&nbsp;
						<label><input type="radio" name="b_url_target" value="unusable" <%If b_url_target="unusable" Then Response.Write "checked"%> onclick="SetLinkUnusable()"/> 링크 사용 안 함</label>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">추가 입력필드1</th>
					<td colspan="3" class="bdt"><input type="text" name="b_addtext1" class="AXInput" size="70" value="<%=b_addtext1%>" />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">추가 입력필드2</th>
					<td colspan="3" class="bdt"><input type="text" name="b_addtext2" class="AXInput" size="70" value="<%=b_addtext2%>" />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">추가 입력필드3</th>
					<td colspan="3" class="bdt"><input type="text" name="b_addtext3" class="AXInput" size="70" value="<%=b_addtext3%>" />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">추가 입력필드4</th>
					<td colspan="3" class="bdt"><input type="text" name="b_addtext4" class="AXInput" size="70" value="<%=b_addtext4%>" />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">추가 입력필드5</th>
					<td colspan="3" class="bdt"><input type="text" name="b_addtext5" class="AXInput" size="70" value="<%=b_addtext5%>" />
					</td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='banner.asp'"></span>
			</p>
			<p class="right">
				<span><input type="submit" value="   적용   " class="AXButton Blue"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>
</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<script type="text/javascript">
function SetLinkUnusable(){
	document.regform.b_url.value="#;"
}
</script>
<!-- #include virtual="/site/manage/inc/footer.asp" -->