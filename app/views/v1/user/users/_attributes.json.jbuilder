json.extract! user, :id, :firstname, :lastname, :username, :follower_count

json.profile_image do
	image = user.profile_image

	json.standard_resolution image.url
	json.thumbnail image.thumb.url
end


is_follower = nil

if current_user
	is_follower = user.follower(current_user).present?
end

json.following is_follower
