class HomeController < ApplicationController
  def index
    ## 获取分享按钮的地址
    current_timeint = Topic.current_timeint(Time.now)
    share_site_topic = Topic.where(:timeint => current_timeint).first
    if share_site_topic.present?
      encoding_site = Topic.encoding(share_site_topic.timeint)
      @share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
    end

    @topic = Topic.where(:timeint => current_timeint).first
    if @topic.present?
      @topiclike = @topic.likeable.to_s.split.length
      @title = Sanitize.clean(@topic.title).strip
    end
  end
end
