// visual slide
$('#mainVisual').slick({
  dots: true,
  infinite: true,
  speed: 1000,
  slidesToShow: 1,
  adaptiveHeight: true,
  autoplay: true,
  autoplaySpeed: 3000,
});

const visualBox = document.querySelector("#mainVisual");
const visualSlideLeft = visualBox.querySelector(".slick-prev");
const visualSlideRight = visualBox.querySelector(".slick-next");

visualSlideLeft.classList.add("fas", "fa-chevron-left");
visualSlideRight.classList.add("fas", "fa-chevron-right");
visualSlideLeft.textContent = "";
visualSlideRight.textContent = "";



// whatNew slide 


function slideList(slideBox, slideShow) {

  const slideNode = slideBox.childNodes[1].querySelector(".slideList");
  $(slideNode).slick({
    dots: false,
    infinite: true,
    speed: 1000,
    slidesToShow: slideShow,
    slidesToScroll: 1,
    adaptiveHeight: true,
    autoplay: true,
    autoplaySpeed: 3000,
  });

  const arrowNode = slideNode.querySelectorAll(".slick-arrow");
  const prevNode = slideNode.querySelector(".slick-prev");
  const nextNode = slideNode.querySelector(".slick-next");
  const infoNode = slideNode.querySelector(".productInfo");
  for(let ele of arrowNode){
    ele.textContent = "";
    ele.classList.add("fas");
    ele.style.marginTop = -(infoNode.clientHeight/2)+"px";
  }

  prevNode.classList.add("fa-chevron-left");
  nextNode.classList.add("fa-chevron-right");

}


const whatNewSlide = document.querySelector("#whatNew");
const stylePick = document.querySelector("#stylePick");
slideList(whatNewSlide, 4);
slideList(stylePick, 3);

