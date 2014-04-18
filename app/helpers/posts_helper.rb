#encoding=utf-8
module PostsHelper
  def is_mine? post
    current_user == post.user
  end

  def print_keywords keywords, count
    search_msg = "在标题和全文中搜索："
    keywords.each { |keyword| search_msg << " #{keyword}" }
    search_msg << "，找到#{count}条日志。"
  end

  def add_viewed_times post
    last_view = if signed_in?
                  post.viewer_logs.where(user_id: current_user.id, view_type: ViewerLog::VIEW_TYPE_POST)
                                  .try(:last).try(:created_at)
                else
                  post.viewer_logs.where(user_ip: request.remote_ip, view_type: ViewerLog::VIEW_TYPE_POST)
                                  .try(:last).try(:created_at)
                end

    if last_view.nil? || Time.now - last_view >= 3600
      viewer_log = post.viewer_logs.build
      viewer_log[:view_type] = ViewerLog::VIEW_TYPE_POST
      if signed_in?
        viewer_log[:login_type] = ViewerLog::LOGIN_TYPE_SIGNED_IN
        viewer_log[:user_id] = current_user.id
      else
        viewer_log[:login_type] = ViewerLog::LOGIN_TYPE_IP
        viewer_log[:user_ip] = request.remote_ip
      end
      post.viewed_times += 1 and post.save if viewer_log.save
    end
  end
end
