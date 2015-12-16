json.extract! post, :id, :message, :latitude, :longitude, :status, :likes_count, :created_at

json.image do
	json.aspect_ratio post.image.aspect_ratio

	json.versions do
		json.original post.image.url
		json.thumbnail post.image.thumb.url
	end
end

json.author do
	json.partial! "/api/v1/user/users/attributes", user: post.author
end

json.liked post.liked_by? current_user