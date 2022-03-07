<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
</head>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>관리자 정보</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>관리자정보</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%	
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_member WHERE m_id='" & W_ID & "' AND m_lev<=10"
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('회원정보가 없거나 탈퇴한 회원입니다.');location.href='/site/manage/';</script>"
	Response.End
Else 
	m_id=Rs("m_id")
	m_pw=Rs("m_pw")	
	m_name=Rs("m_name")
	m_email=Rs("m_email")
End If
Rs.Close
Set Rs = Nothing
%>


	<form name="regform" action="admin-info-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">아이디</th>
				<td class="bdt"><%=W_ID%></td>
			</tr>
			<tr>
				<th class="title bdr bdt">패스워드</th>
				<td class="bdt">
					<input type="password" name="m_pw" value="" class="AXInput" style="width:120px" maxlength="15" > (변경하실 경우에만 입력하세요)
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">이름</th>
				<td class="bdt">
					<input type="text" name="m_name" value="<%=W_NAME%>" class="AXInput" style="width:120px">
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">이메일</th>
				<td class="bdt">
					<input type="text" name="m_email" value="<%=W_EMAIL%>" class="AXInput" style="width:310px">
				</td>
			</tr>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="submit" value="   확인   " class="AXButton Blue"></span>
			<span><input type="button" value="   취소   " class="AXButton"></span>
		</p>
	</div>
	<!-- //btn_left_right -->	

	</form>

	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			기본 설정된 패스워드는 반드시 변경하셔서 보안 관리에 신경 써 주시기 바랍니다.
		</p>
	</div>
	<!-- //tip_box -->

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.m_name.value==""){ alert("이름을 입력하세요"); obj.m_name.focus(); return false; }
	if(obj.m_email.value==""){ alert("이메일을 입력하세요"); obj.m_email.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->