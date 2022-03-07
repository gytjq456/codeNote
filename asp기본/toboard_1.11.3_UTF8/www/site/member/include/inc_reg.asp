<%
If mode="mod" Then
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "' "
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF Then
		Response.Write "<script>alert('회원정보가 없거나 탈퇴한 회원입니다.');location.href='/';</script>"
		Response.End
	Else
		m_lev = Rs("m_lev")
		m_sort = Rs("m_sort")
		m_id = Rs("m_id")
		m_pw = Rs("m_pw")
		m_name = Rs("m_name")
		m_nick = Rs("m_nick")
		m_jumin = Rs("m_jumin")
		m_email = Rs("m_email")
		m_mailing = Rs("m_mailing")
		m_tel1 = Rs("m_tel1")
		m_tel2 = Rs("m_tel2")
		m_tel3 = Rs("m_tel3")
		m_cell1 = Rs("m_cell1")
		m_cell2 = Rs("m_cell2")
		m_cell3 = Rs("m_cell3")
		m_fax1 = Rs("m_fax1")
		m_fax2 = Rs("m_fax2")
		m_fax3 = Rs("m_fax3")
		m_zip1 = Rs("m_zip1")
		m_zip2 = Rs("m_zip2")
		m_addr1 = Rs("m_addr1")
		m_addr2 = Rs("m_addr2")
		m_out = Rs("m_out")
		m_logcount = Rs("m_logcount")
		file1 = Rs("file1")
		file2 = Rs("file2")
		file3 = Rs("file3")
		file4 = Rs("file4")
		file5 = Rs("file5")
		addtext1 = Rs("addtext1")
		addtext2 = Rs("addtext2")
		addtext3 = Rs("addtext3")
		addtext4 = Rs("addtext4")
		addtext5 = Rs("addtext5")
		addtext6 = Rs("addtext6")
		addtext7 = Rs("addtext7")
		addtext8 = Rs("addtext8")
		addtext9 = Rs("addtext9")
		addtext10 = Rs("addtext10")
		addtext11 = Rs("addtext11")
		addtext12 = Rs("addtext12")
		addtext13 = Rs("addtext13")
		addtext14 = Rs("addtext14")
		addtext15 = Rs("addtext15")
		addtext16 = Rs("addtext16")
		addtext17 = Rs("addtext17")
		addtext18 = Rs("addtext18")
		addtext19 = Rs("addtext19")
		addtext20 = Rs("addtext20")
		regdate = Rs("regdate")
		moddate = Rs("moddate")
	End If
	Rs.Close
	Set Rs = Nothing
End If
%>

