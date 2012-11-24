
var countdown = function(){
  var time = $("#time").html();
  var h    = 0;
  var m    = parseInt(time / 60);
  var s    = time % 60;

  // 设置倒计时方法
	var settime = function(){
	  if (h == 0 && m == 0 && s == 0) {
	    $("#countdown").css("visibility","hidden");
	    window.location.href="/";
	  }
	  if (s == 0) { s = 60; }
	  if (s == 60) {
	    m -= 1;

	    if (m == 0 && h > 0) {
	      h -= 1;
	      m = 60;
	      s = 60;
	    }
	  }
	  s -= 1;
		$("#countdown").html('<p><span>离下一篇文章出现还有'+m+' 分钟'+s+'秒</span></p>')
	}

  // 开始执行程序
  setInterval(settime, 1000);
}

var likeable = function(){
  var fadetime = 1800;
  $(".home-like").click(
    function(){
      $.get("/topics/likeable", 
            function(data){
	      $(".like-info").css("display","block")
              $(".home-like span").html("顶 " + data);
	      $(".like-info").fadeOut(fadetime);
            }
      )
       .error(
         function(){
	   $(".like-error-info").css("display","block")
	   $(".like-error-info").fadeOut(fadetime);
	 }
       )
    }
  )
}

var unlikeable = function(){
  var fadetime = 2100;
  $(".home-unlike").click(
    function(){
      $.get("/topics/unlikeable",
          function(data){
	    $(".unlike-info").css("display","block");
            $(".home-unlike span").html("踩 " + data);
	    $(".unlike-info").fadeOut(fadetime);
	  }
      )
       .error(
         function(){
	   $(".unlike-error-info").css("display","block")
	   $(".unlike-error-info").fadeOut(fadetime);
	 }
       )
    }
  )
}
