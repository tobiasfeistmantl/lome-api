json.array! @posts do |post|
	json.user do
		json.partial! "v1/user/users/attributes", user: post.author
	end

	json.post do
		json.partial! "v1/user/post/posts/attributes", post: post
	end

	json.distance_in_km post.distance
end