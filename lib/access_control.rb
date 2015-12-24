require 'access_control/controller_actions'
require 'access_control/errors'

module AccessControl
	def authenticate!(auth_method=:authenticated?)
		begin
			send(auth_method)
		rescue NoMethodError
			raise AccessControl::AuthenticationNotPerformedError
		end

		return if send(auth_method) == true

		raise AccessControl::NotAuthenticatedError
	end

	# Authorizes the user
	# If a record is loaded the before_action 
	# has to be called directly in the controller
	def authorize!(auth_method=:authorized?)
		# Raise Authorization not performed error
		# if the #authorize? action isn't performed
		begin
			send(auth_method)
		rescue NoMethodError
			raise AccessControl::AuthorizationNotPerformedError
		end

		# Permit if #authorized? returns true
		return if send(auth_method) == true

		# Raise Not authorized error if user isn't authorized
		raise AccessControl::NotAuthorizedError
	end
end