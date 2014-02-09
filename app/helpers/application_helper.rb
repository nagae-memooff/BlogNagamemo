module ApplicationHelper
  def set_portrait(user, size='s')
    if Rails.env == 'development'
      portrait_path = if File.exist? "#{Rails.root}/app/assets/images/portraits/#{user.id}.png"
                        "/assets/portraits/#{user.id}.png"
                      else
                        "/assets/portraits/default_portrait.png"
                      end
    elsif Rails.env == 'production'
      portrait_path = if File.exist? "/home/nagae-memooff/rails/blog_nagamemo/shared/portraits/#{user.id}.png"
                        "/portraits/#{user.id}.png"
                      else
                        "/portraits/default_portrait.png"
                      end
    end
    name = user.name
    print_html = "<img class='portrait_#{size}' src='#{portrait_path}' alt='#{name}'/>"
    print_html
  end
end
