json.array! @posts do |post|
	json.partial! "v1/user/post/posts/attributes", post: post
	json.like_count post.likes.count
end