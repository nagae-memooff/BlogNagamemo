module PostsHelper
	def is_mine?(post)
		current_user == post.user
	end
end
