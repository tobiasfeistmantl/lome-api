json.count @count

json.followed_users do
	json.partial! "v1/user/users/attributes", collection: @followed_users, as: :user
end