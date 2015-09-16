json.extract! user, :id, :firstname, :lastname, :username, :follower_count

json.profile_image do
	json.standard_resolution user.profile_image.url
	json.thumbnail user.profile_image.thumb.url
end