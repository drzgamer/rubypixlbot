Rails.application.routes.draw do

	root 'home#index'
	get 'dashboard' => 'dashboards#index'
	resources :posts, path: '/dashboard/posts'
	resources :categories, path: '/dashboard/categories'
	
	
end