<!--회원 테이블-->
<form name="regform" method="post" action="?mode=<%=mode%>_p" enctype="multipart/form-data">

	<input type="hidden" name="idchk" id="idchk" value="0" />
	<!-- 추가필드 
	<input type="hidden"  name="addtext1" value="<%=addtext1%>" />
	<input type="hidden"  name="addtext2" value="<%=addtext2%>" />
	<input type="hidden"  name="addtext3" value="<%=addtext3%>" />
	<input type="hidden"  name="addtext4" value="<%=addtext4%>" />
	<input type="hidden"  name="addtext5" value="<%=addtext5%>" />
	<input type="hidden"  name="addtext6" value="<%=addtext6%>" />
	<input type="hidden"  name="addtext7" value="<%=addtext7%>" />
	<input type="hidden"  name="addtext8" value="<%=addtext8%>" />
	<input type="hidden"  name="addtext9" value="<%=addtext9%>" />
	<input type="hidden"  name="addtext10" value="<%=addtext10%>" />
	<input type="hidden"  name="addtext11" value="<%=addtext11%>" />
	<input type="hidden"  name="addtext12" value="<%=addtext12%>" />
	<input type="hidden"  name="addtext13" value="<%=addtext13%>" />
	<input type="hidden"  name="addtext14" value="<%=addtext14%>" />
	<input type="hidden"  name="addtext15" value="<%=addtext15%>" />
	<input type="hidden"  name="addtext16" value="<%=addtext16%>" />
	<input type="hidden"  name="addtext17" value="<%=addtext17%>" />
	<input type="hidden"  name="addtext18" value="<%=addtext18%>" />
	<input type="hidden"  name="addtext19" value="<%=addtext19%>" />
	<input type="hidden"  name="addtext20" value="<%=addtext20%>" />
	-->
	<div class="join_type">
		<table class="join_tb" style="width:100%" cellpadding="0" cellspacing="0">
			<caption>회원 가입/정보</caption>
			<colgroup>
				<col width="23%" />
				<col width="" />
			</colgroup>
			<tbody>
			<%If (W_LEVEL="1" Or W_LEVEL="2") And m_lev<>"1" And m_lev<>"2" Then%>
			<tr>
				<th align="center">회원등급 *</th>
				<td class="left">
				<select name="m_levmxd" id="m_levmxd" class="AXSelect">
				<%
				Set RsL = Server.Createobject("ADODB.Recordset")
				Sql = "SELECT * FROM tbl_member_level "
				Sql = Sql & " WHERE m_lev!='' "
				Sql = Sql & " ORDER BY m_lev, m_sort  "
				'Response.Write Sql
				RsL.Open Sql, Dbcon, 1
				Do Until RsL.EOF
					l_lev = RsL("m_lev")
					l_sort = RsL("m_sort")
					Response.Write "<option value='" & l_lev & ":" & l_sort & "' "
					If m_lev & ":" & m_sort=l_lev & ":" & l_sort Then Response.Write "selected"
					Response.Write ">" & l_lev & ":" & l_sort & "</option>" & Chr(13) & Chr(10)
					RsL.MoveNext
				Loop
				RsL.Close
				Set RsL = Nothing%>
				</select></td>
			</tr>
			<%ElseIf mode="mod" Then%>
			<tr>
				<th align="center">회원등급</th>
				<td class="left"><input type="hidden" name="m_levmxd" value="<%=m_lev & ":" & m_sort%>" /><%=m_sort%></td>
			</tr>
			<%End If%>

			<%If mode="mod" Then%>
			<tr>
				<th align="center">로그인횟수</th>
				<td class="left"><%=m_logcount%>회</td>
			</tr>
			<tr>
				<th align="center">가입일</th>
				<td class="left"><%=regdate%></td>
			</tr>
			<tr>
				<th align="center">최종수정일</th>
				<td class="left"><%=moddate%></td>
			</tr>
			<%End If%>

			<tr>
				<th align="center">아이디 *</th>
				<td class="left">
				<%If mode="mod" Then%>
					<input type="hidden" name="m_id" value="<%=m_id%>" />
					<%=SnsMemberIcon(m_id)%>
					<%=m_id%>
				<%Else%>
					<input type="text" name="m_id" id="m_id" class="AXInput W100" value="" style="ime-mode:disabled" />
					<input type="button" onclick="IdChk(this.form)" value="중복체크" class="AXButton">
				<%End If%>
				</td>
			</tr>
			<tr>
				<th>패스워드 *</th>
				<td class="left"><input type="password"  name="m_pw" value="" class="AXInput W100" style="ime-mode:disabled" />
				<%If mode="mod" Then Response.Write "(패스워드 변경 하실 경우 입력 하시기 바랍니다.)"%></td>
			</tr>
			<tr>
				<th>패스워드 재확인 *</th>
				<td class="left"><input type="password"  name="m_pw2" value="" class="AXInput W100" style="ime-mode:disabled" /></td>
			</tr>
			<tr>
				<th>이름 *</th>
				<td class="left"><input type="text"  name="m_name" value="<%=m_name%>" class="AXInput W100" /></td>
			</tr>
			<tr>
				<th>이메일 *</th>
				<td class="left"><input type="text"  name="m_email" value="<%=m_email%>" class="AXInput" style="width:90%" />
					<p>
						<input type="checkbox" name="m_mailing" id="m_mailing" value="1" <%If m_mailing=True Then Response.Write "checked"%> />
						<label for="m_mailing">관련 정보 메일을 수신합니다.</label>
					</p>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td class="left"><input type="text"  name="m_tel1" maxlength="3" value="<%=m_tel1%>" class="AXInput W40" numberOnly /> -
				<input type="text"  name="m_tel2" maxlength="4" value="<%=m_tel2%>" class="AXInput W40" numberOnly /> -
				<input type="text"  name="m_tel3" maxlength="4" value="<%=m_tel3%>" class="AXInput W40" numberOnly /></td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td class="left">
				<select name="m_cell1" id="m_cell1" title="앞3자리" class="AXSelect">
					<option value="010" <%If m_cell1="010" Then Response.Write "selected"%>>010</option>
					<option value="011" <%If m_cell1="011" Then Response.Write "selected"%>>011</option>
					<option value="016" <%If m_cell1="016" Then Response.Write "selected"%>>016</option>
					<option value="017" <%If m_cell1="017" Then Response.Write "selected"%>>017</option>
					<option value="018" <%If m_cell1="018" Then Response.Write "selected"%>>018</option>
					<option value="019" <%If m_cell1="019" Then Response.Write "selected"%>>019</option>
				</select>
				<!--input type="text"  name="m_cell1" maxlength="3" value="<%=m_cell1%>" class="AXInput W40" /--> -
				<input type="text"  name="m_cell2" maxlength="4" value="<%=m_cell2%>" class="AXInput W40" numberOnly /> -
				<input type="text"  name="m_cell3" maxlength="4" value="<%=m_cell3%>" class="AXInput W40" numberOnly /></td>
			</tr>
			<tr style="display:none">
				<th>FAX</th>
				<td class="left"><input type="text"  name="m_fax1" maxlength="3" value="<%=m_fax1%>" class="AXInput W40" numberOnly /> -
				<input type="text"  name="m_fax2" maxlength="4" value="<%=m_fax2%>" class="AXInput W40" numberOnly /> -
				<input type="text"  name="m_fax3" maxlength="4" value="<%=m_fax3%>" class="AXInput W40" numberOnly /></td>
			</tr>
			<tr>
				<th>주소</th>
				<td class="left" style="height:86px">
				<div id="addr_pop_wrap" style="display:none;border:1px solid;width:300px;height:300px;margin:5px 0;position:relative">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
				<input type="text" name="m_zip1" id="m_zip1" value="<%=m_zip1%>" class="AXInput W70" readonly="readonly" numberOnly />
				<input type="button" value="주소검색" class="AXButton" onclick="PostSearch();" /><br />
				<input type="text" name="m_addr1" id="m_addr1" value="<%=m_addr1%>" class="AXInput" readonly="readonly" style="width:90%; margin-top:5px" /><br />
				<input type="text" name="m_addr2" id="m_addr2" value="<%=m_addr2%>" class="AXInput" style="width:90%; margin-top:5px" />
				</td>
			</tr>
			<tr style="display:none">
				<th>첨부파일</th>
				<td class="left mod">
					<%if file1<>"" Then%><%=file1%> <a href="/upload/member/<%=file1%>" download class="AXButtonSmall Classic">다운로드</a><br /><%End If%>
					<input type="file" name="file1">
				</td>
			</tr>
			<%If mode="reg" Then%>
			<tr>
				<th>자동등록방지 *</th>
				<td class="left">
				<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /> <input type="button" value="새로고침" class="AXButton" onclick="RefreshImage('imgCaptcha');" />
				<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput W90" maxlength="5" placeholder="코드입력" /></td>
			</tr>
			<%End If%>
			</tbody>
		</table>

		<div class="btn-group">
			<button type="submit">확인</button>
			<button type="button" onclick="history.back();" >취소</button>
			<%If mode="mod" And W_ID=m_id Then%><button type="button" onclick="Withdraw();" >회원탈퇴</button><%End If%>
		</div>
	</div>
