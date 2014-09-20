class Post < ActiveRecord::Base
  include ApplicationHelper
  include SessionsHelper
  validates :user_id, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :file_records, dependent: :destroy
  has_many :viewer_logs, dependent: :destroy

  default_scope { order('id desc') }

  def fetch_last_view options
    return nil if self.id.nil?

    v_type = ViewerLog::VIEW_TYPE_POST
    u = 
      if options.has_key? :user_id
        options[:user_id] 
      elsif options.has_key? :user_ip
        options[:user_ip] 
      end
    options.merge! view_type: ViewerLog::VIEW_TYPE_POST

    key = "/post/#{self.id}/viewer_log/#{v_type}/#{u}"

    last_view = Rails.cache.read key
    if last_view.nil?
      last_view = ViewerLog.where(options).try(:last).try(:created_at)
      Rails.cache.write key, last_view
    end

    last_view 
  end


  def update_last_view viewer_log
    Thread.start do
      viewer_log.save!
      v_type = ViewerLog::VIEW_TYPE_POST

      key = "/post/#{self.id}/viewer_log/#{v_type}/#{viewer_log.user_id || viewer_log.user_ip}"
      Rails.cache.write key, viewer_log.created_at

      conn = ActiveRecord::Base.connection
      conn.close if conn.try :active?
    end
  end
end
