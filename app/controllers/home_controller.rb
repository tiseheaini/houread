class HomeController < ApplicationController
  def index
    @time = 3600 - (Time.now.min * 60 + Time.now.sec)

    current_hour = Time.now.hour
    if (9..21).include?(current_hour)
      #time = Time.now
      #timeint = time.year.to_s + ("%02d" % time.month) + ("%02d" % time.day) + ("%02d" % ((time.hour - 9)/2))
      timeint = Topic.current_timeint(Time.now)
      @topic = Topic.where(:timeint => timeint).first
      @topiclike = @topic.likeable.to_s.split.length if @topic.present?
    else
      render :template => 'home/close_content'
    end
  end
end
