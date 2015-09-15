json.extract! user, :id, :firstname, :lastname, :username

json.follower_count user.follower.count

json.profile_image do
	json.standard_resolution user.profile_image.url
	json.thumbnail user.profile_image.thumb.url
end