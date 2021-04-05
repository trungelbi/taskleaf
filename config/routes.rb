Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
	root to: 'tasks#index'
	resources :tasks
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/new'
  get 'tasks/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
