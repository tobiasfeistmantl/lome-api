json.extract! post, :id, :message, :latitude, :longitude, :status, :created_at

json.image do
	json.low_resolution post.image.low_resolution.url
	json.standard_resolution post.image.standard_resolution.url
	json.high_resolution post.image.url
	json.thumbnail post.image.thumb.url
end

json.liked post.likes(current_user).present?
json.like_count post.likes.count