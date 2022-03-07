<%
o_dir = Request("o_dir")
If W_ID<>"" Then Response.Redirect "?mode=order&o_dir=" & o_dir

If bdevice="mobile" Then
	link_join = "/mobile/sub/member/join.asp"
	link_idpw = "/mobile/sub/member/find.asp"
Else
	link_join = "/sub/member/join.asp"
	link_idpw = "/sub/member/find.asp"
End If
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
.tit  {
	text-align: center;
	font-size: 1.8rem;
	font-weight: 700;
	color:#f48120;
	margin-bottom: 40px;
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
#subWrap {
	background: #f9f9f9;
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

.linkBtn { display:flex;margin-top: 40px; justify-content: center;}
.linkBtn p { font-size: 14px; margin-right:20px; color:}
.linkBtn a {
	color: #aaa;
}
.linkBtn p:last-child {margin:0;}

</style>

<div class="login-box">
	<!-- /.login-logo -->
	<div class="login-box-body">
		<!-- <p class="login-box-msg tit">Login</p> -->
		<!-- <p class="login-box-msg"><span class="ui-icon ui-icon-locked"></span> Sign in to start your session</p> -->

		<form name="loginform" method="post" action="/site/shop/include/login_ok.asp">
			<div class="form-group">
				<div>
					<p>User ID</p>
					<input type="text" name="m_id" class="AXInput" placeholder="ID" style="ime-mode:disabled" required />
				</div>
				<div>
					<p>Password</p>
					<input type="password" name="m_pw" class="AXInput" placeholder="Password" required />
				</div>
			</div>

			<div class="submit">
				<button type="submit" class="">LOGIN</button>
			</div>
			<div class="submit">
				<button type="button" onclick="location.href='?mode=order'">비회원 구매</button>
			</div>
		</form>
		<div class="linkBtn">
			<p><span class="ui-icon ui-icon-alert"></span> <a href="<%=link_idpw%>">계정정보 찾기</a><br></p>
			<p><span class="ui-icon ui-icon-person"></span> <a href="<%=link_join%>" class="text-center">회원 가입</a></p>
		</div>

	</div>
	<!-- /.login-box-body -->
</div>
<!-- /.login-box -->