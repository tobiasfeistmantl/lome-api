json.id @user_session.id

json.user do
	json.extract! @user, :id, :firstname, :lastname, :username
end