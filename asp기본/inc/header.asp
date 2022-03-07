<%
	cacheDate = Replace(FormatDateTime(Now(),4),":","") & Second(Now())
%>
<!DOCTYPE HTML>
<html lang="ko">
	<head>
		<!-- <title>타이틀</title> -->
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="format-detection" content="telephone=no">
		<!-- <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" /> -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.5, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi"> 
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<meta http-equiv="Content-Script-Type" content="text/javascript"/>
    <meta http-equiv="Content-Style-Type" content="text/css"/> 
    <meta property="og:image" content="/ogImg.jpg" />
		<meta name="google" value="notranslate" />
    <!--#include virtual="/site/setting.asp" -->
    <link rel=" shortcut icon" href="/favicon.ico">
 		<link rel="icon" href="/favicon.ico">
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
	<script src="/js/common.js?v=<%=cacheDate%>"></script>
	<script src="/js/animation.js?v=<%=cacheDate%>"></script>
	<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=cacheDate%>" />
	<link rel="stylesheet" type="text/css" href="/css/common.css?v=<%=cacheDate%>" />

	<% If Instr(Request.ServerVariables("URL"),"index.asp")=0 Then %>
	<link rel="stylesheet" href="/css/sub.css?v=<%=cacheDate%>">
	<script defer src="/js/sub.js?v=<%=cacheDate%>"></script>
	<% Else %>
	<link rel="stylesheet" href="/css/main.css?v=<%=cacheDate%>">
	<script src="/js/main.js?v=<%=cacheDate%>"></script>
	<% End if %>
	<link rel="stylesheet" type="text/css" href="/css/media.css?v=<%=cacheDate%>" />
	<link rel="stylesheet" type="text/css" href="/css/animation.css?v=<%=cacheDate%>" />

	<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

		<script type="text/javascript">
			if (/MSIE \d|Trident.*rv:/.test(navigator.userAgent)) {
				window.location = 'microsoft-edge:' + window.location;
				setTimeout(function () {
					window.location = 'https://go.microsoft.com/fwlink/%linkid=2135547';
				}, 1);
			}

			function updateOrientation() {
				var orientationValue = window.orientation
				if (orientationValue == 90 || orientationValue == -90) {
					$("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi");
				}
			}

			window.onload = function () {
				document.body.onorientationchange = updateOrientation;
			}


			var windowWidth = window.screen.width
			setViewPort(windowWidth);
			function setViewPort(w_width) {
				if (w_width <= 400) {
					$("meta[name=viewport]").attr("content", "width=400, maximum-scale=2.0, user-scalable=yes, target-densitydpi=medium-dpi");
				} else {
					$("meta[name=viewport]").attr("content", "width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi");
				}
			}

			window.addEventListener('resize', function (event) {
				windowWidth = window.screen.width
				setViewPort(windowWidth);
			}, true);
		</script>
	</head>
<body>
<div id="wrap">
	<header>
		<section class="inner1760">
      <h1 class="logo"><a href="/"><img src="/img/common/logo.png" alt=""></a></h1>
    </section>
	</header>


<%
	If Instr(Request.ServerVariables("URL"),"index.asp") = 0  Then
		foldname = Split(Request.ServerVariables("URL"), "/")
		Select Case foldname(UBound(foldname)-1)
      Case "company" 
      num = "1"
      svTit = "회사소개"
		End Select
%>
<!--index 페이지 아닐때-->
	<script>
		$pageIdx = <%=num%>;
	</script>
	<div id="subWrap">
		<section id="sv" class="sv0<%=num%>">
			<div class="tit">
				<h2>
					<%=svTit%>
				</h2>
			</div>
		
			<div id="lnb">
				<div class="inner1400">
				</div>
			</div>
		</section>
		<section id="subContents" class="clearfix">
				<div class="pageTit"></div>

<% End If %>