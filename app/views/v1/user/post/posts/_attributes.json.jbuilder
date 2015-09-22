json.extract! post, :id, :message, :latitude, :longitude, :status, :likes_count, :created_at

json.image do
	json.low_resolution post.image.low_resolution.url
	json.standard_resolution post.image.standard_resolution.url
	json.high_resolution post.image.url
	json.thumbnail post.image.thumb.url
end

json.author do
	json.partial! "/v1/user/users/attributes", user: post.author
end

json.liked post.likes.include?(current_user)