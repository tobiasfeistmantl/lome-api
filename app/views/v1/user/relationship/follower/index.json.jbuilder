json.count @count

json.follower do
	json.partial! "v1/user/users/attributes", collection: @follower, as: :user
end
