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
      

end
