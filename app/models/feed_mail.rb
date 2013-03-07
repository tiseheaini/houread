class FeedMail < ActiveRecord::Base
  attr_accessible :email, :is_delete

  validates :email, :uniqueness => true
end