</form>

<iframe src="" name="bframe" style="width:0; height:0; border:0;"></iframe>

<script type="text/javascript">
function RegChk(){
	obj = document.regform;
	<%If mode="reg" Then%>
	if(obj.m_id.value==""){ alert('아이디를 입력하세요'); obj.m_id.focus(); return; }
	var idReg = /^[a-z]{1}[a-z0-9]{3,11}$/;
	if( !idReg.test( $("#m_id").val() ) ) {
		alert("아이디는 영문자로 시작하는 4~12자 영문 또는 숫자이어야 합니다.");
		return;
	}
	if(obj.idchk.value=="0"){ alert('아이디 중복체크를 해주세요'); obj.m_id.focus(); return; }
	if(obj.m_pw.value==""){ alert('패스워드를 입력하세요'); obj.m_pw.focus(); return; }
	if(obj.m_pw2.value==""){ alert('패스워드 확인을 입력하세요'); obj.m_pw2.focus(); return; }
	<%End If%>
	//비밀번호 일치 체크
	if(obj.m_pw.value != obj.m_pw2.value){
		alert('비밀번호가 일치하지 않습니다.');
		obj.m_pw.value="";
		obj.m_pw2.value="";
		obj.m_pw.focus();
		return;
	}
	if(obj.m_name.value==""){ alert('이름을 입력하세요'); obj.m_name.focus(); return; }
	if(obj.m_email.value==""){ alert('이메일을 입력하세요'); obj.m_email.focus(); return; }
	if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(obj.m_email.value))){ 
		alert("이메일주소를 정확하게 기입하세요"); 
		obj.m_email.focus(); 
		return; 
	}
	<%If mode="reg" Then%>
	if(obj.txtCaptcha.value==""){ alert('자동등록방지 코드를 입력하세요'); obj.txtCaptcha.focus(); return; }
	<%End If%>
	obj.submit();
}

