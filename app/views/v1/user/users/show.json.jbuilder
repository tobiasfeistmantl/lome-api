json.partial! 'attributes', user: @user


if @user == current_user
	json.email @user.email
else
	json.follow current_user.following.find_by(id: @user.id).present?
end