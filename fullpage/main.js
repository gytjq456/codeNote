var winHeight = window.innerHeight;
var winWidth = window.innerWidth;
var mainCont = document.querySelector("#mainContents");
var mainContChild = mainCont.children;
var last_y = winHeight * mainContChild.length;
var y = 0;
var onpage_on = true;
var isScroll = false;

resizeFn();
$(window).resize(function(){
  winHeight = window.innerHeight;
  winWidth = window.innerWidth;
  last_y= winHeight * mainContChild.length;
  resizeFn();
})

function htmlAni(y){
  $('html, body').stop().animate({
    scrollTop: y
  }, 800, function () {
    isScroll = false;
  });  
}

function scrollLock(event){
 
}

function resizeFn(){
  for(var i=0; i< mainContChild.length; i++){
    mainContChild[i].style.height = winHeight+"px";
  }
  
  // 기기 종류
  var UserAgent = navigator.userAgent;
  if (UserAgent.match(/iPhone|Mac|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null || winWidth < 1200) {
    console.log("모바일")
    $("footer").off('scroll touchmove mousewheel');
    $(mainContChild).off('scroll touchmove mousewheel');
  }else{
    console.log("PC")
    var scrPos;
    $(window).scroll(function(){
      scrPos =  $(this).scrollTop();
    })
    $("footer").on('scroll touchmove mousewheel', function (event) {
      //스크롤 이벤트 막기
      event.preventDefault();
      event.stopPropagation();
      if (isScroll) {
        return;
      }
      isScroll = true;  
      y = $(mainContChild).last().offset().top;
      htmlAni(y)  
    })

    $(mainContChild).on('scroll touchmove mousewheel', function (event) {
      var targetTop = $(this).offset().top;

      if (last_y > $("html").scrollTop() && !onpage_on) {
        // 원페이지 스크롤 
        onpage_on = false;
        isScroll = false;
      }
      if (!onpage_on) {
        return;
      }

      //스크롤 이벤트 막기
      event.preventDefault();
      event.stopPropagation();
      if (isScroll) {
        return;
      }
      isScroll = true;  

      // 마우스 휠 방향
      var direction = event.originalEvent.wheelDelta;      
      if (direction > 0) {
        // 마우스 휠 위
        var prevId;
        if(scrPos > targetTop){
          prevId = $(this).attr("id");
        }else{
          prevId = $(this).prev("section").attr("id");
        }
        if(prevId){
          y = $("#"+prevId).offset().top;
        }      
      }else{
        // 마우스 휠 아래
        var nextId = $(this).next("section").attr("id");
        if(nextId || nextId != undefined){
          y = $("#"+nextId).offset().top;
        }else{
          y = $("footer").offset().top;
        }
      }
      htmlAni(y)
    })

  }
}

