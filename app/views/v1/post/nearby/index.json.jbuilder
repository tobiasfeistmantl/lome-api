json.array! @posts do |post|
	json.partial! "v1/user/post/posts/attributes", post: post
end