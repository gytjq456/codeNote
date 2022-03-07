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


	<table class="ntb-tb-view" style="width:100%" cellpadding="0" cellspacing="0">
		<caption>회원 가입/정보</caption>
		<colgroup>
			<col width="23%" />
			<col width="" />
		</colgroup>
		<tbody>

		<%If (W_LEVEL="1" Or W_LEVEL="2") And m_lev<>"1" And m_lev<>"2" Then%>
		<tr>
			<th align="center">Membership level ✔️</th>
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
			<th align="center">Membership level</th>
			<td class="left"><input type="hidden" name="m_levmxd" value="<%=m_lev & ":" & m_sort%>" /><%=m_sort%></td>
		</tr>
		<%End If%>

		<%If mode="mod" Then%>
		<tr>
			<th align="center">Number of logins</th>
			<td class="left"><%=m_logcount%>times</td>
		</tr>
		<tr>
			<th align="center">Date of sign up</th>
			<td class="left"><%=regdate%></td>
		</tr>
		<tr>
			<th align="center">Last modified date</th>
			<td class="left"><%=moddate%></td>
		</tr>
		<%End If%>

		<tr>
			<th align="center">ID ✔️</th>
			<td class="left">
			<%If mode="mod" Then%>
				<input type="hidden" name="m_id" value="<%=m_id%>" />
				<%=SnsMemberIcon(m_id)%>
				<%=m_id%>
			<%Else%>
				<input type="text" name="m_id" id="m_id" class="AXInput W100" value="" style="ime-mode:disabled" />
				<input type="button" onclick="IdChk(this.form)" value="Check ID duplication" class="AXButtonSmall Classic">
			<%End If%>
			</td>
		</tr>
		<tr>
			<th>Password ✔️</th>
			<td class="left"><input type="password"  name="m_pw" value="" class="AXInput W100" style="ime-mode:disabled" />
			<%If mode="mod" Then Response.Write "(Please enter if you wish to change your password.)"%></td>
		</tr>
		<tr>
			<th>Re-confirm password ✔️</th>
			<td class="left"><input type="password"  name="m_pw2" value="" class="AXInput W100" style="ime-mode:disabled" /></td>
		</tr>
		<tr>
			<th>Name ✔️</th>
			<td class="left"><input type="text"  name="m_name" value="<%=m_name%>" class="AXInput W100" /></td>
		</tr>
		<tr>
			<th>E-mail ✔️</th>
			<td class="left"><input type="text"  name="m_email" value="<%=m_email%>" class="AXInput" style="width:90%" />
				<p>
					<input type="checkbox" name="m_mailing" id="m_mailing" value="1" <%If m_mailing=True Then Response.Write "checked"%> />
					<label for="m_mailing"> I want to receive relevant information emails</label>
				</p>
			</td>
		</tr>
		<tr>
			<th>Contact information</th>
			<td class="left"><input type="text"  name="m_tel1" value="<%=m_tel1%>" class="AXInput W150"  /></td>
		</tr>
		<tr>
			<th>Mobile phone</th>
			<td class="left"><input type="text"  name="m_cell1" value="<%=m_cell1%>" class="AXInput W150"  /></td>
		</tr>
		<tr style="display:none">
			<th>FAX</th>
			<td class="left"><input type="text"  name="m_fax1" maxlength="3" value="<%=m_fax1%>" class="AXInput W40" numberOnly /> -
			<input type="text"  name="m_fax2" maxlength="4" value="<%=m_fax2%>" class="AXInput W40" numberOnly /> -
			<input type="text"  name="m_fax3" maxlength="4" value="<%=m_fax3%>" class="AXInput W40" numberOnly /></td>
		</tr>
		<tr>
			<th>Address</th>
			<td class="left"><input type="text" name="m_addr1" id="m_addr1" value="<%=m_addr1%>" class="AXInput" style="width:90%" /></td>
		</tr>
		<tr style="display:none">
			<th>Attach</th>
			<td class="left mod">
				<%if file1<>"" Then%><%=file1%> <a href="/upload/member/<%=file1%>" download class="AXButtonSmall Classic">Download</a><br /><%End If%>
				<input type="file" name="file1">
			</td>
		</tr>
		<%If mode="reg" Then%>
		<tr>
			<th>Automatic registration prevention ✔️</th>
			<td class="left">
			<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /> <input type="button" value="Refresh" class="AXButtonSmall Classic" onclick="RefreshImage('imgCaptcha');" />
			<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput W100" maxlength="5" placeholder="Please enter the code" /></td>
		</tr>
		<%End If%>
		</tbody>
	</table>

	<div class="ntb-listbtn-area" style="width:100%">
		<input type="button" value="   Confirm   " class="AXButton Classic" onclick="RegChk()">
		<input type="button" value="   Cancel   " class="AXButton" onclick="history.back();">
		<%If mode="mod" And W_ID=m_id Then%><input type="button" value=" Membership withdrawal " class="AXButton" onclick="Withdraw()"><%End If%>
	</div>

</form>

<iframe src="" name="bframe" style="width:0; height:0; border:0;"></iframe>

<script type="text/javascript">
function RegChk(){
	obj = document.regform;
	<%If mode="reg" Then%>
	if(obj.m_id.value==""){ alert('Please enter your ID'); obj.m_id.focus(); return; }
	if(obj.idchk.value=="0"){ alert('Please check ID duplication'); obj.m_id.focus(); return; }
	var idReg = /^[a-z]{1}[a-z0-9]{3,11}$/;
	if( !idReg.test( $("#m_id").val() ) ) {
		alert("ID must be 4 to 12 alphabets or numbers starting with an alphabetic character.");
		return;
	}
	if(obj.m_pw.value==""){ alert('Please enter a password'); obj.m_pw.focus(); return; }
	if(obj.m_pw2.value==""){ alert('Please enter password confirmation '); obj.m_pw2.focus(); return; }
	<%End If%>
	//비밀번호 일치 체크
	if(obj.m_pw.value != obj.m_pw2.value){
		alert('Your password does not match.');
		obj.m_pw.value="";
		obj.m_pw2.value="";
		obj.m_pw.focus();
		return;
	}
	if(obj.m_name.value==""){ alert('Please enter your name'); obj.m_name.focus(); return; }
	if(obj.m_email.value==""){ alert('Please enter your email'); obj.m_email.focus(); return; }
	if (!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(obj.m_email.value))){ 
		alert("Please enter your email address correctly"); 
		obj.m_email.focus(); 
		return; 
	}
	<%If mode="reg" Then%>
	if(obj.txtCaptcha.value==""){ alert('Please enter the automatic registration prevention code'); obj.txtCaptcha.focus(); return; }
	<%End If%>
	obj.submit();
}

function IdChk(obj){
	if (obj.m_id.value=="")	{
		alert('Please enter your ID');
	}else{
		var idReg = /^[a-z]{1}[a-z0-9]{3,11}$/;
		if( !idReg.test( $("#m_id").val() ) ) {
			alert("ID must be 4 to 12 alphabets or numbers starting with an alphabetic character.");
			return;
		}
		bframe.location.href='/site/member/include/id-chk.asp?m_lang=en&m_id='+obj.m_id.value;
	}
	obj.m_id.focus();
}

function Withdraw(){
	if(confirm("When you withdraw from membership, all member information is deleted and cannot be recovered. Are you sure you want to withdraw?")){
		location.href='/site/member/withdraw.asp?m_id=<%=m_id%>';
	}
}

<%If mode="mod" Then%>$("#idchk").val("1");<%End If%>
</script>
