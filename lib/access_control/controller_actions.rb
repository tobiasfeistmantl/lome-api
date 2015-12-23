# @author Tobias Feistmantl
#
# The methods in this module work
# with the controller actions.
module AccessControl
	# @note
	#     This method can only be used
	#     for RESTful methods!
	#
	# @return [Boolean]
	#     True if the called action
	#     is a only-read action.
	def read_action?
		action_name == "index" ||
		action_name == "show"
	end

	# @note
	#     This method can only be used
	#     for RESTful methods!
	#
	# @return [Boolean]
	#     True if the called action
	#     is a write action.
	def write_action?
		action_name == "new" ||
		action_name == "create" ||
		action_name == "edit" ||
		action_name == "update" ||
		action_name == "destroy"
	end

	# @note
	#     This method can only be used
	#     for RESTful methods!
	#
	# @note
	#     Is only true for create methods
	#     such as new and create.
	def create_action?
		action_name == "new" ||
		action_name == "create"
	end

	# @note
	#    This method is only for
	#    RESTful update methods!
	#
	# @note
	#    Isn't true for create methods!
	#
	# @note
	#    Is also true for the pseudo
	#    update action `edit`.
	#
	# @return [Boolean]
	#    True if the called action
	#    is a update action.
	def update_action?
		action_name == "edit" ||
		action_name == "update"
	end

	# @return [Boolean]
	#    True if it's a destroy action.
	def destroy_action?
		action_name == "destroy"
	end
end