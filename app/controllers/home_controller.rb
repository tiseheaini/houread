class HomeController < ApplicationController
  def index
    @topic = Topic.last
    @topiclike = @topic.likeable.to_s.split.length
    @topicunlike = @topic.unlikeable.to_s.split.length
    @time = 3600 - (Time.now.min * 60 + Time.now.sec)
  end
end
