class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def redirect_back
		redirect_to :back
	rescue ActionController::RedirectBackError
		redirect_to root_path
	end
end
