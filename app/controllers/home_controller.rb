class HomeController < ApplicationController
  def index
    @topic = Topic.last
		@time = 3600 - (Time.now.min * 60 + Time.now.sec)
  end
end
