# @author Tobias Feistmantl
module AccessControl
	# Generic authorization error.
	# Other, more specific errors inherit from this one.
	#
	# @raise [AuthorizationError]
	#    if something generic is happening.
	class AuthorizationError < StandardError
	end

	# Error for classes where authorization isn't handled.
	#
	# @raise [AuthorizationNotPerformedError]
	#    if the #authorized? method isn't defined
	#    in the controller class.
	class AuthorizationNotPerformedError < AuthorizationError
	end

	# Error if user unauthorized.
	#
	# @raise [NotAuthorizedError]
	#    if authorized? isn't returning true.
	#
	# @note
	#    Should always be called at the end
	#    of the #authorize! method.
	class NotAuthorizedError < AuthorizationError
	end
end