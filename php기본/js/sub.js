$(function () {
	var depth2 = $("#gnb > li:eq(" + ($pageIdx - 1) + ") .depth2").clone();
	$lnb = $("#lnb");
	$lnb.children("div").append(depth2);

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
		$lnb.find("li").each(function (index, item) {
			var hrefVal = $(this).find("a").attr("href");
			var url = location.href;
			var hrefVlaArr = hrefVal.split("/");
			var hrefVlaArrMenu = hrefVlaArr[hrefVlaArr.length - 1].split(".php")[0];
			var urlSplit = url.split(".php")[0].split("/");
			var currentMenu = urlSplit[urlSplit.length - 1];
			if (hrefVlaArrMenu == currentMenu) {
				$(this).addClass("on");
			}
		})
	}



})