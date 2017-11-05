/*----------глитч начало----------*/

var word = document.getElementById('word');
var colors = ['red', 'yellow'];
var letters = 
    ['×','×','×','×','×','×','×','×','	x','×','×','×','×','×','×','×','×','×','×','×','×','×','×','×','×','×'];
var hello = 
    ['H','E','L','L','O'];
var nivanov = 
    ['N','I','V','A','N','O','V']

var skip = 8;
var counter = 0;
var letterRandom= 0;
var cursorName=0;

var swap = function() {
    
  if(counter++ == skip) {
          $('.preloader span').text(nivanov[cursorName++]);
      letterRandom=Math.floor(Math.random()*5);
      $( ".header span" ).each(function(i) { 
          if(letterRandom==i){
                $( this ).text(letters[Math.floor(Math.random()*25)]);
          }
          else{
               $( this ).text(hello[i]); 
          }
          this.dataset.text = $(this).text();
          
          });
      
      
    if(cursorName==7){
      cursorName=0;  
    }
    counter = 0;
  }
  window.requestAnimationFrame(swap);
}

swap();


//конец глитча и начало параллакса фона 


  w = $(window).width(), //window width
  h = $(window).height(); //window height


$(window).on('mousemove', function(e) {
  var offsetX = 0.1 - e.pageX / w, //cursor position X
    offsetY = 0.1 - e.pageY / h; //cursor position Y
    
      $(".particle").each(function(i) {
     $(".particle").eq(i).css('top',(offsetY*100*(4-i))+'px');
    $(".particle").eq(i).css('left',(offsetX*100*(4-i))+'px');
  });


});
//тут код при загрузке
$( window ).ready(function() {
     $('.preloader span').eq(0).delay(1000).animate({
         opacity:0,
      marginTop:40,
         fontSize:80,
  },100,);
         $('.preloader span').eq(1).delay(1000).animate({
        opacity:0,
      marginTop:40,
        fontSize:80,
  },100, );
     $('#fullPage').delay(1500).animate({
        opacity:1,
  },100, );
    
  $('.preloader').delay(1500).animate({
    opacity: 0,
      'z-index': 0,
  },300 );
    
});



//глитч картинки

!function(t,e,s,i){"use strict";function n(e,s){this.element=e,this.settings=t.extend({},a,s),this._defaults=a,this._name=r,this.init()}var r="_Glitch",a={destroy:!1,glitch:!0,scale:!0,blend:!0,blendModeType:"hue",glitch1TimeMin:600,glitch1TimeMax:900,glitch2TimeMin:10,glitch2TimeMax:115,zIndexStart:5};t.extend(n.prototype,{init:function(){this.glitch()},glitch:function(){function e(t,e){return Math.floor(Math.random()*(e-t+1))+t}function s(){var i=e(10,1900),n=9999,a=e(10,1300),o=0,h=e(0,16),f=e(0,16),d=e(c,l);t(r).css({clip:"rect("+i+"px, "+n+"px, "+a+"px,"+o+"px)",right:f,left:h}),setTimeout(s,d)}function i(){var s=e(10,1900),n=9999,c=e(10,1300),l=0,f=e(0,40),d=e(0,40),m=e(o,h);if(a===!0)var x=(Math.random()*(1.1-.9)+.9).toFixed(2);else if(a===!1)var x=1;t(r).next().css({clip:"rect("+s+"px, "+n+"px, "+c+"px,"+l+"px)",left:f,right:d,"-webkit-transform":"scale("+x+")","-ms-transform":"scale("+x+")",transform:"scale("+x+")"}),setTimeout(i,m)}function n(){var s=e(10,1900),i=9999,c=e(10,1300),l=0,f=e(0,40),d=e(0,40),m=e(o,h);if(a===!0)var x=(Math.random()*(1.1-.9)+.9).toFixed(2);else if(a===!1)var x=1;t(r).next().next().css({clip:"rect("+s+"px, "+i+"px, "+c+"px,"+l+"px)",left:f,right:d,"-webkit-transform":"scale("+x+")","-ms-transform":"scale("+x+")",transform:"scale("+x+")"}),setTimeout(n,m)}var r=this.element,a=this.settings.scale,c=this.settings.glitch1TimeMin,l=this.settings.glitch1TimeMax,o=this.settings.glitch2TimeMin,h=this.settings.glitch2TimeMax,f=this.settings.zIndexStart;if(this.settings.destroy===!0)(t(r).hasClass("el-front-1")||t(r).hasClass("front-3")||t(r).hasClass("front-2"))&&t(".front-1, .front-2, .front-3").remove(),t(".back").removeClass("back");else if(this.settings.destroy===!1){var d=t(r).clone();if(d.insertBefore(r).addClass("back").css({"z-index":f}),this.settings.blend===!0){var d=t(r).clone();d.insertAfter(r).addClass("front-3").css({"z-index":f+3,"mix-blend-mode":this.settings.blendModeType}),n()}if(this.settings.glitch===!0){var d=t(r).clone();d.insertAfter(r).addClass("front-2").css({"z-index":f+2}),t(".back").next().addClass("front-1").css({"z-index":f+1}),s(),i()}}}}),t.fn[r]=function(t){return this.each(function(){new n(this,t)})}}(jQuery,window,document);

    $(function(){$(".glitch")._Glitch({destroy:!1,glitch:!0,scale:!0,blend:!0,blendModeType:"hue",glitch1TimeMin:100,glitch1TimeMax:400,glitch2TimeMin:10,glitch2TimeMax:100})});