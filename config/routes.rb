Rails.application.routes.draw do
  devise_for :users
  resources :proyectos do
	member do
		post 'deleteportada'
	end
    resources :fotos, only: [:new, :create, :destroy]
  end
  root 'proyectos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
