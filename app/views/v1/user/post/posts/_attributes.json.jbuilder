json.extract! post, :id, :message, :latitude, :longitude, :status, :likes_count, :created_at

json.image do
	json.original do
		json.url post.image.url

		if post.image_dimensions
			json.width post.image_dimensions["original"]["width"]
			json.height post.image_dimensions["original"]["height"]
		else
			json.width nil
			json.height nil
		end
	end

	json.thumbnail do
		json.url post.image.thumb.url
		
		if post.image_dimensions
			json.width post.image_dimensions["thumbnail"]["width"]
			json.height post.image_dimensions["thumbnail"]["height"]
		else
			json.width nil
			json.height nil
		end
	end
end

json.author do
	json.partial! "/v1/user/users/attributes", user: post.author
end

json.liked post.likes.include?(current_user)