class ViewerLog < ActiveRecord::Base
  VIEW_TYPE_INDEX = 0
  VIEW_TYPE_POST = 1
  LOGIN_TYPE_IP = 0
  LOGIN_TYPE_SIGNED_IN = 1

  def post
    post =
      case self.view_type
      when VIEW_TYPE_INDEX
        nil
      when VIEW_TYPE_POST
        Post.find post_id
      end
    post
  end

  def user
    user =
      case self.login_type
      when LOGIN_TYPE_IP
        self.user_ip
      when LOGIN_TYPE_SIGNED_IN
        User.find self.user_id
      end
    user
  end

  def self.fetch_last_view options
    v_type = options[:view_type]
    u = 
      if options.has_key? :user_id
        options[:user_id] 
      elsif options.has_key? :user_ip
        options[:user_ip] 
      end

    key = "/viewer_log/#{v_type}/#{u}"

    last_view = Rails.cache.read key
    if last_view.nil?
      last_view = ViewerLog.where(options).try(:last).try(:created_at)
      Rails.cache.write key, last_view
    end

    last_view
  end


  def async_save
    self.write_cache
    t = Thread.new do
      self.save!
      conn = ActiveRecord::Base.connection
      conn.close if conn.try :active?
    end

    t.run
  end
    
  #保存对象后，将自己写入缓存
  def write_cache
    u = self.user_id || self.user_ip
    key = "/viewer_log/#{self.view_type}/#{u}"
    Rails.cache.write key, self.created_at
  end
end
