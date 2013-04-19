class MobileController < ApplicationController
  include Home

  def index
    ## 获取分享按钮的地址
    current_timeint = Topic.current_timeint(Time.now)
    share_site_topic = Topic.where(:timeint => current_timeint).first || Topic.last
    if share_site_topic.present?
      encoding_site = Topic.encoding(share_site_topic.timeint)
      @share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
    end

    @topic = Topic.where(:timeint => current_timeint).first || Topic.last
    if @topic.present?
      @topiclike = @topic.likeable.to_s.split.length
      @title = Sanitize.clean(@topic.title).strip
    end
  end

  def random
    @topic = Topic.rand_topic
    encoding_site = Topic.encoding(@topic.timeint)
    @share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
    @title = Sanitize.clean(@topic.title).strip

    render :template => 'mobile/index'
  end

  def yuedu
    if mobile?
      coding = Topic.decoding(params[:encoding])
      @share_site = request.url

      @topic = Topic.where(:timeint => coding).first
      if @topic.present?
        @topiclike = @topic.likeable.to_s.split.length
        @title = Sanitize.clean(@topic.title).strip
      end

      render :template => 'mobile/index'
    else
      redirect_to yuedu_encoding_path(:encoding => params[:encoding])
    end
  end
end
