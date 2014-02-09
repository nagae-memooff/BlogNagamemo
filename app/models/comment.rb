class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	validates :user_id, presence: true
	validates :post_id, presence: true

  default_scope { order('id asc') }
end
