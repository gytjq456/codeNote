<%
If W_ID<>"" Then Response.Redirect "?mode=order_info_list"
%>

<style type="text/css">
.login-box {
	width: 100%;
	margin:3% auto;
	max-width: 320px;
	border:1px solid #d4d8d9;
	border-radius: 5px;
	background: #fff;
	padding:40px;
	box-shadow: 0 0 30px rgb(0 0 0 / 10%)
	
}
.form-group > div {}
.form-group > div:not(:last-child) {
	margin-bottom: 20px;
}
.form-group p {
	font-size: 14px;
	color:#666;
}
.form-group input {
	border:1px solid #ddd;
	border-radius: 3px;
	padding:10px;
	width: 100%;
	height: 42px;
	box-sizing: border-box;
	margin-top: 10px;
}

.submit {
	margin-top: 30px;
}
button {
	width: 100%;
	height: 50px;
	font-size: 16px;
	border-radius: 3px;
	color:#666;
	font-weight: 300;
	background: #fff;
	transition: all 0.5s;
	border:1px solid #ddd;
}
button:hover {
	background: #94babb;
	color:#fff;
}

</style>

<div class="login-box">
	<!-- /.login-logo -->
	<div class="login-box-body">
		<form name="loginform" method="post" action="?mode=order_info_list">
			<div class="form-group">
				<div>
					<p>주문자 이메일</p>
					<input type="text" name="s_o_email" class="AXInput" placeholder="" style="ime-mode:disabled" required />
				</div>
				<div>
					<p>주문자 명</p>
					<input type="text" name="s_o_name" class="AXInput" placeholder="" required />
				</div>
			</div>

			<div class="submit">
				<button type="submit" class="">조회하기</button>
			</div>
		</form>

	</div>
	<!-- /.login-box-body -->
</div>
<!-- /.login-box -->
