<? 
	$cacheDate = date("ymdhis");
	$lang = "/kr";
?>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<title>타이틀</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!--meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no"-->
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="keywords" content="">
	<meta name="Description" content="">
	<meta property="og:image" content="이미지 주소" />
	<meta name="google" value="notranslate" />
	<link rel=" shortcut icon" href="파일이름.ico">
	<link rel="icon" href="파일이름.ico">
	<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

	<link rel="stylesheet" href="/css/base.css?v=<?=$cacheDate?>">
	<link rel="stylesheet" href="/css/common.css?v=<?=$cacheDate?>">
	
	<script src="//code.jquery.com/jquery-latest.js"></script>
	<? if($_SERVER["PHP_SELF"] == $lang."/index.php") { ?>
		<link rel="stylesheet" href="/css/main.css?v=<?=$cacheDate?>">
		<script src="/js/main.js?v=<?=$cacheDate?>"></script>
	<? }else { ?>
		<link rel="stylesheet" href="/css/sub.css?v=<?=$cacheDate?>">
		<script defer src="/js/sub.js?v=<?=$cacheDate?>"></script>
	<? } ?>
	<link rel="stylesheet" href="/css/animation.css?v=<?=$cacheDate?>">
	<link rel="stylesheet" href="/css/media.css?v=<?=$cacheDate?>">

	<script src="/js/common.js?v=<?=$cacheDate?>"></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<script>
	
	if (/MSIE \d|Trident.*rv:/.test(navigator.userAgent)) {
		window.location = 'microsoft-edge:' + window.location;
		setTimeout(function() {
			window.location = 'https://go.microsoft.com/fwlink/?linkid=2135547';
		}, 1);
	}

	function updateOrientation() {
		var orientationValue = window.orientation
		if (orientationValue == 90 || orientationValue == -90) {
			$("meta[name=viewport]").attr("content",
				"width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi"
			);
		}
	}

	window.onload = function() {
		document.body.onorientationchange = updateOrientation;
	}


	var windowWidth = window.screen.width
	setViewPort(windowWidth);

	function setViewPort(w_width) {
		if (w_width <= 400) {
			$("meta[name=viewport]").attr("content",
				"width=400, maximum-scale=2.0, user-scalable=yes, target-densitydpi=medium-dpi");
		} else {
			$("meta[name=viewport]").attr("content",
				"width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=yes,target-densitydpi=medium-dpi"
			);
		}
	}

	window.addEventListener('resize', function(event) {
		windowWidth = window.screen.width
		setViewPort(windowWidth);
	}, true);
	</script>

</head>

<body>
	<div id="wrap">
		<?
		$file = basename($_SERVER["SCRIPT_NAME"]);
		$folderName = explode("/",$_SERVER["SCRIPT_NAME"]);
		switch($folderName[count($folderName)-2]) {
			case "company" : 
				$num = 1; 
				$subTitle = "COMPANY";
				break;
			default:
				$num = 0;
				break;
		}
		?>
		<? if($file != "index.php") { ?>
		<script>
		$pageIdx = <?=$num?>;
		</script>

		<div id="subWrap">
			<section id="sv" class="sv0<?=$num?>">

			</section>
			<!--#sv-->

			<section id="lnb" class="sm<?=$num?>">
			</section>

			<div id="subContents">
				<div class="subTitle"><?=$subTitle?></div>

				<? }else { ?>
				<? } ?>