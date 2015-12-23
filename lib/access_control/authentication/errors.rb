# @author Tobias Feistmantl
module AccessControl
	# Generic authentication error.
	# Other, more specific errors inherit from this one.
	#
	# @raise [AuthenticationError]
	#    if something generic is happening.
	class AuthenticationError < StandardError
	end

	# Error for classes where authentication isn't handled.
	#
	# @raise [AuthenticationNotPerformed]
	#    if the #authenticated? isn't defined
	#    in the controller class.
	class AuthenticationNotPerformed < AuthenticationError
	end

	# Error if user is unauthenticated.
	#
	# @raise [NotAuthenticatedError]
	#    if #authenticated? isn't returning true.
	class NotAuthenticatedError < AuthenticationError
	end
end