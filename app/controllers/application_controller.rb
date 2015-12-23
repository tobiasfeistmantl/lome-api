class ApplicationController < ActionController::Base
	include AccessControl

	protect_from_forgery with: :exception
end
