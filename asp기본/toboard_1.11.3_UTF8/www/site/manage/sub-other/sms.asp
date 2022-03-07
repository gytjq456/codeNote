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
	<p>SMS 연동 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>SMS 연동 설정</li>
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
	sms_key=Rs("sms_key")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="sms-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>SMS 연동 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">SMS 인증키</th>
				<td class="bdt"><input type="text" name="sms_key" value="<%=sms_key%>" class="AXInput W200"></td>
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


	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
			<a href="http://sms.webmoa.co.kr" target="_blank">http://sms.webmoa.co.kr</a> 에서 계정 등록 및 충전 후 사용 가능합니다.
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.sms_key.value==""){ alert("SMS 인증키를 입력하세요"); obj.sms_key.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->