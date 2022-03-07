var winHeight = window.innerHeight;
var winWidth = window.innerWidth;
var mainCont = document.querySelector("#mainContents");
var mainContChild = mainCont.children;
var itemLen = mainContChild.length
var isScroll = false;
var secSlideBtn = $(".sec_slide_btn");
var secLi = secSlideBtn.find("li");

resizeFn(winWidth);
$(window).resize(function () {
	winHeight = window.innerHeight;
	winWidth = window.innerWidth;
	resizeFn(winWidth);
})



var idx = 0;
function resizeFn(winWidth) {
	for (var i = 0; i < mainContChild.length; i++) {
		mainContChild[i].style.height = winHeight + "px";
	}

	$("#mainVisual .item").css({
		height: winHeight
	})

	// 기기 종류

	if (winWidth <= 1200) {
		console.log("모바일")
		var isCount = false;
		$(document).on("scroll", function () {
			var scrPos = $(this).scrollTop();
			$(mainContChild).each(function (index) {
				var topPos = $(this).offset().top;
				console.log("scrpos" + scrPos)
				console.log("topPos" + topPos)
				if (scrPos >= topPos - 500) {
					$(this).addClass("active")
				}
			})
		});
	} else {

		secLi.find("button").on("click", function (event) {
			idx = $(this).parent().index();
			if (!isScroll) {
				fullPageSlide(idx, event)
				isScroll = true;
			}
		})

		$(window).off('scroll DOMScroll mousewheel DOMMousewheel');
		$(window).on('scroll DOMScroll mousewheel DOMMousewheel', function (e) {
			// 마우스 휠 방향
			var wheelDelta = e.originalEvent.wheelDelta;
			if (!isScroll) {
				if (wheelDelta > 0) {
					// 마우스 휠 위
					idx--;
					if (idx <= 0) {
						idx = 0;
					}
					fullPageSlide(idx, e)
				} else {
					// 휠 아래
					idx++;
					if (idx == itemLen) {
						idx = itemLen - 1
						fullPageSlide(idx, e)
					}
					fullPageSlide(idx, e)
				}
				isScroll = true
			}
		})

	}
}

function fullPageSlide(idx, event) {
	if (idx == itemLen - 2) {
		secSlideBtn.addClass("on")
	} else if (idx > itemLen - 2) {
	} else {
		secSlideBtn.removeClass("on")
	}
	if (idx == itemLen - 1) {
		idx = itemLen - 2
		var top = $("#footer").innerHeight();
		$(mainContChild).stop().animate({
			top: (-100 * idx) - (top / winHeight * 100) + "%"
		}, 800, function () {
			isScroll = false
		})
	} else {
		$(mainContChild).stop().animate({
			transform: "translateY(0)",
			top: -100 * idx + "%"
		}, 800, function () {
			isScroll = false
		})
	}


	secLi.siblings().removeClass("on")
	secLi.eq(idx).addClass("on")
}
