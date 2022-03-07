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
	<p>ServerVariables</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>ServerVariables</li>
	</ul>
</div>
<!-- //location -->

<!-- contents -->
<div class="contents">

	<!-- tb_info -->
	<div class="tb_info">
		<table>
			<colgroup>
				<col width="25%" />
				<col width="" />
			</colgroup>
			<% For Each a_key in Request.ServerVariables %>
				<tr>
					<th class="title bdr bdt"><%=a_key%></th>
					<td class="bdt">
					<% 
						if Request.ServerVariables(a_key) = "" Then
							Response.Write " " 
						else 
							Response.Write Request.ServerVariables(a_key)
						end if
					%>
					</td>
				</tr>
			<% Next %>
		</table>
	</div>
	<!-- tb_info -->
</div>
<!-- //contents -->


<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->