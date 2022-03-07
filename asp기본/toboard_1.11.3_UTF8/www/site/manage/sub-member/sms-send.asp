<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<%
s_m_id = Request("m_id")
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>문자 발송</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>문자 발송</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="regform" method="post" action="sms-send-ok.asp">

	<%
	Set Rs = Server.Createobject("ADODB.Recordset")
	Sql = "SELECT TOP 100 m_cell1+'-'+m_cell2+'-'+m_cell3 FROM tbl_member "
	Sql = Sql & " WHERE idx!='' "
	Sql = Sql & " AND m_lev>=3 "	'관리자를 제외한 회원만 검색
	Sql = Sql & " AND m_id IN ('" & Replace(s_m_id, ", ", "','") & "') "
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
		<h4>문자 발송</h4>
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