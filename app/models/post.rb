class Post < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :file_records, dependent: :destory

  default_scope { order('id desc') }
end
