class HomeController < ApplicationController
  def index
    @topic = Topic.last
    @topiclike = @topic.likeable.to_s.split.length
    @topicunlike = @topic.unlikeable.to_s.split.length
    @time = 120 - Time.now.min
  end
end
