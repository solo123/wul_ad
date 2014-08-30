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



   resources :products do
    collection do
      get '/settle/:product_type',  to: 'products#settle', as: :settle
      get '/:product_type/:id/publish', to: 'products#publish', as: :publish
      get '/:product_type/:id/edit', to: 'products#edit', as: :edit
      get '/:product_type', to: 'products#index', as: :index
      get '/:product_type/new', to: 'products#new', as: :new
      get '/:product_type/:id', to: 'products#show', as: :show
      post '/:product_type', to: 'products#create', as: :create
      post '/:product_type/:id', to: 'products#update', as: :update


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
