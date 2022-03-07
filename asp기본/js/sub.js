$(function () {

	let lnb = $("#lnb");

	// gnb Clone => lnb 
	let depth2 = $("#gnb .depth1 > li:eq(" + ($pageIdx - 1) + ") .depth2");
	lnb.gnbClone(lnb, depth2, $pageIdx,);

	function getParameter(name) {
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
			results = regex.exec(location.search);
		return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	var curPage = getParameter("curPage").toUpperCase();
	if (curPage) {
		lnb.find("li").each(function (index, item) {
			var menu = $(this).text().toUpperCase().trim();
			if (curPage.indexOf(menu) >= 0) {
				$(this).addClass("on");
				return false;
			}
		});
	} else {
		lnb.find("li").each(function (index, item) {
			var hrefVal = $(this).find("a").attr("href");
			var url = location.href;
			var hrefVlaArr = hrefVal.split("/");
			var hrefVlaArrMenu = hrefVlaArr[hrefVlaArr.length - 1].split(".asp")[0];
			var urlSplit = url.split(".asp")[0].split("/");
			var currentMenu = urlSplit[urlSplit.length - 1];
			if (hrefVlaArrMenu == currentMenu) {
				$(this).addClass("on");
			}
		})
	}

	// 탭 메뉴가 있는경우 tab & lnb on
	let tab = $(".tab_s1");
	if (tab.length) {
		tab.urlCompare(lnb);
	}

	var currentPage = lnb.find(".on > a").html();
	$(".pageTit").html(currentPage)


	if (lnb.find("li").length == 1) {
		lnb.remove();
	}





})