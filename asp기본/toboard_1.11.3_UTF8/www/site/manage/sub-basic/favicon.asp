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
	<p>파비콘 설정</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>파비콘 설정</li>
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
	favicon=Rs("favicon")
End If
Rs.Close
Set Rs = Nothing
%>

	<form name="regform" action="favicon-ok.asp" method="post" enctype="multipart/form-data">

	<!-- tb_info -->
	<div class="tb_info">
		<h4>파비콘 설정</h4>
		<table>
			<colgroup>
				<col width="120px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="title bdr bdt">아이콘 파일</th>
				<td class="bdt">
				<%if favicon="" Then%>
					현재 등록된 파일이 없습니다.<br />
				<%Else%>
					<img src="/upload/favicon/<%=favicon%>" alt="<%=favicon%>" style="width:60px" /><br />
					현재 <%=favicon%> 파일이 등록되어 있습니다. (<input type="checkbox" name="favicon_del" value="1" />삭제)<br />
				<%End If%>
				<input type="file" name="favicon" value="<%=favicon%>" /><br />
				<span class="txt_small">ico 확장자, 16 x 16px 또는 32 x 32px, 16/256/트루컬러</span></td>
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

</div>
<!-- //contents -->

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->