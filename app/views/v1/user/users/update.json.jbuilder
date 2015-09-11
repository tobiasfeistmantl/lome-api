json.partial! 'attributes', user: @user

if @user == current_user
	json.email @user.email
end