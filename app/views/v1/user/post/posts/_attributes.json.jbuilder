json.extract! post, :id, :message, :image, :latitude, :longitude, :status

json.liked post.likes(current_user).present?