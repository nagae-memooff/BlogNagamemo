module UsersHelper
	def is_me?(user)
		current_user == user
	end
end
