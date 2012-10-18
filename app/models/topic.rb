class Topic < ActiveRecord::Base
  attr_accessible :body, :like, :unlike
end
