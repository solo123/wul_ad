WooulAdmin::Application.routes.draw do
  resources :guarantee_companies

  resources :fixed_deposits do
    collection do
      get :settle
      get :publish
      get :finish
      get :refund
      get :switchdisplay
      get :payprofit
    end
  end

  resources :month_deposits do
    collection do
      get :settle
      get :publish
      get :finish
      get :refund
      get :switchdisplay
      get :payprofit
      get :payprincipal
    end
  end





  get '/products/:product_type', to: 'products#index', as: :index_product
  get '/products/:product_type/new', to: 'products#new'
  get '/product/:product_type/:id', to: 'products#show', as: :show_product
  resources :products do
    collection do
      get :settle
      get :publish
      get :finish
      get :refund
      get :switchdisplay
      get :payprofit
      get :payprincipal
    end
  end



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
