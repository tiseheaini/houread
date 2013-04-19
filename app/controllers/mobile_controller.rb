class MobileController < ApplicationController

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

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'

  private

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end
end
