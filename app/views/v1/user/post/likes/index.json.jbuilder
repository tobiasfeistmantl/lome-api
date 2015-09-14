json.count @count

json.likes do
	json.array! @likes do |like|
		json.id like.id
		json.user do
			json.partial! "v1/user/users/attributes", user: like.user
		end
	end
end