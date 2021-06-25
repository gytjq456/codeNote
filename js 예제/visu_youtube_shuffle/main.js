

<script>
	

	var mainVisual = $("#mainVisual");
	var mainVisu = mainVisual.find(".visu");
	var itemIdx = 0;
	mainVisu.on('init', function (event, slick) {
		var item = $(this).find(".item").eq(0)
		item.addClass("active-item");
		setTimeout(function () {
			item.find(".combine_ani").addClass("animated")
		}, 800)


	});




	function shuffleRandom(n) {
		var ar = new Array();
		var temp;
		var rnum;

		//전달받은 매개변수 n만큼 배열 생성 ( 1~n )
		for (var i = 1; i <= n; i++) {
			ar.push(i);
		}

		//값을 서로 섞기
		for (var i = 0; i < ar.length; i++) {
			rnum = Math.floor(Math.random() * n); //난수발생
			temp = ar[i];
			ar[i] = ar[rnum];
			ar[rnum] = temp;
		}

		return ar;
	}
	var arr = shuffleRandom(4);
	for(var i =0; i <arr.length; i++){
		var n = arr[i];
		var item = mainVisu.children().eq(n - 1);
		mainVisu.append(item)
	}




	mainVisu.not(".slick-initialized").slick({
		slidesToScroll: 1,
		fade: true,
		autoplay: true,
		autoplaySpeed: 8000,
		infinite: true,
		dots: true,
		arrows: false,
		speed: 1200,
		swipe: false,
		pauseOnFocus: false,
		focusOnSelect: false,
		pauseOnHover: false,
		responsive: [
			{
				breakpoint: 641,
				settings: {
					dots: true
				}
			},
		]
	});


	mainVisu.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
		var item = $(this).find(".item");
		item.removeClass("active-item");
		item.eq(nextSlide).addClass("active-item")
		item.find(".combine_ani").removeClass("animated")
		setTimeout(function () {
			item.eq(nextSlide).find(".combine_ani").addClass("animated")
		}, 800)

		slick = $(slick.$slider);
		//playPauseVideo(slick, "pause");
		//var item = $(this).find(".item").eq(nextSlide).attr("class").split(" ")[1];
		//console.log(item)
		if (item == "youtube") {
			stopVideo();
		}		

	});

	mainVisu.on('afterChange', function (event, slick, currentSlide, nextSlide) {
		slick = $(slick.$slider);
		//playPauseVideo(slick, "play");
		
		var item = $(this).find(".item").eq(currentSlide).attr("class").split(" ")[1];
		if(item == "youtube"){
			onPlayerReady(event)
		}else {
			stopVideo();
		}
	});
	


	mainVisual.find(".slide_arrows button").on("click", function (e) {
		var className = e.target.className;
		if (className == "prev") {
			mainVisu.slick("slickPrev")
		} else if (className == "next") {
			mainVisu.slick("slickNext")
		}
	})

	// POST commands to YouTube or Vimeo API
	function postMessageToPlayer(player, command) {
		if (player == null || command == null) return;
		player.contentWindow.postMessage(JSON.stringify(command), "*");
	}
	
	function playPauseVideo(slick, control) {
		var currentSlide, slideType, player;

		currentSlide = slick.find(".slick-current");
		slideType = currentSlide.attr("class").split(" ")[1];
		player = currentSlide.find("iframe").get(0);

		if(slideType === "youtube"){
			switch (control) {
				case "play":
					mainVisu.slick('slickPause');
					postMessageToPlayer(player, {
						"event": "command",
						"func": "mute"
					});
					postMessageToPlayer(player, {
						"event": "command",
						"func": "playVideo"
					});
					break;
				case "pause":
					postMessageToPlayer(player, {
						"event": "command",
						"func": "pauseVideo"
					});
					break;
			}
		}
	}

	var tag = document.createElement('script');

	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	var player;
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('player', {
			height: '360',
			width: '640',
			videoId: '<%=sc_addtext1%>',
			playerVars: {
				'controls': 0, //플레이어 컨드롤러 표시여부
				'rel': 0, //연관동영상 표시여부
				'playsinline': 1, //ios환경에서 전체화면으로 재생하지 않게하는 옵션
				// 'autoplay': 1,
				'modestbranding': 1,
				'loop': 0,
				'mute': 1,
				'showsearch': 0,
				'showinfo': 0,
				'modestbranding': 0,
				//'playlist': 'fO4F2Idpaw4'
			},
			events: {
				'onReady': onPlayerReady,
				'onStateChange': onPlayerStateChange
			}
		});
	}

	
	function onPlayerReady(event) {
		mainVisu.slick('slickPause');
		player.playVideo();//자동재생 }
	}

	var done = false;
	function onPlayerStateChange(event) {
		if (event.data === 0) {
			//여기에 재생이 끝났을 때 실행시킬 스크립트 작성
				mainVisu.slick("slickPlay");
				mainVisu.slick("slickNext")
				stopVideo()
		}
	}

	function stopVideo() {
		player.stopVideo();
	}
</script>