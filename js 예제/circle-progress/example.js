	$(".circle").each(function(){
		var val = parseInt($(this).data("value"));
		var degVal = 360 * val / 100;
		console.log(degVal)
		$(this).find("p").stop().animate({
			'transform':'rotate('+(-degVal)+'deg)'
		},1500)
		
		$(this).circleProgress({
			value: val/100,
			startAngle:-Math.PI/2 ,
			size:260,
			fill:{
				gradient:["#fff","#fff"],
				gradientAngle: Math.PI / 2
			},
			animation:{
				duration:1500,
				easing:"swing"
			},
			lineCap : "butt",
			thickness:1,
			reverse:true,
			emptyFill: "rgba(255,255,255,0.1)",		
		});
