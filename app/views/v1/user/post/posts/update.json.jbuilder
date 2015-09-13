json.extract! @post, :id, :message, :image, :latitude, :longitude, :status

json.like_count @post.likes.count