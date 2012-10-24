// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var countdown = function(){
  var time = $("#time").html();
  var h    = 0;
  var m    = parseInt(time / 60);
  var s    = 60;

  // 设置倒计时方法
	var settime = function(){
	  if (s == 60){
		  m -= 1;
		}
		if (s == 0){
		  if (m == 0){
			  $("#countdown").css("visibility","hidden")
				window.location.href="/home/index";
			}else{
			  s = 60;
			}
		}
  
    s -= 1;
  
	  $("#countdown").html('<p><span>还有'+h+' 小时'+m+' 分钟'+s+'秒</span></p>')
  }

  // 开始执行程序
  setInterval(settime, 1000);
}
