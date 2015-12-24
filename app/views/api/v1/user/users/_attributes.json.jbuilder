include_following ||= false

json.extract! user, :id, :firstname, :lastname, :username, :follower_count

json.email user.email if current_user == user || current_user.moderator? || current_user.admin?

json.profile_image do
	json.aspect_ratio user.profile_image.aspect_ratio

	json.versions do
		json.original user.profile_image.url
		json.thumbnail user.profile_image.thumb.url
	end
end

if include_following
	is_follower = user.follower.include?(current_user) if current_user

	json.following is_follower
end

json.role User.roles[user.role] if current_user.moderator? || current_user.admin?