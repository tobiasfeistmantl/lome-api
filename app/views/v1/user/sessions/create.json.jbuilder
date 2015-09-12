json.extract! @user_session, :id, :token

json.user do
	json.extract! @user, :firstname, :lastname, :username
end