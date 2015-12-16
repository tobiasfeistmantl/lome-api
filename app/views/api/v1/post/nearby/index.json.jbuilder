json.array! @posts do |post|
	json.partial! "api/v1/user/post/posts/attributes", post: post
end