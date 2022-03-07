<%
If bdevice="mobile" Then
	link_join = "/mobile/sub/member/join.asp"
	link_idpw = "/mobile/sub/member/find.asp"
Else
	link_join = "/sub/member/join.asp"
	link_idpw = "/sub/member/find.asp"
End If
%>

<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<div class="login-box">
	<!-- /.login-logo -->
	<div class="login-box-body">
		<!-- <p class="login-box-msg tit">Login</p> -->
		<!-- <p class="login-box-msg"><span class="ui-icon ui-icon-locked"></span> Sign in to start your session</p> -->

		<form name="loginform" method="post" action="?mode=login_p">
			<%'BASE64_ENCODE 데이터로 전송 할 것%>
			<input type="hidden" name="rturl" value="<%=Request("rturl")%>" />
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
			<div class="btn-group">
				<button type="submit" class="">LOGIN</button>
			</div>
		</form>
		<div class="linkBtn">
			<p><span class="ui-icon ui-icon-alert"></span> <a href="<%=link_idpw%>">계정정보 찾기</a><br></p>
			<p><span class="ui-icon ui-icon-person"></span> <a href="<%=link_join%>" class="text-center">회원 가입</a></p>
		</div>
		<p class="sns-login-title">Social Login</p>
		<ul class="sns-login">
			<li>
				<div id="naverIdLogin"></div>
			</li>
			<li>
				<a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="/site/member/snsicon/btn_kakaoH.jpg" /></a>
			</li>
			<li>
				<a href="#;" id="fb-auth" title="페이스북으로 로그인"><img src="/site/member/snsicon/btn_facebookH.jpg" /></a>
			</li>
			<li>
				<a href="#;" id="google_login_btn" title="구글 로그인"><img src="/site/member/snsicon/btn_googleH.jpg" /></a>
			</li>
		</ul>
	</div>
	<!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<!-- 네이버로그인 -->
<script type="text/javascript">
var naverLogin = new naver.LoginWithNaverId(
	{
		clientId: "Sd0CnemUk3R922RPZXO3",
		callbackUrl: "http://<%=Request.ServerVariables("SERVER_NAME")%>/site/member/include/naver_login_callback.asp",
		callbackHandle: true,
		isPopup: false, /* 팝업을 통한 연동처리 여부 */
		loginButton: {color: "green", type: 3, height: 52} /* 로그인 버튼의 타입을 지정 */
	}
);
naverLogin.init();
$("#naverIdLogin_loginButton img").attr("src", "/site/member/snsicon/btn_naverH.jpg");
</script>
<!-- // 네이버로그인 -->

<!-- 카카오 로그인 -->
<script type='text/javascript'>
//JavaScript 키
Kakao.init('379ee157dcaff3e567a839e2f7971a33');
function loginWithKakao() {
	Kakao.Auth.login({
		success: function(authObj) {
			getKakaotalkUserProfile();
		},
		fail: function(err) {
			alert(JSON.stringify(err));
		}
	});
};

function getKakaotalkUserProfile(){
	Kakao.API.request({
		url: '/v2/user/me',
		success: function(res) {
			var $form = $('<form></form>');
			$form.attr('action', '?mode=sns_login_p');
			$form.attr('method', 'post');
			$form.attr('target', '');
			$form.appendTo('body');

			var m_id = $('<input type="hidden" value="_kk_'+res.id+'" name="m_id">');
			var m_pw = $('<input type="hidden" value="a12345" name="m_pw">');
			var m_name = $('<input type="hidden" value="'+res.properties.nickname+'" name="m_name">');
			var m_email = $('<input type="hidden" value="'+res.kaccount_email+'" name="m_email">');

			$form.append(m_id).append(m_pw).append(m_name);
			$form.submit();

		},
		fail: function(error) {
			console.log(error);
		}
	});
}
</script>
<!--// 카카오 로그인 -->

<!-- 페이스북로그인 -->
<div id="fb-root"></div>
<script language=javascript>
window.fbAsyncInit = function(){
	FB.init({ appId: '286817863006511',
		status: true,
		cookie: true,
		xfbml: true,
		oauth: true});
}

function updateButton(response) {
	var button = document.getElementById('fb-auth');
	if (response.authResponse) {
		FB.api('/me', {fields: 'name,email'}, function(response) {
			if(confirm('Facebook ID : '+response.email+' 계정으로 로그인하시겠습니까?')==true){
				// 확인을 선택했을 경우의 처리.
				var $form = $('<form></form>');
				$form.attr('action', '?mode=sns_login_p');
				$form.attr('method', 'post');
				$form.attr('target', '');
				$form.appendTo('body');

				var m_id = $('<input type="hidden" value="_fb_'+response.email+'" name="m_id">');
				var m_pw = $('<input type="hidden" value="a12345" name="m_pw">');
				var m_name = $('<input type="hidden" value="'+response.name+'" name="m_name">');
				var m_email = $('<input type="hidden" value="'+response.email+'" name="m_email">');

				$form.append(m_id).append(m_pw).append(m_name).append(m_email);
				$form.submit();
			}else{
				// 취소를 선택했을 경우의 처리(아래는 페이스북 로그아웃 처리)
				FB.logout(function(response) {
				});
			}
		});

	} else {
		FB.login(function(response) {
			if (response.authResponse) {
				FB.api('/me', function(response) {
				});
			} else {
			}
		}, {scope:'email'});
	}
}

document.getElementById('fb-auth').onclick = function() {
	FB.Event.subscribe('auth.statusChange', updateButton);
	FB.getLoginStatus(updateButton);
};

(function() {
	var e = document.createElement('script'); e.async = true;
	e.src = document.location.protocol
	+ '//connect.facebook.net/ko_KR/all.js';
	document.getElementById('fb-root').appendChild(e);
}());

</script>
<!-- // 페이스북로그인 -->

<!-- 구글로그인 -->
<meta name ="google-signin-client_id" content="957789291970-kih7sefa28rdh39c6mhv57at8tukb0r2.apps.googleusercontent.com">
<script>
//처음 실행하는 함수
function init() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // google_login_btn은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('google_login_btn', options, onSignIn, onSignInFailure);
	})
}

function onSignIn(googleUser) {
	var access_token = googleUser.getAuthResponse().access_token
	$.ajax({
    	// people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
		url: 'https://people.googleapis.com/v1/people/me'
        // key에 자신의 API 키를 넣습니다.
		, data: {personFields:'birthdays', key:'AIzaSyA0pnJduXCwJdqcYywDzpHYufq-mETYGKc', 'access_token': access_token}
		, method:'GET'
	})
	.done(function(e){
        //프로필을 가져온다.
		var profile = googleUser.getBasicProfile();
		console.log(profile);
		var $form = $('<form></form>');
		$form.attr('action', '?mode=sns_login_p');
		$form.attr('method', 'post');
		$form.attr('target', '');
		$form.appendTo('body');

		var m_id = $('<input type="hidden" value="_gg_'+profile.getId()+'" name="m_id">');
		var m_pw = $('<input type="hidden" value="a12345" name="m_pw">');
		var m_name = $('<input type="hidden" value="'+profile.getName()+'" name="m_name">');
		var m_email = $('<input type="hidden" value="'+profile.getEmail()+'" name="m_email">');

		$form.append(m_id).append(m_pw).append(m_name).append(m_email);
		$form.submit();
	})
	.fail(function(e){
		console.log(e);
	})
}
function onSignInFailure(t){		
	console.log(t);
}
</script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<!-- // 구글로그인 -->