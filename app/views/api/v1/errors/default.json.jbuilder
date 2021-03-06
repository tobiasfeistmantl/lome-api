json.error do
	json.type error[:type]
	json.specific error[:specific] if error[:specific]
	json.message do
		json.user error[:message][:user] if error[:message] && error[:message][:user]
		json.language I18n.locale
	end
end