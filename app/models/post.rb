class Post < ActiveRecord::Base
  include ApplicationHelper
  include SessionsHelper
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :file_records, dependent: :destroy
  has_many :viewer_logs, dependent: :destroy

  default_scope { order('id desc') }
end
