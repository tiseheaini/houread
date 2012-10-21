class HomeController < ApplicationController
  def index
    @topic = Topic.last
  end
end
