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
	<p>기본 정보 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>기본 정보 설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_site_config "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('사이트 정보가 없습니다.'); history.back();</script>"
	Response.End
Else
	sc_name=Rs("sc_name")
	sc_email=Rs("sc_email")
	sc_tel=Rs("sc_tel")
	sc_regno1=Rs("sc_regno1")
	sc_regno2=Rs("sc_regno2")
	sc_regno3=Rs("sc_regno3")
	sc_address=Rs("sc_address")
	sc_addtext1=Rs("sc_addtext1")
	sc_addtext2=Rs("sc_addtext2")
	sc_addtext3=Rs("sc_addtext3")
	sc_addtext4=Rs("sc_addtext4")
	sc_addtext5=Rs("sc_addtext5")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="base-info-ok.asp?mode=mod" method="post">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>기본 정보 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">사이트명</th>
				<td class="bdt"><input type="text" name="sc_name" value="<%=sc_name%>" class="AXInput" style="width:220px" required></td>
			</tr>
			<tr style="display:none">
				<th class="title bdr bdt">대표메일</th>
				<td class="bdt"><input type="text" name="sc_email" value="<%=sc_email%>" class="AXInput" style="width:220px"></td>
			</tr>
			<tr style="display:none">
				<th class="title bdr bdt">대표전화</th>
				<td class="bdt"><input type="text" name="sc_tel" value="<%=sc_tel%>" class="AXInput" style="width:100px"></td>
			</tr>
			<tr style="display:none">
				<th class="title bdr bdt">사업자등록번호</th>
				<td class="bdt"><input type="text" name="sc_regno1" value="<%=sc_regno1%>" class="AXInput" style="width:100px"></td>
			</tr>
			<tr style="display:none">
				<th class="title bdr bdt">주소</th>
				<td class="bdt"><input type="text" name="sc_address" value="<%=sc_address%>" class="AXInput" style="width:90%"></td>
			</tr>
			<tr style="display:none">
				<th class="title bdr bdt">추가1</th>
				<td class="bdt"><input type="text" name="sc_addtext1" value="<%=sc_addtext1%>" class="AXInput" style="width:90%"></td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
			<span><input type="button" value="   취소   " class="AXButton"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>

</div>
<!-- //contents -->

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->