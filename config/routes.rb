WooulAdmin::Application.routes.draw do
  resources :roles

  devise_for :employees
	root to: 'homes#index'

	resources :homes
	resources :invests
	resources :notices
	resources :users
	resources :employees
end
