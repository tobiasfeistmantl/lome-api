json.extract! user, :id, :firstname, :lastname, :username, :follower_count

json.profile_image do
	image = user.profile_image

	json.standard_resolution image.url
	json.thumbnail image.thumb.url
end