<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="coupon"%>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script>
$(function(){
	$("#c_enddate").datepicker({dateFormat: 'yy-mm-dd'});
	$("input[type=checkbox]").checkboxradio();
});
</script>
</head>

<%
idx = Request("idx")
mode = Request("mode")
If mode="" Then mode="reg"

If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_coupon WHERE idx='" & idx & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
		c_name=Rs("c_name")
		c_enddate=Rs("c_enddate")
		c_dc_type=Rs("c_dc_type")
		c_dc_amount=Rs("c_dc_amount")
		c_dl_type=Rs("c_dl_type")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>쿠폰 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>쿠폰 관리</li>
	</ul>
</div>
<!-- //location -->

<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="coupon-reg-ok.asp?mode=<%=mode%>&idx=<%=idx%>&<%=pLink%>">
		<div class="tb_info">
			<h4>쿠폰 기본 정보</h4>
			<table>
				<caption>쿠폰 기본 정보</caption>
				<colgroup>
					<col width="13%" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt"><span class="icon">쿠폰명</span></th>
					<td class="bdt"><input type="text" name="c_name" class="AXInput" value="<%=c_name%>" style="width:70%" required /></td>
				</tr>
				<tr>
					<th class="title bdr bdt">사용 만료일</th>
					<td class="bdt"><input type="text" name="c_enddate" id="c_enddate" class="AXInput W100" value="<%=c_enddate%>" required /></td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">금액설정</span></th>
					<td class="bdt"><input type="text" name="c_dc_amount" class="AXInput W70" value="<%=c_dc_amount%>" required numberOnly />
					<select name="c_dc_type" id="c_dc_type" class="AXSelect">
						<option value="원" <%If c_dc_type="원" Then Response.Write "selected"%>>정액(원)</option>					
						<option value="%" <%If c_dc_type="%" Then Response.Write "selected"%>>정률(%)</option>					
					</select>
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt"><span class="icon">발급방식</span></th>
					<td class="bdt"><select name="c_dl_type" id="c_dl_type" class="AXSelect">
						<option value="join" <%If c_dl_type="join" Then Response.Write "selected"%>>회원가입시 자동 발급</option>					
						<option value="dir" <%If c_dl_type="dir" Then Response.Write "selected"%>>직접 다운로드 발급</option>					
					</select>
					</td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="left">
				<span><input type="button" value="   목록   " class="AXButton Blue" onclick="location.href='coupon.asp'"></span>
			</p>
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
				<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<!-- #include virtual="/site/manage/inc/footer.asp" -->