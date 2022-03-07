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
	<p>단체 메일 발송</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>단체 메일 발송</li>
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
				<th class="bdb bdr">메일수신여부</th>
				<td class="bdb bdr">
				<select name="s_mailing" id="s_mailing" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="1" <%If s_mailing="1" Then Response.Write "selected"%>>수신함</option>
					<option value="0" <%If s_mailing="0" Then Response.Write "selected"%>>수신안함</option>
				</select></td>
			</tr>
			<tr>
				<th class="bdb bdr">정렬</th>
				<td class="bdb bdr">
				<select name="s_align" id="s_align" class="AXSelect">
					<option value="0" <%If s_align="0" Then Response.Write "selected"%>>가입일(-)</option>
					<option value="1" <%If s_align="1" Then Response.Write "selected"%>>가입일(+)</option>
					<option value="2" <%If s_align="2" Then Response.Write "selected"%>>이름(-)</option>
					<option value="3" <%If s_align="3" Then Response.Write "selected"%>>이름(+)</option>
					<option value="4" <%If s_align="4" Then Response.Write "selected"%>>아이디(-)</option>
					<option value="5" <%If s_align="5" Then Response.Write "selected"%>>아이디(+)</option>
					<option value="6" <%If s_align="6" Then Response.Write "selected"%>>로그인수(-)</option>
					<option value="7" <%If s_align="7" Then Response.Write "selected"%>>로그인수(+)</option>
				</select>
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
				<th class="bdb bdr"></th>
				<td class="bdb"></td>
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

<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT COUNT(*) FROM tbl_member "
			Sql = Sql & " WHERE idx!='' "
			Sql = Sql & " AND m_lev>=3 "	'관리자를 제외한 회원만 검색

			If s_keyword<>"" Then
				Sql = Sql & " AND (m_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_id LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_email LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr2 LIKE '%" & s_keyword & "%') "
			End If

			If s_mailing<>"" Then Sql = Sql & " AND m_mailing='" & s_mailing & "' "
			If s_sort<>"" Then Sql = Sql & " AND m_sort='" & s_sort & "' "

			If s_srdate<>"" And s_erdate<>"" Then Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "

			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1
				ms_to_count = Rs(0)
			Rs.Close
			Set Rs = Nothing
%>

	<form name="regform" method="post" action="mail-send-ok.asp?mode=gro_send&<%=pLink%>">

	<div class="tb_info">
		<h4>단체 메일 발송</h4>
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
				<th class="title bdr bdt">받는사람</th>
				<td class="bdt bdr"><span class="txt_red"><%=ms_to_count%></span>명</td>
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
		{SITE_NAME} 사이트명&nbsp;&nbsp;&nbsp;{SITE_URL} 사이트 주소
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