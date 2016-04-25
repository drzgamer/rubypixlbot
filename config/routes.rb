Rails.application.routes.draw do

  resources :images, path: '/dashboard/images'
	root 'home#index'
	get 'dashboard' => 'dashboards#index'
	
	resources :posts, path: '/dashboard/posts'
	resources :categories, path: '/dashboard/categories'
	
	
end
