json.extract! user, :id, :firstname, :lastname, :username, :follower_count

if current_user == user
	json.email user.email
end

json.profile_image do
	json.original do
		json.url user.profile_image.url

		if user.profile_image_dimensions
			json.width user.profile_image_dimensions["original"]["width"]
			json.height user.profile_image_dimensions["original"]["height"]
		else
			json.width nil
			json.height nil
		end
	end

	json.thumbnail do
		json.url user.profile_image.thumb.url

		if user.profile_image_dimensions
			json.width user.profile_image_dimensions["thumbnail"]["width"]
			json.height user.profile_image_dimensions["thumbnail"]["height"]
		else
			json.width nil
			json.height nil
		end
	end
end

is_follower = user.follower.include?(current_user) if current_user

json.following is_follower
