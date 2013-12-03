WooulAdmin::Application.routes.draw do
  resources :guarantee_companies

  resources :fixed_deposits

  resources :photos

  resources :personal_reviews

  resources :personal_assets

  resources :user_companies

  resources :personal_finances

  resources :personal_credits

  resources :user_infos

  resources :roles

  devise_for :employees
	root to: 'homes#index'

	resources :homes
	resources :invests
	resources :notices
	resources :users
	resources :employees
end
