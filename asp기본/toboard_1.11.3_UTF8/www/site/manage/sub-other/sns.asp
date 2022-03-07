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
	<p>SNS 연동 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>SNS 연동 설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_sns_config "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('설정 정보가 없습니다.'); history.back();</script>"
	Response.End
Else
	f_id=Rs("f_id")
	f_pw=Rs("f_pw")
	f_call=Rs("f_call")
	f_url=Rs("f_url")
	t_id=Rs("t_id")
	t_pw=Rs("t_pw")
	t_call=Rs("t_call")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="sns-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">faceBookKey</th>
				<td class="bdt"><input type="text" name="f_id" value="<%=f_id%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">faceBookSecret</th>
				<td class="bdt"><input type="text" name="f_pw" value="<%=f_pw%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">faceBookCallBack</th>
				<td class="bdt"><input type="text" name="f_call" value="<%=f_call%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">faceBookDomain</th>
				<td class="bdt"><input type="text" name="f_url" value="<%=f_url%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">twitterKey</th>
				<td class="bdt"><input type="text" name="t_id" value="<%=t_id%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">twitterSecret</th>
				<td class="bdt"><input type="text" name="t_pw" value="<%=t_pw%>" class="AXInput" style="width:350px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">twitterCallback</th>
				<td class="bdt"><input type="text" name="t_call" value="<%=t_call%>" class="AXInput" style="width:350px"></td>
				</td>
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

<script type="text/javascript">
function RegChk(obj){
	if(obj.sms_id.value==""){ alert("ID를 입력하세요"); obj.sms_id.focus(); return false; }
	if(obj.sms_pw.value==""){ alert("패스워드를 입력하세요"); obj.sms_pw.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->