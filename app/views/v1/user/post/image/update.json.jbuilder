json.post do
	json.partial! "v1/user/post/posts/attributes", post: @post
end