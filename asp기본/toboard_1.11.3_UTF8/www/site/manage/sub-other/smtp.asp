<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script>
$(function(){
	$("input[type=checkbox]").checkboxradio();
});
</script>
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>메일 발송 서버(SMTP) 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>메일 발송 서버 설정</li>
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
	sc_email=Rs("sc_email")
	smtpserver=Rs("smtpserver")
	smtpserverport=Rs("smtpserverport")
	smtpusessl=Rs("smtpusessl")
	smtpauthenticate=Rs("smtpauthenticate")
	sendusername=Rs("sendusername")
	sendpassword=Rs("sendpassword")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="smtp-ok.asp?mode=mod" method="post">

		<!-- tb_info -->
		<div class="tb_info">
			<h4>SMTP 접속정보 설정</h4>
			<table>
				<colgroup>
					<col width="120px" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">보내는 메일 서버<br />(SMTP)</th>
					<td class="bdt"><input type="text" name="smtpserver" value="<%=smtpserver%>" class="AXInput W300" required></td>
				</tr>
				<tr>
					<th class="title bdr bdt">포트번호</th>
					<td class="bdt"><input type="text" name="smtpserverport" value="<%=smtpserverport%>" class="AXInput W60" maxlength="4" numberOnly required></td>
				</tr>
				<tr>
					<th class="title bdr bdt">SSL 연결</th>
					<td class="bdt"><label><input type="checkbox" name="smtpusessl" value="1" <%If smtpusessl="1" Then Response.Write "checked"%>> 암호화 된 연결(SSL) 필요</label></td>
				</tr>
				<tr>
					<th class="title bdr bdt">SMTP 인증</th>
					<td class="bdt"><label><input type="checkbox" name="smtpauthenticate" value="1" <%If smtpauthenticate="1" Then Response.Write "checked"%>> 보내는 메일 서버(SMTP) 인증 필요</label></td>
				</tr>
				<tr>
					<th class="title bdr bdt">사용자 이름(ID)</th>
					<td class="bdt"><input type="text" name="sendusername" value="<%=sendusername%>" class="AXInput W300"></td>
				</tr>
				<tr>
					<th class="title bdr bdt">사용자 패스워드</th>
					<td class="bdt"><input type="text" name="sendpassword" value="<%=sendpassword%>" class="AXInput W300"></td>
				</tr>
				<tr>
					<th class="title bdr bdt">보내는 메일주소</th>
					<td class="bdt"><input type="text" name="sc_email" value="<%=sc_email%>" class="AXInput W300"> <span class="txt_small">대표메일로 설정됩니다.</span></td>
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

	<form name="sendform" action="smtp-ok.asp?mode=send" method="post">
		<input type="hidden" name="from_email" value="<%=sc_email%>">

		<!-- tb_info -->
		<div class="tb_info">
			<h4>메일 발송 테스트</h4>
			<table>
				<colgroup>
					<col width="120px" />
					<col width="" />
				</colgroup>
				<tr>
					<th class="title bdr bdt">받는 메일주소</th>
					<td class="bdt"><input type="text" name="to_email" value="" class="AXInput W300" required>
					<input type="submit" value="발송" class="AXButton Blue"></td>
				</tr>
			</table>
		</div>
		<!-- tb_info -->

		<!-- tip_box -->
		<div class="tip_box" style="width:100%">
			<p>
			위 입력칸에 테스트 메일을 발송하실 메일 주소를 입력하시면, <b>[메일검사]</b> 라는 제목으로 테스트 메일을 발송합니다.<br />
			오류가 뜬다면 접속정보를 다시 한번 확인 해 보시기 바라며,
			테스트 메일이 도착하지 않는다면 보내는 메일서버 혹은 받는 메일서버 중 문제가 발생했을 가능성이 있습니다.<br />
			보다 정확한 테스트를 위해 여러 곳으로 메일을 발송해 보시기 바랍니다.
			</p>
		</div>
		<!-- //tip_box -->

	</form>

</div>
<!-- //contents -->

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->