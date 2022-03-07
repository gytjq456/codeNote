$(document).ready(function () {


	var a = window.innerHeight * .425
	var wow = $(".combine_ani");

	var line = 0;
	var winW = $(window).width();
	aniResize(winW)
	$(window).on("resize", function () {
		winW = $(window).width();
		aniResize(winW)
	})

	function aniResize(winW) {
		if (winW < 1200) {
			line = -100
		} else {
			line = 50
		}

		if (wow.length) {
			$(window).on("scroll", function () {
				console.log(line);
				var scrPos = $(this).scrollTop() + a;
				wow.each(function () {
					var offsetTop = $(this).offset().top - a + line;
					if (scrPos >= offsetTop) {
						$(this).addClass("animated");
					} else {
						//$(this).removeClass("animated");
					}
				})
			})
		}
	}


	wow.each(function () {
		var delay = $(this).data("delay");
		$(this).css({
			"transition-delay": delay
		})
	});





})