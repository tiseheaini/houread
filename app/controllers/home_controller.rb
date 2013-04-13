class HomeController < ApplicationController
  def index
    @time = 3600 - (Time.now.min * 60 + Time.now.sec)

    current_hour = Time.now.hour
    if (9..20).include?(current_hour)
      ## 获取分享按钮的地址
      current_timeint = Topic.current_timeint(Time.now)
      share_site_topic = Topic.where(:timeint => current_timeint).first
      if share_site_topic.present?
        encoding_site = Topic.encoding(share_site_topic.timeint)
        @share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
      end
      #time = Time.now
      #timeint = time.year.to_s + ("%02d" % time.month) + ("%02d" % time.day) + ("%02d" % ((time.hour - 9)/2))
      timeint = Topic.current_timeint(Time.now)
      @topic = Topic.where(:timeint => timeint).first
      if @topic.present?
        @topiclike = @topic.likeable.to_s.split.length
        @title = Sanitize.clean(@topic.title).strip
      end
    else
      render :template => 'home/close_content'
    end
  end
end
