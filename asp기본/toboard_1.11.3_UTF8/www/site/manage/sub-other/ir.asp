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
	<p>상장기업 IR정보 연동설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>상장기업 IR정보 연동설정</li>
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

	<form name="regform" action="ir-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>상장기업 IR정보 연동설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">종목코드</th>
				<td class="bdt"><input type="text" name="stock_code" value="<%=stock_code%>" maxlength="6" class="AXInput W60"></td>
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


	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
			아래의 사이트에서 서비스 신청 후 이용 가능합니다.<br />
			<a href="https://data.koscom.co.kr/kor/krxAsp/aspSecond.do?menuNo=200050" target="_blank">https://data.koscom.co.kr/kor/krxAsp/aspSecond.do?menuNo=200050</a><br />
			<%If W_LEVEL="1" Then%>
			<br />
			<b>주가정보 소스코드</b><br />
			&lt;%ir_lang="한국어"  '한국어, 영어%&gt;<br />
			&lt;!--#include virtual="/site/ir/inv_stockinfo.asp" --&gt;<br />
			<%End If%>
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.stock_code.value==""){ alert("종목코드 6자리를 입력하세요"); obj.stock_code.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->