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
	<p>SSL 연동 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>SSL 연동 설정</li>
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
	ssl_chk=Rs("ssl_chk")
	ssl_port=Rs("ssl_port")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="ssl-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>SSL 연동 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">SSL 사용체크</th>
				<td class="bdt"><input type="checkbox" name="ssl_chk" value="1" <%If ssl_chk=True Then Response.write "checked"%> /> SSL을 사용하는 경우 체크하세요</td>
			</tr>
			<tr>
				<th class="title bdr bdt">SSL 포트번호</th>
				<td class="bdt"><input type="text" name="ssl_port" value="<%=ssl_port%>" class="AXInput W60" maxlength="6"><br />
				<span class="txt_small">https에 포트번호를 사용하는 경우 입력하세요.</span></td>
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

	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			SSL은 회원가입 및 정보수정, 로그인 등에 사용됩니다.<br />
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
//	if(obj.fb_appid.value==""){ alert("페이스북 앱 ID를 입력하세요"); obj.fb_appid.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->