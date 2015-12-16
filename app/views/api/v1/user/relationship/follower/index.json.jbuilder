json.count @count

json.follower do
	json.partial! "api/v1/user/users/attributes", collection: @follower, as: :user
end
