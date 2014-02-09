class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :user_id, presence: true

  default_scope { order('id desc') }
end
