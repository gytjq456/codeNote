$(function () {
	var speed = 1000;
	var interleaveOffset = 0.5
	var slideWidth = $(window).width();
	$(".slide_ctn").slick({
		arrows: true,
		speed: speed,
	})

	var w = slideWidth / 2 * -1;
	slideFn(w)
	$(window).on("resize", function () {
		slideWidth = $(window).width();
		w = slideWidth / 2 * -1;
		slideFn(w)
	})

	$(".slide_ctn").on("beforeChange", function (e, slick, currentSlide, nextSlide) {

		var count = slick.slideCount;
		var selectors = [nextSlide, nextSlide - count, nextSlide + count].map(function (n) {
			return '[data-slick-index="' + n + '"]'
			//한페이지에서 여러개 사용시 return '.부모클래스 [data-slick-index="'+n+'"]'
		}).join(',');
		$('.slick-now').removeClass('slick-now');
		//한페이지에서 여러개 사용시  $('.부모 클래스 .slick-now').removeClass('slick-now');
		$(selectors).addClass('slick-now');

		$(this).find(".slick-slide .bg0" + nextSlide).find(".inner").css({
			'transform': 'translateX(' + (w * -1) + 'px)'
		})

		$(this).find(".slick-slide .bg0" + (nextSlide + 1)).find(".inner").css({
			'transform': 'translateX(0px)'
		})

		$(this).find(".slick-slide .bg0" + (nextSlide + 2)).find(".inner").css({
			'transform': 'translateX(' + w + 'px)'
		})
		if (nextSlide + 1 == slick.slideCount) {
			$(this).find(".slick-slide .bg01").find(".inner").css({
				'transform': 'translateX(' + w + 'px)'
			})
		}

		if (nextSlide == 0) {
			$(this).find(".slick-slide .bg05").find(".inner").css({
				'transform': 'translateX(' + (w * -1) + 'px)'
			})
		}

	})
	$(".slide_ctn").find($('.slick-slide[data-slick-index="0"]')).addClass('slick-now');
	
	
	function slideFn(w) {
		visu.find(".slick-active").prev().find(".bg").css({
			'transform': 'translateX(' + (w * -1) + 'px)'
		})
		visu.find(".slick-active").find(".bg").css({
			'transform': 'translateX(0px)'
		})

		visu.find(".slick-active").next().find(".bg").css({
			'transform': 'translateX(' + w + 'px)'
		})
	}	
})