function IdChk(obj){
	if (obj.m_id.value=="")	{
		alert('아이디를 입력하세요');
	}else{
		var idReg = /^[a-z]{1}[a-z0-9]{3,11}$/;
		if( !idReg.test( $("#m_id").val() ) ) {
			alert("아이디는 영문자로 시작하는 4~12자 영문 또는 숫자이어야 합니다.");
			return;
		}
		bframe.location.href='/site/member/include/id-chk.asp?m_lang=kr&m_id='+obj.m_id.value;
	}
	obj.m_id.focus();
}

function Withdraw(){
	if(confirm("회원 탈퇴 하시게 되면 모든 회원 정보가 삭제되며 복구가 불가능합니다. 정말로 탈퇴 하시겠습니까??")){
		location.href='/site/member/withdraw.asp?m_id=<%=m_id%>';
	}
}

<%If mode="mod" Then%>$("#idchk").val("1");<%End If%>
</script>

<%If Request.ServerVariables("SERVER_PORT")=443 Then%>
<!-- https --><script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<%Else%>
<!-- http --><script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%End If%>

<script>
// 우편번호 찾기 찾기 화면을 넣을 element
var element_wrap = document.getElementById('addr_pop_wrap');

function foldDaumPostcode() {
	// iframe을 넣은 element를 안보이게 한다.
	element_wrap.style.display = 'none';
}

function PostSearch() {
	var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	new daum.Postcode({
		oncomplete: function(data) {
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			if(data.userSelectedType === 'R'){
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ')';
				}
			}

			document.getElementById('m_zip1').value = data.zonecode;
			document.getElementById("m_addr1").value = addr;
			document.getElementById("m_addr2").focus();

			element_wrap.style.display = 'none';
			document.body.scrollTop = currentScroll;
		},
		onresize : function(size) {
			element_wrap.style.height = size.height+'px';
		},
		width : '100%',
		height : '100%'
	}).embed(element_wrap);

	element_wrap.style.display = 'block';
}
</script>