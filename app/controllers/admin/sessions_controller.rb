class Admin::SessionsController < Admin::Base
	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: params[:user][:email])

		if (@user && @user.authenticate(params[:user][:password]) && (@user.moderator? || @user.admin?))
			session[:admin_id] = @user.id
			redirect_to admin_dashboard_path
		else
			flash[:danger] = "Authentication failed"
			redirect_back
		end
	end

	def destroy
		if session.delete(:admin_id)
			flash[:success] = "Successfully signed out"
			redirect_to new_admin_session_path
		else
			flash[:danger] = "Unable to sign you out! Watch out!"
			redirect_back
		end
	end

	private

	def authorized?
		if create_action?
			return true
		end

		if destroy_action?
			return true if admin_signed_in?
		end
	end
end
