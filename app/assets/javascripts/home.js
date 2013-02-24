
var countdown = function(){
    //总时间，已分为单位
    //var time = 122;
    var time = $("#time").html();
    //小时
    var h = parseInt(time / 60) > 0 ? parseInt(time / 60) : 0;
    //分
    var m = time % 60;
    //秒
    var s = 60;

    //输出到当前Script的Dom位置
    //document.write('<span>剩余<font id="f_hh">' + h + '</font>小时<font id="f_mm">' + m + '</font>分<font id="f_ss">' + s + '</font>秒</span>');

    //开始执行倒计时
    var timeInterval = setInterval(function () {
        //如果时、分、秒都为0时将停止当前的倒计时
        if (h == 0 && m == 0 && s == 0) {
            $("#countdown").css("visibility","hidden");
            window.location.href="/";
        }
        //当秒走到0时，再次为60秒
        if (s == 0) { s = 60; }
        if (s == 60) {
            //每次当秒走到60秒时，分钟减一
            if (m > 0){ m -= 1; }
            //当分等于0时并且小时还多余1个小时的时候进里面看看
            if (m == 0 && h > 0) {
                //小时减一
                h -= 1;
                //分钟自动默认为60分
                if (h == 0) {
                    m = 60;
                } else {
                    m = 59;
                }
                //秒自动默认为60秒
                s = 60;
            }
        }
        //秒继续跳动，减一
        s -= 1;
        //小时赋值
        //document.getElementById('f_hh').innerHTML = h;
        //分钟赋值
        //document.getElementById('f_mm').innerHTML = m;
        //秒赋值
        //document.getElementById('f_ss').innerHTML = s;
        $("#countdown").html('<p><span>离下一篇文章出现还有'+h+'小时'+m+'分钟'+s+'秒</span></p>')

    }, 1000);
}

var likeable = function(){
  var fadetime = 900;
  $(".btn-like").click(
    function(){
      $.get("/topics/likeable", 
          function(data){
            if (data.status){
              $(".like-info").css("display","block");
              $(".like-info").html(data.text);
              $(".btn-like span").html("顶 " + data.count);
              $(".like-info").fadeOut(fadetime);
            }else{
              $(".like-error-info").css("display","block");
              $(".like-error-info").html(data.text);
              $(".like-error-info").fadeOut(fadetime);
            }
          }, "json"
      )
    }
  )
}

var unlikeable = function(){
  var fadetime = 900;
  $(".btn-unlike").click(
    function(){
      $.get("/topics/unlikeable",
          function(data){
            if (data.status){
              $(".like-info").css("display","block");
              $(".like-info").html(data.text);
              $(".btn-unlike span").html("踩 -" + data.count);
              $(".like-info").fadeOut(fadetime);
            }else{
              $(".like-error-info").css("display","block");
              $(".like-error-info").html(data.text);
              $(".like-error-info").fadeOut(fadetime);
            }
          },"json"
      )
    }
  )
}
