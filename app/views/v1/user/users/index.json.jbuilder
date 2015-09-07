json.array! @users do |user|

	json.extract! user, :id, :firstname, :lastname, :username

end