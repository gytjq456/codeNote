$(document).ready(function () {


	let winUnit = 0;

	if ($("#subWrap").length) {
		winUnit = window.innerHeight * .7
	} else {
		winUnit = window.innerHeight * .8
	}
	let wow = $(".combine_ani");
	if (wow.length) {
		$(window).on("load scroll", function () {
			let scrPos = $(this).scrollTop();
			wow.each(function () {
				let offsetTop = $(this).offset().top - winUnit;
				if (scrPos >= offsetTop) {
					$(this).addClass("animated");
				} else {
					if (!$(this).hasClass("start")) {
						$(this).removeClass("animated");
					}
				}
			})
		})
	}

	wow.each(function () {
		let delay = $(this).data("delay");
		$(this).css({
			"transition-delay": delay
		})

		if ($(this).hasClass("start")) {
			$(this).addClass("animated")
		}

	});

	if ($(".trY").length) {
		$(".trY").each(function () {
			$(this).find("li").each(function (index) {
				$(this).css({
					"transitionDelay": `${index * 0.2}s`
				})
			})
		})
	}




})
