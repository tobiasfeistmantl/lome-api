class V1::User::Relationship::RelationshipsController < V1::User::Relationship::Base
	before_action :set_relationship_by_followed_id, only: [:destroy]

	def create
		@relationship = @user.active_relationships.new relationship_params

		if @relationship.save
			render nothing: true, status: 204
		else
			render "v1/errors/default",
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
	end

	def destroy
		if @relationship.destroy
			render nothing: true, status: 204
		else
			render "v1/errors/default",
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
		unless @relationship = @user.active_relationships.find_by(followed_id: params[:followed_id])
			render "v1/errors/default",
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