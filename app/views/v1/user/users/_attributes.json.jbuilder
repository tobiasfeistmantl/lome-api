json.extract! user, :id, :firstname, :lastname, :username

json.profile_image do
	json.full user.profile_image.url
	json.thumb user.profile_image.thumb.url
	json.profile user.profile_image.profile.url
end