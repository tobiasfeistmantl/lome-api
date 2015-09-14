Rails.application.routes.draw do
	namespace :v1, defaults: { format: :json } do
		resources :users, module: :user, only: [:index, :create, :show, :update, :destroy] do
			resources :sessions, module: :session, only: [:show, :destroy] do
				resources :positions, only: [:create]
			end

			resources :relationships, module: :relationship, only: [:create] do
			end
			resources :posts, module: :post, only: [:index, :create, :show, :update, :destroy] do
				resources :likes, only: [:index, :create]
				delete "likes" => "likes#destroy", as: :like
			end

			delete "relationships" => "relationship/relationships#destroy", as: :relationship

			get 'follower' => "relationship/follower#index", as: :follower
			get 'followed' => "relationship/followed#index", as: :followed
		end

		post "users/sessions" => "user/sessions#create", as: :user_sessions
	end
end
