json.extract! @user_session, :id, :token

json.user do
	json.partial! "v1/user/users/attributes", user: @user
end