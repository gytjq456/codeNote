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
	<p>Naver Blog 연동 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>Naver Blog 연동 설정</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">
<%
Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_site_config "
Rs.Open Sql, Dbcon, 1
If Rs.EOF Then
	Response.Write "<script>alert('사이트 정보가 없습니다.'); history.back();</script>"
	Response.End
Else
	nb_id=Rs("nb_id")
	nb_apikey=Rs("nb_apikey")
	nb_apiurl = Rs("nb_apiurl")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="naver-blog-ok.asp?mode=mod" method="post" onsubmit="return RegChk(this)">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>Naver Blog 연동 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">네이버블로그 ID</th>
				<td class="bdt"><input type="text" name="nb_id" value="<%=nb_id%>" class="AXInput" style="width:100px"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">API KEY</th>
				<td class="bdt"><input type="text" name="nb_apikey" value="<%=nb_apikey%>" class="AXInput" style="width:98%"></td>
				</td>
			</tr>
			<tr>
				<th class="title bdr bdt">API URL</th>
				<td class="bdt"><input type="text" name="nb_apiurl" value="<%=nb_apiurl%>" class="AXInput" style="width:98%"></td>
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


	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>참고사항</b><br />
			1) 설정된 게시판과 제품관리에서 컨텐츠 내용을 바로 블로그로 포스팅 할 수 있습니다.<br />
			2) KEY값 취득은 'Naver Blog > 관리 > 플러그인 연동 관리 > 글쓰기 API설정'에서 생성 가능합니다.
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

</div>
<!-- //contents -->

<script type="text/javascript">
function RegChk(obj){
	if(obj.nb_id.value==""){ alert("네이버블로그 ID를 입력하세요"); obj.nb_id.focus(); return false; }
	if(obj.nb_apikey.value==""){ alert("API KEY를 입력하세요"); obj.nb_apikey.focus(); return false; }
	if(obj.nb_apiurl.value==""){ alert("API URL을 입력하세요"); obj.nb_apiurl.focus(); return false; }
}
</script>

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->