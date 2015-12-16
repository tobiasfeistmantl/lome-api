Rails.application.routes.draw do
	namespace :api, path: nil do
		namespace :v1, defaults: { format: :json } do
			scope :users, module: :user do
				get '' => 'users#index', as: :users
				post '' => 'users#create'
				get ':id' => 'users#show', as: :user
				put ':id' => 'users#update'
				patch ':id' => 'users#update'
				delete ':id' => 'users#destroy'

				scope :sessions, module: :session do
					post '' => 'sessions#create', as: :user_sessions
				end

				scope ':user_id' do
					scope :sessions, module: :session do
						get ':id' => 'sessions#show', as: :user_session
						delete ':id' => 'sessions#destroy'
					end

					scope 'sessions/:session_id', module: :session do
						post 'positions' => 'positions#create', as: :user_session_positions
					end

					scope :posts, module: :post do
						get '' => 'posts#index', as: :user_posts
						post '' => 'posts#create'
						get ':id' => 'posts#show', as: :user_post
						put ':id' => 'posts#update'
						patch ':id' => 'posts#update'
						delete ':id' => 'posts#destroy'

						scope ':post_id' do
							get 'likes' => 'likes#index', as: :user_post_likes
							post 'like' => 'likes#create', as: :user_post_like
							delete 'like' => 'likes#destroy'

							put 'image' => 'image#update', as: :user_post_image
							patch 'image' => 'image#update'

							post 'abuse_report' => 'abuse_reports#create', as: :user_post_abuse_report
						end

						post 'image' => 'image#create', as: :user_post_with_image
					end

					scope '', module: :relationship do
						post 'relationships' => 'relationships#create', as: :user_relationships
						get 'relationships' => 'relationships#show'
						delete 'relationships' => 'relationships#destroy'

						get 'follower' => 'follower#index', as: :user_follower
						get 'followed' => 'followed#index', as: :user_followed
					end
				end
			end

			namespace :posts, module: :post do
				get 'nearby' => 'nearby#index', as: :nearby
			end
		end
	end
end
