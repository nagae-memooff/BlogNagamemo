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
end
