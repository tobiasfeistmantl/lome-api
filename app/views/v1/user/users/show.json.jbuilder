json.extract! @user, :id, :firstname, :lastname, :username

if @user == current_user
	json.email @user.email
end