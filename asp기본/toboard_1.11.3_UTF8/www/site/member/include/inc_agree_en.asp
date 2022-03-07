<style type="text/css">
.provision{background:#f8f8f8;border:1px solid #eaeaea;padding:20px}
.provision .tit{font-size:15px;font-weight:700;#333}
.provision .txt{background:#fff;border:1px solid #eaeaea;line-height:22px;height:250px;overflow-x:hidden;overflow-y:scroll;color:#818181;padding:20px}
.provision .check{color:#333;}
.submit{text-align:center;}
</style>

<form name="agreeform" method="post" action="?mode=reg">
				
	<!-- provision -->
	<div class="provision">
		<p class="tit">Terms of Membership</p>
		<br />
		<p class="txt"><%=TagText(sc_agree1)%></p>
		<br />
		<p class="check"><input type="checkbox" id="agree1" required /> <label for="agree1">I agree to the terms of membership.</label></p>

	</div>
	<!-- //provision -->
	<br />
	<br />

	<!-- provision -->
	<div class="provision">
		<p class="tit">Privacy Policy</p>
		<br />
		<p class="txt"><%=TagText(sc_agree2)%></p>
		<br />
		<p class="check"><input type="checkbox" id="agree2" required /> <label for="agree2">I agree to the Privacy Policy.</label></p>
	</div>
	<!-- //provision -->
	<br />
	<br />

	<div class="ntb-listbtn-area">
		<input type="submit" value="   Next   " class="AXButton Classic" />
		<input type="button" value="   Cancel   " class="AXButton" onclick="history.back();" />
	</div>

</form>