<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$( function() {
	$("#s_srdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#s_erdate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
</head>

<%
s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_mailing = Request("s_mailing")
s_sort = Request("s_sort")

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_mailing=" & s_mailing & "&s_sort=" & s_sort
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>단체 문자 발송</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>단체 문자 발송</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="searchform" method="post" action="?">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="이름, 아이디, 이메일, 주소 등"></td>
				<th class="bdb bdr">가입일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div>
				</td>
				<th class="bdb bdr">회원등급</th>
				<td class="bdb bdr">
				<select name="s_sort" id="s_sort" class="AXSelect">
				<%
				Set RsL = Server.Createobject("ADODB.Recordset")
				Sql = "SELECT * FROM tbl_member_level "
				Sql = Sql & " WHERE m_lev!='' "
				Sql = Sql & " ORDER BY m_lev, m_sort  "
				'Response.Write Sql
				RsL.Open Sql, Dbcon, 1
				Response.Write "<option value=''>---- 전체 ----</option>" & Chr(13) & Chr(10)
				Do Until RsL.EOF
					l_lev = RsL("m_lev")
					l_sort = RsL("m_sort")
					Response.Write "<option value='" & l_sort & "' "
					If Trim(l_sort)=Trim(s_sort) Then Response.Write "selected"
					Response.Write ">" & l_lev & ":" & l_sort & "</option>" & Chr(13) & Chr(10)
					RsL.MoveNext
				Loop
				RsL.Close
				Set RsL = Nothing%>
				</select>
				</td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<form name="regform" method="post" action="group-sms-send-ok.asp">

	<%
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 100 m_cell1+'-'+m_cell2+'-'+m_cell3 FROM tbl_member "
	Sql = Sql & " WHERE idx!='' "
	Sql = Sql & " AND m_lev>=3 "	'관리자를 제외한 회원만 검색

	If s_keyword<>"" Then
		Sql = Sql & " AND (m_name LIKE '%" & s_keyword & "%' "
		Sql = Sql & " OR m_id LIKE '%" & s_keyword & "%' "
		Sql = Sql & " OR m_email LIKE '%" & s_keyword & "%' "
		Sql = Sql & " OR m_addr1 LIKE '%" & s_keyword & "%' "
		Sql = Sql & " OR m_addr2 LIKE '%" & s_keyword & "%' "
		Sql = Sql & " OR m_cell1+'-'+m_cell2+'-'+m_cell3 LIKE '%" & s_keyword & "%') "
	End If

	If s_sort<>"" Then Sql = Sql & " AND m_sort='" & s_sort & "' "
	If s_srdate<>"" And s_erdate<>"" Then Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "

	'Response.Write Sql
	Rs.Open Sql, Dbcon, 1
	If Rs.EOF=False Then
	Do Until Rs.EOF
		If Left(Rs(0), 2)="01" Then
			to_tel = to_tel & Rs(0) & "<br />"
			to_tel_val = to_tel_val & Rs(0) & "#$#"
		End If
		Rs.Movenext
	Loop
	Else
		Response.Write "<script>alert('조회된 회원이 없습니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing
	to_tel_val=Left(to_tel_val, Len(to_tel_val)-3)
	%>

	<div class="tb_info">
		<h4>단체 문자 발송</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">받는사람</th>
				<td class="bdt bdr"><span class="txt_red"><%=to_tel%></span>
				<input type="hidden" name="s_tonum" value="<%=to_tel_val%>" />
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt"><span class="icon">내용</span></th>
				<td class="bdt"><textarea name="sms_content" class="AXInput" style="width:120px;height:150px" onkeyup="chkMsgLength(80,this,txt_Byte);"><%=sms_content%></textarea>
				<span id="txt_Byte" style="padding-left: 60;">0</span>/80</td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="button" value="   전송하기   " class="AXButton Blue" onclick="RegChk()"></span>
			<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	</form>

	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
		내용이 80바이트가 초과하는 경우 자동으로 LMS로 발송됩니다.
		</p>
	</div>
	<!-- //tip_box -->

<script>
// 메세지 바이트 체크
function chkMsgLength(intMax,objMsg,st) {
	var length = lengthMsg(objMsg.value);
	st.innerHTML = length;//현재 byte수를 넣는다
	document.regform.txtbyte = length;//현재 byte수를 넣는다
}

// 현재 메시지 바이트 수 계산
function lengthMsg(objMsg){
	var nbytes = 0;
	for (i=0; i<objMsg.length; i++){
		var ch = objMsg.charAt(i);
		if(escape(ch).length > 4){
			nbytes += 2;
		}else if (ch == '\n'){
			if (objMsg.charAt(i-1) != '\r'){
				nbytes += 1;
			}
		}else if (ch == '<' || ch == '>'){
			nbytes += 4;
		}else{
			nbytes += 1;
		}
	}
	return nbytes;
}

// 80 바이트 넘는 문자열 자르기
function assertMsg(intMax, objMsg, st){
	var inc = 0;
	var nbytes = 0;
	var msg = "";
	var msglen = objMsg.length;
	for (i=0; i < msglen; i++){
		var ch = objMsg.charAt(i);
		if (escape(ch).length > 4){
			inc = 2;
		}else if (ch == '\n'){
			if (objMsg.charAt(i-1) != '\r'){
				inc = 1;
			}
		}else if (ch == '<' || ch == '>'){
			inc = 4;
		}else{
			inc = 1;
		}
		if ((nbytes + inc) > intMax){
			break;
		}
		nbytes += inc;
		msg += ch;
	}
	st.innerHTML = nbytes; //현재 byte수를 넣는다
	return msg;
}

chkMsgLength(80, document.regform.sms_content, txt_Byte);

//유효성 체크
function RegChk(){
	var obj = document.regform;
	if(obj.sms_content.value==""){ alert("내용을 입력하세요"); return; }
	obj.submit();
}

</script>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->