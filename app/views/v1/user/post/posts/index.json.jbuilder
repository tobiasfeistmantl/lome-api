json.array! @posts do |post|
	json.extract! post, :id, :message, :image, :latitude, :longitude
	json.like_count post.likes.count
end