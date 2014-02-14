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

  def simple_format(text, html_options={}, options={})
    text = '' if text.nil?
    text = text.dup
    start_tag = tag('p', html_options, true)
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  -> paragraph
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.gsub!(/\t/, '&nbsp;&nbsp;&nbsp;&nbsp;') # 1 newline   -> br
    text.gsub!(/^/, '\1&nbsp;&nbsp;&nbsp;&nbsp;') # 1 newline   -> br
    text.insert 0, start_tag
    text.html_safe.safe_concat("</p>")
  end
end
