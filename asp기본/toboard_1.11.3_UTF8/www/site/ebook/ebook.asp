<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="Content-Script-Type" content="text/javascript"/>
	<meta http-equiv="Content-Style-Type" content="text/css"/>
	<meta name="viewport" content="width = 1250, user-scalable = no" />
	<link rel="stylesheet" type="text/css" href="/site/css/axj.css" />
	<link rel="stylesheet" type="text/css" href="/site/css/AXButton.css" />
	<link rel="stylesheet" type="text/css" href="/site/ebook/css/base.css" />
	<link rel="stylesheet" type="text/css" href="/site/ebook/css/base2.css" />
	<!--#include virtual="/site/common/dbconn.asp" -->
	<!--#include virtual="/site/common/function.asp" -->
	<script type="text/javascript" src="/site/ebook/js/jquery.min.1.7.js"></script>
	<script type="text/javascript" src="/site/ebook/js/modernizr.2.5.3.min.js"></script>
	<script type="text/javascript" src="/site/ebook/js/turn.js"></script>
</head>
<body oncontextmenu='return false' ondragstart='return false'>
<%
idx = Request("idx")
%>
<div class="flipbook-viewport">
	<div id="flipbook">
		<%
		Set Rs = Server.Createobject("ADODB.Recordset")
		Sql = "SELECT * FROM tbl_ebook_img "
		Sql = Sql & " WHERE e_idx='" & idx & "' "
		Sql = Sql & " ORDER BY e_lev ASC"
		Rs.Open Sql, Dbcon, 1
		num=1
		If Rs.EOF=False Then
			Do Until Rs.EOF
				ei_idx = Rs("idx")
				ei_file = Rs("e_file")
				ei_lev = Rs("e_lev")
				%>
				<div><img src="/upload/ebook/<%=ei_file%>" style="width:500px; height:690px" /></div>
				<%
				num=num+1
				cnt=cnt+1
				Rs.MoveNext
			Loop
		End If
		Rs.Close
		Set Rs = Nothing%>
	</div>
	<div class="flip-control">
		<button type="button" id="prev" class="AXButton">◀</button>
		<button type="button" id="next" class="AXButton">▶</button>
	</div>
</div>


<script type="text/javascript">
	var oTurn = $("#flipbook").turn({
		width: 1190,
		height: 800,
		elevation: 100,			
		gradients: true,			
		autoCenter: true,
		next:true
	});

	$("#prev").click(function(e){
		e.preventDefault();
		oTurn.turn("previous");
	});

	$("#next").click(function(e){
		e.preventDefault();
		oTurn.turn("next");
	});
</script>

</body>
</html>