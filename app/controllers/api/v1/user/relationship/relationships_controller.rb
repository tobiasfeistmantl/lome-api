class Api::V1::User::Relationship::RelationshipsController < Api::V1::User::Relationship::Base
	before_action :set_relationship_by_followed_id, only: [:destroy]

	def create
		unless @user.following.find_by(id: params[:relationship][:followed_id])
			if @relationship = @user.active_relationships.create(relationship_params)
				render nothing: true, status: 204
			else
				render "api/v1/errors/default",
				locals: {
					error: {
						type: "UNABLE_TO_SAVE_RELATIONSHIP",
						specific: @relationship.errors.messages,
						message: {
							user: "Unable to follow the user"
						}
					}
				}, status: 400
			end
		else
			render "/api/v1/errors/default",
			locals: {
				error: {
					type: "ALREADY_FOLLOWING",
					message: {
						user: "You already following this user"
					}
				}
			}, status: 400
		end
	end

	def show
		unless params[:partner_id]
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "PARAMETER_MISSING",
					specific: "partner_id"
				}
			}, status: 400 and return
		end
	end

	def destroy
		if @relationship.destroy
			render nothing: true, status: 204
		else
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "UNABLE_TO_DESTROY_RELATIONSHIP",
					specific: @relationship.errors.messages,
					message: {
						user: "Unable to unfollow the user"
					}
				}
			}, status: 500
		end
	end

	protected

	def relationship_params
		params.require(:relationship).permit(:followed_id)
	end

	def set_relationship_by_followed_id
		unless @relationship = @user.active_relationships.find_by(followed_id: params[:relationship][:followed_id])
			render "api/v1/errors/default",
			locals: {
				error: {
					type: "RELATIONSHIP_NOT_FOUND",
					message: {
						user: "Relationship does not exist"
					}
				}
			}, status: 404
		end
	end

end
