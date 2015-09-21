json.extract! user, :id, :firstname, :lastname, :username, :follower_count

json.profile_image do
	image = user.profile_image

	json.standard_resolution image.url
	json.thumbnail image.thumb.url
end


is_follower = nil

is_follower = user.follower(current_user).present? if current_user

json.following is_follower
