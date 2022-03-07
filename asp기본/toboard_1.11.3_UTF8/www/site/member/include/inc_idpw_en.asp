<style type="text/css">
.login-box, .register-box {
	max-width:400px;
	margin:3% auto;
	border:1px solid #d4d8d9;
	border-radius: 5px;
	background: #fff;
	padding:40px;
	box-shadow: 0 0 30px rgb(0 0 0 / 10%)
}
.login-box-msg {margin:0; text-align:left; padding: 10px 10px 20px 0; font-size:17px; font-weight: 700;}
.form-group {margin-bottom:16px; font-size:14px;}
.form-group input {
	border:1px solid #ddd;
	border-radius: 3px;
	padding:10px;
	width: 100%;
	height: 42px;
	box-sizing: border-box;
	margin-top: 10px;
}
.btn-group {margin-bottom: 60px;}
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
	<div class="login-box-body">
		<p class="login-box-msg"><span class="ui-icon ui-icon-lightbulb"></span> Find ID</p>
		<form name="regform1" method="post" action="?mode=id_p">
			<div class="form-group">
				<input type="text" name="m_name" class="AXInput" placeholder="Name" required />
			</div>
			<div class="form-group">
				<input type="text" name="m_email" class="AXInput" placeholder="E-mail" required />
			</div>
			<div class="form-group">
				<span class="ui-icon ui-icon-alert"></span>
				Enter the name and email address you created when signing up and we will inform you of your ID to email.
			</div>
			<div class="btn-group">
				<button type="submit" style="height:40px; float:right">Find ID</button>
			</div>
		</form>
	</div>
</div>

<div class="login-box">
	<div class="login-box-body">
		<p class="login-box-msg"><span class="ui-icon ui-icon-lightbulb"></span> Find password</p>
		<form name="regform2" method="post" action="?mode=pw_p">
			<div class="form-group">
				<input type="text" name="m_id" class="AXInput" placeholder="아이디" style="ime-mode:disabled" required />
			</div>
			<div class="form-group">
				<input type="text" name="m_name" class="AXInput" placeholder="이름" required />
			</div>
			<div class="form-group">
				<input type="text" name="m_email" class="AXInput" placeholder="이메일" required />
			</div>
			<div class="form-group">
				<span class="ui-icon ui-icon-alert"></span>
				Enter ID, name and email address you created when signing up and we will inform you of your temporary password to email.
			</div>
			<div class="btn-group">
				<button type="submit" style="height:40px; float:right">Find password</button>
			</div>
		</form>
	</div>
</div>