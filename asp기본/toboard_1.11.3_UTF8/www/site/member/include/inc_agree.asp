<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT sc_agree1, sc_agree2 FROM tbl_site_config "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('정보가 없습니다.'); history.back();</script>"
	Response.End
Else
	sc_agree1=Rs("sc_agree1")
	sc_agree2=Rs("sc_agree2")
End If
Rs.Close
Set Rs = Nothing
%>

<script>
$(function(){
	$("input[type=checkbox]").checkboxradio();
});
</script>

<form name="agreeform" method="post" action="?mode=reg">

	<div class="agree-box">
		<div class="agree-box-body">
			<p class="agree-box-msg tit">회원가입 약관</p>
			<div class="form-group">
				<%=TagText(sc_agree1)%>
			</div>
			<div class="chk-group">
				<p class="check"><input type="checkbox" id="agree1" required /> <label for="agree1">회원가입 약관에 동의합니다.</label></p>
			</div>
		</div>

		<div class="agree-box-body">
			<p class="agree-box-msg tit">개인정보 취급방침</p>
			<div class="form-group">
				<%=TagText(sc_agree2)%>
			</div>
			<div class="chk-group">
				<p class="check"><input type="checkbox" id="agree2" required /> <label for="agree2">개인정보 취급방침에 동의합니다.</label></p>
			</div>
		</div>

		<div class="btn-group">
			<button type="submit">다음</button>
			<button type="button" onclick="history.back();" >취소</button>
		</div>
	</div>

</form>