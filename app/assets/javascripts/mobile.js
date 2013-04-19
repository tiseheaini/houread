// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
//= require jquery
//= require_self

var likeable = function(){
  var fadetime = 900;
  $(".btn-like").click(
    function(){
      var topicId = $(".btn-like").data("topic");
      $.get("/topics/likeable" + "?" + "topic_id=" + topicId, 
          function(data){
            if (data.status){
              $(".like-info").css("display","block");
              $(".like-info").html(data.text);
              $(".btn-like span").html("喜欢 " + data.count);
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
