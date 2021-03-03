<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>타이틀</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no"-->
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
<meta name="format-detection" content="telephone=no" />
<meta name="keywords" content="" >
<meta name="Description" content="" >
<link rel="stylesheet" type="text/css" href="/kr/css/style.css" />
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="/js/common.js"></script>
		<!--[if lt IE 9]>
		<script src="/js/html5shiv.js"></script>
		<![endif]-->
</head>
<body>
<div id="wrap">
	<header>
		<section class="inner1786">
			<div class="left">
				<h1 id="logo"><a href="/kr">Intekplus</a></h1>
				<div id="menuBtn">
					<button type="button">
						<span></span>
						<span></span>
					</button>
				</div>
			</div>
			<div class="util">
				<div class="schWrap">
					<form action="">
						<input type="text" name="" id="">
						<input type="reset" value="">
						<input type="submit" value="">
						<button type="submit"><i class="fas fa-search"></i></button>
					</form>
				</div>
				<div class="lang">
					<button type="button">KR</button>
					<ul>
						<li><a href="#;">EN</a></li>
						<li><a href="#;">CH</a></li>
					</ul>
				</div>
			</div>
		</section>
	</header>
<? $file = basename($_SERVER["SCRIPT_NAME"]);
	$folderName = explode("/",$_SERVER["SCRIPT_NAME"]);
	switch( $folderName[3]){
		case "company" : 
		$mNum = 1; 
		$sv01 = "COMPANY";
		break;
		case "product" : 
		$mNum = 2; 
		$sv01 = "PRODUCT";
		break;
		case "news" : 
		$mNum = 3; 
		$sv01 = "NEWS";
		break;
	}
	if ($file != "index.php") { ?>
	<div id="subWrap">
		<section id="sv" class="sv0<?=$mNum?>">
			<div class="inner">
				<dl>
					<dt><?=$sv01?></dt>
					<dd>Leading Solution Provider for EUV Lithography</dd>
				</dl>
			</div>
		</section><!--#sv-->
		<section id="lnb" class="sm<?=$mNum?>">
			<div class="inner">
				
			</div>
		</section>
		<div id="subContents">
			<div class="subTitle"><?=$subTitle?></div>

<? } else { ?>
<? } ?>