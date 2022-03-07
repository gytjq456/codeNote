<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<!-- 스마트에디터2 -->
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>메일 발송</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>메일 발송</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

<%
m_id = Request("m_id")
If m_id="" Then
	Response.Write "<script>alert('선택된 아이디가 없습니다.'); history.back();</script>"
	Response.End
End If
%>

	<form name="regform" method="post" action="mail-send-ok.asp?mode=sel_send">

	<div class="tb_info">
		<h4>메일 발송</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">보내는사람</th>
				<td class="bdt bdr"><input type="text" name="ms_from" class="AXInput W400" value="<%=W_EMAIL%>" /></td>
			</tr>
			<tr>
				<th class="title bdr bdt">받는사람(ID)</th>
				<td class="bdt bdr"><textarea name="ms_to" id="ms_to" class="AXInput" style="width:98%; height:60px" readonly><%=m_id%></textarea></td>
			</tr>
			<tr>
				<th class="title bdr bdt">제목</th>
				<td class="bdt bdr"><input type="text" name="ms_subject" class="AXInput" value="" style="width:98%" / ></td>
			</tr>
			<tr>
				<td class="bdt bdr" colspan="2"><textarea name="ms_content" id="ms_content" class="AXInput" style="width:98%; height:200px"><%=MailSkin("메일 내용을 입력하세요")%></textarea></td>
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
		<b>제목과 내용에 아래의 대체문자를 사용 할 수 있습니다.</b><br />
		{MEM_ID} 받는회원아이디&nbsp;&nbsp;&nbsp;{MEM_NAME} 받는회원이름&nbsp;&nbsp;&nbsp;{MEM_EMAIL} 받는회원이메일<br />
		{SITE_NAME} 사이트명&nbsp;&nbsp;&nbsp;{SITE_URL} 사이트 주소<br /><br />
		+ 1회 발송량이 많을경우 서버 설정에 따라 발송중 중단될 수 있습니다.
		</p>
	</div>
	<!-- //tip_box -->

<script type="text/javascript">
//메일전송 유효성 체크
function RegChk() {
	var obj = document.regform;
	if(obj.ms_from.value==""){ alert('보내는 사람 메일주소를 입력하세요'); obj.ms_from.focus(); return; }
	if(obj.ms_subject.value==""){ alert(' 제목을 입력하세요'); obj.ms_subject.focus(); return; }
	oEditors.getById["ms_content"].exec("UPDATE_CONTENTS_FIELD", []);
	obj.submit();
}

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "ms_content",
    sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->