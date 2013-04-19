# encoding: utf-8
class TopicsController < ApplicationController
  include Home
  before_filter :admin_validation, :except => [:random, :encoding, :likeable, :subscribe_mail]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.where('timeint >= :timeint', :timeint => Topic.current_timeint(Time.now))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @topiclike = @topic.likeable.to_s.split.length
    @time = 3600 - (Time.now.min * 60 + Time.now.sec)

    render :template => 'home/index'
  end

  def random
    @topic = Topic.rand_topic
    encoding_site = Topic.encoding(@topic.timeint)
    @share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
    @title = Sanitize.clean(@topic.title).strip

    render :template => 'home/index'
  end

  def encoding
    if mobile?
      redirect_to yuedu_mobiles_path(:encoding => params[:encoding])
    else
      coding = Topic.decoding(params[:encoding])
      @share_site = request.url

      @topic = Topic.where(:timeint => coding).first
      if @topic.present?
        @topiclike = @topic.likeable.to_s.split.length
        @title = Sanitize.clean(@topic.title).strip
      end

      render :template => 'home/index'
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  def subscribe_mail
    case params[:button]
    when 'subscribe'
      feed_mail = FeedMail.new(params[:feed_mail])
      regexp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
      match_mail = regexp.match(params[:feed_mail][:email])

      if match_mail
        feed_mail.save
        render :js => "feedMailAlert('alert-success','邮箱订阅成功');"
      else
        render :js => "feedMailAlert('alert-error','你输入的邮箱不合法');"
      end
    when 'unsubscribe'
      regexp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
      match_mail = regexp.match(params[:feed_mail][:email])
      if match_mail
        feed_mail = FeedMail.where(:email => match_mail[0]).first

        if feed_mail
          feed_mail.destroy
          render :js => "feedMailAlert('alert-success','邮箱退定成功');"
        else
          render :js => "feedMailAlert('alert-alert','你的邮箱没订阅');"
        end
        ####
      else
        render :js => "feedMailAlert('alert-error','你输入的邮箱不合法');"
      end
    end
  end

  def likeable
    topic_id = params[:topic_id]
    
    @topic = Topic.find(topic_id)
    @topicarr = @topic.likeable.to_s.split

    if !@topicarr.include?(request.remote_ip.to_s)
      @topic.likeable = @topic.likeable.to_s + request.remote_ip.to_s + ' '
      @count = @topic.likeable.to_s.split.length.to_s
      @topic.save
      render :json => {:status => true, :text => "顶 +1", :count => @count}
    else
      render :json => {:status => false, :text => "你已经点击过了"}
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    if Topic.find_by_timeint(Topic.current_timeint(Time.now))
      @topic.timeint = Topic.add_timeint(Topic.last.timeint)
    else
      @topic.timeint = Topic.current_timeint(Time.now)
    end

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
		@remain_topics = Topic.where("timeint > ?", @topic.timeint)
		@remain_topics.each do |topic|
		  topic.timeint = Topic.del_timeint(topic.timeint)
			topic.save
		end

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private

  def admin_validation
    if user_signed_in? && current_user.role == "admin"
      true
    else
      redirect_to root_path
    end
  end
end
