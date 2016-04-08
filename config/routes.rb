Rails.application.routes.draw do

	get 'dashboard' => 'dashboards#index'
	resources :posts, path: '/dashboard/posts'
	
	root 'home#index'
end
