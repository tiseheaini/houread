# encoding: utf-8
class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

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
    @topicunlike = @topic.unlikeable.to_s.split.length
    @time = 3600 - (Time.now.min * 60 + Time.now.sec)

    render :template => 'home/index'
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

  def likeable
    @topic = Topic.last
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

  def unlikeable
    @topic = Topic.last
    @topicarr = @topic.unlikeable.to_s.split

    if !@topicarr.include?(request.remote_ip.to_s)
      @topic.unlikeable = @topic.unlikeable.to_s + request.remote_ip.to_s + ' '
      @count = @topic.unlikeable.to_s.split.length.to_s
      @topic.save
      render :json => {:status => true, :text => "踩 -1", :count => @count}
    else
      render :json => {:status => false, :text => "你已经点击过了"}
    end
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    if @timeint = Topic.find_by_timeint(Topic.make_timeint)
      @topic.timeint = Topic.add_timeint(@timeint.timeint)
    else
      @topic.timeint = Topic.make_timeint
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
end
