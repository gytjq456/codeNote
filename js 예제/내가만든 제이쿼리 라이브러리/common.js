$(document).ready(function () {


	// 플러그인 호출 
	$("a").greenify({
		color: "orange"
	});


	// header menu event
	let gnb = $("#gnb")
	$(window).on("load resize", function () {
		let window_width = $(window).width();
		if (window_width > 1200) {
			gnb.find(".depth1 > li > a").off("click");
			gnb.find(".depth1 > li").off().on("mouseenter mouseleave", function (e) {
				// $(this).gnbHoverEvent(e, "fade");
				// $(this).gnbHoverEvent(e, "slide");
				$(this).gnbHoverEvent(e, "allSlide", 300);
			})
		} else {
			gnb.find(".depth1 > li").off("mouseenter mouseleave");
			gnb.find(".depth1 > li > a").off().on("click", function (e) {
				e.preventDefault();
				$(this).gnbHoverEvent(e, "slide");
			})
		}
	})


	// tab menu click / content change
	let tab = $(".tab");
	tab.find("a").on("click", function () {
		$(this).tabChange(".tabContent");
	})

	// toggleTab menu click event
	let toggleTabDiv = $(".toggleTab");
	toggleTabDiv.find("button").on("click", function () {
		$(this).toggleTab(".txtBox");
	})


	// gnb Clone => lnb 
	let lnb = $("#lnb");
	let depth2 = $("#gnb .depth1 > li:eq(" + ($pageIdx - 1) + ") .depth2");
	lnb.gnbClone(lnb, depth2, $pageIdx,);

})