json.extract! user, :id, :firstname, :lastname, :username, :follower_count

if current_user == user
	json.email user.email
end

json.profile_image do
	json.aspect_ratio user.profile_image.aspect_ratio

	json.versions do
		json.original user.profile_image.url
		json.thumbnail user.profile_image.thumb.url
	end
end

is_follower = user.follower.include?(current_user) if current_user

json.following is_follower
