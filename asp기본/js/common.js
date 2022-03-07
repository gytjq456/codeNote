function init() {
	$gnb = $(".gnb");
};

function initEvent_pc(val) {
	console.log(val);
};

/*
	모바일 함수 
*/
function initEvent_m(val) {
	console.log(val);
};


function hdlr_switch(val) {
	if (val > 1200) {
		console.log("pc");
		initEvent_pc(val);
	} else {
		console.log("mobile");
		initEvent_m(val);
	};
};

$(document).ready(function () {
	init();

	$(window).on("load resize", function () {
		var doc_width = $(window).width(); // 문서 로드될 때 문서 넓이 감지
		hdlr_switch(doc_width);
	});


});



