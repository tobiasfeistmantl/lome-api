class Admin::PostsController < Admin::Base
	before_action :set_post

	def show
	end

	def destroy
		if @post.destroy
			flash[:info] = "Post deleted"
			redirect_to admin_dashboard_path
		else
			flash[:danger] = "Unable to delete post"
			redirect_back
		end
	end

	private

	def set_post
		@post = Post.find(params[:post_id] || params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:danger] = "Not found"
		redirect_back
	end

	def authenticated?
		return true if admin_signed_in?
	end

	def authorized?
		return true if current_admin.moderator? || current_admin.admin?
	end
end
