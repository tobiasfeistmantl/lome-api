json.extract! @post, :id, :message, :image, :latitude, :longitude
json.like_count @post.likes.count

if @user == current_user
	json.status @post.status
end