
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

var feedMailAlert = function(alertType, alertMess){
  $('.feed-mail-alert').html(alertMess);
  $('.feed-mail-alert').addClass(alertType);
  $('.feed-mail-alert').slideToggle();
  setTimeout((function(){$('.feed-mail-alert').slideToggle();}), 2000);
  setTimeout((function(){$('.feed-mail-alert').removeClass(alertType);}), 3000);
}
