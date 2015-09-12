Rails.application.routes.draw do
	namespace :v1, defaults: { format: :json } do
		resources :users, module: :user, only: [:index, :create, :show, :update, :destroy] do
			resources :sessions, module: :session, only: [:show, :destroy] do
				resources :positions, only: [:create]
			end
		end

		post "users/sessions" => "user/sessions#create", as: :user_sessions
	end
end
