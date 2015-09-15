json.extract! post, :id, :message, :image, :latitude, :longitude, :status, :created_at

json.liked post.likes(current_user).present?