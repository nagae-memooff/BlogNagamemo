class Post < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments
  has_many :file_records

  default_scope { order('id desc') }
end
