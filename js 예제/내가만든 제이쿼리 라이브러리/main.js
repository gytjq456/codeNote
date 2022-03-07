// 플러그인 정의 
let window_width = $(window).width();
$(window).on("resize", function () {
	window_width = $(window).width();
})

$.fn.greenify = function (options) {
	this.css("color", "green");
	let settings = $.extend({
		color: "#333",
		background: "red"
	}, options)

	// settings 변수를 사용해서 작업합니다. 
	return this.css({
		color: settings.color,
		backgroundColor: settings.backgroundColor
	});

};


// header menu event
$.fn.gnbHoverEvent = function (e, type, hd_height) {
	let header = $("header");
	console.log();
	let eventType = e.type;
	let depth2;
	let depth2_All = header.find(".depth2");
	console.log(window_width);
	if (window_width > 1200) {
		depth2 = $(this).find(".depth2");
		if (type == "slide") {
			depth2_All.stop().slideUp();
			if (eventType == "mouseenter") {
				depth2.stop().slideDown();
			}
			if (eventType == "mouseleave") {
				depth2.stop().slideUp();
			}
		}
		if (type == "fade") {
			depth2_All.stop().fadeOut();
			if (eventType == "mouseenter") {
				depth2.stop().fadeIn();
			}
			if (eventType == "mouseleave") {
				depth2.stop().fadeOut();
			}
		}
		if (type == "allSlide" && hd_height != undefined) {
			if (eventType == "mouseenter") {
				depth2_All.show();
				header.css({
					height: hd_height + "px"
				})
			}
			if (eventType == "mouseleave") {
				header.css({
					height: depth2_All.siblings().height()
				})
			}
		} else {
			header.css({
				overflow: "inherit",
				height: "auto"

			})
		}
	} else {
		depth2 = $(this).siblings(".depth2");
		if (eventType == "click") {
			depth2_All.stop().slideUp();
			depth2.stop().slideToggle();
		}
	}
	return this;
}

// tab menu click / content change
$.fn.tabChange = function (tabContent) {
	let idx = $(this).parent().index();
	let thisParent = $(this).parent();
	thisParent.siblings().removeClass("on")
	thisParent.addClass("on")
	$(tabContent).children().hide();
	$(tabContent).children().eq(idx).stop().fadeIn();
}


// toggleTab menu click event
$.fn.toggleTab = function (txtBox) {
	$(this).closest(".toggleTab").find(".txtBox").stop().slideUp();
	$(this).siblings(txtBox).stop().slideToggle();
}

// gnb Clone => lnb 
$.fn.gnbClone = function (lnb, depth, num) {
	let depth2 = depth.clone();
	lnb.children().append(depth2)
}


//url 비교
$.fn.urlCompare = function (lnb) {
	let location = window.location.pathname;
	console.log(location);
	$(this).find("li").each(function (index) {
		let url = $(this).find("a").attr("href");

		if (location == url) {
			$(this).addClass("on");
			let urlSplit = url.split("/");
			lnb.find("li").each(function (index) {
				let lnbUrl = $(this).find("a").attr("href");
				console.log(lnbUrl);
				if (lnbUrl.indexOf(urlSplit[urlSplit.length - 2]) >= 0) {
					lnb.find("li").eq(index).addClass("on")
					return false;
				}
			})
			return false;
		}
	})
}

