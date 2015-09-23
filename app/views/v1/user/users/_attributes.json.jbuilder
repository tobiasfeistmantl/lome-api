json.extract! user, :id, :firstname, :lastname, :username, :follower_count

if current_user == user
	json.email user.email
end

json.profile_image do
	json.original user.profile_image.url
	json.thumbnail user.profile_image.thumb.url
end

is_follower = user.follower.include?(current_user) if current_user

json.following is_follower
