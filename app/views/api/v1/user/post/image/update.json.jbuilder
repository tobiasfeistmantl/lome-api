json.post do
	json.partial! "api/v1/user/post/posts/attributes", post: @post
end