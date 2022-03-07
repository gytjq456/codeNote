<div class="login-box">
	<div class="login-box-body">
		<p class="login-box-msg"><span class="ui-icon ui-icon-lightbulb"></span> 아이디 찾기</p>
		<form name="regform1" method="post" action="?mode=id_p">
			<div class="form-group">
				<input type="text" name="m_name" class="AXInput" placeholder="이름" required />
			</div>
			<div class="form-group">
				<input type="text" name="m_email" class="AXInput" placeholder="이메일" required />
			</div>
			<div class="form-group">
				<span class="ui-icon ui-icon-alert"></span>
				가입시 작성하신 이름과 이메일 주소를 입력하시면 이메일로 아이디를 알려드립니다.
			</div>
			<div class="btn-group">
				<button type="submit" style="height:40px; float:right">아이디 찾기</button>
			</div>
		</form>
	</div>
</div>

<div class="login-box">
	<div class="login-box-body">
		<p class="login-box-msg"><span class="ui-icon ui-icon-lightbulb"></span> 패스워드 찾기</p>
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
				가입시 작성하신 아이디와 이름, 이메일 주소를 입력하시면 이메일로 임시비밀번호를 알려드립니다.
			</div>
			<div class="btn-group">
				<button type="submit" style="height:40px; float:right">패스워드 찾기</button>
			</div>
		</form>
	</div>
</div>
