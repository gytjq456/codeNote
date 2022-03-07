$(document).ready(function () {


	var a = window.innerHeight * .25
	var wow = $(".combine_ani");
	if (wow.length) {
		$(window).off("scroll");
		$(window).on("scroll", function () {
			var scrPos = $(this).scrollTop() + a;
			wow.each(function () {
				var offsetTop = $(this).offset().top - 600;
				if (scrPos >= offsetTop) {
					$(this).addClass("animated");
				} else {
					$(this).removeClass("animated");
				}
			})
		})
	}

	wow.each(function () {
		var delay = $(this).data("delay");
		$(this).css({
			"transition-delay": delay
		})
	});





})